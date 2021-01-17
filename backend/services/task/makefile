run:
	bundle exec ruby -Iservice -Iservice/codegen/pb ./service/main.rb

setup: install-dependencies compile-protos

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
	if [ -d ./service/codegen ]; then rm -rf ./service/codegen/pb; fi
	mkdir -p ./service/codegen/pb
	for service in `ls -d ./protos/*`; do \
	  	for serv_ver in `ls -d $$service/*`; do \
	    	for proto in `ls -d $$serv_ver/*`; do \
			  	grpc_tools_ruby_protoc -I ./protos --ruby_out=service/codegen/pb --grpc_out=service/codegen/pb $$proto; \
      		done; \
    	done; \
	done

	# if [ -d "src/services/grpc" ]; then rm -rf src/services/grpc; fi
	# mkdir -p src/services/grpc

	# for proto in `ls -d ./protos/*`; do \
	# 	grpc_tools_ruby_protoc -I ./protos --ruby_out=src/services/grpc --grpc_out=src/services/grpc $$proto; \
	# done
