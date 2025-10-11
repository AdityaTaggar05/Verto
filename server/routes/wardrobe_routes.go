package routes

import (
	"github.com/AdityaTaggar05/Verto/server/services"
	"github.com/gofiber/fiber/v3"
)

func RegisterWardrobeRoutes(r fiber.Router) {
	r.Get("/", services.AuthMiddleware, services.FetchEquippedItems)
	r.Get("/:category", services.AuthMiddleware, services.FetchItemsForCategory)
	r.Post("/create", services.AuthMiddleware, services.CreateItem)
	r.Post("/purchase", services.AuthMiddleware, services.PurchaseItem)
}
