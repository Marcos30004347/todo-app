FROM ubuntu:latest
WORKDIR /api-service
COPY . /api-service

RUN apt-get update
RUN apt-get -y install curl gnupg
RUN apt-get update
RUN apt-get install -y openssl
RUN apt-get install -y make
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs
RUN npm install

RUN npm install -g grpc-tools grpc_tools_node_protoc_ts
RUN npm install

RUN make setup

EXPOSE 8080

ENTRYPOINT [ "npm", "start:dev" ]
