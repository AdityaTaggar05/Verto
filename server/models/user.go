package models

import "time"

type User struct {
	ID        string     `json:"id" db:"id"`
	FirstName string     `json:"first_name" db:"first_name"`
	LastName  string     `json:"last_name" db:"last_name"`
	Username  string     `json:"username" db:"username"`
	Email     string     `json:"email" db:"email"`
	PassHash  string     `json:"-" db:"pass_hash"`
	Coins     int        `json:"coins" db:"coins"`
	Level     int        `json:"level" db:"level"`
	XP        int        `json:"xp" db:"xp"`
	CreatedAt time.Time  `json:"created_at" db:"created_at"`
	LastLogin *time.Time `json:"-" db:"last_login"`
}
