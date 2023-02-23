
#!/bin/bash

# Script to deploy the application to dev or prod. 
#./eks-scale-cluster.sh --help for usage



################################### Functions ##################################

usage() {
   usage="$(basename "$0") [env] [--build]  - Script to deploy the application to dev or prod. 
   where:
      - env: [dev|prod]. Choose dev to deploy locally or prod to deploy to k8s
      --build: optional argument, if you want to build the image before deploying."
      
   echo "$usage"
   exit 0
}
export -f usage
##################################### Main #####################################



# If no args were supplied
if [ $# -eq 0 ]; then
   echo "Error: No arguments supplied"
   usage


# to print the usage text
elif [ "$1" == "--help" ];then
   usage

# Start a local development environment based on docker
elif [ "$1" == "dev" ];then
    echo "Deploying dev environment..."
	if [ "$2" == "--build" ];then
        # Build image
        echo "Building  image"
        docker build -t nodejs-demo:latest .
    fi
    echo "Starting development environment"
    docker stop nodejs-demo
    docker rm nodejs-demo
    docker run --name nodejs-demo -p 8080:8080 -d nodejs-demo
    docker ps

# Deploy to k8s (prod) 
elif [ "$1" == "prod" ];then
    echo "Deploying prod environment..."
    # if [ "$2" == "--build" ];then
    #     # Build image
    #     echo "Building  image"
    #     docker build -t nodejs-demo:latest .
    # fi
else
   echo "Error: Not a valid argument"
   usage
fi