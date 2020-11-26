param (
    [Parameter(Mandatory=$true)][string]$gateway_artifact_location
)


Write-Host "gateway artifact location: $gateway_artifact_location"
Write-Host "starting gateway artifact migration..."


$configFiles = Get-ChildItem $gateway_artifact_location *.xml -rec

foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |
    Foreach-Object { $_ -replace "org.wso2.carbon.apimgt.usage.publisher.APIMgtThrottleUsageHandler", "org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtThrottleUsageHandler" } |
    Foreach-Object { $_ -replace "org.wso2.carbon.apimgt.usage.publisher.APIMgtResponseHandler", "org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtResponseHandler" } |
    Foreach-Object { $_ -replace "org.wso2.carbon.apimgt.usage.publisher.APIMgtFaultHandler", "org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtFaultHandler" } |
    Foreach-Object { $_ -replace "org.wso2.carbon.apimgt.usage.publisher.APIMgtUsageHandler", "org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtUsageHandler" } |
    Foreach-Object { $_ -replace "org.wso2.carbon.apimgt.usage.publisher.APIMgtGoogleAnalyticsTrackingHandler", "org.wso2.carbon.apimgt.gateway.handlers.analytics.APIMgtGoogleAnalyticsTrackingHandler" } |
    Foreach-Object { $_ -replace "org.wso2.carbon.mediator.cache.digest.DOMHASHGenerator", "org.wso2.carbon.mediator.cache.digest.REQUESTHASHGenerator" } |
    Foreach-Object { $_ -replace "org.wso2.caching.digest.REQUESTHASHGenerator", "org.wso2.carbon.mediator.cache.digest.REQUESTHASHGenerator" } |
    Foreach-Object { $_ -replace "<handler class=`"org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler`"/>", "<handler class=`"org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler`">`n`t`t<property name=`"RemoveOAuthHeadersFromOutMessage`" value=`"true`"/>`n`t</handler>" } |
    Set-Content $file.PSPath
}

Write-Host "migration completed."
