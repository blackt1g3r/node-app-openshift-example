# node-app-openshift-example

Build a Node.js Application for Openshift

## Prerequisites

To follow this tutorial, you will need:

- Node.js and npm installed
- podman installed (To run the container locally for learning purposes)
- Podman installed
- An Openshift cluster where the application will run.
  - It should have the internal redistry exposed.

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
podman build -t nodejs-demo .
```

### Run the container

To use that image, run the container with:

```
podman run --name nodejs-demo -p 8090:8080 -d nodejs-demo
```

Access http://127.0.0.1:8080 to see the app running on the container.

## Deploy to Openshift

### Push the image

Login to Openshift:

```
oc login
```

Create a project:

```
oc project demo-project
```

Get the default route from the Openshift registry:

```
oc get route default-route -n openshift-image-registry
```

Save the route in a varibale to further usage:

```
HOST=$(oc get route default-route -n openshift-image-registry --template='{{ .spec.host }}')
```

Login to the registry:

```
podman login -u $(oc whoami) -p $(oc whoami -t) --tls-verify=false $HOST
```

You should see the following message:

```
Login Succeeded!
```

Tag the image:

```
podman tag nodejs-demo:$HOST/demo-project/nodejs-demo
```

Push the image:

```
podman push $HOST/demo-project/nodejs-demo
```

### Deploy and expose the app

Apply the manifest orchestration/deployment:

```
oc apply -f orchestration/deployment,yml
```

Create a service:

````
oc expose deployment nodejs-demo --name nodejs-demo-svc --port 8080 --target-port=8080```

Create a route:

````

oc expose service nodejs-demo-svc -l route=external --name=nodejs-demo

```

Access the application

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

```
