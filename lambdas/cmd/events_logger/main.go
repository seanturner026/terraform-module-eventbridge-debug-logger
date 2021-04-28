package main

import (
	"encoding/json"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
	log "github.com/sirupsen/logrus"
)

func handler(event events.CloudWatchEvent) error {
	var eventDetail interface{}
	err := json.Unmarshal(event.Detail, &eventDetail)
	if err != nil {
		log.Error("Unable to unmarshal event.Detail into json")
		return err
	}

	log.WithFields(
		log.Fields{
			"version":     event.Version,
			"id":          event.ID,
			"detail-type": event.DetailType,
			"source":      event.Source,
			"account":     event.AccountID,
			"region":      event.Region,
			"resources":   event.Resources,
			"detail":      eventDetail,
		},
	).Info("handled event")

	return nil
}

func main() {
	log.SetFormatter(&log.JSONFormatter{})
	lambda.Start(handler)
}
