package routes

import (
	"github.com/AdityaTaggar05/Verto/server/services"
	"github.com/gofiber/fiber/v3"
)

func RegisterSessionRoutes(r fiber.Router) {
	r.Get("/upcoming", services.AuthMiddleware, services.FetchUpcomingSessions)
	r.Get("/recent", services.AuthMiddleware, services.FetchRecentlyAddedSessions)
	r.Post("/create", services.AuthMiddleware, services.CreateSession)
	r.Post("/book/:id", services.AuthMiddleware, services.BookSession)
}
