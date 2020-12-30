
PROTOS_FOLDER=./protos

define print
	echo "\033[0;32m$(1)\033[0;39m"
endef


all: install-dependencies compile-protos

install-dependencies: install-grpc install-grpc-tools

install-grpc:
	$(call print,Installing gRPC)
	gem install grpc

install-grpc-tools:
	$(call print,Installing gRPC-Tools)
	gem install grpc-tools

compile-protos:
	for proto in $(foreach dir,$(PROTOS_FOLDER),$(wildcard $(dir)/*)) ; do \
		grpc_tools_ruby_protoc -I ${PROTOS_FOLDER} --ruby_out=lib --grpc_out=lib $$proto; \
	done


