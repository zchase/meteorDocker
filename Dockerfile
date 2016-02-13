FROM mvertes/alpine-mongo

# Update packages
RUN apk upgrade --update

# Install app dependencies
RUN apk add git curl apk-tools python wget g++ make
RUN cd /tmp; wget http://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz; tar xvzf node-v0.10.40-linux-x64.tar.gz; ls
RUN rm -rf /opt/nodejs; mv node-v0.10.40-linux-x64 /opt/nodejs; ln -sf /opt/nodejs/bin/node /usr/bin/node; ln -sf /opt/nodejs/bin/npm /usr/bin/npm
RUN curl https://install.meteor.com | /bin/sh
RUN meteor build ./build --directory
RUN cd build/bundle/programs/server/
COPY package.json /src/package.json
RUN cd /src; npm install

# Bundle app source
COPY build/* /src

EXPOSE  8080
CMD ["node", "/src/bundle/main.js"]