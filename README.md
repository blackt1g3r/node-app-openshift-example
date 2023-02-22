# node-app-k8s-example

Build a Node.js Application for k8s

## Prerequisites

To follow this tutorial, you will need:

- Docker installed

- Node.js and npm installed

- A Docker Hub account. For an overview of how to set this up, refer to this introduction on getting started with Docker Hub.

## Run the app locally

Run the app without containers locally. Inside the app dir, run:

```
npm install
node app.js
```

You should see the following output:

```
Example app listening on port 8080!
```

Access http://127.0.0.1:8080 to see the app running.

## Containerize the app

### Build the image

Builld the image with the following command:

```
docker build -t nodejs-demo .
```

### Run the container

To use that image, run the container with:

```
docker run --name nodejs-demo -p 80:8080 -d nodejs-demo
```

Access http://127.0.0.1:8080 to see the app running on the container.

## Deploy to kubernetes

PENDING

## run.sh

A script to automate the process is available:

```
./run.sh --help
```

To deploy the app locally use dev as an argument, add --build if you want to build the image before deploying.

```
./run.sh dev --build
```

### Prod

```
./run.sh prod --build
```
