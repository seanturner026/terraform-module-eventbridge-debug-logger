// Package test creates and destroys the deployable example with Terratest.
package test

import (
	"context"
	"fmt"
	"strings"
	"testing"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge"
	"github.com/aws/aws-sdk-go-v2/service/eventbridge/types"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/awserr"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestCompleteInvocation(t *testing.T) {
	t.Parallel()
	uniqueID := strings.ToLower(random.UniqueId())
	serviceName := "ecs"

	options := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/",
		Vars: map[string]interface{}{
			"name":         fmt.Sprintf("_%s", uniqueID),
			"service_name": serviceName,
		},
	})

	defer terraform.Destroy(t, options)
	terraform.InitAndApply(t, options)

	cfg, err := config.LoadDefaultConfig(context.TODO())
	if err != nil {
		fmt.Printf("[ERROR] unable to load config %v\n", err)
	}

	client := eventbridge.NewFromConfig(cfg)
	input := &eventbridge.DescribeRuleInput{
		Name:         aws.String(fmt.Sprintf("_%s_%s_star_rule", uniqueID, serviceName)),
		EventBusName: aws.String(fmt.Sprintf("_%s_%s", uniqueID, serviceName)),
	}

	response, err := client.DescribeRule(context.TODO(), input)
	if err != nil {
		if awsErr, ok := err.(awserr.Error); ok {
			fmt.Printf("%v\n", awsErr)
		} else {
			fmt.Printf("%v\n", err)
		}
	}

	expectedSawCommand := fmt.Sprintf("saw watch /aws/lambda/events_debug_logger_%s --expand", serviceName)
	sawCommand := terraform.Output(t, options, "saw_command")

	assert.Equal(t, expectedSawCommand, sawCommand)
	assert.Equal(t, types.RuleState("ENABLED"), response.State)
	assert.Equal(t, fmt.Sprintf("{\"source\":[\"aws.%s\"]}", serviceName), *response.EventPattern)
}
