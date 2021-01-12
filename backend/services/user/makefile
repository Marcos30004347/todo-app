all:
	go build -o user-service src/main.go

# run:
#     ./user-service

dependencies:
	go get google.golang.org/protobuf/cmd/protoc-gen-go google.golang.org/grpc/cmd/protoc-gen-go-grpc
	PROTOC_ZIP=protoc-3.14.0-osx-x86_64.zip
	curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/$PROTOC_ZIP
	sudo unzip -o $PROTOC_ZIP -d /usr/local bin/protoc
	sudo unzip -o $PROTOC_ZIP -d /usr/local 'include/*'
	rm -f $PROTOC_ZIP
	export PATH="$PATH:$(go env GOPATH)/bin"

compile-protos:
	for service in `ls -d ./protos/*`; do \
		echo $$service; \
		for proto in `ls -d $$service/*`; do \
			protoc --go_out=./lib --go_opt=paths=source_relative \
			--go-grpc_out=./lib --go-grpc_opt=paths=source_relative \
			$$proto; \
		done; \
	done
