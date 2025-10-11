package routes

import (
	"github.com/AdityaTaggar05/Verto/server/utils"
	"github.com/gofiber/fiber/v3"
)

func RegisterRoutes(app *fiber.App) {
	app.Get("/", func(c fiber.Ctx) error {
		return utils.RespondSuccess(c, fiber.StatusOK, "server is running", nil)
	})

	api := app.Group("/api")
	RegisterAuthRoutes(api.Group("/auth"))
	RegisterSessionRoutes(api.Group("/sessions"))
	RegisterWardrobeRoutes(api.Group("/wardrobe"))
}
