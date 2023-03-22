# FROM --platform=linux/amd64 ubuntu:22.04
FROM ubuntu:22.04
LABEL maintainer="Siddiqua Mazhar <smazhar@email.arizona.edu>"
LABEL date_ctreated="03-07-2023"

ARG DEBIAN_FRONTEND=noninteractive
COPY requirements.txt /home/extractor/

WORKDIR /allCode

RUN apt-get update && apt-get install -y software-properties-common
RUN apt-get install -y git wget curl gnupg python3-pip python3-pymssql systemd libpam-systemd nano screen graphviz libgraphviz-dev pkg-config

RUN wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-6.0.list

# Update apt-get sources AND install MongoDB
RUN apt-get update && apt-get install -y mongodb-org

# Create the MongoDB data directory
RUN mkdir -p /data/db

# Create the MongoDB data directory
RUN mkdir -p /data/code

# CMD systemctl start mongod
# CMD systemctl enable mongod
# CMD systemctl status mongod

RUN pip install -r /home/extractor/requirements.txt

RUN [ -s /home/extractor/requirements.txt ] && \
    (echo "Install python modules" && \
    python3 -m pip install -U --no-cache-dir pip && \
    python3 -m pip install --no-cache-dir setuptools && \
    python3 -m pip install --no-cache-dir -r /home/extractor/requirements.txt && \
    rm /home/extractor/requirements.txt) || \
    (echo "No python modules to install" && \
    rm /home/extractor/requirements.txt)

RUN git clone --single-branch -b <branch> https://<token>@github.com/UA-KMAP/ua-kmap-data-collection.git /allCode/collection && \
    git clone --single-branch -b <branch> https://<token>i@github.com/UA-KMAP/kmap-core-processing.git /allCode/processing

# Expose port #27017 from the container to the host
EXPOSE 27017

WORKDIR /allCode

ENTRYPOINT [ "/bin/bash", "-l", "-c" ]
