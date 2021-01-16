# FROM alpine:3.12

# ARG GOLANG_VERSION=1.14.3

# #we need the go version installed from apk to bootstrap the custom version built from source
# RUN apk update && apk add go curl git protoc unzip gcc make bash musl-dev openssl-dev ca-certificates && update-ca-certificates
# RUN wget https://dl.google.com/go/go$GOLANG_VERSION.src.tar.gz && tar -C /usr/local -xzf go$GOLANG_VERSION.src.tar.gz
# RUN cd /usr/local/go/src && ./make.bash
# ENV PATH=$PATH:/usr/local/go/bin
# RUN rm go$GOLANG_VERSION.src.tar.gz

# #we delete the apk installed version to avoid conflict
# RUN apk del go

# # RUN go get -u google.golang.org/grpc
# # RUN go get -u github.com/golang/protobuf/protoc-gen-go
# # RUN go get -u github.com/gogo/protobuf/proto
# # RUN go get -u github.com/gogo/protobuf/gogoproto
# # RUN go get -u github.com/gogo/protobuf/protoc-gen-gofast
# # RUN go get -u github.com/gogo/protobuf/protoc-gen-gogofaster
# # RUN go get -u github.com/gogo/protobuf/protoc-gen-gogoslick
# # RUN go get -u github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc
# # RUN go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
# # RUN go get -u github.com/gogo/protobuf/protoc-gen-gogo
# # RUN go get -u github.com/gogo/protobuf/protoc-gen-gogofast
# # RUN go get -u github.com/ckaznocha/protoc-gen-lint
# # RUN go get -u github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc
# # RUN go get -u github.com/golang/protobuf/protoc-gen-go
# RUN apk update && apk add git curl build-base autoconf automake libtool


# ENV PROTOBUF_URL https://github.com/google/protobuf/releases/download/v3.3.0/protobuf-cpp-3.3.0.tar.gz
# RUN curl -L -o /tmp/protobuf.tar.gz $PROTOBUF_URL
# WORKDIR /tmp/
# RUN tar xvzf protobuf.tar.gz
# WORKDIR /tmp/protobuf-3.3.0
# RUN mkdir /export
# RUN ./autogen.sh && \
#     ./configure --prefix=/export && \
#     make -j 3 && \
#     make check && \
#     make install

# # Install protoc-gen-go
# RUN go get github.com/golang/protobuf/protoc-gen-go
# RUN cp /go/bin/protoc-gen-go /export/bin/

# # Export dependencies
# RUN cp /usr/lib/libstdc++* /export/lib/
# RUN cp /usr/lib/libgcc_s* /export/lib/

# # RUN cp -a /tmp/googleapis/google/. /opt/include/google
# # RUN cp -a /tmp/api-common-protos/google/. /opt/include/google
# # RUN cp -a /tmp/grpc/bazel-grpc/external/com_google_protobuf/src/google/protobuf/. /opt/include/google/protobuf/
# # RUN cp -a /tmp/grpc/bazel-bin/external/com_google_protobuf/. /usr/local/bin/
# # RUN cp -a /tmp/grpc/bazel-bin/src/compiler/. /usr/local/bin/
# # RUN cp -a /usr/local/bin/prototool/. /usr/local/bin/prototool
# # RUN cp -a /usr/local/go/bin/. /usr/local/bin/
# # COPY --from=build /tmp/googleapis/google/ /opt/include/google
# # COPY --from=build /tmp/api-common-protos/google/ /opt/include/google

# # Copy well known proto files
# # COPY --from=build /tmp/grpc/bazel-grpc/external/com_google_protobuf/src/google/protobuf/ /opt/include/google/protobuf/
# # Copy protoc
# # COPY --from=build /tmp/grpc/bazel-bin/external/com_google_protobuf/ /usr/local/bin/
# # Copy protoc default plugins
# # COPY --from=build /tmp/grpc/bazel-bin/src/compiler/ /usr/local/bin/
# # # Copy protoc java plugin
# # COPY --from=build /tmp/grpc-java/bazel-bin/compiler/ /usr/local/bin/
# # Copy grpc_cli
# # COPY --from=build /tmp/grpc/bazel-bin/test/cpp/util/ /usr/local/bin/

# # COPY --from=build /usr/local/bin/prototool /usr/local/bin/prototool
# # COPY --from=build /go/bin/* /usr/local/bin/
# # COPY --from=build /tmp/grpc_web_plugin /usr/local/bin/grpc_web_plugin

# # COPY --from=build /tmp/protoc-gen-scala /usr/local/bin/

# # COPY --from=build /go/src/github.com/grpc-ecosystem/grpc-gateway/protoc-gen-openapiv2/options/ /opt/include/protoc-gen-openapiv2/options/

# # COPY --from=build /go/src/github.com/envoyproxy/protoc-gen-validate/ /opt/include/
# # COPY --from=build /go/src/github.com/mwitkow/go-proto-validators/ /opt/include/github.com/mwitkow/go-proto-validators/

# # ENV GO_PATH=~/go
# # ENV PATH=$PATH:/$GO_PATH/bin

# # ENV PATH=$PATH:$HOME/go/bin
# # ENV GOROOT=/usr/local/go
# # ENV GOPATH=$HOME/go
# # ENV GOBIN=$GOPATH/bin
# # ENV PATH=$PATH:$GOROOT:$GOPATH:$GOBIN

# WORKDIR /user-service
# COPY . /user-service

# RUN make compile-protos

# RUN go build

# ENTRYPOINT [ "./user-service" ]

FROM golang:1.12

RUN apt-get update && \
    apt-get -y install unzip && \
    apt-get -y install bzr

RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.9.1/protoc-3.9.1-linux-x86_64.zip && \
    unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local bin/protoc && \
    unzip -o protoc-3.9.1-linux-x86_64.zip -d /usr/local include/* && \
    rm -rf protoc-3.9.1-linux-x86_64.zip

RUN go get -u github.com/golang/protobuf/protoc-gen-go
# RUN go get -u github.com/gogo/protobuf/proto
RUN go get -u github.com/gogo/protobuf/gogoproto
RUN go get -u github.com/gogo/protobuf/protoc-gen-gofast
RUN go get -u github.com/gogo/protobuf/protoc-gen-gogo
RUN go get -u github.com/gogo/protobuf/protoc-gen-gogofast
RUN go get -u github.com/gogo/protobuf/protoc-gen-gogofaster
RUN go get -u github.com/gogo/protobuf/protoc-gen-gogoslick
# RUN go get -u github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc

RUN mkdir -p /go/src/github.com/google
RUN git clone --branch master https://github.com/google/protobuf /go/src/github.com/google/protobuf
RUN git clone --branch master https://github.com/openconfig/gnmi /go/src/github.com/openconfig/gnmi
RUN mkdir -p /go/src/github.com/
RUN wget "https://github.com/grpc/grpc-web/releases/download/1.0.5/protoc-gen-grpc-web-1.0.5-linux-x86_64" --quiet
RUN mv protoc-gen-grpc-web-1.0.5-linux-x86_64 /usr/local/bin/protoc-gen-grpc-web
RUN chmod +x /usr/local/bin/protoc-gen-grpc-web

RUN go get -u google.golang.org/protobuf/cmd/protoc-gen-go
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go

RUN go get -u google.golang.org/grpc/cmd/protoc-gen-go-grpc
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc

RUN go get google.golang.org/grpc/cmd/protoc-gen-go-grpc
RUN go install google.golang.org/grpc/cmd/protoc-gen-go-grpc
# WORKDIR "/go/src/github.com/"

# ENTRYPOINT ["/bin/bash"]

WORKDIR /user-service
COPY . /user-service

RUN if [ -f ./service/go.sum ]; then rm ./service/go.sum; fi

RUN make compile-protos

RUN make

ENTRYPOINT [ "./user-service" ]
