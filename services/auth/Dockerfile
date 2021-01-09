FROM ubuntu:latest

WORKDIR /auth-service
COPY . /auth-service

ENV DEBIAN_FRONTEND noninteractive

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
# RUN npm install -g grpc grpc-tools grpc_tools_node_protoc_ts
# RUN make setup

EXPOSE 8080

ENTRYPOINT [ "make", "run-dev" ]
