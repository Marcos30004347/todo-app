package database

import (
	"context"
	"fmt"
	"log"
	"time"

	"go.mongodb.org/mongo-driver/bson/primitive"

	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"labix.org/v2/mgo/bson"
)

type User struct {
	Id       string `json:"id"     bson:"_id"`
	Username string `json:"username"  bson:"username"`
}

type Database struct {
	client *mongo.Client
	ctx    context.Context
}

func (db *Database) ConnectDb(url string) {
	ctx, cancel := context.WithTimeout(context.Background(), 20*time.Second)

	defer cancel()

	db.ctx = ctx

	clientOptions := options.Client().ApplyURI("mongodb://localhost:27017")

	// Connect to MongoDB
	client, err := mongo.Connect(db.ctx, clientOptions)

	if err != nil {
		log.Fatal(err)
	}

	// Check the connection
	err = client.Ping(db.ctx, nil)

	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Connected to MongoDB!")

	db.client = client

	defer client.Disconnect(db.ctx)

	err = client.Ping(db.ctx, nil)
	if err != nil {
		log.Fatal(err)
	}
}

func (db *Database) createUser(user *User) (string, error) {
	result, err := db.client.Database("poster").Collection("posts").InsertOne(db.ctx, user)

	oid, ok := result.InsertedID.(primitive.ObjectID)
	if ok {
		return oid.Hex(), err
	}
	return "", DatabaseError{1, "error"}
}

func (db *Database) getAll() ([]*User, error) {
	// passing bson.D{{}} matches all documents in the collection
	filter := bson.D{{}}
	return db.filterUsers(filter)
}

func (db *Database) filterUsers(filter interface{}) ([]*User, error) {
	var tasks []*User

	cur, err := db.client.Database("users").Collection("users").Find(db.ctx, filter)

	if err != nil {
		return tasks, err
	}

	for cur.Next(db.ctx) {

		var tmp User
		err := cur.Decode(&tmp)

		if err != nil {
			return tasks, err
		}

		tasks = append(tasks, &tmp)
	}

	if err := cur.Err(); err != nil {
		return tasks, err
	}

	cur.Close(db.ctx)

	if len(tasks) == 0 {
		return tasks, mongo.ErrNoDocuments
	}

	return tasks, nil
}

func (db *Database) Update() {
	filter := bson.M{"title": "Teste"}
	update := bson.M{"$inc": bson.M{"age": 1}}

	updateResult, err := db.client.Database("poster").Collection("posts").UpdateOne(db.ctx, filter, update)

	if err != nil {
		log.Fatal(err)
	}

	fmt.Printf("Matched %v documents and updated %v documents.\n", updateResult.MatchedCount, updateResult.ModifiedCount)

}

func (db *Database) FindUserById(id string) User {
	filter := bson.M{"_id": bson.ObjectIdHex(id)}

	findResult := db.client.Database("poster").Collection("posts").FindOne(db.ctx, filter)

	var tmp User
	findResult.Decode(&tmp)

	return tmp
}
