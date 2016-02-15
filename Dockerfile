FROM ubuntu:14.04

# Update
RUN sudo apt-get update
RUN sudo apt-get install -y mongodb-server build-essential libssl-dev git curl
RUN cd /tmp
RUN wget http://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz
RUN tar xvzf node-v0.10.40-linux-x64.tar.gz
RUN sudo rm -rf /opt/nodejs
RUN sudo mv node-v0.10.40-linux-x64 /opt/nodejs
RUN sudo ln -sf /opt/nodejs/bin/node /usr/bin/node
RUN sudo ln -sf /opt/nodejs/bin/npm /usr/bin/npm
RUN sudo apt-get install -y software-properties-common
RUN sudo apt-get install -y python-software-properties python g++ make
RUN sudo curl https://install.meteor.com | /bin/sh
RUN /usr/local/bin/meteor build ./build --directory

# Install app dependencies
COPY build/bundle/programs/server/package.json /src/package.json
RUN cd /src; npm install

# Bundle app source
COPY . /src

EXPOSE  8080
CMD ["usr/bin/node", "build/bundle/main.js"]