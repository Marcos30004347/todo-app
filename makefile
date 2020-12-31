system-up-detatched: system-update
	docker-compose -d up 
system-up: system-update
	docker-compose up --force-recreate --build
system-down:
	docker-compose down

system-update:
	docker-compose rm -f
	docker-compose pull   

system-prune:
	docker rmi $(docker images -q)
	docker system prune --force