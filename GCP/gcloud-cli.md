# Google Cloud CLI

The Google Cloud CLI (commonly known as the gcloud CLI) is the primary command-line tool used to create, manage, and automate Google Cloud Platform (GCP) resources. 

## Getting Started
- [install guide](https://docs.cloud.google.com/sdk/docs/install-sdk)
- Google Cloud CLI requires Python; supported versions are Python 3.10 to 3.14. By default, the Windows version of Google Cloud CLI comes bundled with Python 3.
```sh
# Debian/Ubuntu
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update 
sudo apt-get install google-cloud-cli
gcloud version
```

### Initialize the gcloud CLI
It Creates a configuration named default for you and sets it as the active configuration
```sh
# Default
gcloud init
gcloud init --no-browser    # no browser on local machine; can run gcloud cli on another machine with browser
gcloud init --console-only  # no browser on local machine; cannot run gcloud cli on another machine with browser

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
gcloud auth login --no-launch-browser

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
