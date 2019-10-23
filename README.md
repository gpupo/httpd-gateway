# httpd-gateway


## Install

    git clone https://github.com/gpupo/httpd-gateway.git;

    cd httpd-gateway;

    make setup;

### Setup

Setup logstash server value in ``.env.prod`` file:

    LOGSTASH_SERVER="foo.bar:5400"

## Usage

Start server

    make alone;

Start server with Filebeat

    make start;

Stop server

    make stop;

Other commands:

    make help

## Configure new domains

In each App, the Docker configuration service of the webserver must include the information of the domain for which it will be responsible and then connect to the nginx-proxy network.

You can use webservers other than NGINX and you do not need to open the webserver port publicly, just expose it.

### Examples

Webserver with **HTTP** on port 80

```
version: '3.3'
#see https://www.openproject.org/docker/
services:
    openproject:
        image: openproject/community:8
        expose:
            - 80
        environment:
            - VIRTUAL_HOST=openproject.foo.bar
            - VIRTUAL_PORT=80
        networks:
            - default
networks:
    default:
        external:
            name: nginx-proxy
```

Webserver with **HTTPS** on port 443

```
version: '3.3'
#see https://hub.docker.com/r/linuxserver/pydio/
services:
    pydio:
        image: linuxserver/pydio
        expose:
            - 443
        environment:
            - VIRTUAL_HOST=pydio.foo.bar
            - VIRTUAL_PROTO=https
            - VIRTUAL_PORT=443
        networks:
            - default
networks:
    default:
        external:
            name: nginx-proxy
```


## Keep domais up

Edit ~/stage/config and include your domains

Put your Apps at ~/stage/${DOMAIN}/current and run ``make start`` or ``bin/up-stages.sh``

## Keep domais up after an update

sudo yum update -y && cd ~/httpd-gateway && make start


### Crontab (at boot)

  @reboot ~/httpd-gateway/start
