#! /bin/bash

docker build -t jasonblanchard/phusion-app2 . && \
  docker push jasonblanchard/phusion-app2 && \
  docker tag jasonblanchard/phusion-app2 jasonblanchard/phusion-app2:$(git rev-parse HEAD) && \
  docker push jasonblanchard/phusion-app2:$(git rev-parse HEAD)
