# Terminate ec2 Instances

## About
This repo contains Bash shell script file to terminate AWS ec2 instances based on a condition. 
Going forward we will see the rule of thumb for termination.

## How it works?
The script looks for the "Expiration" tag for each of the instances in a specific region.
The Expiration tag is a custom tag that user creates at the time of ec2 instance creation.
The Expiration tag essential has the date of expiration i.e. once the expiration date passes the instance is ready for termination.

This script should be run on regular basis to automate garbage collection.

## Pre-requisites
The following are the pre-requisites to execute the shell script :
1. AWS CLI installed on your machine
2. jq CLI installed on your machine.

** jq is a command-line interface to parse json objects, array, strings...

## Configuration
Configure the AWS CLI to talk to your org AWS service.

[How to configure?](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

** Make sure you create a user with IAM privileges and use its key, secret to access AWS resources.

## Execute
Now everything is set-up to run the script. Use the command to run the script:

```command
#run the script
bash terminate-awsec2.sh
```

```aidl
#output on termination
{
    "TerminatingInstances": [
        {
            "InstanceId": "i-1234567890abcdef0",
            "CurrentState": {
                "Code": 32,
                "Name": "shutting-down"
            },
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
```
