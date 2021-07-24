docker build -t bde2020/flink-base:1.13.1-hadoop3.3.1 base
docker build -t bde2020/flink-master:1.13.1-hadoop3.3.1 master
docker build -t bde2020/flink-worker:1.13.1-hadoop3.3.1 worker
docker build -t bde2020/flink-submit:1.13.1-hadoop3.3.1 submit
docker build -t bde2020/flink-nginx:1.13.1-hadoop3.3.1 nginx