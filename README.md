# Simple Python web server

This is a simple python-based web server that shows how to build a parent container image that can be customized.  When using the parent image in a Dockerfile FROM statement, the build process will copy all files from the files/ directory and make them available via the web server.

## Build and test the parent image

    ./build.sh docker.io/tprinz/websvr
    docker run --rm --name base -d -p 8080:8080 docker.io/tprinz/websvr
    curl http://localhost:8080
    docker stop base

## Push the image to your repository

    docker push docker.io/tprinz/websvr

## Build and test a customized image

The test directory shows how this can be used as a parent image.  The FROM argument in the Dockerfile needs to be changed to reference your image repository.  Once that is done, run the following:

    cd test
    docker build -t test .
    docker run --rm --name mywebsvr -d -p 8080:8080 test
    curl http://localhost:8080
    docker stop mywebsvr

## Deploy a customized image to OpenShift

Build and deploy a customized image to OpenShift using Source-to-Image (s2i) and the docker build strategy:

    oc new-app --name mywebsvr https://github.com/t-prinz/container-webserver.git --strategy docker --context-dir test
    oc expose svc/mywebsvr
    curl http://`oc get route mywebsvr -o jsonpath='{.spec.host}{"\n"}'`
    oc delete all -l app=mywebsvr
