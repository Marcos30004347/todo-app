FROM ubuntu

WORKDIR /service:task
COPY . /service:task

RUN apt-get update
RUN apt-get install -y openssl
RUN apt-get install -y make
RUN apt-get install -y ruby

RUN gem install bundler

RUN gem install grpc
RUN gem install grpc-tools
RUN bundle install

EXPOSE 50051
ENTRYPOINT [ "make", "run-server" ]
