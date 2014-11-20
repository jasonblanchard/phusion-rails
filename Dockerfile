# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-full:0.9.14

# Set correct environment variables.
ENV HOME /root

RUN rm /etc/nginx/sites-available/default

RUN echo "env PHUSIONDOCKER_DB_1_PORT_5432_TCP_ADDR;" >> /etc/nginx/main.d/default.conf
RUN echo "env PHUSIONDOCKER_DB_1_PORT_5432_TCP_PORT;" >> /etc/nginx/main.d/default.conf

RUN rm -f /etc/service/nginx/down

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD webapp.conf /etc/nginx/sites-enabled/webapp.conf

RUN mkdir /home/app/webapp
ADD . /home/app/webapp

WORKDIR /home/app/webapp

RUN bundle install
RUN RAILS_ENV=production rake assets:precompile

RUN chown -R app /home/app

ADD setup.sh /etc/my_init.d/01_setup.sh
RUN chmod a+x /etc/my_init.d/01_setup.sh

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
