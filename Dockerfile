FROM gradle:4.10-jdk8

USER root

WORKDIR /usr/src/app
COPY package*.json ./

RUN apt-get update && apt-get install -y mysql-client && apt-get install -y jq
RUN apt-get install -y git
RUN apt-get install -y openssh-client sshpass

ENV NODE_VERSION=12.6.0
RUN mkdir /usr/local/nvm
ENV NVM_DIR /usr/local/nvm
ENV NVM_INSTALL_PATH $NVM_DIR/versions/node/v$NODE_VERSION
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN source $NVM_DIR/nvm.sh \
   && nvm install $NODE_VERSION \
   && nvm alias default $NODE_VERSION \
   && nvm use default
ENV NODE_PATH $NVM_INSTALL_PATH/lib/node_modules
ENV PATH $NVM_INSTALL_PATH/bin:$PATH
RUN npm install

RUN rm -rf /var/lib/apt
