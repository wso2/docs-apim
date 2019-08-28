#!/bin/bash

set -e
location=$1

if [[ -z $location ]]; then
  echo 'Usage: ./apim220_to_apim250_gateway_artifact_migrator.sh <location of gateway artifacts>'
  exit 1
fi

echo gateway artifact location: "$(cd "$(dirname "$location")"; pwd -P)"

pushd $location > /dev/null

echo 'starting gateway artifact migration...'

c='<handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler">\n\t\t<property name="RemoveOAuthHeadersFromOutMessage" value="true"/>\n\t</handler>'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e "s@<handler class=\"org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler\"/>@${c}@"

popd > /dev/null

echo 'migration completed.'
