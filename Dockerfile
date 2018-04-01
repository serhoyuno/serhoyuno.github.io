# Runs Jekyll under Nginx with Passenger

FROM phusion/passenger-ruby21:0.9.15
MAINTAINER Fernando Rivas "fenandos@hotmail.com"

# Set environment variables
ENV HOME /home/app

# Use baseimage-docker's init process
CMD ["/sbin/my_init"]

# Expose Nginx HTTP service
EXPOSE 80

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the Nginx site and config
COPY nginx.conf /etc/nginx/sites-enabled/serhoyuno.com.conf

# Install bundle of gems
WORKDIR /tmp
COPY Gemfile /tmp/
COPY Gemfile.lock /tmp/
RUN bundle install

# Add the Passenger app
COPY . /home/app
RUN chown -R app:app /home/app

# Build the app with Jekyll
WORKDIR /home/app
RUN jekyll build --watch --incremental

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
