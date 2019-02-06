# httpd-gateway


## Install

  git clone git@github.com:gpupo/httpd-gateway.git;

  cd httpd-gateway;

  make setup;

## Setup

Setup logstash server in ``.env.prod`` file:

    LOGSTASH_SERVER="foo.bar:5400"

or, without filebeat:

    ln -snf docker-compose.dev.yaml docker-compose.yaml; #Development env

## Usage
