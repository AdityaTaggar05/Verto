package database

import (
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

	query := `
		SELECT * FROM sessions
		ORDER BY start_time ASC
		LIMIT $2;
	`

	if err := pgxscan.Select(c.Context(), DB, &sessions, query, uid, count); err != nil {
		return nil, err
	}
	return sessions, nil
}
