PROTOS_FOLDER=./protos
PASSPHRASE?=1234

define print
	echo "\033[0;32m$(1)\033[0;39m"
endef

##################################################
## Common
##################################################
setup:\
install-dependencies\
compile-protos\
create-certificates

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

##################################################
## Security
##################################################
# https://jamielinux.com/docs/openssl-certificate-authority/create-the-root-pair.html
# https://roll.urown.net/ca/ca_root_setup.html
# https://stackoverflow.com/questions/37714558/how-to-enable-server-side-ssl-for-grpc
serial:
	openssl rand -hex 16 > serial

create-certificates:\
certificates-setup\
ca-key\
ca-certificate\
server-key\
server-signing-req\
server-sign-certificate\
server-remove-passphrase\
client-key\
client-signing-req\
client-sign-certificate\
client-remove-passphrase\

certificates-setup:
	if [ -d "./certs" ]; then rm -Rf ./certs; fi
	mkdir certs

ca-key:
	$(call print,Generate CA key:)
	openssl genrsa -passout pass:$(PASSPHRASE) -des3 -out certs/ca.key 4096

ca-certificate:
	$(call print,Generate CA certificate:)
	openssl req -passin pass:$(PASSPHRASE) -new -x509 -days 365 -key certs/ca.key -out certs/ca.crt -subj  "/C=BR/ST=MG/L=Belo Horizonte/O=YourCompany/OU=ToDoApp/CN=MyRootCA" -config config.conf

server-key:
	$(call print,Generate server key:)
	openssl genrsa -passout pass:$(PASSPHRASE) -des3 -out certs/server.key 4096

server-signing-req:
	$(call print,Generate server signing request:)
	openssl req -passin pass:$(PASSPHRASE) -new -key certs/server.key -out certs/server.csr -subj  "/C=BR/ST=MG/L=Belo Horizonte/O=YourCompany/OU=ToDoApp/CN=localhost" -config config.conf

server-sign-certificate:
	$(call print,Self-sign server certificate:)
	openssl x509 -req -passin pass:$(PASSPHRASE) -days 365 -in certs/server.csr -CA certs/ca.crt -CAkey certs/ca.key -set_serial 01 -out certs/server.crt

server-remove-passphrase:
	$(call print,Remove passphrase from server key:)
	openssl rsa -passin pass:$(PASSPHRASE) -in certs/server.key -out certs/server.key

client-key:
	$(call print,Generate client key:)
	openssl genrsa -passout pass:$(PASSPHRASE) -des3 -out certs/client.key 4096

client-signing-req:
	$(call print,Generate client signing request:)
	openssl req -passin pass:$(PASSPHRASE) -new -key certs/client.key -out certs/client.csr -subj  "/C=BR/ST=MG/L=Belo Horizonte/O=YourCompany/OU=ToDoApp/CN=client" -config config.conf

client-sign-certificate:
	$(call print,Self-sign client certificate:)
	openssl x509 -passin pass:$(PASSPHRASE) -req -days 365 -in certs/client.csr -CA certs/ca.crt -CAkey certs/ca.key -set_serial 01 -out certs/client.crt

client-remove-passphrase:
	$(call print,Remove passphrase from client key:)
	openssl rsa -passin pass:$(PASSPHRASE) -in certs/client.key -out certs/client.key
