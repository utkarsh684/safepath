package services

import (
	"context"
	"time"

	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/bson/primitive"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"

	"myapp-backend/db"
	"myapp-backend/models"
)

type UserService struct {
	collection *mongo.Collection
}

func NewUserService() *UserService {
	return &UserService{
		collection: db.Client.Database("myapp").Collection("users"),
	}
}

func (s *UserService) UpsertUser(googleID, email, name string) (*models.User, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	user := &models.User{
		GoogleID:  googleID,
		Email:     email,
		Name:      name,
		CreatedAt: primitive.NewDateTimeFromTime(time.Now()),
	}

	opts := options.Update().SetUpsert(true)
	_, err := s.collection.UpdateOne(
		ctx,
		bson.M{"google_id": googleID},
		bson.M{"$set": user},
		opts,
	)
	if err != nil {
		return nil, err
	}

	return user, nil
}

func (s *UserService) GetUserByGoogleID(googleID string) (*models.User, error) {
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	var user models.User
	err := s.collection.FindOne(ctx, bson.M{"google_id": googleID}).Decode(&user)
	if err != nil {
		return nil, err
	}
	return &user, nil
}
