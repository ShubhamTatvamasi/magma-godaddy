#!/bin/bash

source godaddy.keys
GODADDY_URL=https://api.godaddy.com

DOMAIN=${2}
RECORD_VALUE=${1}
RECORD_TYPE=A
DOMAIN_NAME=$(echo ${DOMAIN} | rev | cut -d "." -f 1,2 | rev)
SUBDOMAIN=$(echo ${DOMAIN} | sed "s/${DOMAIN_NAME}//")

if [ "${SUBDOMAIN}" != "" ]; then
  SUBDOMAIN=$(echo ${SUBDOMAIN} | rev | cut -c2- | rev)
fi

AUTH_HEADER="Authorization: sso-key ${GODADDY_API_KEY}:${GODADDY_API_SECRET}"
RECORDS_URI="${GODADDY_URL}/v1/domains/${DOMAIN_NAME}/records"
NEW_RECORD="[{ \"data\": \"${RECORD_VALUE}\" }]"

for i in *.nms api fluentd controller bootstrapper-controller
do

  if [ "${SUBDOMAIN}" != "" ]; then
    RECORD_NAME="${i}.${SUBDOMAIN}"
  else
    RECORD_NAME="${i}"
  fi

  RECORD_PATH="${RECORDS_URI}/${RECORD_TYPE}/${RECORD_NAME}"

  if [ "${RECORD_VALUE}" == "delete" ]; then
    echo "$(tput setaf 1)Deleting ${RECORD_NAME}.${DOMAIN_NAME}"
    curl -X "DELETE" -H "${AUTH_HEADER}" ${RECORD_PATH}
  else
    echo "$(tput setaf 2)Updating ${RECORD_NAME}.${DOMAIN_NAME}"
    curl -X "PUT" --data "${NEW_RECORD}" \
      -H "Content-Type: application/json" \
      -H "${AUTH_HEADER}" ${RECORD_PATH}
  fi

done
