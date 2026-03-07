#!/bin/bash

set -e
location=$1

if [[ -z $location ]]; then
  echo 'Usage: ./apim200_to_apim260_gateway_artifact_migrator.sh <location of gateway artifacts>'
  exit 1
fi

echo gateway artifact location: "$(cd "$(dirname "$location")"; pwd -P)"

pushd $location > /dev/null

echo 'starting gateway artifact migration...'

c='<handler class="org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler">\n\t\t<property name="RemoveOAuthHeadersFromOutMessage" value="true"/>\n\t</handler>'

find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtThrottleUsageHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtThrottleUsageHandler/'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtResponseHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtResponseHandler/'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtFaultHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtFaultHandler/'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtUsageHandler/'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtGoogleAnalyticsTrackingHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtGoogleAnalyticsTrackingHandler/'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.mediator.cache.digest.DOMHASHGenerator/org.wso2.carbon.mediator.cache.digest.REQUESTHASHGenerator/'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.caching.digest.REQUESTHASHGenerator/org.wso2.carbon.mediator.cache.digest.REQUESTHASHGenerator/'
find . -wholename './[0-9]*/synapse-configs/default/*.xml' -print0 -o -name '*.xml' -print0 | xargs -0 sed -i -e "s@<handler class=\"org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler\"/>@${c}@"

popd > /dev/null

echo 'migration completed.'
