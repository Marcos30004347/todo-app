FROM ubuntu:latest
WORKDIR /api-service
COPY . /api-service

RUN apt-get update
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
    ca-certificates

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get -y install nodejs

# RUN npm install -g grpc-tools grpc_tools_node_protoc_ts
RUN npm install

# RUN make setup

EXPOSE 8080

ENTRYPOINT [ "npm", "dev" ]
