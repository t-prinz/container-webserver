# Simple Python web server

This is a simple python-based web server that shows how to build a parent container image that can be customized.  When using the parent image in a Dockerfile FROM statement, the build process will copy all files from the files/ directory and make them available via the web server.

To build the parent image

./build.sh docker.io/tprinz/websvr
docker run --rm --name base -d -p 8080:8080 docker.io/tprinz/websvr
curl http://localhost:8080
docker stop base

Push the image to your repository

docker push docker.io/tprinz/websvr

The test directory shows how this can be used as a parent image.  The FROM argument in the Dockerfile needs to be changed to reference your image repository.  Once that is done, run the following:

cd test
docker build -t test .
docker run --rm --name mywebsvr -d -p 8080:8080 test
curl http://localhost:8080
docker stop mywebsvr

The parent image can be deployed to OpenShift by running the following:

oc new-app --name mywebsvr https://github.com/t-prinz/container-webserver.git --strategy docker --context-dir test
oc expose svc/websvr
