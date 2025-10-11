package database

import (
	"log"
	"time"

	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/georgysavva/scany/v2/pgxscan"
	"github.com/gofiber/fiber/v3"
)

type CheckInResponse struct {
	Coins     int       `db:"coins"`
	LastLogin time.Time `db:"last_login"`
	CheckedIn bool      `db:"checked_in"`
}

func CreateUser(c fiber.Ctx, user models.User) error {
	_, err := DB.Exec(c.Context(), `
		INSERT INTO users (id, first_name, last_name, username, email, pass_hash, created_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7);
	`, user.ID, user.FirstName, user.LastName, user.Username, user.Email, user.PassHash, user.CreatedAt)

	return err
}

func FetchUserFromUsername(c fiber.Ctx, username string) (*models.User, error) {
	var user models.User

	if err := pgxscan.Get(c.Context(), DB, &user, "SELECT * FROM users WHERE username=$1 LIMIT 1;", username); err != nil {
		return nil, err
	}
	return &user, nil
}

func FetchUserFromUID(c fiber.Ctx, uid string) (*models.User, error) {
	var user models.User

	if err := pgxscan.Get(c.Context(), DB, &user, "SELECT * FROM users WHERE id=$1 LIMIT 1;", uid); err != nil {
		return nil, err
	}
	return &user, nil
}

func DailyCheckIn(c fiber.Ctx, uid string) (*CheckInResponse, error) {
	var res CheckInResponse

	err := pgxscan.Get(c.Context(), DB, &res, `
		WITH updated AS (
		SELECT 
			id,
			(last_login IS NULL OR last_login::date < CURRENT_DATE) AS checked_in
		FROM users
		WHERE id = $1
		)
		UPDATE users
		SET 
		coins = coins + CASE WHEN updated.checked_in THEN 100 ELSE 0 END,
		last_login = NOW()
		FROM updated
		WHERE users.id = updated.id
		RETURNING users.coins, users.last_login, updated.checked_in;
    `, uid)

	log.Println("[CHECK IN]:", res.CheckedIn)

	if err != nil {
		return nil, err
	}
	return &res, err
}
