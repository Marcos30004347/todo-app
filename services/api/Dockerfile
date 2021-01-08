# https://docs.nginx.com/nginx/admin-guide/installing-nginx/installing-nginx-docker/

FROM nginx:1.17.6-alpine
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d/
EXPOSE 80