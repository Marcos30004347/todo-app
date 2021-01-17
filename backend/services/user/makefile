all:
	if [ -f executable ]; then rm executable; fi
	cd service && go build -o executable main.go
	cp service/executable .
	rm service/executable

run:
	./executable


docker-image:
	docker build -t user-service .

run-image:
	docker run -p 8080:8080 user-service:latest

compile-protos:
	if [ -d ./service/codegen ]; then rm -rf ./service/codegen; fi
	mkdir -p service/codegen
	for service in `ls -d ./protos/*`; do \
	  for serv_ver in `ls -d $$service/*`; do \
	    for proto in `ls -d $$serv_ver/*`; do \
		    protoc --go_opt=paths=source_relative --go-grpc_opt=paths=source_relative --go_out=./service/codegen --go-grpc_out=./service/codegen $$proto; \
      done; \
    done; \
	done
	mv ./service/codegen/protos ./service/codegen/pb
