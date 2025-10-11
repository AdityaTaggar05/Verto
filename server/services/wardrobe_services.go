package services

import (
	"log"
	"time"

	"github.com/AdityaTaggar05/Verto/server/database"
	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/AdityaTaggar05/Verto/server/utils"
	"github.com/gofiber/fiber/v3"
	"github.com/google/uuid"
)

type createItemRequest struct {
	Name          string `json:"name"`
	Category      string `json:"category"`
	Price         int    `json:"price"`
	LevelRequired int    `json:"level_required"`
	Rarity        string `json:"rarity"`
}

func FetchEquippedItems(c fiber.Ctx) error {
	uid := c.Locals("uid").(string)

	items, err := database.FetchEquippedItems(c, uid)

	if err != nil {
		log.Println("[WARDROBE]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "fetched equipped items successfully", items)
}

func FetchItemsForCategory(c fiber.Ctx) error {
	items, err := database.FetchItemsForCategory(c, c.Params("category"))

	if err != nil {
		log.Println("[WARDROBE]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "fetched category items successfully", items)
}

func CreateItem(c fiber.Ctx) error {
	req, err := utils.ValidateBody[createItemRequest](c)

	if err != nil {
		return err
	}

	item := models.Item{
		ID:            uuid.NewString(),
		Name:          req.Name,
		Category:      req.Category,
		Price:         req.Price,
		LevelRequired: req.LevelRequired,
		Rarity:        req.Rarity,
		CreatedAt:     time.Now(),
	}

	err = database.CreateItem(c, item)

	if err != nil {
		log.Println("[WARDROBE]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}
	return utils.RespondSuccess(c, fiber.StatusOK, "created item successfully", item)
}

func PurchaseItem(c fiber.Ctx) error {
	uid := c.Locals("uid").(string)
	itemID := c.Query("id")

	err := database.PurchaseItem(c, uid, itemID)

	if err != nil {
		log.Println("[WARDROBE]:", err.Error())
		return utils.RespondError(c, fiber.StatusInternalServerError, err.Error())
	}

	return utils.RespondSuccess(c, fiber.StatusOK, "purchased item successfully", nil)
}
