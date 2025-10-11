package database

import (
	"fmt"
	"strings"

	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/georgysavva/scany/v2/pgxscan"
	"github.com/gofiber/fiber/v3"
)

func FetchSessions(c fiber.Ctx, search, count string) ([]models.Session, error) {
	var sessions []models.Session

	query := `
		SELECT * FROM sessions
		WHERE LOWER(title) LIKE '%' || $1 || '%'
		LIMIT $2;
	`
	if err := pgxscan.Select(c.Context(), DB, &sessions, query, strings.ToLower(search), count); err != nil {
		return nil, err
	}
	return sessions, nil
}

func FetchUpcomingSessions(c fiber.Ctx, uid string) ([]models.Session, error) {
	var sessions []models.Session

	query := `
		SELECT * FROM sessions
		WHERE host_id=$1 AND start_time>NOW()
		ORDER BY start_time ASC;
	`

	if err := pgxscan.Select(c.Context(), DB, &sessions, query, uid); err != nil {
		return nil, err
	}
	return sessions, nil
}

func FetchTodaySessions(c fiber.Ctx, uid string) ([]models.Session, error) {
	var sessions []models.Session

	query := `
		SELECT * FROM sessions
		WHERE host_id=$1 AND start_time::date=CURRENT_DATE
		ORDER BY start_time ASC;
	`

	if err := pgxscan.Select(c.Context(), DB, &sessions, query, uid); err != nil {
		return nil, err
	}
	return sessions, nil
}

func FetchTomorrowSessions(c fiber.Ctx, uid string) ([]models.Session, error) {
	var sessions []models.Session

	query := `
		SELECT * FROM sessions
		WHERE host_id=$1 AND start_time::date>CURRENT_DATE
		ORDER BY start_time ASC;
	`

	if err := pgxscan.Select(c.Context(), DB, &sessions, query, uid); err != nil {
		return nil, err
	}
	return sessions, nil
}

func FetchRecentlyAddedSessions(c fiber.Ctx, uid string, count int) ([]models.Session, error) {
	var sessions []models.Session

	query := `
		SELECT * FROM sessions
		ORDER BY created_at DESC
		LIMIT $1;
	`

	if err := pgxscan.Select(c.Context(), DB, &sessions, query, count); err != nil {
		return nil, err
	}
	return sessions, nil
}

func CreateSession(c fiber.Ctx, session models.Session) error {
	query := `
		INSERT INTO sessions (id, host_id, host_name, title, description, start_time, price, created_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
	`

	_, err := DB.Exec(c.Context(), query, session.ID, session.HostID, session.HostName, session.Title, session.Description, session.StartTime, session.Price, session.CreatedAt)
	return err
}

func BookSession(c fiber.Ctx, uid, sessionID string) error {
	tx, err := DB.Begin(c.Context())
	if err != nil {
		return err
	}
	defer tx.Rollback(c.Context())

	var price int
	var hostID string
	var isBooked bool

	err = tx.QueryRow(c.Context(), `
        SELECT price, host_id, is_booked 
        FROM sessions 
        WHERE id = $1
        FOR UPDATE;
    `, sessionID).Scan(&price, &hostID, &isBooked)

	if err != nil {
		return err
	}

	if isBooked {
		return fmt.Errorf("session already booked")
	}

	var bookerCoins int
	err = tx.QueryRow(c.Context(), `
        SELECT coins FROM users WHERE id = $1 FOR UPDATE;
    `, uid).Scan(&bookerCoins)
	if err != nil {
		return fmt.Errorf("fetching booker coins: %w", err)
	}

	if bookerCoins < price {
		return fmt.Errorf("insufficient balance")
	}

	_, err = tx.Exec(c.Context(), `
        INSERT INTO bookings (session_id, booked_by)
        VALUES ($1, $2);
    `, sessionID, uid)
	if err != nil {
		return fmt.Errorf("creating booking: %w", err)
	}

	_, err = tx.Exec(c.Context(), `
        UPDATE users
		SET coins = coins - $1,
			xp = xp + 10
		WHERE id = $2;
    `, price, uid)
	if err != nil {
		return fmt.Errorf("deducting coins and crediting xp: %w", err)
	}

	_, err = tx.Exec(c.Context(), `
        UPDATE users
		SET coins = coins + $1,
			xp = xp + 20
		WHERE id = $2;
    `, price, hostID)
	if err != nil {
		return fmt.Errorf("adding coins: %w", err)
	}

	_, err = tx.Exec(c.Context(), `
        UPDATE sessions 
        SET is_booked = TRUE 
        WHERE id = $1;
    `, sessionID)
	if err != nil {
		return fmt.Errorf("updating session: %w", err)
	}

	if err = tx.Commit(c.Context()); err != nil {
		return fmt.Errorf("committing tx: %w", err)
	}

	return nil
}
