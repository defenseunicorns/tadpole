# Tadpole

## Description

LeapfrogAI is a self-hosted AI platform designed to be deployed in air-gapped environments. Tadpole is the fastest way to get started with LeapfrogAI locally. It runs a docker compose build of the LeapfrogAI API, language backend, and user interface - culminating in a locally hosted "Chat with an LLM" demonstration.

> Disclaimer: This repo exists for demonstration purposes. For advanced production deployments, please select another deployment strategy from the [LeapfrogAI](https://github.com/defenseunicorns/leapfrogai) main repo.

This has been tested on Mac and Linux. If you run into any issues while following [Getting Started](#getting-started) please open an issue:

- [🐛Bug Report🐛](https://github.com/defenseunicorns/tadpole/issues/new?assignees=&labels=bug&projects=&template=bug_report.md&title=)
- [💻Feature Request💻](https://github.com/defenseunicorns/tadpole/issues/new?assignees=&labels=enhancement&projects=&template=feature_request.md&title=)

## Getting Started

This repo uses git submodules to pull in all the pieces of LeapfrogAI. To initialize all submodules:

``` shell
make submodules
```

The repo uses docker-compose to run all the components. Please use the provided make commands to ensure all configurations are set:

``` shell
make docker-compose-build
make docker-compose
```

### Accessing

Leapfrog-UI will be running at `http://localhost:3000/`.

API Swagger Documentation can be accessed at `http://localhost:8080/docs`.

### Cleanup

When you are done with Tadpole you can run this command to cleanup:

``` shell
make clean
```

## What's next?

To learn more about the rest of LeapfrogAI, please checkout the [LeapfrogAI GitHub Repo](https://github.com/defenseunicorns/leapfrogai)
