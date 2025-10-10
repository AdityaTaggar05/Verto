package utils

import (
	"log"
	"reflect"
	"strings"

	"github.com/go-playground/validator/v10"
	"github.com/gofiber/fiber/v3"
)

var validate = validator.New()

// To use json tags as fields while formatting error messages
func init() {
	validate.RegisterTagNameFunc(func(fld reflect.StructField) string {
		name := strings.SplitN(fld.Tag.Get("json"), ",", 2)[0]
		if name == "-" {
			return ""
		}
		return name
	})
}

func ValidateBody[T any](c fiber.Ctx) (*T, error) {
	var body T

	if err := c.Bind().Body(&body); err != nil {
		log.Printf("Bind error (%T): %v", body, err.Error())
		RespondError(c, fiber.StatusBadRequest, "Invalid JSON Body")
		return nil, err
	}

	if err := validate.Struct(body); err != nil {
		log.Printf("Validation error (%T): %v", body, err.Error())
		RespondValidationError(c, err)
		return nil, err
	}

	return &body, nil
}
