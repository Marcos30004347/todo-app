run-detatched: setup update
	docker-compose up -d --build

run: setup update
	docker-compose up --force-recreate

api:
	docker-compose build api-service

user-service:
	docker-compose build user-service

task:
	docker-compose build task-service

auth:
	docker-compose build auth-service


stop:
	docker-compose down

update:
	docker-compose rm -f
	docker-compose pull   

cleanup:
	docker system prune -f -a

setup:
	for script in `ls -d ./scripts/*`; do \
		chmod 777 $$script; \
	done
	./scripts/setup-protos.sh


install-dependencies:
	for path in $(foreach dir,./services,$(wildcard $(dir)/*)) ; do \
		make -C $$path install-dependencies; \
	done
