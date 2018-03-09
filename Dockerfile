# Use this as the base image
FROM ubuntu:17.10

# We need to reload the index of available packages
RUN apt-get update
# Now install all the tools we will need
RUN apt-get install webhook nodejs npm git jekyll s3cmd -y
# Now install the XC scripts
RUN npm install -g @modelica/fmi-xc-scripts
# Create a directory to hold our webhooks configuration file...
RUN mkdir /etc/webhooks
# ...and copy that file there.
COPY hooks.json /etc/webhooks

# Make a build directory to do all our work in
RUN mkdir /usr/build
# Copy our build and start scripts there
COPY build.sh init.sh gen.sh webhook.sh /usr/build/
# ...and make them executable
RUN chmod +x /usr/build/*.sh

# Now create a data directory for all the vendor data
RUN mkdir /usr/build/data /usr/build/data/vendors
# Copy the files from this repository into the image so they are available there
COPY .gitconfig clone.js update.js package.json yarn.lock vendors.json /usr/build/data/

# Make directory for the site
RUN mkdir /usr/build/data/site

# Expose port 9000 for the webhook server
EXPOSE 9000

# Set our current directory to /usr/build
WORKDIR /usr/build

# By default, launch this in webhook mode
CMD /usr/build/webhook.sh
