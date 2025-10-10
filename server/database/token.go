package database

import (
	"time"

	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
)

func CreateRefreshToken(c fiber.Ctx, uid string, duration time.Duration) (string, error) {
	token := uuid.NewString()

	_, err := DB.Exec(c.Context(), `
		INSERT INTO refresh_tokens (uid, token, created_at, expires_at) 
		VALUES ($1, $2, $3, $4)
	`, uid, token, time.Now(), time.Now().Add(duration))

	if err != nil {
		return "", err
	}

	return token, nil
}

func UpdateRefreshToken(c fiber.Ctx, uid string, duration time.Duration) (string, error) {
	newToken := uuid.NewString()

	_, err := DB.Exec(c.Context(), `
		UPDATE refresh_tokens
		SET token=$1, expires_at=$2
		WHERE uid=$3 AND revoked=false
	`, newToken, time.Now().Add(duration), uid)

	if err != nil {
		return "", err
	}

	return newToken, nil
}

func VerifyRefreshToken(c fiber.Ctx, token string) (uid string, err error) {
	err = DB.QueryRow(c.Context(), "SELECT uid FROM refresh_tokens WHERE token=$1 AND revoked=false", token).Scan(&uid)
	if err != nil {
		return "", err
	}
	return
}
