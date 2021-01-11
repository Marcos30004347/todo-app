# https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/

FROM nginx:1.17.6-alpine
RUN rm /etc/nginx/conf.d/default.conf

RUN echo "/etc/nginx/nginx.conf"

COPY ./etc/nginx/conf.d/ /etc/nginx/conf.d/
EXPOSE 1000