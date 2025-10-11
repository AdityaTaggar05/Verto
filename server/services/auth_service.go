package services

import (
	"log"
	"strings"
	"time"

	"golang.org/x/crypto/bcrypt"

	"github.com/AdityaTaggar05/Verto/server/database"
	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/AdityaTaggar05/Verto/server/utils"
	"github.com/gofiber/fiber/v3"
	"github.com/golang-jwt/jwt/v5"
	"github.com/google/uuid"
)

const (
	ACCESS_TOKEN_DURATION  = 30 * time.Minute
	REFRESH_TOKEN_DURATION = 3 * 24 * time.Hour
)

type registerRequest struct {
	FirstName string `json:"first_name" validate:"required"`
	LastName  string `json:"last_name" validate:"required"`
	Username  string `json:"username" validate:"required"`
	Email     string `json:"email" validate:"required,email"`
	Password  string `json:"password" validate:"required"`
}

type loginRequest struct {
	Username string `json:"username" validate:"required"`
	Password string `json:"password" validate:"required"`
}

func Register(c fiber.Ctx) error {
	req, err := utils.ValidateBody[registerRequest](c)

	if err != nil {
		return nil
	}

	hashed, err := bcrypt.GenerateFromPassword([]byte(req.Password), bcrypt.DefaultCost)

	if err != nil {
		log.Println("[REGISTER]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, "cannot hash the given password")
	}

	user := models.User{
		ID:        uuid.NewString(),
		FirstName: req.FirstName,
		LastName:  req.LastName,
		Username:  req.Username,
		Email:     req.Email,
		PassHash:  string(hashed),
		Coins:     200,
		Level:     1,
		XP:        0,
		CreatedAt: time.Now(),
	}

	err = database.CreateUser(c, user)

	if err != nil {
		log.Println("[REGISTER]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, "user already exists")
	}

	// Create JWT Tokens
	accessToken, _ := utils.GenerateJWT(user.ID, ACCESS_TOKEN_DURATION)
	refreshToken, err := database.CreateRefreshToken(c, user.ID, REFRESH_TOKEN_DURATION)

	if err != nil {
		log.Println("[REGISTER]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, "couldn't create the user successfully")
	}

	return utils.RespondSuccess(c, fiber.StatusCreated, "User created successfully", map[string]any{
		"user":          req,
		"access_token":  accessToken,
		"refresh_token": refreshToken,
	})
}

func Login(c fiber.Ctx) error {
	req, err := utils.ValidateBody[loginRequest](c)

	if err != nil {
		log.Println("[LOGIN]:", err.Error())
		return nil
	}

	// Fetch User from DB
	user, err := database.FetchUserFromUsername(c, req.Username)

	if err != nil {
		log.Println("[LOGIN]:", err.Error())
		return utils.RespondError(c, fiber.StatusUnauthorized, err.Error())
	}

	// Comparing the stored hash and incoming password
	if err := bcrypt.CompareHashAndPassword([]byte(user.PassHash), []byte(req.Password)); err != nil {
		log.Println("[LOGIN]:", err.Error())
		return utils.RespondError(c, fiber.StatusUnauthorized, "invalid credentials")
	}

	// Generate JWT Tokens
	accessToken, _ := utils.GenerateJWT(user.ID, ACCESS_TOKEN_DURATION)
	refreshToken, err := database.UpdateRefreshToken(c, user.ID, REFRESH_TOKEN_DURATION)

	if err != nil {
		return utils.RespondError(c, fiber.StatusUnauthorized, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "User logged in successfully", map[string]any{
		"access_token":  accessToken,
		"refresh_token": refreshToken,
		"user":          *user,
	})
}

func Refresh(c fiber.Ctx) error {
	type Req struct {
		RefreshToken string `json:"refresh_token"`
	}
	var body Req
	if err := c.Bind().Body(&body); err != nil {
		log.Println("[REFRESH]:", err.Error())
		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "invalid json"})
	}

	uid, err := database.VerifyRefreshToken(c, body.RefreshToken)
	if err != nil {
		log.Println("[REFRESH]:", err.Error())
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "invalid refresh token"})
	}

	// Create new tokens
	newAccessToken, _ := utils.GenerateJWT(uid, ACCESS_TOKEN_DURATION)
	newRefreshToken, _ := database.UpdateRefreshToken(c, uid, REFRESH_TOKEN_DURATION)

	return c.JSON(fiber.Map{"access_token": newAccessToken, "refresh_token": newRefreshToken})
}

func AuthMiddleware(c fiber.Ctx) error {
	token, err := utils.ParseJWT(strings.TrimPrefix(c.Get("Authorization"), "Bearer "))

	if err != nil {
		log.Println("[AUTH MIDDLEWARE]:", err.Error())
		return utils.RespondError(c, fiber.StatusUnauthorized, "unauthorized request")
	}

	if !token.Valid {
		log.Println("[AUTH MIDDLEWARE]: access token expired")
		return utils.RespondError(c, fiber.StatusUnauthorized, "access token expired")
	}

	claims := token.Claims.(jwt.MapClaims)
	c.Locals("uid", claims["uid"])

	return c.Next()
}
