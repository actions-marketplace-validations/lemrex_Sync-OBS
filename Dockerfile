# Container image that runs your code
FROM ubuntu:latest

LABEL maintainer="Emeka Raphael <emekaralf@gmail.com>"

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY * ./

#COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

# Code file to execute when the docker container starts up
ENTRYPOINT ["/entrypoint.sh"]
