FROM gradle:4.10-jdk8

USER root

WORKDIR /usr/src/app
COPY package*.json ./

RUN apt-get install -y curl \
  && curl -sL https://deb.nodesource.com/setup_9.x | bash - \
  && apt-get install -y nodejs \
  && curl -L https://www.npmjs.com/install.sh | sh

RUN apt-get update && apt-get install -y mysql-client && apt-get install -y jq 
RUN apt-get install -y git
RUN apt-get install -y openssh-client sshpass
RUN npm install
RUN rm -rf /var/lib/apt
