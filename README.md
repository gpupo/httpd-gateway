# httpd-gateway

[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/gpupo/httpd-gateway)



![mermaid-diagram](Resources/mermaid-diagram.svg?raw=true)

Components 

* https://github.com/nginx-proxy/nginx-proxy/
* https://github.com/nginx-proxy/acme-companion


## Install

    git clone https://github.com/gpupo/httpd-gateway.git;

    cd httpd-gateway;

    make setup;

## Usage

Start server

    make start;

Start server [Sem proxy server]

    make boot@alone;

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
            name: frontendNetwork
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
            name: frontendNetwork
```


## Keep domais up

Edit ~/stage/config and include your domains

Put your Apps at ~/stage/${DOMAIN}/current and run ``make start`` or ``bin/up-stages.sh``

## Keep domais up after an update

sudo yum update -y && cd ~/httpd-gateway && make start


### Crontab (at boot)

Setup log file

  sudo touch /var/log/httpd-gateway;
  sudo chmod 666 /var/log/httpd-gateway;

Add to crontab

  @reboot ~/httpd-gateway/boot >> /var/log/httpd-gateway 2>&1
