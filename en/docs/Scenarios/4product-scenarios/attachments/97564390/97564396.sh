#!/bin/bash

set -e
location=$1

if [[ -z $location ]]; then
  echo 'Usage: ./apim200_to_apim210_gateway_artifact_migrator.sh <location of gateway artifacts>'
  exit 1
fi

echo gateway artifact location: "$(cd "$(dirname "$location")"; pwd -P)"

pushd $location > /dev/null

echo 'starting gateway artifact migration...'

find . -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtThrottleUsageHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtThrottleUsageHandler/'
find . -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtResponseHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtResponseHandler/'
find . -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtFaultHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtFaultHandler/'
find . -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtUsageHandler/'
find . -name '*.xml' -print0 | xargs -0 sed -i -e 's/org.wso2.carbon.apimgt.usage.publisher.APIMgtGoogleAnalyticsTrackingHandler/org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtGoogleAnalyticsTrackingHandler/'

popd > /dev/null

echo 'migration completed.'
