package database

import (
	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/georgysavva/scany/v2/pgxscan"
	"github.com/gofiber/fiber/v3"
)

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
