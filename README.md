# httpd-gateway


## Install

    git clone https://github.com/gpupo/httpd-gateway.git;

    cd httpd-gateway;

    make setup;

## Setup

Setup logstash server value in ``.env.prod`` file:

    LOGSTASH_SERVER="foo.bar:5400"

or, without filebeat:

    ln -snf docker-compose.dev.yaml docker-compose.yaml; #Development env

## Usage

Start server

    make start;

Stop server

    make stop;

Help

    make
