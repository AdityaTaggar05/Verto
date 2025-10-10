package database

import (
	"context"
	"fmt"
	"os"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
)

var DB *pgxpool.Pool

func ConnectPostgres() error {
	dbURL := os.Getenv("DATABASE_URL")

	if dbURL == "" {
		dbURL = "postgres://username:password@localhost:5432/marketplace?sslmode=disable"
	}

	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	pool, err := pgxpool.New(ctx, dbURL)

	if err != nil {
		return fmt.Errorf("failed to connect to Postgres: %w", err)
	}

	if err := pool.Ping(ctx); err != nil {
		return fmt.Errorf("unable to ping to database: %w", err)
	}

	DB = pool
	fmt.Println("connected successfully to database")
	return nil
}
