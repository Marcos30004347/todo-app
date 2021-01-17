all:
	npm run build

run:
	npm run start

setup: compile-protos
	for script in `ls -d ./lib/bash/*`; do \
		chmod 777 $$script; \
	done

run-dev:
	npm run dev

docker-image:
	docker build -t api-service .

run-image:
	docker run api-service:latest

run-image-iterative:
	docker run -it api-service:latest

install-dependencies:
	npm-install

compile-protos:
	if [ -d ./service/codegen ]; then rm -rf ./service/codegen; fi
	mkdir -p ./service/codegen/pb
	for service in `ls -d ./protos/*`; do \
	  	for serv_ver in `ls -d $$service/*`; do \
	    	for proto in `ls -d $$serv_ver/*`; do \
				npx grpc_tools_node_protoc \
				--js_out=import_style=commonjs,binary:service/codegen/pb \
				--grpc_out=service/codegen/pb  \
				--plugin=protoc-gen-grpc=./node_modules/.bin/grpc_tools_node_protoc_plugin  \
				-I ./protos  \
				$$proto; \
				\
				npx grpc_tools_node_protoc \
				--plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
				--ts_out=service/codegen/pb \
				-I ./protos \
				$$proto; \
      		done; \
    	done; \
	done

	# if [ -d "src/services/grpc" ]; then rm -rf src/serviceS/grpc; fi

	# mkdir -p src/services/grpc

	# for proto in `ls -d ./protos/*`; do \
	# 	grpc_tools_node_protoc \
	# 	--js_out=import_style=commonjs,binary:lib/typescript/lib \
	# 	--grpc_out=src/services/grpc  \
	# 	--plugin=protoc-gen-grpc=./node_modules/.bin/grpc_tools_node_protoc_plugin  \
	# 	-I ./protos  \
	# 	$$proto; \
	# 	\
	# 	grpc_tools_node_protoc \
	# 	--plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
	# 	--ts_out=src/services/grpc \
	# 	-I ./protos \
	# 	$$proto; \
	# done