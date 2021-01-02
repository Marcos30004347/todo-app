system-up-detatched: \
system-setup \
system-update
	docker-compose up -d --build

system-up: \
system-setup \
system-update
	docker-compose up --force-recreate

system-down:
	docker-compose down

system-update:
	docker-compose rm -f
	docker-compose pull   

system-prune:
	docker rmi -f $(docker images -q)
	docker system prune --force

system-setup:\
setup-task-service

setup-task-service:
	if [ -d "./services/task/lib" ]; then rm -Rf ./services/task/lib; fi
	cp -a ./shared/ruby/lib/. ./services/task/lib/
	make -C services/task setup
