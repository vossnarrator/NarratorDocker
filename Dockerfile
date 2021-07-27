FROM gradle:4.10-jdk8

USER root

WORKDIR /usr/src/app
COPY package*.json ./

RUN apt-get update && apt-get install -y mysql-client && apt-get install -y jq
RUN apt-get install -y git
RUN apt-get install -y openssh-client sshpass

ENV NODE_VERSION=12.6.0
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}

RUN rm -rf /var/lib/apt
