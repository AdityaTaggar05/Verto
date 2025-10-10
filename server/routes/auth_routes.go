package routes

import (
	"github.com/AdityaTaggar05/Verto/server/services"
	"github.com/gofiber/fiber/v3"
)

func RegisterAuthRoutes(r fiber.Router) {
	r.Post("/login", services.Login)
	r.Post("/register", services.Register)
	r.Post("/refresh", services.Refresh)
}
