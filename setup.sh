#! /bin/bash

cd /home/app/webapp && RAILS_ENV=production rake db:create && RAILS_ENV=production rake db:migrate
