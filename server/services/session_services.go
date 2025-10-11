package services

import (
	"log"
	"strconv"

	"github.com/AdityaTaggar05/Verto/server/database"
	"github.com/AdityaTaggar05/Verto/server/utils"
	"github.com/gofiber/fiber/v3"
)

func FetchUpcomingSessions(c fiber.Ctx) error {
	uid := c.Locals("uid").(string)

	sessions, err := database.FetchUpcomingSessions(c, uid)

	if err != nil {
		log.Println("[SESSIONS]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "upcoming sessions fetched successfully", sessions)
}

func FetchRecentlyAddedSessions(c fiber.Ctx) error {
	uid := c.Locals("uid").(string)
	count, _ := strconv.Atoi(c.Params("count"))

	sessions, err := database.FetchRecentlyAddedSessions(c, uid, count)

	if err != nil {
		log.Println("[SESSIONS]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "recently added sessions fetched successfully", sessions)
}
