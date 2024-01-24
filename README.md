# Docker-cloudwatch-slack

This is a fork of assertible/lambda-cloudwatch-slack to build a public docker image for the cloudwatch to lambda code.
This is only a convenience thing to be able to set a docker image rather than upload your own code.

Does not support encrypted hook URLs. feel free to PR if you want it (you can find implematation example in the base of the fork)

Use at your own risks.

## Run via docker-compose

Make sure to populate the `.env` file by copying from .env.example and setting the correct webhook URL.
After so you can run the following command

```sh
docker-compose up 
```

this will start a docker container on port 9000, you can then run curl request to it to test further, for instance:

```sh
curl -XPOST "http://localhost:9000/2015-03-31/functions/function/invocations" -d '{  "Records": [    {      "EventSource": "aws:sns",      "EventVersion": "1.0",      "EventSubscriptionArn": "arn:aws:sns:us-west-2:123456789123:CloudWatchNotifications:00000000-0000-0000-0000-000000000000",      "Sns": {        "Type": "Notification",        "MessageId": "00000000-0000-0000-0000-000000000000",        "TopicArn": "arn:aws:sns:us-west-2:123456789123:CloudWatchNotifications",        "Timestamp": "2016-08-11T07:24:05.959Z",        "Subject": "ALARM: \"awsrds-app-High-DB-Connections\" in US West - Oregon",        "Message": "{\"AlarmName\":\"awsrds-app-High-DB-Connections\",\"AlarmDescription\":null,\"AWSAccountId\":\"123456789123\",\"NewStateValue\":\"ALARM\",\"NewStateReason\":\"Threshold Crossed: 1 datapoint (10.0) was greater than or equal to the threshold (10.0).\",\"StateChangeTime\":\"2016-07-24T22:05:19.737+0000\",\"Region\":\"US West - Oregon\",\"OldStateValue\":\"OK\",\"Trigger\":{\"MetricName\":\"DatabaseConnections\",\"Namespace\":\"AWS/RDS\",\"Statistic\":\"AVERAGE\",\"Unit\":null,\"Dimensions\":[{\"name\":\"DBInstanceIdentifier\",\"value\":\"app\"}],\"Period\":300,\"EvaluationPeriods\":1,\"ComparisonOperator\":\"GreaterThanOrEqualToThreshold\",\"Threshold\":10.0}}",        "MessageAttributes": {}      }    }  ]}'

```


# lambda-cloudwatch-slack

An [AWS Lambda](http://aws.amazon.com/lambda/) function for better Slack notifications. 
[Check out the blog post](https://assertible.com/blog/npm-package-lambda-cloudwatch-slack).

[![BuildStatus](https://travis-ci.org/assertible/lambda-cloudwatch-slack.png?branch=master)](https://travis-ci.org/assertible/lambda-cloudwatch-slack)
[![NPM version](https://badge.fury.io/js/lambda-cloudwatch-slack.png)](http://badge.fury.io/js/lambda-cloudwatch-slack)


## Overview

This function was originally derived from the
[AWS blueprint named `cloudwatch-alarm-to-slack`](https://aws.amazon.com/blogs/aws/new-slack-integration-blueprints-for-aws-lambda/). The
function in this repo improves on the default blueprint in several
ways:

**Better default formatting for CloudWatch notifications:**

![AWS Cloud Notification for Slack](https://github.com/assertible/lambda-cloudwatch-slack/raw/master/images/cloudwatch.png)

**Support for notifications from Elastic Beanstalk:**

![Elastic Beanstalk Slack Notifications](https://github.com/assertible/lambda-cloudwatch-slack/raw/master/images/elastic-beanstalk.png)

**Support for notifications from Code Deploy:**

![AWS CodeDeploy Notifications](https://github.com/assertible/lambda-cloudwatch-slack/raw/master/images/code-deploy.png)

**Basic support for notifications from ElastiCache:**

![AWS ElastiCache Notifications](https://github.com/assertible/lambda-cloudwatch-slack/raw/master/images/elasticache.png)

**Support for encrypted and unencrypted Slack webhook url:**


## Configuration

### 1. Clone this repository

### 2. Configure environment variables

```
cp .env.example .env
```

Fill in the variables in the `.env`. 

### 3. Setup Slack hook

Follow these steps to configure the webhook in Slack:

  1. Navigate to
     [https://slack.com/services/new](https://slack.com/services/new)
     and search for and select "Incoming WebHooks".

  3. Choose the default channel where messages will be sent and click
     "Add Incoming WebHooks Integration".

  4. Copy the webhook URL from the setup instructions and use it in
     the next section.

  5. Click 'Save Settings' at the bottom of the Slack integration
     page.

#### Encrypted the Slack webhook URL

If you don't want or need to encrypt your hook URL, you can use the
`UNENCRYPTED_HOOK_URL`.  If this variable is specified, the
`KMS_ENCRYPTED_HOOK_URL` is ignored.

If you **do** want to encrypt your hook URL, follow these steps to
encrypt your Slack hook URL for use in this function:

  1. Create a KMS key -
     http://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html.

  2. Encrypt the event collector token using the AWS CLI.
     $ aws kms encrypt --key-id alias/<KMS key name> --plaintext "<SLACK_HOOK_URL>"

     Note: You must exclude the protocol from the URL
     (e.g. "hooks.slack.com/services/abc123").

  3. Copy the base-64 encoded, encrypted key (CiphertextBlob) to the
     ENCRYPTED_HOOK_URL variable.

  4. Give your function's role permission for the kms:Decrypt action.
     Example:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1443036478000",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt"
            ],
            "Resource": [
                "<your KMS key ARN>"
            ]
        }
    ]
}
```


### 4. Deploy to AWS Lambda

The final step is to deploy the integration to AWS Lambda:

    npm install
    npm run deploy

## Tests

With the variables filled in, you can test the function:

```
npm install
npm test
```

## License

MIT License
