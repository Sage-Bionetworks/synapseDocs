#!/usr/bin/env bash

# Push site to s3 only on master
if [ "$TRAVIS_BRANCH" == "master" ]; then
  bundle exec s3_website push
fi
