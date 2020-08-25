param (
    [Parameter(Mandatory=$true)][string]$gateway_artifact_location
)


Write-Host "gateway artifact location: $gateway_artifact_location"
Write-Host "starting gateway artifact migration..."


$configFiles = Get-ChildItem $gateway_artifact_location *.xml -rec

foreach ($file in $configFiles)
{
    (Get-Content $file.PSPath) |    
    Foreach-Object { $_ -replace "<handler class=`"org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler`"/>", "<handler class=`"org.wso2.carbon.apimgt.gateway.handlers.security.APIAuthenticationHandler`">`n`t`t<property name=`"RemoveOAuthHeadersFromOutMessage`" value=`"true`"/>`n`t</handler>" } |
    Set-Content $file.PSPath
}

Write-Host "migration completed."
