package models

import "go.mongodb.org/mongo-driver/bson/primitive"

type User struct {
	ID        primitive.ObjectID `bson:"_id,omitempty" json:"id"`
	GoogleID  string             `bson:"google_id" json:"google_id"`
	Email     string             `bson:"email" json:"email"`
	Name      string             `bson:"name" json:"name"`
	CreatedAt primitive.DateTime `bson:"created_at" json:"created_at"`
}
