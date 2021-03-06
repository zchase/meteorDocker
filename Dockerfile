FROM ubuntu:14.04
ENV     MONGO_URL="mongodb://localhost:27017/todos" ROOT_URL="http://162.243.233.228"

# Update
RUN sudo apt-get update
RUN sudo apt-get install -y mongodb-server build-essential libssl-dev git curl wget
RUN cd /tmp
RUN wget http://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz; tar xvzf node-v0.10.40-linux-x64.tar.gz
RUN sudo rm -rf /opt/nodejs; sudo mv node-v0.10.40-linux-x64 /opt/nodejs; sudo ln -sf /opt/nodejs/bin/node /usr/bin/node; sudo ln -sf /opt/nodejs/bin/npm /usr/bin/npm
RUN sudo apt-get install -y software-properties-common python-software-properties python g++ make

# Install app dependencies
COPY build/bundle/programs/server/package.json /src/package.json
RUN cd /src; npm install

# Bundle app source
RUN ls
COPY . /src

EXPOSE  3000
CMD ["usr/bin/node", "src/build/bundle/main.js"]