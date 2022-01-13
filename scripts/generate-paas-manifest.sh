#!/usr/bin/env bash

#define parameters which are passed in.
APPLICATION_NAME=$1  # e.g. mhclg-epb-something-api-integration

cat << EOF
---
applications:
  - name: $APPLICATION_NAME
    command: null
    memory: 1G
    buildpacks:
      - ruby_buildpack

EOF
