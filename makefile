word-equal = $(word $2,$(subst =, ,$1))
word-semi = $(word $2,$(subst ;, ,$1))

define print
	echo "\033[0;32m$(1)\033[0;39m"
endef

define printError
	echo "\033[0;31m$(1)\033[0;39m"
endef

# Run System in detatched mode
system-up-detatched: \
setup-libs \
system-update
	docker-compose up -d --build

# Run System
system-up: \
setup-libs \
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
system-setup: setup-protos setup-libs
	for path in $(foreach dir,./services,$(wildcard $(dir)/*)) ; do \
		make -C $$path setup; \
	done

setup-install-dependencies:
	for path in $(foreach dir,./services,$(wildcard $(dir)/*)) ; do \
		make -C $$path install-dependencies; \
	done

compile-protos:
	for path in $(foreach dir,./services,$(wildcard $(dir)/*)) ; do \
		$(call print,\nWorking on $$path); \
		if [ -f $$path/service.conf ]; then \
			env_file="$$path/service.conf";\
			echo using config file $$env_file; \
			\
			while IFS= read -r line || [[ -n "$$line" ]]; do\
				IFS== read -r left right <<< "$$line";\
				\
				if [[ $$left == service_libs ]]; then \
					echo $$right | tr \, \\n | while read val ; do \
						$(call print,Compiling proto files inside the '$$path/protos' folder); \
						for filename in $$path/protos/*.proto; do\
							if [[ $$val == ruby ]]; then \
								grpc_tools_ruby_protoc -I $$path/protos --ruby_out=$$path/lib/ruby/lib --grpc_out=$$path/lib/ruby/lib $$filename; \
							fi; \
						done; \
					done; \
				fi;\
			done < $$env_file;\
		else \
			$(call printError,No service.conf find in $$path);\
		fi; \
	done

setup-protos:
	for path in $(foreach dir,./services,$(wildcard $(dir)/*)) ; do \
		if [ -d "$$path/protos" ]; then rm -Rf $$path/protos; fi; \
		mkdir $$path/protos; \
		cp -a ./protos/. $$path/protos; \
	done

setup-libs:
	echo $(call word-equal,Name=Val,1)
	echo $(call word-equal,Name=Val,2)

	for path in $(foreach dir,./services,$(wildcard $(dir)/*)) ; do \
		$(call print,\nWorking on $$path); \
		if [ -f $$path/service.conf ]; then \
			env_file="$$path/service.conf";\
			echo using config file $$env_file; \
			$(call print,Setting $$path library folder); \
			if [ -d "$$path/lib" ]; then rm -Rf $$path/lib; fi; \
			mkdir $$path/lib; \
			\
			while IFS= read -r line || [[ -n "$$line" ]]; do\
				IFS== read -r left right <<< "$$line";\
				\
				if [[ $$left == service_libs ]]; then \
					echo $$right | tr \, \\n | while read val ; do \
						if [ -d "$$path/lib" ]; then \
							$(call print,Copying lib/$$val to $$path/lib); \
							cp -a ./lib/$$val/. $$path/lib/$$val; \
						fi; \
					done; \
				fi;\
			done < $$env_file;\
		else \
			$(call printError,No service.conf find in $$path); \
		fi; \
	done

# Setup the task service
setup-task-service:
	# Remove current lib folder and Replace it
	if [ -d "./services/task/lib" ]; then rm -Rf ./services/task/lib; fi
	cp -a ./lib/ruby/lib/. ./services/task/lib/

	# Call Service setup
	make -C services/task setup
