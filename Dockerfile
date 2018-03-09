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

# Now install the XC scripts
RUN npm install -g @modelica/fmi-xc-scripts

# Install jekyll and bundler
RUN gem install jekyll bundler

# Create a directory to hold our webhooks configuration file...
RUN mkdir /etc/webhooks

# ...and copy that file there.
COPY hooks.json /etc/webhooks

# CREATE a non-root user and work in /home/builder
RUN useradd -ms /bin/bash builder

# Make a build directory to do all our work in
# Copy our build and start scripts there
COPY build.sh init.sh gen.sh webhook.sh /home/builder/
# ...and make them executable

# Now create a data directory for all the vendor data
RUN mkdir /home/builder/data /home/builder/data/vendors
# Copy the files from this repository into the image so they are available there
COPY .gitconfig clone.js update.js package.json yarn.lock vendors.json /home/builder/data/

# Make directory for the site
RUN mkdir /home/builder/data/site

# Expose port 9000 for the webhook server
EXPOSE 9000

RUN chown -R builder /home/builder
RUN chmod +x /home/builder/*.sh
USER builder
WORKDIR /home/builder

# By default, launch this in webhook mode
CMD /home/builder/webhook.sh
