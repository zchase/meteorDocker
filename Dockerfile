FROM alpine:3.1

# Add Testing Repo for Alpine
RUN echo "@testing \http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Install app dependencies
RUN apk add --update mongodb@testing libssl1.0 git curl apk-tools python wget g++ make
RUN cd /tmp; wget http://nodejs.org/dist/v0.10.40/node-v0.10.40-linux-x64.tar.gz; tar xvzf node-v0.10.40-linux-x64.tar.gz
RUN rm -rf /opt/nodejs; mv node-v0.10.40-linux-x64 /opt/nodejs; ln -sf /opt/nodejs/bin/node /usr/bin/node; ln -sf /opt/nodejs/bin/npm /usr/bin/npm
RUN curl https://install.meteor.com | /bin/sh
RUN cd build/bundle/programs/server/
COPY package.json /src/package.json
RUN cd /src; npm install

# Bundle app source
COPY build/* /src

EXPOSE  8080
CMD ["node", "/src/bundle/main.js"]