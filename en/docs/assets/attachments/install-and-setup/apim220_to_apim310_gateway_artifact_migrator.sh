#!/bin/bash

set -e
location=$1

if [[ -z $location ]]; then
  echo 'Usage: ./apim220_to_apim310_gateway_artifact_migrator.sh <location of gateway artifacts>'
  exit 1
fi

echo gateway artifact location: "$(cd "$(dirname "$location")"; pwd -P)"

pushd $location > /dev/null

echo 'starting gateway artifact migration...'

find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 perl -i -pe's/<handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler"\/>/<handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler">\n\t\t\t\t<property name="RemoveOAuthHeadersFromOutMessage" value="true"\/>\n\t\t\t<\/handler>/'

popd > /dev/null

echo 'migration completed.'
