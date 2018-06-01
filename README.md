On this repository you will find all the necessary files to run the [parse server platform](http://parseplatform.org/) on your own machine using [docker](https://www.docker.com/community-edition) and [docker-compose](https://docs.docker.com/compose/).

The stack is composed by the following services:

* [parse server](http://parseplatform.org/)
* [mongodb](https://www.mongodb.com/download-center?jmp=nav#community)
* [mongo express](https://github.com/mongo-express/mongo-express)
* [parse dashboard](https://github.com/parse-community/parse-dashboard)

## Before you start

You need to install the following packages on you machine:

* [docker](https://www.docker.com/community-edition)
* [docker-compose](https://docs.docker.com/compose/)

## The docker-compose services

In our [docker-compose.yaml] file we have all the services declarations, we have the following services:

* mongo
* parse_server
* parse_dashboard
* mongo_express

To run some docker-compose commands we need to know the name of the service. If do not know about what I'm talking about, just go to the next session and go on, when you see SERVICE_NAME you will remember of this section. **If you read this!** ;)

## Running the parse server

### Running all the stack.

```bash
# We need to run mongo before any other services.
docker-compose up -d mongo && sleep 5 && docker-compose up -d
```

### See the logs of the service.

```bash
docker-compose logs -f SERVICE_NAME
```

### Stop and remove an service

```bash
docker-compose rm -sf
```

### Running a command inside the service container.

```bash
docker-compose exec SERVICE_NAME /bin/bash # or /bin/sh or any other command that you need.
```

## Cloud code

One of the most coolest features of parse server, is the [cloud code](http://docs.parseplatform.org/cloudcode/guide/). To enable this feature you need to uncomment the following line on the docker-compose.yaml file:

```bash
# Just remove the # on the beginning of the line.
# PARSE_SERVER_CLOUD: ${PARSE_SERVER_CLOUD:-./cloud/main.js}
```

### Where the parse server will looking for the cloud code

By default the parse server container will mount the host directory **/tmp/cloud** and will look for the file main.js inside this directory, but, the looking up procedure will only occours if you uncommend the line mentioned line above.

To set a new location for your custom cloud code, just change the following line on the docker-compose.yaml:

```yaml
    volumes:
      - /tmp/cloud:/parse-server/cloud
```

> Change only the **/tmp/cloud** otherwise the cloud code will not work properly.
This feature will only work if you uncomment the line mentioned on the previous section.

### Hot cloud code changing

This image is prepared for reload the parse server when the
