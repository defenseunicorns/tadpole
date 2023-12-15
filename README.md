# Tadpole

## Description

LeapfrogAI is a self-hosted AI platform designed to be deployed in air-gapped environments. Tadpole is the fastest way to get started with LeapfrogAI locally. It runs a docker compose build of the LeapfrogAI API, language backend, and user interface - culminating in a locally hosted "Chat with an LLM" demonstration.

> Disclaimer: This repo exists for demonstration purposes. For advanced production deployments, please select another deployment strategy from the [LeapfrogAI](https://github.com/defenseunicorns/leapfrogai) main repo.

This has been tested on Mac and Linux. If you run into any issues while following [Getting Started](#getting-started) please open an issue:

- [🐛Bug Report🐛](https://github.com/defenseunicorns/tadpole/issues/new?assignees=&labels=bug&projects=&template=bug_report.md&title=)
- [💻Feature Request💻](https://github.com/defenseunicorns/tadpole/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.md&title=)

## Prerequisites

* [Docker](https://www.docker.com/)
* [Continue.dev](Continue.dev) (For Code Recipe)

## Getting Started

Under the hood this repo uses docker-compose to run all the components. We have provided a simple set of basic recipes to get started with. By running any one of these recipes, Tadpole will automatically build, configure, and start the requisite components.

### Common Components

Regardless of which recipe you pick, API Swagger Documentation can be accessed at `http://localhost:8080/docs`.

### Chat

```shell
make chat
```

Leapfrog-UI will be running at `http://localhost:3000/`.

### Code

> This recipe is intended for use with a code extension such as [Continue.dev](continue.dev). 
> Tested with the v0.7.53 prerelease of [Continue.dev](continue.dev).

To build/run the code backend:

``` shell
make code
```

[Continue.dev](continue.dev) Configuration:
``` json
{
  "models":
  [{
    "title": "leapfrogai",
    "provider": "openai",
    "model": "leapfrogai",
    "apiKey": "freeTheModels",
    "apiBase": "http://localhost:8080/openai"
  }],
  "modelRoles": 
  {
      "default": "leapfrogai"
  }
}
```

### Cleanup

When you are done with Tadpole you can run this command to cleanup:

``` shell
make clean
```

## What's next?

To learn more about the rest of LeapfrogAI, please checkout the [LeapfrogAI GitHub Repo](https://github.com/defenseunicorns/leapfrogai)
