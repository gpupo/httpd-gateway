FROM jwilder/nginx-proxy

RUN wget -q https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.4.0-amd64.deb;\
    dpkg -i filebeat-6.4.0-amd64.deb; rm filebeat-6.4.0-amd64.deb;\
    unlink /var/log/nginx/access.log; touch /var/log/nginx/access.log; \
    unlink /var/log/nginx/error.log; touch /var/log/nginx/error.log;

COPY .bashrc /root/
COPY  nginx.conf /etc/nginx/nginx.conf
