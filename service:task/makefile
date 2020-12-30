include utils.mk

PROTOS_FOLDER=./protos

##################################################
## Common
##################################################
all: \
install-dependencies \
compile-protos 


##################################################
## Run's
##################################################
run-server:
	$(call print,Starting the Server)
	bundle exec ./src/server.rb

run-client:
	$(call print,Starting the Client)
	bundle exec ./src/client.rb


##################################################
## Docker Images
##################################################
image:
	$(call print,Building Docker image)
	docker build -t task-service .

run-image:
	$(call print,Starting docker image)
	docker run -p 50051:50051 -d task-service:latest

run-image-iterative:
	$(call print,Starting docker image iterativelly)
	docker run -it -p 50051:50051 task-service:latest

##################################################
## Dependencies
##################################################
install-dependencies: \
install-bundler \
install-ruby-dependencies

install-bundler:
	$(call print,Installing bundler)
	gem install bundler

install-grpc:
	$(call print,Installing gRPC)
	gem install grpc

install-grpc-tools:
	$(call print,Installing gRPC-Tools)
	gem install grpc-tools

install-ruby-dependencies:
	$(call print,Installing Ruby Gem dependencies)
	bundle install


##################################################
## Protobufs
##################################################
compile-protos:
	$(call print,Compiling proto files inside the './protos' folder)
	for proto in $(foreach dir,$(PROTOS_FOLDER),$(wildcard $(dir)/*)) ; do \
		grpc_tools_ruby_protoc -I ${PROTOS_FOLDER} --ruby_out=lib --grpc_out=lib $$proto; \
	done


