FROM ubuntu:17.10

RUN apt-get update
RUN apt-get install webhook nodejs npm git -y
RUN npm install -g @modelica/fmi-xc-scripts
RUN mkdir /etc/webhooks
COPY hooks.json /etc/webhooks

RUN mkdir /usr/build
COPY build.sh start.sh /usr/build/
RUN chmod +x /usr/build/build.sh /usr/build/start.sh

RUN mkdir /usr/build/data
COPY .gitconfig clone.js update.js package.json yarn.lock vendors.json /usr/build/data/
EXPOSE 9000

WORKDIR /usr/build
CMD /usr/build/start.sh
