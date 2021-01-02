# Run System in detatched mode
system-up-detatched: \
system-setup \
system-update
	docker-compose up -d --build

# Run System
system-up: \
system-setup \
system-update
	docker-compose up --force-recreate

# Turn Off the running system
system-down:
	docker-compose down

# Update the services images
system-update:
	docker-compose rm -f
	docker-compose pull   

# Setup the system
system-setup:\
setup-task-service

# Setup the task service
setup-task-service:
	# Remove current lib folder and Replace it
	if [ -d "./services/task/lib" ]; then rm -Rf ./services/task/lib; fi
	cp -a ./shared/ruby/lib/. ./services/task/lib/
 
	# Remove current protos folder and Replace it
	if [ -d "./services/task/protos" ]; then rm -Rf ./services/task/protos; fi
	cp -a ./shared/protos/. ./services/task/protos/

	# Call Service setup
	make -C services/task setup
