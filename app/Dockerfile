FROM ubuntu:16.04

WORKDIR /app

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade

ENV ENVIROMENT=production

RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install net-tools nginx

# Install nodejs as per http://askubuntu.com/questions/672994/how-to-install-nodejs-4-on-ubuntu-15-04-64-bit-edition
RUN apt-get -y update; apt-get -y install wget python build-essential git libfontconfig
RUN apt-get install -y \
    curl \
    gnupg \
    openssl \
    apt-utils \
    make \
    gcc \
    g++ \
    curl \
    dirmngr \
    apt-transport-https \
    lsb-release \
    ca-certificates \
    phantomjs \
    bzip2


RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get -y install nodejs

RUN npm install -g bower
RUN echo '{ "allow_root": true }' > /root/.bowerrc

RUN npm install -g ember-cli

COPY . /app

RUN rm -rf package-lock.json node_modules
RUN npm install

RUN ember build -prod

RUN mkdir -p /usr/share/nginx/var/log/nginx/
RUN touch /usr/share/nginx/var/log/nginx/access.log

RUN rm -f /etc/nginx/fastcgi.conf /etc/nginx/fastcgi_params && \
    rm -f /etc/nginx/snippets/fastcgi-php.conf

RUN rm -v /etc/nginx/nginx.conf

COPY ./etc/ /etc/

EXPOSE 80

RUN make setup

ENTRYPOINT ["make", "run"]
