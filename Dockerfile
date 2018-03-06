FROM ubuntu:17.10

RUN apt-get update
RUN apt-get install webhook nodejs npm -y
RUN npm install -g @modelica/fmi-xc-scripts
RUN mkdir /etc/webhooks
COPY hooks.json /etc/webhooks
RUN mkdir /usr/build
COPY build.sh /usr/build
RUN chmod +x /usr/build/build.sh
EXPOSE 9000
CMD webhook -verbose -hooks=/etc/webhooks/hooks.json
