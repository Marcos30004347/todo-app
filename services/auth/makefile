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
	docker run -p 8080:8080 -d api-service:latest

run-image-iterative:
	docker run -it -p 8080:8080 api-service:latest

install-dependencies:
	npm-install

compile-protos:
	for proto in `ls -d ./protos/*`; do \
		grpc_tools_node_protoc \
		--js_out=import_style=commonjs,binary:lib/typescript/lib \
		--grpc_out=lib/typescript/lib  \
		--plugin=protoc-gen-grpc=./node_modules/.bin/grpc_tools_node_protoc_plugin  \
		-I ./protos  \
		$$proto; \
		\
		grpc_tools_node_protoc \
		--plugin=protoc-gen-ts=./node_modules/.bin/protoc-gen-ts \
		--ts_out=lib/typescript/lib \
		-I ./protos \
		$$proto; \
	done
