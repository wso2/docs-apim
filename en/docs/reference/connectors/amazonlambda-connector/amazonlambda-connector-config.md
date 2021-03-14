# Amazon Lambda Connector Reference

The following operations allow you to work with the Amazon Lambda Connector. Click an operation name to see parameter details and samples on how to use it.

### Accounts

??? note "getAccountSettings"
    The getAccountSettings operation retrieves details about your account's limits and usage in an AWS Region. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_GetAccountSettings.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionGetAccountSettings</td>
            <td>API version for GetAccountSettings method.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.getAccountSettings>
        <apiVersionGetAccountSettings>{$ctx:apiVersionGetAccountSettings}</apiVersionGetAccountSettings>
    </amazonlambda.getAccountSettings>
    ```
    
    **Sample request**
    
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
        "accessKeyId":"AKIAJHJ*************",
        "region":"us-east-2",
        "blocking":"false",
        "apiVersionGetAccountSettings": "2016-08-19"
    }
    ```

    **Sample response**

    ```json
    {
        "AccountLimit": {
            "CodeSizeUnzipped": 262144000,
            "CodeSizeZipped": 52428800,
            "ConcurrentExecutions": 1000,
            "TotalCodeSize": 80530636800,
            "UnreservedConcurrentExecutions": 1000,
            "UnreservedConcurrentExecutionsMinimum": null
        },
        "AccountUsage": {
            "FunctionCount": 1,
            "TotalCodeSize": 176268666
        },
        "DeprecatedFeaturesAccess": null,
        "HasFunctionWithDeprecatedRuntime": false,
        "PreviewFeatures": null
    }
    ```

### Aliases

??? note "createAlias"
    The createAlias implementation of the POST operation creates an alias for a Lambda function version. Use aliases to provide clients with a function identifier that you can update to invoke a different version. You can also map an alias to split invocation requests between two versions. Use the RoutingConfig parameter to specify a second version and the percentage of invocation requests that it receives. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateAlias.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionCreateAlias</td>
            <td>API version for CreateAlias method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function that the alias invokes.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>createAliasDescription</td>
            <td>The description of the alias.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionVersion</td>
            <td>The function version that the alias invokes.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>aliasName</td>
            <td>The name of the alias.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>aliasAdditionalVersionWeights</td>
            <td>The name of second alias, and the percentage of traffic that's routed to it.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.createAlias>
        <functionName>{$ctx:functionName}</functionName>
        <createAliasDescription>{$ctx:createAliasDescription}</createAliasDescription>
        <functionVersion>{$ctx:functionVersion}</functionVersion>
        <aliasName>{$ctx:aliasName}</aliasName>
        <aliasAdditionalVersionWeights>{$ctx:aliasAdditionalVersionWeights}</aliasAdditionalVersionWeights>
        <apiVersionCreateAlias>{$ctx:apiVersionCreateAlias}</apiVersionCreateAlias>
    </amazonlambda.createAlias>
    ```
    
    **Sample request**
    
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
        "accessKeyId":"AKIAJHJ*************",
        "region":"us-east-2",
        "blocking":"false",
        "functionName":"test",
        "functionVersion":"$LATEST",
        "aliasName":"alias2",
        "apiVersionCreateAlias":"2015-03-31"
    }
    ```

    **Sample response**

    ```json
    {
        "AliasArn": "arn:aws:lambda:us-east-2:********:function:test:alias2",
        "Description": "",
        "FunctionVersion": "$LATEST",
        "Name": "alias2",
        "RevisionId": "be8925ae-a634-4303-92e2-5364d0724406",
        "RoutingConfig": null
    }
    ```

??? note "deleteAlias"
    The deleteAlias implementation deletes a Lambda function alias. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_DeleteAlias.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionDeleteAlias</td>
            <td>API version for DeleteAlias method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function that the alias invokes.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>aliasName</td>
            <td>The name of the alias.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.deleteAlias>
        <functionName>{$ctx:functionName}</functionName>
        <aliasName>{$ctx:aliasName}</aliasName>
        <apiVersionDeleteAlias>{$ctx:apiVersionDeleteAlias}</apiVersionDeleteAlias>
    </amazonlambda.deleteAlias>
    ```
    
    **Sample request**
    
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
        "accessKeyId":"AKIAJHJ*************",
        "region":"us-east-2",
        "blocking":"false",
        "functionName":"test",
        "aliasName":"alias2",
        "apiVersionDeleteAlias":"2015-03-31"
    }
    ```

    **Sample response**

    ```
    Status: 204 No Content
    ```

??? note "getAlias"
    The getAlias implementation of the GET operation returns details about a Lambda function alias. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_GetAlias.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionGetAlias</td>
            <td>API version for getAlias method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function that the alias invokes.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>aliasName</td>
            <td>The name of the alias.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.getAlias>
        <functionName>{$ctx:functionName}</functionName>
        <aliasName>{$ctx:aliasName}</aliasName>
        <apiVersionGetAlias>{$ctx:apiVersionGetAlias}</apiVersionGetAlias>    
    </amazonlambda.getAlias>
    ```
    
    **Sample request**
    
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
        "accessKeyId":"AKIAJHJ*************",
        "region":"us-east-2",
        "blocking":"false",
        "functionName":"test",
        "aliasName":"alias2",
        "apiVersionGetAlias":"2015-03-31"
    }
    ```

    **Sample response**

    ```
    Status: 204 No Content
    ```

    ```json
    {
        "AliasArn": "arn:aws:lambda:us-east-2:********:function:test:alias2",
        "Description": "",
        "FunctionVersion": "$LATEST",
        "Name": "alias2",
        "RevisionId": "be8925ae-a634-4303-92e2-5364d0724406",
        "RoutingConfig": null
    }
    ```

??? note "updateAlias"
    The updateAlias method implementation updates the configuration of a Lambda function alias. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_UpdateAlias.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionUpdateAlias</td>
            <td>API version for updateAlias method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function that the alias invokes.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>aliasName</td>
            <td>The name of the alias.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>updatedAliasDescription</td>
            <td>The description of the alias.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>updatedAliasAdditionalVersionWeight</td>
            <td>The name of second alias, and the percentage of traffic that's routed to it.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionVersion</td>
            <td>The function version that the alias invokes.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.updateAlias>
        <functionName>{$ctx:functionName}</functionName>
        <updatedAliasDescription>{$ctx:updatedAliasDescription}</updatedAliasDescription>
        <functionVersion>{$ctx:functionVersion}</functionVersion>
        <aliasName>{$ctx:aliasName}</aliasName>
        <updatedAliasAdditionalVersionWeight>{$ctx:updatedAliasAdditionalVersionWeight}</updatedAliasAdditionalVersionWeight>
        <apiVersionUpdateAlias>{$ctx:apiVersionUpdateAlias}</apiVersionUpdateAlias>
    </amazonlambda.updateAlias>
    ```
    
    **Sample request**
    
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
        "accessKeyId":"AKIAJHJ*************",
        "region":"us-east-1",
        "blocking":"false",
        "functionName":"test",
        "aliasName":"alias2",
        "functionVersion":"$LATEST",
        "apiVersionUpdateAlias":"2015-03-31"
    }
    ```

    **Sample response**

    ```
    Status: 200 OK
    ```

    ```json
    {
        "AliasArn": "arn:aws:lambda:us-east-2:*********:function:test:alias2",
        "Description": "",
        "FunctionVersion": "$LATEST",
        "Name": "alias2",
        "RevisionId": "6d8d089b-c632-4a4b-91ba-ee1ce706c50a",
        "RoutingConfig": null
    }
    ```
### functions

??? note "addPermission"
    The addPermission method implementation grants an AWS service or another account permission to use a function. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_AddPermission.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionAddPermission</td>
            <td>API version for AddPermission method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>Name of the Lambda function, version, or alias.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>permissionAction</td>
            <td>The action that the principal can use on the function.For example, lambda:InvokeFunction or lambda:GetFunction.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>permissionStatementId</td>
            <td>A statement identifier that differentiates the statement from others in the same policy.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>permissionPrincipal</td>
            <td>The AWS service or account that invokes the function. If you specify a service, use SourceArn or SourceAccount to limit who can invoke the function through that service.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>permissionQualifier</td>
            <td>Specify a version or alias.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.addPermission>
        <functionName>{$ctx:functionName}</functionName>
        <permissionAction>{$ctx:permissionAction}</permissionAction>
        <permissionStatementId>{$ctx:permissionStatementId}</permissionStatementId>
        <permissionPrincipal>{$ctx:permissionPrincipal}</permissionPrincipal>
        <permissionQualifier>{$ctx:permissionQualifier}</permissionQualifier>
        <apiVersionAddPermission>{$ctx:apiVersionAddPermission}</apiVersionAddPermission>    
    </amazonlambda.addPermission>
    ```
    
    **Sample request**
    
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M55z8I*****************",
        "accessKeyId":"AKIAJHJX************",
        "region":"us-east-2",
        "blocking":"false",
        "functionName":"testFunction",
        "permissionAction":"lambda:addPermission",
        "permissionPrincipal":"s3.amazonaws.com",
        "permissionStatementId":"Permisssion_Added182p",
        "apiVersionAddPermission":"2015-03-31"
    }
    ```

    **Sample response**

    ```
    Status: 201 Created
    ```

    ```json
    {
        "Statement": "{\"Sid\":\"Permisssion_Added182p\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"s3.amazonaws.com\"},\"Action\":\"lambda:addPermission\",\"Resource\":\"arn:aws:lambda:us-east-2:*******:function:testFunction\"}"
    }
    ```
??? note "createFunction"
    The createFunction method implementation creates a new function. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionCreateFunction</td>
            <td>The API version for the CreateFunction method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionDescription</td>
            <td>Contains description of the function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>s3Bucket</td>
            <td>An Amazon S3 bucket name in the same region as your function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>s3Key</td>
            <td>The Amazon S3 key of the deployment package.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>s3ObjectVersion</td>
            <td>For versioned objects, the version of the deployment package object to use.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>zipFile</td>
            <td>The base64-encoded contents of zip file containing your deployment package. AWS SDK and AWS CLI clients handle the encoding for you.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>targetArn</td>
            <td>The Amazon Resource Name (ARN) of an Amazon SQS queue or Amazon SNS topic.</td>
            <td>Yes</td>
            </tr>
        <tr>
            <td>environmentVariables</td>
            <td>Environment variable key-value pairs.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>kmsKeyArn</td>
            <td>The ARN of the KMS key used to encrypt your function's environment variables. If not provided, AWS Lambda will use a default service key.</td>
            <td>Yes</td>
            </tr>
        <tr>
            <td>layers</td>
            <td>A list of function layers to add to the function's execution environment.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>memorySize</td>
            <td>The amount of memory that your function has access to. Increasing the function's memory also increases it's CPU allocation. The default value is 128 MB. The value must be a multiple of 64 MB.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>publish</td>
            <td>Set to true to publish the first version of the function during creation.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>role</td>
            <td>The Amazon Resource Name (ARN) of the function’s execution role.</td>
            <td>Yes</td>
            </tr>
        <tr>
            <td>runtime</td>
            <td> The runtime version for the function.Valid Values: nodejs | nodejs4.3 | nodejs6.10 | nodejs8.10 | java8 | python2.7 | python3.6 | python3.7 | dotnetcore1.0 | dotnetcore2.0 | dotnetcore2.1 | nodejs4.3-edge | go1.x | ruby2.5 |.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>tags</td>
            <td>The list of tags (key-value-pairs) assigned to the new function. For more information see Tagging Lambda Functions in the AWS Lambda Developer Guide.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>timeout</td>
            <td>The amount of time that Lambda allows a function to run before terminating it. The default is 3 seconds. The maximum allowed value is 900 seconds.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>mode</td>
            <td>Set Mode to Activate to sample and trace a subset of incoming requests with AWS X-Ray. The tracing mode to Activate to sample and trace a subset of incoming requests with AWS X-Ray.</td>
            <td>Yes</td>
            </tr>
        <tr>
            <td>securityGroupIds</td>
            <td>A list of VPC security groups IDs.</td>
            <td>Yes</td>
        </tr>
        <tr>
           <td>subnetIds</td>
           <td>A list of VPC subnet IDs.</td>
           <td>Yes</td>
        </tr>       
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.addPermission>
        <functionName>{$ctx:functionName}</functionName>
        <permissionAction>{$ctx:permissionAction}</permissionAction>
        <permissionStatementId>{$ctx:permissionStatementId}</permissionStatementId>
        <permissionPrincipal>{$ctx:permissionPrincipal}</permissionPrincipal>
        <permissionQualifier>{$ctx:permissionQualifier}</permissionQualifier>
        <apiVersionAddPermission>{$ctx:apiVersionAddPermission}</apiVersionAddPermission>    
    </amazonlambda.addPermission>
    ```
    
    **Sample request**
    
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M55z8I*****************",
        "accessKeyId":"AKIAJHJX************",
        "region":"us-east-2",
        "blocking":"false",
        "s3Bucket":"ajbuck8",
        "s3Key":"fnc.zip",
        "s3ObjectVersion":"null",
        "functionName":"createdFunc",
        "handler":"mdhandler",
        "role":"arn:aws:iam::14*****:role/service-role/yfuj",
        "runtime":"python3.7",
        "apiVersionCreateFunction":"2015-03-31"
    }
    ```

    **Sample response**

    ```json
    {
        "CodeSha256": "tp34ACQUVOU5YVe84VQUQHsHWdfixrnP/mkMdtt6gEc=",
        "CodeSize": 338,
        "DeadLetterConfig": null,
        "Description": "",
        "Environment": null,
        "FunctionArn": "arn:aws:lambda:us-east-2:*********:function:createdFunc",
        "FunctionName": "createdFunc",
        "Handler": "mdhandler",
        "KMSKeyArn": null,
        "LastModified": "2019-03-05T09:36:27.074+0000",
        "Layers": null,
        "MasterArn": null,
        "MemorySize": 128,
        "RevisionId": "acdf452b-5bf0-4203-9e22-728c200aa42a",
        "Role": "arn:aws:iam::**********:role/service-role/yfuj",
        "Runtime": "python3.7",
        "Timeout": 3,
        "TracingConfig": {
            "Mode": "PassThrough"
        },
        "Version": "$LATEST",
        "VpcConfig": null
    }
    ```    
??? note "deleteFunction"
    The deleteFunction method implementation deletes a Lambda function. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_DeleteFunction.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionDeleteFunction</td>
            <td>API version for DeleteFunction method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>deleteFunctionQualifier</td>
            <td>Specify a version to delete. You can't delete a version that's referenced by an alias.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.deleteFunction>
        <functionName>{$ctx:functionName}</functionName>
        <deleteFunctionQualifier>{$ctx:deleteFunctionQualifier}</deleteFunctionQualifier>
        <apiVersionDeleteFunction>{$ctx:apiVersionDeleteFunction}</apiVersionDeleteFunction>
    </amazonlambda.deleteFunction>
    ```
    
    **Sample request**
    
    ```json
    {
      "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
      "accessKeyId":"AKIAJHJX************",
      "region":"us-east-1",
      "blocking":"false",
      "functionName":"func",
      "apiVersionDeleteFunction":"2015-03-31"
    }
    ```
    
    **Sample response**
    
    ```
    Status: 201 Created
    ```    
??? note "getFunction"
    The deleteFunction method implementation returns information about the function or function version. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_GetFunction.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionGetFunction</td>
            <td>API version for GetFunction method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>qualifier</td>
            <td>Specify a version or alias.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.getFunction>
        <functionName>{$ctx:functionName}</functionName>
        <qualifier>{$ctx:qualifier}</qualifier>
        <apiVersionGetFunction>{$ctx:apiVersionGetFunction}</apiVersionGetFunction>
    </amazonlambda.getFunction>
    ```
    
    **Sample request**
    
    ```json
    {
      "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
      "accessKeyId":"AKIAJHJ*************",
      "region":"us-east-2",
      "blocking":"false",
      "functionName":"Fn",
      "qualifier":"$LATEST",
      "apiVersionGetFunction":"2015-03-31"
    }
    ```
    
    **Sample response**
    
    ```json
    {
        "Code": {
            "Location": "https://awslambda-us-east-2-tasks.s3.us-east-2.amazonaws.com/snapshots/1*****6/test-9f25e193-f604-4d9e-83f1-1254f57e92bc?versionId=wGTdzzK2xtmCGZdt_kgFyy4dlBV8qr1N&X-Amz-Security-Token=FQoGZXIvYXdzEFoaDGu12sbFFNlw0JI6rCK3A6sbM%2FoxC7a2gKuwHXuKoacmpYJa0L%2FtR%2B52PUf9Pbxh2K4OOg5iffmAhfRV%2BpdhyLs32zWlkiYXRpZseDeZPAbofXMZSoLDWhtLVB0EmLTwz33gX8EQfrsvAJa2xWyM9bsebmNwHe9jTa56DvfaQzPEEa4QXpzWEKH8i5%2FSz9iNCrQhbRP%2B5dvclV%2FULql2gMPlxbwPIZNIYdF1xZuddIGcZInkrEHL3956%2B0kHag%2FL%2FoWzN81IGkySbjKNgRFeLxlDEn9ZpDiC%2FdrnNqJ%2FuBdgben7T1ZV3ck5ra0aT7XKaZhDtEN4jHv0sw3O9rORxvlne50TZ56aVePW%2FpUekHjTUiMgrwG%2B2J4uXl2ht2lTJQW3heAFFCoo1DawPlSG%2Fszht8Mt%2BhkHOrE7Re2GRTlnj0jEzEtqgp3JjuaYZU7dtbU4PhbvavF2LtxWFin9p0hWGkcMjKWuWDTaHLdj%2FzTSkS3qifkD9k34B6P%2BaQE1liduGSwK4CgNGNIP5PISt%2Fyoq2Gii1A3yIKyFgeL1W3cJ%2FuhVL9iC%2FsAN6AMkGMsNNjO%2BxvlclQ0YNK10sGhsc7A0z0Cvsgo0O344wU%3D&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20190305T090047Z&X-Amz-SignedHeaders=host&X-Amz-Expires=599&X-Amz-Credential=ASIARQRML75E7CY33SUO%2F20190305%2Fus-east-2%2Fs3%2Faws4_request&X-Amz-Signature=e82c9ea475e1ba363b6e061c2eebeded0dfd8f275ad8313e16f42430a4f4819b",
            "RepositoryType": "S3"
        },
        "Concurrency": null,
        "Configuration": {
            "CodeSha256": "pETr5sslHxypYmc5mm3M8j3RFMB2G5f5y8lQM/7ZVIs=",
            "CodeSize": 262,
            "DeadLetterConfig": null,
            "Description": "",
            "Environment": null,
            "FunctionArn": "arn:aws:lambda:us-east-2:********:function:test:$LATEST",
            "FunctionName": "test",
            "Handler": "index.handler",
            "KMSKeyArn": null,
            "LastModified": "2019-03-05T08:43:52.123+0000",
            "Layers": [
                {
                    "Arn": "arn:aws:lambda:us-east-2:*******:layer:ballerina-09903:1",
                    "CodeSize": 177304793,
                    "UncompressedCodeSize": 207173983
                }
            ],
            "MasterArn": null,
            "MemorySize": 128,
            "RevisionId": "1da07f2e-469d-4981-a350-38bb01f19167",
            "Role": "arn:aws:iam::**********:role/test-role",
            "Runtime": "nodejs8.10",
            "Timeout": 3,
            "TracingConfig": {
                "Mode": "PassThrough"
            },
            "Version": "$LATEST",
            "VpcConfig": {
                "SecurityGroupIds": [],
                "SubnetIds": [],
                "VpcId": "",
                "VpcSetupStatus": null,
                "VpcSetupStatusReason": null
            }
        },
        "Tags": null
    }
    ``` 
??? note "getFunctionConfiguration"
    The deleteFunction method implementation returns the version-specific settings of a Lambda function or version. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_GetFunctionConfiguration.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionGetFunctionConfiguration</td>
            <td>API version for GetFunctionConfiguration method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>qualifier</td>
            <td>Specify a version or alias.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.getFunctionConfiguration>
        <functionName>{$ctx:functionName}</functionName>
        <qualifier>{$ctx:qualifier}</qualifier>
        <apiVersionGetFunctionConfiguration>{$ctx:apiVersionGetFunctionConfiguration}</apiVersionGetFunctionConfiguration>
    </amazonlambda.getFunctionConfiguration>
    ```
    
    **Sample request**
    
    ```json
    {
      "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
      "accessKeyId":"AKIAJHJ*************",
      "region":"us-east-2",
      "blocking":"false",
      "functionName":"test",
      "qualifier":"$LATEST",
      "apiVersionGetFunctionConfiguration":"2015-03-31"
    }
    ```
    
    **Sample response**
    
    ```
    Status: 200 OK
    ```
    
    ```json
    {
        "CodeSha256": "pETr5sslHxypYmc5mm3M8j3RFMB2G5f5y8lQM/7ZVIs=",
        "CodeSize": 262,
        "DeadLetterConfig": null,
        "Description": "",
        "Environment": null,
        "FunctionArn": "arn:aws:lambda:us-east-2:*********:function:test:$LATEST",
        "FunctionName": "test",
        "Handler": "index.handler",
        "KMSKeyArn": null,
        "LastModified": "2019-03-05T08:43:52.123+0000",
        "Layers": [
            {
                "Arn": "arn:aws:lambda:us-east-2:***********:layer:ballerina-09903:1",
                "CodeSize": 177304793,
                "UncompressedCodeSize": 207173983
            }
        ],
        "MasterArn": null,
        "MemorySize": 128,
        "RevisionId": "1da07f2e-469d-4981-a350-38bb01f19167",
        "Role": "arn:aws:iam::*********:role/test-role",
        "Runtime": "nodejs8.10",
        "Timeout": 3,
        "TracingConfig": {
            "Mode": "PassThrough"
        },
        "Version": "$LATEST",
        "VpcConfig": {
            "SecurityGroupIds": [],
            "SubnetIds": [],
            "VpcId": "",
            "VpcSetupStatus": null,
            "VpcSetupStatusReason": null
        }
    }
    ``` 
??? note "invoke	"
    The deleteFunction method implementation invokes a Lambda function. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_Invoke.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionInvoke</td>
            <td> API version for Invoke method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>The name of the Lambda function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>qualifier</td>
            <td>Specify a version or alias.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>x-amz-invocation-type </td>
            <td>It specifies the way you want to invoke the function. Choose from the following options.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>x-amz-log-type</td>
            <td>It specifies whether to include the execution log in the response. Set to Tail to include it in the response. Valid values are: None and Tail.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>x-amz-client-context</td>
            <td>It's the base64-encoded data about the invoking client to pass to the function in the context object. It can be up to 3583 bytes.
            <ol>
              <li>RequestResponse (default) - Invoke the function synchronously. Keep the connection open until the function returns a response or times out. The API response includes the function response and additional data.</li>
              <li>Event - Invoke the function asynchronously. Send events that fail multiple times to the function's dead-letter queue (if it's configured). The API response only includes a status code.</li>
              <li>DryRun - Validate parameter values and verify that the user or role has permission to invoke the function.</li>
            </ol>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>payload</td>
            <td>The JSON that you want to provide to your Lambda function as input.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.invoke>
        <functionName>{$ctx:functionName}</functionName>
        <apiVersionInvoke>{$ctx:apiVersionInvoke}</apiVersionInvoke>
        <qualifier>{$ctx:qualifier}</qualifier>
        <x-amz-invocation-type>{$ctx:x-amz-invocation-type}</x-amz-invocation-type>
        <x-amz-log-type>{$ctx:x-amz-log-type}</x-amz-log-type>
        <x-amz-client-context>{$ctx:x-amz-client-context}</x-amz-client-context>
        <payload>{$ctx:payload}</payload>
    </amazonlambda.invoke>
    ```
    
    **Sample request**
    
    ```json
    {
    	"secretAccessKey":"0b+fcboKq87Nf7m****************",
    	"accessKeyId":"AKIAJHJXWUY*********",
    	"region":"us-east-1",
    	"blocking":"false",
    	"functionName":"LambdawithLayer",
    	"apiVersionInvoke":"2015-03-31"
    }
    ```
    
    **Sample response**
    
    ```
    Status: 200 OK
    ```
    
    ```json
    {
        "body": "Hello from Lambda Layers!",
        "statusCode": 200
    }
    ```
??? note "listFunctions"
    The deleteFunction method implementation returns a list of Lambda functions, with the version-specific configuration of each. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_ListFunctions.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionListFunction</td>
            <td> API version for ListFunctions method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionVersion</td>
            <td>Version name which specifies the version to include in entries for each function. Set to ALL to include entries for all published versions of each function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>marker</td>
            <td>It specifies the pagination token that is returned by a previous request to retrieve the next page of results.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>masterRegion</td>
            <td>For Lambda@Edge functions, the AWS Region of the master function. For example, us-east-2 or ALL. If specified, you must set FunctionVersion to ALL.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxItems</td>
            <td>It specifies the value, ranging from 1 to 10000, to limit the number of functions in the response.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.listFunctions>
        <functionVersion>{$ctx:functionVersion}</functionVersion>
        <apiVersionListFunctions>{$ctx:apiVersionListFunctions}</apiVersionListFunctions>
        <marker>{$ctx:marker}</marker>
        <masterRegion>{$ctx:masterRegion}</masterRegion>
        <maxItems>{$ctx:maxItems}</maxItems>
    </amazonlambda.listFunctions>
    ```    
    **Sample request**
        
    ```json
    {
        "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
        "accessKeyId":"AKIAJHJ*************",
        "region":"us-east-1",
        "blocking":"false",
        "functionVersion":"ALL",
        "marker":"1",
        "masterRegion":"us-east-1",
        "maxItems":"3",
        "apiVersionListFunctions":"2015-03-31"
    }
    ```
    
??? note "removePermission	"
    The deleteFunction method implementation revokes function-use permission from an AWS service or another account. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_RemovePermission.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionRemovePermission</td>
            <td>API version for RemovePermission method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>functionName</td>
            <td>Name of the Lambda function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>permissionStatementId</td>
            <td>Statement ID of the permission to remove.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>permissionQualifier</td>
            <td>It specifies a version or alias to remove permission from a published version of the function.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>permissionRevisionId</td>
            <td>It's a Id which allow to update the policy only if the revision ID matches the ID that's specified. Use this option to avoid modifying a policy that has changed since you last read it.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.removePermission>
        <functionName>{$ctx:functionName}</functionName>
        <apiVersionRemovePermission>{$ctx:apiVersionRemovePermission}</apiVersionRemovePermission>
        <permissionStatementId>{$ctx:permissionStatementId}</permissionStatementId>
        <permissionQualifier>{$ctx:permissionQualifier}</permissionQualifier>
        <permissionRevisionId>{$ctx:permissionRevisionId}</permissionRevisionId>
    </amazonlambda.removePermission>
    ```
    
    **Sample request**
        
    ```json
    {
      "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
      "accessKeyId":"AKIAJHJ*************",
      "region":"us-east-1",
      "blocking":"false",
      "functionName":"Fn",
      "permissionStatementId":"Permisssion_Added1443p",
      "apiVersionRemovePermission":"2015-03-31"
    }
    ``` 
    **Sample response**
    
    ```
    Status: 204 No Content
    ```
### Layers

??? note "addLayerVersionPermission"
    The deleteFunction method implementation adds permission to the resource-based policy of a version of an AWS Lambda layer. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_AddLayerVersionPermission.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionAddLayerVersionPermission</td>
            <td>API version for AddLayerVersionPermission method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerName</td>
            <td>The name or Amazon Resource Name (ARN) of the layer.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerVersionNumber</td>
            <td>The version number.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerRevisionId</td>
            <td>Only update the policy if the revision ID matches the ID specified. Use this option to avoid modifying a policy that has changed since you last read it.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerAction</td>
            <td>The API action that grants access to the layer. For example, lambda:GetLayerVersion.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerOrganizationId</td>
            <td>With the principal set to *, grant permission to all accounts in the specified organization.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerPrincipal</td>
            <td>An account ID, or * to grant permission to all AWS accounts.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerStatementId</td>
            <td>An identifier that distinguishes the policy from others on the same layer version.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.addLayerVersionPermission>
        <layerName>{$ctx:layerName}</layerName>
        <layerVersionNumber>{$ctx:layerVersionNumber}</layerVersionNumber>
        <layerRevisionId>{$ctx:layerRevisionId}</layerRevisionId>
        <layerAction>{$ctx:layerAction}</layerAction>
        <layerOrganizationId>{$ctx:layerOrganizationId}</layerOrganizationId>
        <layerPrincipal>{$ctx:layerPrincipal}</layerPrincipal>
        <layerStatementId>{$ctx:layerStatementId}</layerStatementId>
        <apiVersionAddLayerVersionPermission>{$ctx:apiVersionAddLayerVersionPermission}</apiVersionAddLayerVersionPermission>
    </amazonlambda.addLayerVersionPermission>
    ```
    
    **Sample request**
    
    ```json
    {
      "secretAccessKey":"0b+fcboKq87Nf7mH6M**********************",
      "accessKeyId":"AKIAJHJ*************",
      "region":"us-east-2",
      "blocking":"false",
      "layerVersionNumber":"1",
      "layerPrincipal":"*",
      "layerStatementId":"Permisssion_Added",
      "layerAction":"lambda:GetLayerVersion",
      "layerName":"CustomFunction",
      "apiVersionAddLayerVersionPermission":"2018-10-31"
    }
    ```
    
    **Sample response**
    
    ```json
    {
        "RevisionId": "632d9fdb-a063-4309-99f5-023762923216",
        "Statement": "{\"Sid\":\"Layer_Version_Permisssion_Added\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"lambda:GetLayerVersion\",\"Resource\":\"arn:aws:lambda:us-east-2:**********:layer:CustomFunction:1\"}"
    }
    ``` 
??? note "removeLayerVersionPermission"
    The deleteFunction method implementation revokes permission to the resource-based policy of a version of an AWS Lambda layer. See the [related API documentation](https://docs.aws.amazon.com/lambda/latest/dg/API_RemoveLayerVersionPermission.html).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiVersionRemoveLayerVersionPermission</td>
            <td>API version for RemoveLayerVersionPermission method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerName</td>
            <td>The name or Amazon Resource Name (ARN) of the layer.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerVersionNumber</td>
            <td>The version number of layer.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerRevisionId</td>
            <td>Only update the policy if the revision ID matches the ID specified. Use this option to avoid modifying a policy that has changed since you last read it.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>layerStatementId</td>
            <td>An identifier that distinguishes the policy from others on the same layer version.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonlambda.removeLayerVersionPermission>
        <layerName>{$ctx:layerName}</layerName>
        <layerVersionNumber>{$ctx:layerVersionNumber}</layerVersionNumber>
        <layerStatementId>{$ctx:layerStatementId}</layerStatementId>
        <layerRevisionId>{$ctx:layerRevisionId}</layerRevisionId>
        <apiVersionRemoveLayerVersionPermission>{$ctx:apiVersionRemoveLayerVersionPermission}</apiVersionRemoveLayerVersionPermission>
    </amazonlambda.removeLayerVersionPermission>
    ```
    
    **Sample request**
    
    ```json
    {
    	"secretAccessKey":"ZvLiOJbh/Gm5o/wE9l7+kAVtjDRg414a/Ev8sF0M",
    	"accessKeyId":"AKIAIZCDHDKX7DBMEKSA",
    	"region":"us-east-2",
    	"blocking":"false",
    	"layerVersionNumber":"1",
    	"layerStatementId":"Layer_Version_Permisssion_Added",
    	"layerName":"CustomFunction",
    	"apiVersionRemoveLayerVersionPermission":"2018-10-31"
    }
    ```
    
    **Sample response**
    
    ```
    Status: 204 No Content
    ```     
    
    
    