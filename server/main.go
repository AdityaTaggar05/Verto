package main

import (
	"log"
	"os"

	"github.com/AdityaTaggar05/Verto/server/database"
	"github.com/AdityaTaggar05/Verto/server/routes"
	"github.com/gofiber/fiber/v3"
	"github.com/joho/godotenv"

	"github.com/golang-migrate/migrate/v4"
	_ "github.com/golang-migrate/migrate/v4/database/postgres"
	_ "github.com/golang-migrate/migrate/v4/source/file"
)

const (
	PORT = ":4000"
)

func main() {
	godotenv.Load()

	if os.Getenv("MIGRATE_ON_START") == "1" {
		m, _ := migrate.New("file://migrations", os.Getenv("DATABASE_URL"))
		if err := m.Up(); err != nil && err != migrate.ErrNoChange {
			log.Fatal(err)
		}
		log.Println("Migrations applied successfully")
	}

	log.Println("starting server at port", PORT)
	if err := database.ConnectPostgres(); err != nil {
		log.Fatal(err)
	}
	defer database.DB.Close()

	app := fiber.New()

	routes.RegisterRoutes(app)

	log.Fatal(app.Listen(PORT))
}
