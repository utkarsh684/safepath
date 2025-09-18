package main

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"

	"myapp-backend/auth"
	"myapp-backend/db"
	"myapp-backend/services"

	"github.com/gin-contrib/cors"
)

func main() {
	db.Connect()
	auth.InitGoogleOAuth()

	r := gin.Default()
	r.Use(cors.Default())
	// Auth routes
	r.GET("/auth/google", auth.GoogleAuth)
	r.GET("/auth/google/callback", auth.GoogleCallback)

	// Protected route example (add middleware for JWT validation)
	r.POST("/api/user", func(c *gin.Context) {
		// TODO: Validate JWT from Authorization header
		userService := services.NewUserService()
		// Assume you extract googleID from JWT
		googleID := "example_google_id" // Replace with actual extraction
		user, err := userService.GetUserByGoogleID(googleID)
		if err != nil {
			c.JSON(http.StatusNotFound, gin.H{"error": "User not found"})
			return
		}
		c.JSON(http.StatusOK, user)
	})

	log.Println("Server starting on :8080")
	log.Fatal(http.ListenAndServe(":8080", r))
}
