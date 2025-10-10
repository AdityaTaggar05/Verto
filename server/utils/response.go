package utils

import (
	"fmt"

	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v3"
)

func RespondSuccess(c fiber.Ctx, status int, message string, data any) error {
	response := fiber.Map{
		"status":  "success",
		"message": message,
	}

	if data != nil {
		response["data"] = data
	}

	return c.Status(status).JSON(response)
}

func RespondError(c fiber.Ctx, status int, message string) error {
	return c.Status(status).JSON(fiber.Map{
		"status":  "error",
		"message": message,
	})
}
func RespondValidationError(c fiber.Ctx, err error) error {
	return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{
		"success": false,
		"errors":  formatErrors(err),
	})
}

func formatErrors(err error) map[string]string {
	errs := err.(validator.ValidationErrors)
	messages := make(map[string]string)

	for _, e := range errs {
		field := e.Field()
		tag := e.Tag()

		switch tag {
		case "required":
			messages[field] = fmt.Sprintf("%s is required", field)
		case "email":
			messages[field] = "Not a valid email address"
		case "min":
			messages[field] = fmt.Sprintf("%s should be atleast %s characters long", field, e.Param())
		case "max":
			messages[field] = fmt.Sprintf("%s should be atmost %s characters long", field, e.Param())
		case "gte":
			messages[field] = fmt.Sprintf("%s must be >= %s", field, e.Param())
		case "lte":
			messages[field] = fmt.Sprintf("%s must be <= %s", field, e.Param())
		default:
			messages[field] = fmt.Sprintf("%s is invalid (%s)", field, tag)
		}
	}

	return messages
}
