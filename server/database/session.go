package database

import (
	"log"

	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/georgysavva/scany/v2/pgxscan"
	"github.com/gofiber/fiber/v3"
)

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

func FetchRecentlyAddedSessions(c fiber.Ctx, uid string, count int) ([]models.Session, error) {
	var sessions []models.Session

	log.Println("[COUNT]:", count)

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
		INSERT INTO sessions (id, host_id, start_time, price, created_at)
		VALUES ($1, $2, $3, $4, $5)
	`

	_, err := DB.Exec(c.Context(), query, session.ID, session.HostID, session.StartTime, session.Price, session.CreatedAt)
	return err
}

func BookSession(c fiber.Ctx, uid, sessionID string) error {
	query := `
		BEGIN;

		INSERT INTO bookings (session_id, booked_by)
		VALUES ($1, $2);

		UPDATE sessions
		SET is_booked = TRUE
		WHERE id=$1 AND is_booked=FALSE;

		COMMIT;
	`

	_, err := DB.Exec(c.Context(), query, sessionID, uid)

	return err
}
