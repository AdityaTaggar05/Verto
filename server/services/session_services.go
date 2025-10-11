package services

import (
	"log"
	"strconv"
	"time"

	"github.com/AdityaTaggar05/Verto/server/database"
	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/AdityaTaggar05/Verto/server/utils"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
)

type createSessionRequest struct {
	StartTime   time.Time `json:"start_time"`
	Price       int       `json:"price"`
	Title       string    `json:"title"`
	Description string    `json:"description"`
}

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
	count, _ := strconv.Atoi(c.Query("count"))

	sessions, err := database.FetchRecentlyAddedSessions(c, uid, count)

	if err != nil {
		log.Println("[SESSIONS]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "recently added sessions fetched successfully", sessions)
}

func CreateSession(c fiber.Ctx) error {
	uid := c.Locals("uid").(string)

	req, err := utils.ValidateBody[createSessionRequest](c)

	if err != nil {
		return nil
	}

	user, err := database.FetchUserFromUID(c, uid)

	if err != nil {
		log.Println("[SESSIONS]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	session := models.Session{
		ID:          uuid.NewString(),
		HostID:      uid,
		HostName:    user.FirstName + " " + user.LastName,
		Title:       req.Title,
		Description: req.Description,
		StartTime:   req.StartTime,
		Price:       req.Price,
		CreatedAt:   time.Now(),
	}

	err = database.CreateSession(c, session)

	if err != nil {
		log.Println("[SESSIONS]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "created session successfully", session)
}

func BookSession(c fiber.Ctx) error {
	uid := c.Locals("uid").(string)
	sessionID := c.Params("id")

	err := database.BookSession(c, uid, sessionID)

	if err != nil {
		log.Println("[SESSIONS]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "session booked successfully", nil)
}

func FetchTimeline(c fiber.Ctx) error {
	uid := c.Locals("uid").(string)
	mode := c.Query("mode")

	var sessions []models.Session
	var err error

	if mode == "today" {
		sessions, err = database.FetchTodaySessions(c, uid)

		if err != nil {
			log.Println("[SESSIONS]:", err.Error())
			return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
		}
	} else {
		sessions, err = database.FetchTomorrowSessions(c, uid)

		if err != nil {
			log.Println("[SESSIONS]:", err.Error())
			return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
		}
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "sessions fetched successfully", sessions)
}

func FetchSessions(c fiber.Ctx) error {
	search := c.Query("search")
	count := c.Query("count")

	if count == "" {
		count = "10"
	}

	sessions, err := database.FetchSessions(c, search, count)

	if err != nil {
		log.Println("[SESSIONS]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "sessions fetched successfully", sessions)
}
