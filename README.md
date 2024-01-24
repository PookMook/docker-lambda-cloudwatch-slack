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


## License

MIT License
