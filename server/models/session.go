package models

import "time"

type Session struct {
	ID          string    `json:"id" db:"id"`
	HostID      string    `json:"host_id" db:"host_id"`
	HostName    string    `json:"host_name" db:"host_name"`
	Title       string    `json:"title" db:"title"`
	Description string    `json:"description" db:"description"`
	StartTime   time.Time `json:"start_time" db:"start_time"`
	Price       int       `json:"price" db:"price"`
	CreatedAt   time.Time `json:"created_at" db:"created_at"`
	IsBooked    bool      `json:"is_booked" db:"is_booked"`
}
