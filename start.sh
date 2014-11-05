#! /bin/bash

docker run -it -v $(pwd):/home/app/webapp -p 80:80 jasonblanchard/phusion-app /sbin/my_init -- bash -l
