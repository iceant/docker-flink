[![Build Status](https://travis-ci.org/big-data-europe/docker-flink.svg?branch=master)](https://travis-ci.org/big-data-europe/docker-flink)
[![Twitter](https://img.shields.io/twitter/follow/BigData_Europe.svg?style=social)](https://twitter.com/BigData_Europe)
# Flink docker

Apache Flink docker images to:
* Setup a standalone [Apache Flink](http://flink.apache.org/) cluster running one Flink Master and multiple Flink workers
* Build Flink applications in Scala, Java or Python to run on a Flink cluster

Currently supported versions:
* Flink 1.12.2 for Hadoop 3.2 and Scala 2.11
* Flink 1.7.2 for Hadoop 2.8 and Scala 2.11
* Flink 1.7.2 for Hadoop 2.7 and Scala 2.11
* Flink 1.7.1 for Hadoop 2.8 and Scala 2.11
* Flink 1.7.1 for Hadoop 2.7 and Scala 2.11
* Flink 1.7.0 for Hadoop 2.8 and Scala 2.11
* Flink 1.7.0 for Hadoop 2.7 and Scala 2.11
* Flink 1.6.3 for Hadoop 2.8 and Scala 2.11
* Flink 1.6.3 for Hadoop 2.7 and Scala 2.11
* Flink 1.6.2 for Hadoop 2.8 and Scala 2.11
* Flink 1.6.2 for Hadoop 2.7 and Scala 2.11
* Flink 1.6.1 for Hadoop 2.8 and Scala 2.11
* Flink 1.6.1 for Hadoop 2.7 and Scala 2.11
* Flink 1.6.0 for Hadoop 2.8 and Scala 2.11
* Flink 1.6.0 for Hadoop 2.7 and Scala 2.11
* Flink 1.5.5 for Hadoop 2.8 and Scala 2.11
* Flink 1.5.5 for Hadoop 2.7 and Scala 2.11
* Flink 1.5.4 for Hadoop 2.8 and Scala 2.11
* Flink 1.5.4 for Hadoop 2.7 and Scala 2.11
* Flink 1.5.3 for Hadoop 2.8 and Scala 2.11
* Flink 1.5.3 for Hadoop 2.7 and Scala 2.11
* Flink 1.5.2 for Hadoop 2.8 and Scala 2.11
* Flink 1.5.2 for Hadoop 2.7 and Scala 2.11
* Flink 1.5.1 for Hadoop 2.8 and Scala 2.11
* Flink 1.5.1 for Hadoop 2.7 and Scala 2.11
* Flink 1.5.0 for Hadoop 2.8 and Scala 2.11
* Flink 1.5.0 for Hadoop 2.7 and Scala 2.11
* Flink 1.4.2 for Hadoop 2.8 and Scala 2.11
* Flink 1.4.2 for Hadoop 2.7 and Scala 2.11
* Flink 1.4.1 for Hadoop 2.8 and Scala 2.11
* Flink 1.4.1 for Hadoop 2.7 and Scala 2.11
* Flink 1.4.0 for Hadoop 2.8 and Scala 2.11
* Flink 1.4.0 for Hadoop 2.7 and Scala 2.11
* Flink 1.3.2 for Hadoop 2.7 and Scala 2.11
* Flink 1.3.1 for Hadoop 2.7 and Scala 2.11
* Flink 1.3.0 for Hadoop 2.7 and Scala 2.11
* Flink 1.2.1 for Hadoop 2.7 and Scala 2.11
* Flink 1.2.0 for Hadoop 2.7 and Scala 2.11
* Flink 1.1.4 for Hadoop 2.7 and Scala 2.11
* Flink 1.1.3 for Hadoop 2.7 and Scala 2.11
* Flink 0.10.2 for Hadoop 2.7 and Scala 2.11
* Flink 0.10.1 for Hadoop 2.7 and Scala 2.11

## Using Docker Compose

Add the following services to your `docker-compose.yml` to integrate a Flink master and Flink worker in [your BDE pipeline](https://github.com/big-data-europe/app-bde-pipeline):
```yml
flink-master:
   image: bde2020/flink-master:1.13.1-hadoop3.3.1
   hostname: flink-master
   container_name: flink-master
   environment:
      - INIT_DAEMON_STEP=setup_flink
#     - "constraint:node==<yourmasternode>"

   ports:
     - "8080:8080"
     - "8081:8081"

 flink-worker:
   image: bde2020/flink-worker:1.13.1-hadoop3.3.1
   hostname: flink-worker
   container_name: flink-worker
   environment:
     - FLINK_MASTER_PORT_6123_TCP_ADDR=flink-master
#    - FLINK_NUM_TASK_SLOTS=2
#    - "constraint:node==<yourworkernode>"
   depends_on:
      - "flink-master"

```

## Running Docker containers without the init daemon

    docker network create flink-net

## Flink Master
To start a Flink master:

    docker run --name flink-master --net flink-net -e ENABLE_INIT_DAEMON=false -d bde2020/flink-master:1.13.1-hadoop3.3.1

## Flink Worker
To start a Flink worker:

    docker run --name flink-worker --net flink-net -e ENABLE_INIT_DAEMON=false -e FLINK_MASTER_PORT_6123_TCP_ADDR=flink-master -d bde2020/flink-worker:1.13.1-hadoop3.3.1

## Launch a Flink application
Building and running your Flink application on top of the Flink cluster is as simple as extending a template Docker image. Check the template's README for further documentation.
* [Maven template](template/maven)
* [Sbt template](template/sbt)

# example
1. startup 
   ```sh
   docker compose -f .\docker-compose-nginx.yml up -d
   ```
2. inside flink-master box
    ```sh
    docker compose -f .\docker-compose-nginx.yml exec flink-master bash
    ```
3. run WordCount
   ```sh
   cd /usr/local/flink
   ./bin/flink run ./examples/batch/WordCount.jar
   ```
   ```sh
   cd /usr/local/flink
   ./bin/flink run ./examples/batch/WordCount.jar --input /usr/local/flink/README.txt
   ```   
4. check Flink Dashboard
   Visit `http://localhost/` will show you the Flink Dashboard
