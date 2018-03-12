## This script creates a Docker image that is capable of integrating FMI cross-check data and 
## uploading it to the FMI web site.

# Use this as the base image
FROM ubuntu:17.10

# We need to reload the index of available packages
RUN apt-get update

# Now install all the tools we will need
RUN apt-get install nodejs npm -y
RUN apt-get install git -y
RUN apt-get install s3cmd -y
RUN apt-get install ruby ruby-dev -y
RUN apt-get install webhook -y
RUN apt-get install vim -y
RUN apt-get install sudo -y

# Now install the XC scripts
RUN npm install -g @modelica/fmi-xc-scripts
RUN npm install -g netlify-cli

# Install jekyll and bundler
RUN gem install jekyll bundler

# Create a directory to hold our webhooks configuration file...
RUN mkdir /etc/webhooks

# ...and copy that file there.
COPY hooks.json /etc/webhooks

# Create a non-root user to do the actual work and a home directory for that
# user in /home/builder
RUN useradd -ms /bin/bash builder && adduser builder sudo

# Copy our build and start scripts to the working directory
COPY build.sh init.sh gen.sh webhook.sh /home/builder/

# Now create a data directory for all the vendor data
RUN mkdir /home/builder/data /home/builder/data/vendors
# Copy the files from this repository into the image so they are available there
COPY .gitconfig s3.cfg clone.js update.js package.json yarn.lock vendors.json /home/builder/data/

# Make directory for the site
RUN mkdir /home/builder/data/site /home/builder/data/output

# Expose port 9000 for the webhook server
EXPOSE 9000

# Allow AWS credentials and parameters 
ENV NETLIFY_TOKEN ""
ENV NETLIFY_SITE 99c55eb2-e26a-4fc1-bfdc-e994b24f6d1b

RUN chown -R builder /home/builder
RUN chmod +x /home/builder/*.sh
USER builder
WORKDIR /home/builder

# By default, launch this in webhook mode
CMD /home/builder/webhook.sh
