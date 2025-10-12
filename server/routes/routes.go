package routes

import (
	"github.com/AdityaTaggar05/Verto/server/database"
	"github.com/AdityaTaggar05/Verto/server/services"
	"github.com/AdityaTaggar05/Verto/server/utils"
	"github.com/gofiber/fiber/v3"
)

func RegisterRoutes(app *fiber.App) {
	app.Get("/", func(c fiber.Ctx) error {
		return utils.RespondSuccess(c, fiber.StatusOK, "server is running", nil)
	})

	api := app.Group("/api")

	api.Get("/", services.AuthMiddleware, func(c fiber.Ctx) error {
		user, err := database.FetchUserFromUID(c, c.Locals("uid").(string))

		if err != nil {
			return utils.RespondError(c, fiber.StatusInternalServerError, "couldn't fetch the user")
		}
		return utils.RespondSuccess(c, fiber.StatusOK, "fetched user successfully", user)
	})

	RegisterAuthRoutes(api.Group("/auth"))
	RegisterSessionRoutes(api.Group("/sessions"))
	RegisterWardrobeRoutes(api.Group("/wardrobe"))
}
