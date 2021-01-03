###Task Microservice

This service is responsable for managing all the tasks of the system

To properly run and create the service image, it is necessary to run 'make system-setup' from the root of the mono repo, this will setup all the shared libs and protobuf constracts.

To create the docker image run 'make docker-image'

Dependencies:
Ruby >= 2.6 