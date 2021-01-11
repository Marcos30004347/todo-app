run:
	bundle exec ruby -Ilib/ruby/lib ./src/index.rb 

setup: install-dependencies compile-protos
	for script in `ls -d ./lib/bash/*`; do \
		chmod 777 $$script; \
	done
docker-image:
	docker build -t task-service .

run-docker-image:
	docker run -p 50051:50051 -d task-service:latest

run-docker-image-iterative:
	docker run -it -p 50051:50051 task-service:latest

install-dependencies:
	gem install bundler
	gem install grpc
	gem install grpc-tools
	bundle install

compile-protos:
	for proto in `ls -d ./protos/*`; do \
		grpc_tools_ruby_protoc -I ./protos --ruby_out=lib/ruby/lib --grpc_out=lib/ruby/lib $$proto; \
	done
