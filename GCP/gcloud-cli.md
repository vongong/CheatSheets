# Google Cloud CLI

The Google Cloud CLI (commonly known as the gcloud CLI) is the primary command-line tool used to create, manage, and automate Google Cloud Platform (GCP) resources.

## Getting Started
- [install guide](https://docs.cloud.google.com/sdk/docs/install-sdk)

### Initialize the gcloud CLI
It Creates a configuration named default for you and sets it as the active configuration
```sh
# Default
gcloud init

# remote terminal session
gcloud init --console-only

# View configuration properties
gcloud config list
```

### Auth Method
Initializing walks you through an authentication flow, sets up a gcloud CLI configuration.
- Authenticate and store credential
- Authenticate with a credential file
```sh
# Google Cloud user credentials
gcloud auth login

# Google Cloud Service Account
gcloud auth activate-service-account
gcloud auth activate-service-account --key-file /path-to/keyfile-name

# List all credentialed accounts
gcloud auth list
```

## cmds
- [gcloud ref](https://docs.cloud.google.com/sdk/gcloud/reference)
```sh
# View configuration properties
gcloud config list

# Project
## Get Active Project
gcloud config get project

## Set Active Project
gcloud config set project PROJECT_ID

# Compute
# note: Add --project only if it's not already your active project
## List VM
gcloud compute instances list
gcloud compute instances list --format json
gcloud compute instances list --project=PROJECT_ID --filter="name=INSTANCE_NAME"

## VM Status
## if zone is omitted, it will attempt to find correct zone.
gcloud compute instances describe INSTANCE_NAME --zone=ZONE --format='value(status)'

## VM Stop
gcloud compute instances stop INSTANCE_NAME --zone=ZONE
gcloud compute instances stop INSTANCE_1 INSTANCE_2 --zone=ZONE

## VM Start
gcloud compute instances start INSTANCE_NAME --zone=ZONE
gcloud compute instances start INSTANCE_1 INSTANCE_2 --zone=ZONE
```
