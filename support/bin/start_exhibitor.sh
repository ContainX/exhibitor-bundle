#!/bin/bash

## Edit this file and add options and evironment mappings that map to your environment, variables are
## loaded from /opt/exhibitor-bundle/etc/environment

java -jar /opt/exhibitor-bundle/exhibitor/exhibitor.jar \
     --port 8181 --defaultconfig /run/exhibitor/exhibitor_defaults.conf \
     --hostname ${EXHIBITOR_HOSTNAME} --configtype=${EXHIBITOR_BACKEND} --staticensemble=${EXHIBITOR_STATICENSEMBLE}
