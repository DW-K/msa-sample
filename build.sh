#!/bin/bash
if [ $# -ne 1 ]
then
    echo "usage: $0 <docker hub ID>"
    exit 1
fi

USER=$1

list="catalogs config-client config-server customers eureka-server sidecar zuul-server"
#list="config-client"

for IMG in ${list}
do
  echo "===================================================================================================="
  echo "remove the existing images"
  echo "----------------------------s----------------------------------------------------------${IMG}"
  docker image rm ${IMG}
  docker image rm ${USER}/${IMG}
  echo "===================================================================================================="
  cd ./${IMG}
  pwd
  echo "----------------------------------------------------------------------------------------------------"
  echo "clean mvnw"
  chmod -R 777 ./
  ./mvnw clean package
  chmod -R 777 ./target/
  echo "----------------------------------------------------------------------------------------------------"

  echo "===================================================================================================="
  echo "make docker file"
  echo \
"FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY \${JAR_FILE} app.jar
ENTRYPOINT [\"java\",\"-jar\",\"/app.jar\"]" \
  > Dockerfile
  chmod -R 777 Dockerfile
  echo "===================================================================================================="

#  docker build --platform linux/amd64 -t ${IMG} .
#  chmod -R 777 ./target/
  docker build -t ${IMG} .
  chmod -R 777 ./target/
  docker tag ${IMG}:latest ${USER}/${IMG}:latest
  docker push ${USER}/msa_sample-${IMG}:latest
  cd ..
done

docker-compose pull
docker-compose build --no-cached
docker-compose up