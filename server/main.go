package main

import (
	"log"

	"github.com/AdityaTaggar05/Verto/server/database"
	"github.com/AdityaTaggar05/Verto/server/routes"
	"github.com/gofiber/fiber/v3"
	"github.com/joho/godotenv"
)

const (
	PORT = ":4000"
)

func main() {
	godotenv.Load()

	log.Println("starting server at port", PORT)
	if err := database.ConnectPostgres(); err != nil {
		log.Fatal(err)
	}
	defer database.DB.Close()

	app := fiber.New()

	routes.RegisterRoutes(app)

	log.Fatal(app.Listen(PORT))
}
