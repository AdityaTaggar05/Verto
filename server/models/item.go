package models

import "time"

type Item struct {
	ID            string    `json:"id" db:"id"`
	Name          string    `json:"name" db:"name"`
	Category      string    `json:"category" db:"category"`
	Price         int       `json:"price" db:"price"`
	LevelRequired int       `json:"level_required" db:"level_required"`
	Rarity        string    `json:"rarity" db:"rarity"`
	CreatedAt     time.Time `json:"created_at" db:"created_at"`
}
