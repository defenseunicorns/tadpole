# Tadpole

## Description

This repo is the fastest way to get started with LeapfrogAI. This has been tested on Mac and Linux. If you run into any issues while following [Getting Started](#getting-started), please open an issue so we can improve the experience for everyone!

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

## What's next?

To learn more about the rest of LeapfrogAI, please checkout the [LeapfrogAI GitHub Repo](https://github.com/defenseunicorns/leapfrogai)