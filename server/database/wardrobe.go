package database

import (
	"fmt"

	"github.com/AdityaTaggar05/Verto/server/models"
	"github.com/georgysavva/scany/v2/pgxscan"
	"github.com/gofiber/fiber/v3"
)

func FetchEquippedItems(c fiber.Ctx, uid string) ([]models.Item, error) {
	var items []models.Item

	query := `
		SELECT i.*
		FROM avatar_items i
		JOIN user_items ui ON ui.item_id = i.id
		WHERE ui.uid = $1 AND ui.equipped=TRUE;
	`

	if err := pgxscan.Select(c.Context(), DB, &items, query, uid); err != nil {
		return nil, err
	}
	return items, nil
}

func FetchItemsForCategory(c fiber.Ctx, category string) ([]models.Item, error) {
	var items []models.Item

	query := `
		SELECT *
		FROM avatar_items
		WHERE category=$1;
	`

	if err := pgxscan.Select(c.Context(), DB, &items, query, category); err != nil {
		return nil, err
	}
	return items, nil
}

func CreateItem(c fiber.Ctx, item models.Item) error {
	_, err := DB.Exec(c.Context(), `
		INSERT INTO avatar_items (id, name, category, price, level_required, rarity, created_at)
		VALUES ($1, $2, $3, $4, $5, $6, $7)
	`, item.ID, item.Name, item.Category, item.Price, item.LevelRequired, item.Rarity, item.CreatedAt)

	return err
}

func PurchaseItem(c fiber.Ctx, uid, itemID string) error {
	// TODO: Validate and perform coin transaction
	tx, err := DB.Begin(c.Context())
	if err != nil {
		return err
	}
	defer tx.Rollback(c.Context())

	var price int
	err = tx.QueryRow(c.Context(), `
		SELECT price FROM avatar_items WHERE id = $1 FOR UPDATE;
	`, itemID).Scan(&price)

	if err != nil {
		return err
	}

	var bookerCoins int
	err = tx.QueryRow(c.Context(), `
        SELECT coins FROM users WHERE id = $1 FOR UPDATE;
    `, uid).Scan(&bookerCoins)
	if err != nil {
		return fmt.Errorf("fetching booker coins: %w", err)
	}

	if bookerCoins < price {
		return fmt.Errorf("insufficient balance")
	}

	_, err = tx.Exec(c.Context(), `
		UPDATE users
		SET coins = coins - $1
		WHERE id = $2;
	`, price, uid)
	if err != nil {
		return fmt.Errorf("deducting coins: %w", err)
	}

	_, err = tx.Exec(c.Context(), `
		INSERT INTO user_items (uid, item_id)
		VALUES ($1, $2)
	`, uid, itemID)
	if err != nil {
		return fmt.Errorf("creating purchase: %w", err)
	}

	if err = tx.Commit(c.Context()); err != nil {
		return fmt.Errorf("committing tx: %w", err)
	}

	return err
}
