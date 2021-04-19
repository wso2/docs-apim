# Amazon S3 Connector Reference

The following operations allow you to work with the Amazon S3 Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Amazon S3 connector, add the <amazons3.init> element in your configuration before carrying out any Amazon S3 operations. This Amazon S3 configuration authenticates with Amazon S3 by specifying the AWS access key ID and secret access key ID, which are used for every operation. The signature is used with every request and thus differs based on the request the user makes.

??? note "init"
    The init operation is used to initialize the connection to Amazon S3.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region which is used select a regional endpoint to make requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>methodType</td>
            <td>Type of the HTTP method.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentLength</td>
            <td>Length of the message without the headers according to RFC 2616.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>The content type of the resource in case the request content in the body.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>addCharset</td>
            <td>To add the char set to ContentType header. Set to true to add the charset in the ContentType header of POST and HEAD methods.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>host</td>
            <td>For path-style requests, the value is s3.amazonaws.com. For virtual-style requests, the value is BucketName.s3.amazonaws.com.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isXAmzDate</td>
            <td>The current date and time according to the requester.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket required.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>blocking</td>
            <td>The blocking parameter helps the connector to perform the blocking invocations to Amazon S3.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>privateKeyFilePath</td>
            <td>Path of AWS private Key File.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>keyPairId</td>
            <td>Key pair ID of AWS cloud front.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>policyType</td>
            <td>Policy for the URL signing. It can be custom or canned policy.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>urlSign</td>
            <td>Specify whether to create Signed URL or not. It can be true or false.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>dateLessThan</td>
            <td>Can access the object before this specific date only.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>dateGreaterThan</td>
            <td>Can access the object before this specific date only.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ipAddress</td>
            <td>IP address for creating Policy.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentMD5</td>
            <td>Base64 encoded 128-bit MD5 digest of the message without the headers according to RFC 1864.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expect</td>
            <td>This header can be used only if a body is sent to not to send the request body until it recieves an acknowledgment.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzSecurityToken</td>
            <td>The security token based on whether using Amazon DevPay operations or temporary security credentials.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzAcl</td>
            <td>Sets the ACL of the bucket using the specified canned ACL.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWrite</td>
            <td>Allows the specified grantee or grantees to create, overwrite, and delete any object in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantReadAcp</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWriteAcp</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMeta</td>
            <td>Field names prefixed with x-amz-meta- contain user-specified metadata.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzServeEncryption</td>
            <td>Specifies server-side encryption algorithm to use when Amazon S3 creates an object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzStorageClass</td>
            <td>Storage class to use for storing the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzWebsiteLocation</td>
            <td>Amazon S3 stores the value of this header in the object metadata.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMfa</td>
            <td>The value is the concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzCopySource</td>
            <td>The name of the source bucket and key name of the source object, separated by a slash.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzCopySourceRange</td>
            <td>The range of bytes to copy from the source object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMetadataDirective</td>
            <td>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfMatch</td>
            <td>Copies the object if its entity tag (ETag) matches the specified tag.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfNoneMatch</td>
            <td>Copies the object if its entity tag (ETag) is different than the specified ETag.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfUnmodifiedSince</td>
            <td>Copies the object if it hasn't been modified since the specified time.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfModifiedSince</td>
            <td>Copies the object if it has been modified since the specified time.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzServerSideEncryption</td>
            <td>Specifies the server-side encryption algorithm to use when Amazon S3 creates the target object.</td>
            <td>Yes</td>
        </tr>
    </table>

    > **Note**: You need to pass the bucketName within init configuration only if you use the bucketURL in path-style (e.g., BucketName.s3.amazonaws.com). For the virtual-style bucketUrl (e.g., s3.amazonaws.com) you should not pass the bucketName.

    **Sample configuration**

    ```xml
    <amazons3.init>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <methodType>{$ctx:methodType}</methodType>
        <region>{$ctx:region}</region>
        <contentType>{$ctx:contentType}</contentType>
        <addCharset>{$ctx:addCharset}</addCharset>
        <bucketName>{$ctx:bucketName}</bucketName>
        <isXAmzDate>{$ctx:isXAmzDate}</isXAmzDate>
        <expect>{$ctx:expect}</expect>
        <contentMD5>{$ctx:contentMD5}</contentMD5>
        <xAmzSecurityToken>{$ctx:xAmzSecurityToken}</xAmzSecurityToken>
        <contentLength>{$ctx:contentLength}</contentLength>
        <host>{$ctx:host}</host>
        <xAmzAcl>{$ctx:xAmzAcl}</xAmzAcl>
        <xAmzGrantRead>{$ctx:xAmzGrantRead}</xAmzGrantRead>
        <xAmzGrantWrite>{$ctx:xAmzGrantWrite}</xAmzGrantWrite>
        <xAmzGrantReadAcp>{$ctx:xAmzGrantReadAcp}</xAmzGrantReadAcp>
        <xAmzGrantWriteAcp>{$ctx:xAmzGrantWriteAcp}</xAmzGrantWriteAcp>
        <xAmzGrantFullControl>{$ctx:xAmzGrantFullControl}</xAmzGrantFullControl>
        <uriRemainder>{$ctx:uriRemainder}</uriRemainder>
        <xAmzCopySource>{$ctx:xAmzCopySource}</xAmzCopySource>
        <xAmzCopySourceRange>{$ctx:xAmzCopySourceRange}</xAmzCopySourceRange>
        <xAmzCopySourceIfMatch>{$ctx:xAmzCopySourceIfMatch}</xAmzCopySourceIfMatch>
        <xAmzCopySourceIfNoneMatch>{$ctx:xAmzCopySourceIfNoneMatch}</xAmzCopySourceIfNoneMatch>
        <xAmzCopySourceIfUnmodifiedSince>{$ctx:xAmzCopySourceIfUnmodifiedSince}</xAmzCopySourceIfUnmodifiedSince>
        <xAmzCopySourceIfModifiedSince>{$ctx:xAmzCopySourceIfModifiedSince}</xAmzCopySourceIfModifiedSince>
        <cacheControl>{$ctx:cacheControl}</cacheControl>
        <contentEncoding>{$ctx:contentEncoding}</contentEncoding>
        <expires>{$ctx:expires}</expires>
        <xAmzMeta>{$ctx:xAmzMeta}</xAmzMeta>
        <xAmzServeEncryption>{$ctx:xAmzServeEncryption}</xAmzServeEncryption>
        <xAmzStorageClass>{$ctx:xAmzStorageClass}</xAmzStorageClass>
        <xAmzWebsiteLocation>{$ctx:xAmzWebsiteLocation}</xAmzWebsiteLocation>
    </amazons3.init>
    ```
    
---

### Buckets

??? note "getBuckets"
    The getBuckets implementation of the GET operation returns a list of all buckets owned by the authenticated sender of the request. To authenticate a request, use a valid AWS Access Key ID that is registered with Amazon S3. Anonymous requests cannot list buckets, and a user cannot list buckets that were not created by that particular user. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTServiceGET.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>Amazon S3 API URL, e.g.: http://s3.amazonaws.com</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Amazon S3 region, e.g.: us-east-1</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBuckets>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <region>{$ctx:region}</region>
    <amazons3.getBuckets>
    ```
    
    **Sample request**

    ```xml
    <getBuckets>
        <accessKeyId>AKIAXXXXXXXXXXQM7G5EA</accessKeyId>
        <secretAccessKey>qHZBBzXXXXXXXXXXDYQc4oMQMnAOj+34XXXXXXXXXXO2s</secretAccessKey>
        <methodType>GET</methodType>
        <contentLength></contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect>100-continue</expect>
        <host>s3.amazonaws.com</host>
        <region>us-east-1</region>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <apiUrl>https://s3.amazonaws.com</apiUrl>
    </getBuckets>
    ```
    
    
??? note "createBucket"
    The createBucket implementation of the PUT operation creates a new bucket. To create a bucket, the user should be registered with Amazon S3 and have a valid AWS Access Key ID to authenticate requests. Anonymous requests are never allowed to create buckets. By creating the bucket, the user becomes the owner of the bucket. Not every string is an acceptable bucket name. For information on bucket naming restrictions, see [Working with Amazon S3 Buckets](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html). By default, the bucket is created in the US Standard region. The user can optionally specify a region in the request body. For example, if the user resides in Europe, the user will probably find it advantageous to create buckets in the EU (Ireland) region. For more information, see [How to Select a Region for Your Buckets](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro). See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUT.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketRegion</td>
            <td>Region for the created bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucket>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <bucketRegion>{$ctx:bucketRegion}</bucketRegion>
    </amazons3.createBucket>
    ```
    
    **Sample request**

    ```xml
    <createBucketWebsiteConfiguration>
        <accessKeyId>AKIXXXXXXXXXXA</accessKeyId>
        <secretAccessKey>qHZXXXXXXQc4oMQMnAOj+340XXxO2s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentLength>256</contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect></expect>
        <host>s3.us-east-2.amazonaws.com</host>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <bucketName>signv4test</bucketName>
        <bucketRegion>us-east-2</bucketRegion>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <websiteConfig>
            <IndexDocument>
                <Suffix>index2.html</Suffix>
            </IndexDocument>
            <ErrorDocument>
                <Key>Error2.html</Key>
            </ErrorDocument>
            <RoutingRules>
                <RoutingRule>
                    <Condition>
                        <KeyPrefixEquals>docs/</KeyPrefixEquals>
                    </Condition>
                    <Redirect>
                        <ReplaceKeyPrefixWith>documents/</ReplaceKeyPrefixWith>
                    </Redirect>
                </RoutingRule>
                <RoutingRule>
                    <Condition>
                        <KeyPrefixEquals>images/</KeyPrefixEquals>
                    </Condition>
                    <Redirect>
                        <ReplaceKeyPrefixWith>documents/</ReplaceKeyPrefixWith>
                    </Redirect>
                </RoutingRule>
            </RoutingRules>
        </websiteConfig>
    </createBucketWebsiteConfiguration>
    ```    
    

??? note "createBucketWebsiteConfiguration"
    Sets the configuration of the website that is specified in the website subresource.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>websiteConfig</td>
            <td>Website configuration information. For information on the elements you use in the request to specify the website configuration, see [here](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTwebsite.html).</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketWebsiteConfiguration>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <websiteConfig>{$ctx:websiteConfig}</websiteConfig>
    </amazons3.createBucketWebsiteConfiguration>
    ```
    
    **Sample request**

    ```xml
    <createBucketWebsiteConfiguration>
        <accessKeyId>AKIXXXXXXXXXXA</accessKeyId>
        <secretAccessKey>qHZXXXXXXQc4oMQMnAOj+340XXxO2s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentLength>256</contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect></expect>
        <host>s3.us-east-2.amazonaws.com</host>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <bucketName>signv4test</bucketName>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <websiteConfig>
            <IndexDocument>
                <Suffix>index2.html</Suffix>
            </IndexDocument>
            <ErrorDocument>
                <Key>Error2.html</Key>
            </ErrorDocument>
            <RoutingRules>
                <RoutingRule>
                    <Condition>
                        <KeyPrefixEquals>docs/</KeyPrefixEquals>
                    </Condition>
                    <Redirect>
                        <ReplaceKeyPrefixWith>documents/</ReplaceKeyPrefixWith>
                    </Redirect>
                </RoutingRule>
                <RoutingRule>
                    <Condition>
                        <KeyPrefixEquals>images/</KeyPrefixEquals>
                    </Condition>
                    <Redirect>
                        <ReplaceKeyPrefixWith>documents/</ReplaceKeyPrefixWith>
                    </Redirect>
                </RoutingRule>
            </RoutingRules>
        </websiteConfig>
    </createBucketWebsiteConfiguration>
    ```

??? note "createBucketPolicy"
    The createBucketPolicy implementation of the PUT operation adds or replaces a policy on a bucket. If the bucket already has a policy, the one in this request completely replaces it. To perform this operation, you must be the bucket owner.

    If you are not the bucket owner but have PutBucketPolicy permissions on the bucket, Amazon S3 returns a 405 Method Not Allowed. In all other cases, for a PUT bucket policy request that is not from the bucket owner, Amazon S3 returns 403 Access Denied. There are restrictions about who can create bucket policies and which objects in a bucket they can apply to.

    When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTpolicy.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketPolicy</td>
            <td>Policy of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketPolicy>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <bucketPolicy>{$ctx:bucketPolicy}</bucketPolicy>
    </amazons3.createBucketPolicy>
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId": "AKXXXXXXXXX5EAS",
        "secretAccessKey": "qHXXXXXXNMDYadDdsQMnAOj+3XXXXPs",
        "region":"us-east-2",
        "methodType": "PUT",
        "contentType": "application/json",
        "bucketName": "signv4test",
        "isXAmzDate": "true",
        "bucketUrl": "http://s3.us-east-2.amazonaws.com/signv4test",
        "contentMD5":"",
        "xAmzSecurityToken":"",
        "host":"s3.us-east-2.amazonaws.com",
        "expect":"",
        "contentLength":"",
        "bucketPolicy": {
                    "Version":"2012-10-17",
                    "Statement":[{
                        "Sid":"AddPerm",
                            "Effect":"Allow",
                        "Principal": {
                                "AWS": "*"
                            },
                         "Action":["s3:GetObject"],
                        "Resource":["arn:aws:s3:::signv4test/*"]
                        }]
                    }
    }
    ```

??? note "createBucketACL"
    The createBucketACL operation uses the ACL sub-resource to set the permissions on an existing bucket using access control lists (ACL). See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTacl.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ownerId</td>
            <td>The ID of the bucket owner.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ownerDisplayName</td>
            <td>The screen name of the bucket owner.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessControlList</td>
            <td>Container for ACL information, which includes the following:
                <ul>
                    <li>Grant: Container for the grantee and permissions.
                        <ul>
                            <li>Grantee: The subject whose permissions are being set.
                                <ul>
                                    <li>ID: ID of the grantee.</li>
                                    <li>DisplayName: Screen name of the grantee.</li>
                                </ul>
                            </li>
                            <li>Permission: Specifies the permission to give to the grantee.</li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketACL>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <ownerId>{$ctx:ownerId}</ownerId>
        <ownerDisplayName>{$ctx:ownerDisplayName}</ownerDisplayName>
        <accessControlList>{$ctx:accessControlList}</accessControlList>
    </amazons3.createBucketACL>
    ```
    
    **Sample request**

    ```xml
    <createBucketACL>
        <accessKeyId>AKIXXXXXXXXXG5EA</accessKeyId>
        <secretAccessKey>qHZXXXXXXXDYQc4oMQXXXOj+340pXXX23s</secretAccessKey>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <addCharset>false</addCharset>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <region>us-east-2</region>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <ownerId>9a48e6b16816cc75df306d35bb5d0bd0778b61fbf49b8ef4892143197c84a867</ownerId>
        <ownerDisplayName>admin+aws+connectors+secondary</ownerDisplayName>
        <accessControlList>
            <Grants>
                <Grant>
                    <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser">
                        <ID>9a48e6b16816cc75df306d35bb5d0bd0778b61fbf49b8ef4892143197c84a867</ID>
                        <DisplayName>admin+aws+connectors+secondary</DisplayName>
                    </Grantee>
                    <Permission>FULL_CONTROL</Permission>
                </Grant>
                <Grant>
                    <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
                        <URI xmlns="">http://acs.amazonaws.com/groups/global/AllUsers</URI>
                    </Grantee>
                    <Permission xmlns="">READ</Permission>
                </Grant>
            </Grants>
        </accessControlList>
    </createBucketACL>
    ```

??? note "createBucketLifecycle"
    The createBucketLifecycle operation uses the acl subresource to set the permissions on an existing bucket using access control lists (ACL). See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTlifecycle.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>lifecycleConfiguration</td>
            <td>Container for lifecycle rules, which includes the following:
                <ul>
                    <li>Rule: Container for a lifecycle rule.
                        <ul>
                            <li>ID: Unique identifier for the rule. The value cannot be longer than 255 characters.</li>
                            <li>Prefix: Object key prefix identifying one or more objects to which the rule applies.</li>
                            <li>Status: If Enabled, Amazon S3 executes the rule as scheduled. If Disabled, Amazon S3 ignores the rule.</li>
                            <li>Transition: This action specifies a period in the objects' lifetime when Amazon S3 should transition them to the STANDARD_IA or the GLACIER storage class.
                                <ul>
                                    <li>Days: Specifies the number of days after object creation when the specific rule action takes effect.</li>
                                    <li>StorageClass: Specifies the Amazon S3 storage class to which you want the object to transition.</li>
                                </ul>
                            </li>
                            <li>Expiration: This action specifies a period in an object's lifetime when Amazon S3 should take the appropriate expiration action.
                                <ul>
                                    <li>Days: Specifies the number of days after object creation when the specific rule action takes effect.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketLifecycle>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <lifecycleConfiguration>{$ctx:lifecycleConfiguration}</lifecycleConfiguration>
    </amazons3.createBucketLifecycle>
    ```
    
    **Sample request**

    ```xml
    <createBucketLifecycle>
        <accessKeyId>AKXXXXXXXXXXX5EA</accessKeyId>
        <secretAccessKey>qHXXXXXXXXXXXqQc4oMQMnAOj+33XXXXXDPO2s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <lifecycleConfiguration>
            <Rule>
                <ID>id1</ID>
                <Prefix>documents/</Prefix>
                <Status>Enabled</Status>
                <Transition>
                    <Days>30</Days>
                    <StorageClass>GLACIER</StorageClass>
                </Transition>
            </Rule>
            <Rule>
                <ID>id2</ID>
                <Prefix>logs/</Prefix>
                <Status>Enabled</Status>
                <Expiration>
                    <Days>365</Days>
                </Expiration>
            </Rule>
        </lifecycleConfiguration>
    </createBucketLifecycle>
    ```

??? note "createBucketReplication"
    The createBucketReplication operation uses the acl subresource to set the permissions on an existing bucket using access control lists (ACL). See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTreplication.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>role</td>
            <td>Amazon Resource Name (ARN) of an IAM role for Amazon S3 to assume when replicating the objects.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>rules</td>
            <td>Container for replication rules, which includes the following:
                <ul>
                    <li>Rule: Container for information about a particular replication rule.
                        <ul>
                            <li>ID: Unique identifier for the rule. The value cannot be longer than 255 characters.</li>
                            <li>Prefix: Object key prefix identifying one or more objects to which the rule applies.</li>
                            <li>Status: The rule is ignored if status is not Enabled..</li>
                            <li>Destination: Container for destination information.
                                <ul>
                                    <li>Bucket:Amazon resource name (ARN) of the bucket where you want Amazon S3 to store replicas of the object identified by the rule.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketReplication>
        <role>{$ctx:role}</role>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <rules>{$ctx:rules}</rules>
    </amazons3.createBucketReplication>
    ```
    
    **Sample request**

    ```xml
    <createBucketReplication>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <role>arn:aws:iam::35667example:role/CrossRegionReplicationRoleForS3</role>
        <rules>
            <Rule>
                <ID>id1</ID>
                <Prefix>documents/</Prefix>
                <Status>Enabled</Status>
                <Destination>
                    <Bucket>arn:aws:s3:::signv4testq23aa1</Bucket>
                </Destination>
            </Rule>
        </rules>
    </createBucketReplication>
    ```

??? note "createBucketTagging"
    The createBucketTagging operation uses the tagging subresource to add a set of tags to an existing bucket. Use tags to organize your AWS bill to reflect your own cost structure. To do this, sign up to get your AWS account bill with tag key values included. Then, to see the cost of combined resources, organize your billing information according to resources with the same tag key values. For example, you can tag several resources with a specific application name, and then organize your billing information to see the total cost of that application across several services. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTtagging.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>tagSet</td>
            <td>Container for a set of tags, which includes the following:
                <ul>
                    <li>Tag: Container for tag information.
                        <ul>
                            <li>Key: Name of the tag.</li>
                            <li>Value: Value of the tag.</li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketTagging>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <tagSet>{$ctx:tagSet}</tagSet>
    </amazons3.createBucketTagging>
    ```
    
    **Sample request**

    ```xml
    <createBucketTagging>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <tagSet>
            <Tag>
                <Key>Project</Key>
                <Value>Project One</Value>
            </Tag>
            <Tag>
                <Key>User</Key>
                <Value>jsmith</Value>
            </Tag>
        </tagSet>
    </createBucketTagging>
    ```

??? note "createBucketRequestPayment"
    The createBucketRequestPayment operation uses the requestPayment subresource to set the request payment configuration of a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTrequestPaymentPUT.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>payer</td>
            <td>Specifies who pays for the download and request fees.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketRequestPayment>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <payer>{$ctx:payer}</payer>
    </amazons3.createBucketRequestPayment>
    ```
    
    **Sample request**

    ```xml
    <createBucketRequestPayment>
        <accessKeyId>AKXXXXXXXXXXX5EA</accessKeyId>
        <secretAccessKey>qHXXXXXXXXXXXqQc4oMQMnAOj+33XXXXXDPO2s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <payer>Requester</payer>
    </createBucketRequestPayment>
    ```

??? note "createBucketVersioning"
    The createBucketVersioning operation uses the requestPayment subresource to set the request payment configuration of a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTVersioningStatus.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>status</td>
            <td>Sets the versioning state of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>mfaDelete</td>
            <td>Specifies whether MFA Delete is enabled in the bucket versioning configuration.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketVersioning>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <status>{$ctx:status}</status>
        <mfaDelete>{$ctx:mfaDelete}</mfaDelete>
    </amazons3.createBucketVersioning>
    ```
    
    **Sample request**

    ```xml
    <createBucketVersioning>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <status>Enabled</status>
    </createBucketVersioning>
    ```

??? note "deleteBucket"
    The deleteBucket implementation of the DELETE operation deletes the bucket named in the URI. All objects (including all object versions and Delete Markers) in the bucket must be deleted before the bucket itself can be deleted. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETE.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucket>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    <amazons3.deleteBucket>
    ```
    
    **Sample request**

    ```xml
    <deleteBucket>
        <accessKeyId>AKIAIGURZM7SDFGJ7TRO6KSFSQ</accessKeyId>
        <secretAccessKey>asAX8CJoDKzeOgfdgd0Ve5dMCFk4STUFDdfgdgRHkGX6m0CcY</secretAccessKey>
        <methodType>DELETE</methodType>
        <region>us-east-2</region>
        <contentLength></contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect></expect>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </deleteBucket>
    ```

??? note "deleteBucketPolicy"
    The deleteBucketPolicy implementation of the DELETE operation deletes the policy on a specified bucket. To use the operation, you must have DeletePolicy permissions on the specified bucket and be the bucket owner. If there are no DeletePolicy permissions, Amazon S3 returns a 403 Access Denied error. If there is the correct permission, but you are not the bucket owner, Amazon S3 returns a 405 Method Not Allowed error. If the bucket does not have a policy, Amazon S3 returns a 204 No Content error. There are restrictions about who can create bucket policies and which objects in a bucket they can apply to. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETE.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketPolicy>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    <amazons3.deleteBucketPolicy>
    ```
    
    **Sample request**

    ```xml
    <deleteBucketPolicy>
        <accessKeyId>AKIAQEIGURZSDFDM7GJ7TRO6KQ</accessKeyId>
        <secretAccessKey>asAX8CJoDvcvKzeOd0Ve5dMjkjCFk4STUFDRHkGX6m0CcY</secretAccessKey>
        <methodType>DELETE</methodType>
        <contentType>application/xml</contentType>
        <contentLength>256</contentLength>
        <contentMD5></contentMD5>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <expect></expect>
        <region>us-east-2</region>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </deleteBucketPolicy>
    ```

??? note "deleteBucketCors"
    The deleteBucketCors operation deletes the cors configuration information set for the bucket. To use this operation, you must have permission to perform the s3:PutCORSConfiguration action. The bucket owner has this permission by default and can grant this permission to others. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETEcors.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketCors>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    <amazons3.deleteBucketCors>
    ```
    
    **Sample request**

    ```xml
    <deleteBucketCors>
        <accessKeyId>AKIAIGURZMSDFD7GJ7TRO6KQDFD</accessKeyId>
        <secretAccessKey>asAX8CJoDKzeOd0Ve5dfgdgdfMCFk4STUFDRHSFSDkGX6m0CcY</secretAccessKey>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <region>us-east-2</region>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
    </deleteBucketCors>
    ```

??? note "deleteBucketLifecycle"
    The deleteBucketLifecycle operation deletes the lifecycle configuration from the specified bucket. Amazon S3 removes all the lifecycle configuration rules in the lifecycle subresource associated with the bucket. Your objects never expire, and Amazon S3 no longer automatically deletes any objects on the basis of rules contained in the deleted lifecycle configuration. To use this operation, you must have permission to perform the s3:PutLifecycleConfiguration action. By default, the bucket owner has this permission and the bucket owner can grant this permission to others. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETElifecycle.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketLifecycle>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    <amazons3.deleteBucketLifecycle>
    ```
    
    **Sample request**

    ```xml
    <deleteBucketLifecycle>
        <accessKeyId>AKIAIGURZMSDFD7GJ7TRO6KQDFD</accessKeyId>
        <secretAccessKey>asAX8CJoDKzeOd0Ve5dfgdgdfMCFk4STUFDRHSFSDkGX6m0CcY</secretAccessKey>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <region>us-east-2</region>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
    </deleteBucketLifecycle>
    ```

??? note "deleteBucketReplication"
    The deleteBucketReplication operation deletes the replication sub-resource associated with the specified bucket. This operation requires permission for the s3:DeleteReplicationConfiguration action. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETEreplication.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketReplication>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    <amazons3.deleteBucketReplication>
    ```
    
    **Sample request**

    ```xml
    <deleteBucketReplication>
        <accessKeyId>AKIAIGURZMSDFD7GJ7TRO6KQDFD</accessKeyId>
        <secretAccessKey>asAX8CJoDKzeOd0Ve5dfgdgdfMCFk4STUFDRHSFSDkGX6m0CcY</secretAccessKey>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <region>us-east-2</region>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
    </deleteBucketReplication>
    ```

??? note "deleteBucketTagging"
    The deleteBucketTagging operation uses the tagging sub-resource to remove a tag set from the specified bucket. To use this operation, you must have permission to perform the s3:PutBucketTagging action. By default, the bucket owner has this permission and can grant this permission to others. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETEtagging.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketTagging>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    <amazons3.deleteBucketTagging>
    ```
    
    **Sample request**

    ```xml
    <deleteBucketTagging>
        <accessKeyId>AKIAIGURZMSDFD7GJ7TRO6KQDFD</accessKeyId>
        <secretAccessKey>asAX8CJoDKzeOd0Ve5dfgdgdfMCFk4STUFDRHSFSDkGX6m0CcY</secretAccessKey>
        <methodType>PUT</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <region>us-east-2</region>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
    </deleteBucketTagging>
    ```

??? note "deleteBucketWebsiteConfiguration"
    The deleteBucketWebsiteConfiguration operation removes the website configuration for a bucket. Amazon S3 returns a 207 OK response upon successfully deleting a website configuration on the specified bucket. It will give a 200 response if the website configuration you are trying to delete does not exist on the bucket, and a 404 response if the bucket itself does not exist. This DELETE operation requires the S3: DeleteBucketWebsite permission. By default, only the bucket owner can delete the website configuration attached to a bucket. However, bucket owners can grant other users permission to delete the website configuration by writing a bucket policy granting them the S3: DeleteBucketWebsite permission. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketDELETEwebsite.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketWebsiteConfiguration>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    <amazons3.deleteBucketWebsiteConfiguration>
    ```
    
    **Sample request**

    ```xml
    <deleteBucketWebsiteConfiguration>
        <accessKeyId>AKIAIGURZM7GDFDJ7TRO6KQDFD</accessKeyId>
        <secretAccessKey>asAdfsX8CJoDKzeOd0Ve5dMCdfsdFk4STUFDRHkdsfGX6m0CcY</secretAccessKey>
        <methodType>DELETE</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <region>us-east-2</region>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <contentMD5></contentMD5>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <expect></expect>
    </deleteBucketWebsiteConfiguration>
    ```

??? note "getObjectsInBucket"
    The getObjectsInBucket implementation of the GET operation returns some or all (up to 1000) of the objects in a bucket. The request parameters act as selection criteria to return a subset of the objects in a bucket. To use this implementation of the operation, the user must have READ access to the bucket. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGET.html)) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>delimiter</td>
            <td>A delimiter is a character used to group keys. All keys that contain the same string between the prefix, if specified, and the first occurrence of the delimiter after the prefixes are grouped under a single result element CommonPrefixes. If the prefix parameter is not specified, the substring starts at the beginning of the key. The keys that are grouped under the CommonPrefixesresult element are not returned elsewhere in the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>encodingType</td>
            <td>Requests Amazon S3 to encode the response and specifies the encoding method to use. An object key can contain any Unicode character. However, XML 1.0 parser cannot parse some characters such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, this parameter can be added to request Amazon S3 to encode the keys in the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>marker</td>
            <td>Specifies the key to start with when listing objects in a bucket. Amazon S3 lists objects in alphabetical order.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>maxKeys</td>
            <td>Sets the maximum number of keys returned in the response body. The response might contain fewer keys but will never contain more.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>prefix</td>
            <td>Limits the response to keys that begin with the specified prefix.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObjectsInBucket>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <delimiter>{$ctx:delimiter}</delimiter>
        <encodingType>{$ctx:encodingType}</encodingType>
        <marker>{$ctx:marker}</marker>
        <maxKeys>{$ctx:maxKeys}</maxKeys>
        <prefix>{$ctx:prefix}</prefix>
    </amazons3.getObjectsInBucket>
    ```
    
    **Sample request**

    ```xml
    <getObjectsInBucket>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <prefix>t</prefix>
        <marker>obj</marker>
        <expect/>
        <maxKeys>3</maxKeys>
        <encodingType>url</encodingType>
        <delimiter>images</delimiter>
    </getObjectsInBucket>
    ```

??? note "getBucketLifeCycle"
    The getBucketLifeCycle operation returns the lifecycle configuration information set on the bucket. To use this operation, permissions should be given to perform the s3:GetLifecycleConfiguration action. The bucket owner has this permission by default and can grant this permission to others. There is usually some time lag before lifecycle configuration deletion is fully propagated to all the Amazon S3 systems. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETlifecycle.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketLifeCycle>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketLifeCycle>
    ```
    
    **Sample request**

    ```xml
    <getBucketLifeCycle>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketLifeCycle>
    ```

??? note "createBucketCors"
    The createBucketCors operation returns the cors configuration information set for the bucket. To use this operation, you must have permission to perform the s3:CreateBucketCORS action. By default, the bucket owner has this permission and can grant it to others. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTcors.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>corsConfiguration</td>
            <td>Container for up to 100 CORSRules elements.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucketCors>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <corsConfiguration>{$ctx:corsConfiguration}</corsConfiguration>
    </amazons3.createBucketCors>
    ```
    
    **Sample request**

    ```xml
    <createBucketCors>
        <accessKeyId>AKXXXXXXXXXXX5EA</accessKeyId>
        <secretAccessKey>qHXXXXXXXXXXXqQc4oMQMnAOj+33XXXXXDPO2s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentLength>256</contentLength>
        <contentType>application/xml</contentType>
        <expect></expect>
        <host>s3.us-east-2.amazonaws.com</host>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <bucketName>signv4test</bucketName>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <corsConfiguration>
            <CORSRule>
                <AllowedOrigin>*</AllowedOrigin>
                <AllowedMethod>GET</AllowedMethod>
                <AllowedHeader>*</AllowedHeader>
                <MaxAgeSeconds>3000</MaxAgeSeconds>
            </CORSRule>
        </corsConfiguration>
    </createBucketCors>
    ```

??? note "getBucketCors"
    The getBucketCors operation returns the cors configuration information set for the bucket. To use this operation, you must have permission to perform the s3:GetBucketCORS action. By default, the bucket owner has this permission and can grant it to others. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETcors.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketCors>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketCors>
    ```
    
    **Sample request**

    ```xml
    <getBucketCors>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength>256</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketCors>
    ```

??? note "getBucketLocation"
    The getBucketLocation operation returns the lifecycle configuration information set on the bucket. To use this operation, you must be the bucket owner. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETlocation.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketLocation>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketLocation>
    ```
    
    **Sample request**

    ```xml
    <getBucketLocation>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketLocation>
    ```

??? note "getBucketLogging"
    The getBucketLogging operation returns the logging status of a bucket and the permissions users have to view and modify that status. To use this operation, you must be the bucket owner. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETlogging.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketLogging>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketLogging>
    ```
    
    **Sample request**

    ```xml
    <getBucketLogging>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketLogging>
    ```

??? note "getBucketNotification"
    The getBucketNotification operation returns the lifecycle configuration information set on the bucket. To use this operation, you must be the bucket owner to read the notification configuration of a bucket. However, the bucket owner can use a bucket policy to grant permission to other users to read this configuration with the s3:GetBucketNotification permission. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETnotification.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketNotification>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketNotification>
    ```
    
    **Sample request**

    ```xml
    <getBucketNotification>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketNotification>
    ```

??? note "getBucketTagging"
    The getBucketTagging operation returns the lifecycle configuration information set on the bucket. To use this operation, you must have permission to perform the s3:GetBucketTagging action. By default, the bucket owner has this permission and can grant this permission to others. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETtagging.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketTagging>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketTagging>
    ```
    
    **Sample request**

    ```xml
    <getBucketTagging>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketTagging>
    ```

??? note "getBucketReplication"
    The getBucketReplication operation returns the lifecycle configuration information set on the bucket. To use this operation, you must have permission to perform the s3:GetReplicationConfiguration action. For more information about permissions, go to Using Bucket Policies and User Policies in the Amazon Simple Storage Service Developer Guide. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETreplication.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketReplication>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketReplication>
    ```
    
    **Sample request**

    ```xml
    <getBucketReplication>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketReplication>
    ```

??? note "getBucketPolicy"
    The getBucketPolicy implementation of the GET operation returns the policy of a specified bucket. To use this operation, the user must have GetPolicy permissions on the specified bucket, and the user must be the bucket owner. If the user does not have GetPolicy permissions, Amazon S3 returns a 403 Access Denied error. If the user has correct permissions, but the user is not the bucket owner, Amazon S3 returns a 405 Method Not Allowed error. If the bucket does not have a policy, Amazon S3 returns a 404 Policy Not found error. There are restrictions about who can create bucket policies and which objects in a bucket they can apply to. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETpolicy.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketPolicy>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketPolicy>
    ```
    
    **Sample request**

    ```xml
    <getBucketPolicy>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketPolicy>
    ```

??? note "getBucketObjectVersions"
    The getBucketObjectVersions operation lists metadata about all of the versions of objects in a bucket. Request parameters can be used as selection criteria to return metadata about a subset of all the object versions. To use this operation, the user must have READ access to the bucket. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETVersion.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>delimiter</td>
            <td>A delimiter is a character used to group keys.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>encodingType</td>
            <td>Requests Amazon S3 to encode the response and specifies the encoding method to use.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>keyMarker</td>
            <td>Specifies the key in the bucket that you want to start listing from. See also versionIdMarker below.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>maxKeys</td>
            <td>Sets the maximum number of keys returned in the response body.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>prefix</td>
            <td>Limits the response to keys that begin with the specified prefix.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>versionIdMarker</td>
            <td>Specifies the object version you want to start listing from.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketObjectVersions>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <delimiter>{$ctx:delimiter}</delimiter>
        <encodingType>{$ctx:encodingType}</encodingType>
        <keyMarker>{$ctx:keyMarker}</keyMarker>
        <maxKeys>{$ctx:maxKeys}</maxKeys>
        <prefix>{$ctx:prefix}</prefix>
        <versionIdMarker>{$ctx:versionIdMarker}</versionIdMarker>
    </amazons3.getBucketObjectVersions>
    ```
    
    **Sample request**

    ```xml
    <getBucketObjectVersions>
	    <accessKeyId>AKXXXXXS3KJA</accessKeyId>
        <secretAccessKey>ieXXHXXTVh/12hL2VxxJJS</secretAccessKey>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
	    <contentLength>256</contentLength>
	    <contentMD5></contentMD5>
        <bucketName>testkeerthu1234</bucketName>
        <isXAmzDate>true</isXAmzDate>
	    <xAmzSecurityToken></xAmzSecurityToken>
	    <host></host>
	    <expect></expect>
        <bucketUrl>http://s3.amazonaws.com/testkeerthu1234</bucketUrl>
        <delimiter>/</delimiter>
        <encodingType></encodingType>
        <keyMarker></keyMarker>
        <maxKeys>3</maxKeys>
        <prefix>images</prefix>
        <versionIdMarker></versionIdMarker>
    </getBucketObjectVersions>
    ```

??? note "getBucketRequestPayment"
    The getBucketRequestPayment implementation of the GET operation returns the request payment configuration of a bucket. To use this operation, the user must be the bucket owner. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETpolicy.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketRequestPayment>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketRequestPayment>
    ```
    
    **Sample request**

    ```xml
    <getBucketRequestPayment>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketRequestPayment>
    ```

??? note "getBucketVersioning"
    The getBucketVersioning implementation of the GET operation returns the versioning state of a bucket. To retrieve the versioning state of a bucket, the user must be the bucket owner. This implementation also returns the MFA Delete status of the versioning state. If the MFA Delete status is enabled, the bucket owner must use an authentication device to change the versioning state of the bucket. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETpolicy.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketVersioning>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketVersioning>
    ```
    
    **Sample request**

    ```xml
    <getBucketVersioning>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketVersioning>
    ```

??? note "getWebSiteConfiguration"
    The getWebSiteConfiguration implementation of the GET operation returns the website configuration associated with a bucket. To host the website on Amazon S3, a bucket can be configured as a website by adding a website configuration. This GET operation requires the S3:GetBucketWebsite permission. By default, only the bucket owner can read the bucket website configuration. However, bucket owners can allow other users to read the website configuration by writing a bucket policy granting them the S3:GetBucketWebsite permission. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETwebsite.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getWebSiteConfiguration>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getWebSiteConfiguration>
    ```
    
    **Sample request**

    ```xml
    <getWebSiteConfiguration>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getWebSiteConfiguration>
    ```

??? note "getBucketACL"
    The getBucketACL implementation of the GET operation returns the access control list (ACL) of a bucket. To use GET to return the ACL of the bucket, the user must have READ_ACP access to the bucket. If READ_ACP permission is granted to the anonymous user, you can return the ACL of the bucket without using an authorization header. When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketGETacl.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketACL>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketACL>
    ```
    
    **Sample request**

    ```xml
    <getBucketACL>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <contentLength>256</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </getBucketACL>
    ```

??? note "checkBucketPermission"
    The checkBucketPermission operation determines whether a bucket exists and you have permission to access it. The operation returns a 200 OK if the bucket exists and you have permission to access it. Otherwise, the operation might return responses such as 404 Not Found and 403 Forbidden. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/user-guide/bucket-permissions-check.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketACL>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getBucketACL>
    ```
    
    **Sample request**

    ```xml
    <checkBucketPermission>
        <accessKeyId>AKXXXXXXXXXXX5EA</accessKeyId>
        <secretAccessKey>qHXXXXXXXXXXXqQc4oMQMnAOj+33XXXXXDPO2s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>HEAD</methodType>
        <contentType>application/xml</contentType>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <expect></expect>
        <host>s3.us-east-2.amazonaws.com</host>
        <xAmzSecurityToken></xAmzSecurityToken>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
    </checkBucketPermission>
    ```

??? note "setBucketACL"
    The setBucketACL implementation of the PUT operation sets the permissions on an existing bucket using access control lists (ACL). You set the permissions by specifying the ACL in the request body. When calling init before this operation, the following headers should be removed: xAmzAcl, x AmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketPUTacl.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessControlPolicy</td>
            <td>Contains the following elements that set the ACL permissions for an object per grantee:
                <ul>
                    <li>Owner: Container for the bucket owner's ID and display name.
                        <ul>
                            <li>ID: ID of the bucket owner, or the ID of the grantee.</li>
                            <li>DisplayName: Screen name of the bucket owner.</li>
                        </ul>
                    </li>
                    <li>AccessControlList: Container for the grants.
                        <ul>
                            <li>Grant: Container for the grantee and the permissions of this grant.
                                <ul>
                                    <li>Grantee: The subject whose permissions are being set.
                                        <ul>
                                            <li>URI: Granting permission to a predefined Amazon S3 group.</li>
                                        </ul>
                                    </li>
                                    <li>Permission: Specifies the permission given to the grantee.</li>
                                </ul>
                            </li>
                        </ul>
                    </li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.setBucketACL>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <accessControlPolicy>{$ctx:accessControlPolicy}</accessControlPolicy>
    </amazons3.setBucketACL>
    ```
    
    **Sample request**

    ```xml
    <setBucketACL>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>PUT</methodType>
        <contentLength>2000</contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect></expect>
        <host>s3.us-east-2.amazonaws.com</host>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <bucketName>signv4test</bucketName>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <accessControlPolicy>
            <Owner>
                <ID>9a48e6b16816cc75df306d35bb5d0bd0778b61fbf49b8ef4892143197c84a867</ID>
                <DisplayName>admin+aws+connectors+secondary</DisplayName>
            </Owner>
            <AccessControlList>
                <Grant>
                    <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser">
                        <ID>9a48e6b16816cc75df306d35bb5d0bd0778b61fbf49b8ef4892143197c84a867</ID>
                        <DisplayName>admin+aws+connectors+secondary</DisplayName>
                    </Grantee>
                    <Permission>FULL_CONTROL</Permission>
                </Grant>
                <Grant>
                    <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
                        <URI xmlns="">http://acs.amazonaws.com/groups/global/AllUsers</URI>
                    </Grantee>
                    <Permission xmlns="">READ</Permission>
                </Grant>
                <Grant>
                    <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="Group">
                        <URI xmlns="">http://acs.amazonaws.com/groups/s3/LogDelivery</URI>
                    </Grantee>
                    <Permission xmlns="">WRITE</Permission>
                </Grant>
            </AccessControlList>
        </accessControlPolicy>
    </setBucketACL>
    ```

??? note "headBucket"
    The headBucket operation is useful to determine if a bucket exists and you have permission to access it. The operation returns a 200 OK if the bucket exists and you have permission to access it. Otherwise, the operation might return responses such as 404 Not Found and 403 Forbidden. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketHEAD.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.headBucket>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.headBucket>
    ```
    
    **Sample request**

    ```xml
    <headBucket>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-west-2</region>
        <methodType>HEAD</methodType>
        <contentType>application/xml</contentType>
        <addCharset>false</addCharset>
        <contentLength></contentLength>
        <contentMD5></contentMD5>
        <bucketName>1513162931643testconbkt2</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <host>s3-us-west-2.amazonaws.com</host>
        <expect></expect>
        <bucketUrl>http://s3-us-west-2.amazonaws.com/1513162931643testconbkt2</bucketUrl>
    </headBucket>
    ```

??? note "listMultipartUploads"
    The listMultipartUploads operation lists in-progress multipart uploads. A multipart upload is in progress when it has been initiated using the Initiate Multipart Upload request but has not yet been completed or aborted. It returns a default value of 1000 multipart uploads in the response. The number of uploads can be further limited in a response by specifying the maxUploads property. If additional multipart uploads satisfy the list criteria, the response will contain an "IsTruncated" element with the value "true". To list the additional multipart uploads, use the keyMarker and uploadIdMarker request parameters.

    In the response, the uploads are sorted by key. If the application has initiated more than one multipart upload using the same object key, uploads in the response are first sorted by key. Additionally, uploads are sorted in ascending order within each key by the upload initiation time.

    When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl. See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListMPUpload.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>delimiter</td>
            <td>A delimiter is a character you use to group keys. All keys that contain the same string between the prefix, if specified, and the first occurrence of the delimiter after the prefix are grouped under a single result element CommonPrefixes. If you do not specify the prefix parameter, the substring starts at the beginning of the key. The keys that are grouped under the CommonPrefixesresult element are not returned elsewhere in the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>encodingType</td>
            <td>Requests Amazon S3 to encode the response and specifies the encoding method to use. An object key can contain any Unicode character. However, XML 1.0 parser cannot parse some characters such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request Amazon S3 to encode the keys in the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxUploads</td>
            <td>Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>keyMarker</td>
            <td>Specifies the key to start with when listing objects in a bucket. Amazon S3 lists objects in alphabetical order.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>prefix</td>
            <td>Limits the response to keys that begin with the specified prefix.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>versionIdMarker</td>
            <td>Together with keyMarker, specifies the multipart upload after which listing should begin. If keyMarker is not specified, the uploadIdMarker parameter is ignored. Otherwise, any multipart uploads for a key equal to the keyMarker might be included in the list only if they have an upload ID lexicographically greater than the specified uploadIdMarker.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.listMultipartUploads>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <delimiter>{$ctx:delimiter}</delimiter>
        <encodingType>{$ctx:encodingType}</encodingType>
        <maxUploads>{$ctx:maxUploads}</maxUploads>
        <keyMarker>{$ctx:keyMarker}</keyMarker>
        <prefix>{$ctx:prefix}</prefix>
        <uploadIdMarker>{$ctx:uploadIdMarker}</uploadIdMarker>
    </amazons3.listMultipartUploads>
    ```
    
    **Sample request**

    ```xml
    <listMultipartUploads>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <region>us-east-2</region>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <contentLength>0</contentLength>
        <contentMD5></contentMD5>
        <bucketName>signv4test</bucketName>
        <host>s3.us-east-2.amazonaws.com</host>
        <expect></expect>
        <xAmzSecurityToken></xAmzSecurityToken>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
    </listMultipartUploads>
    ```

### Objects

??? note "deleteObject"
    The deleteObject operation removes the null version (if there is one) of an object and inserts a delete marker, which becomes the latest version of the object. If there is no null version, Amazon S3 does not remove any objects.

    If the object you want to delete is in a bucket where the bucket versioning configuration is MFA Delete enabled, you must include the xAmzMfa header in the request. Requests that include xAmzMfa must use HTTPS. For more information about MFA Delete, see Using MFA Delete .

    Following is the proxy configuration for init and deleteObject. The init section has additional parameters and parameters that need to be removed apart from those mentioned in the Connecting to Amazon S3 section.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectDELETE.html) for more information.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>methodType</td>
            <td>HTTP method type.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>Content type of the resource.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isXAmzDate</td>
            <td>Indicates whether the current date and time are considered to calculate the signature. Valid values: true or false.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentMD5</td>
            <td>Base64 encoded 128-bit MD5 digest of the message according to RFC 1864.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzSecurityToken</td>
            <td>The security token based on whether Amazon DevPay operations or temporary security credentials are used.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>host</td>
            <td>The path-style requests (s3.amazonaws.com) or virtual-style requests (BucketName.s3.amazonaws.com).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region that is used select a regional endpoint to make requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expect</td>
            <td>When this property is set to 100-continue, the request does not send the request body until it receives an acknowledgment. If the message is rejected based on the headers, the body of the message is not sent.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentLength</td>
            <td>Length of the message without the headers according to RFC 2616.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMfa</td>
            <td>Required to permanently delete a versioned object if versioning is configured with MFA Delete enabled. The value is the concatenation of the authentication device's serial number, a space, and the value displayed on your authentication device.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object to be deleted.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>Version Id of an object to remove a specific object version.</td>
            <td>Yes</td>
        </tr>
    </table>

    > **Note**: To remove a specific version, the user must be the bucket owner and must use the versionId sub-resource, which permanently deletes the version.

    **Sample configuration**

    ```xml
    <amazons3.init>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <methodType>{$ctx:methodType}</methodType>
        <contentType>{$ctx:contentType}</contentType>
        <bucketName>{$ctx:bucketName}</bucketName>
        <isXAmzDate>{$ctx:isXAmzDate}</isXAmzDate>
        <contentMD5>{$ctx:contentMD5}</contentMD5>
        <xAmzSecurityToken>{$ctx:xAmzSecurityToken}</xAmzSecurityToken>
        <host>{$ctx:host}</host>
        <region>{$ctx:region}</region>
        <expect>{$ctx:expect}</expect>
        <contentLength>{$ctx:contentLength}</contentLength>
        <xAmzMfa>{$ctx:xAmzMfa}</xAmzMfa>
    </amazons3.init>

    <amazons3.deleteObject>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
        <versionID>{$ctx:versionId}</versionID>
    </amazons3.deleteObject>
    ```
    
    **Sample request**

    ```xml
    <deleteObject>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <methodType>DELETE</methodType>
        <contentLength></contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect>100-continue</expect>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzMfa></xAmzMfa>
        <xAmzSecurityToken></xAmzSecurityToken>
        <objectName>testObject1</objectName>
        <versionId>FHbrL3xf2TK54hLNWWArYI79woSElvHf</versionId>
    </deleteObject>
    ```

??? note "deleteMultipleObjects"
    The deleteMultipleObjects operation deletes multiple objects from a bucket using a single HTTP request. If object keys that need to be deleted are known, this operation provides a suitable alternative to sending individual delete requests (deleteObject). The deleteMultipleObjects request contains a list of up to 1000 keys that the user wants to delete. In the XML, you provide the object key names, and optionally provide version IDs if you want to delete a specific version of the object from a versioning-enabled bucket. For each key, Amazon S3 performs a delete operation and returns the result of that deletion, success or failure, in the response. Note that if the object specified in the request is not found, Amazon S3 returns the result as deleted.

    The deleteMultipleObjects operation supports two modes for the response: verbose and quiet. By default, the operation uses the verbose mode in which the response includes the result of deletion of each key in your request. In the quiet mode, the response includes only keys where the delete operation encountered an error. For a successful deletion, the operation does not return any information about the deletion in the response body.

    When using the deleteMultipleObjects operation that attempts to delete a versioned object on an MFA Delete enabled bucket, you must include an MFA token. If you do not provide one, even if there are non-versioned objects you are attempting to delete. Additionally, f you provide an invalid token, the entire request will fail, regardless of whether there are versioned keys in the request. For more information about MFA Delete, see MFA Delete.

    Following is the proxy configuration for init and deleteMultipleObjects. The init section has additional parameters and parameters that need to be removed apart from those mentioned in the Connecting to Amazon S3 section.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTBucketHEAD.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>methodType</td>
            <td>HTTP method type.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>Content type of the resource.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isXAmzDate</td>
            <td>Indicates whether the current date and time are considered to calculate the signature. Valid values: true or false.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzSecurityToken</td>
            <td>The security token based on whether Amazon DevPay operations or temporary security credentials are used.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>host</td>
            <td>The path-style requests (s3.amazonaws.com) or virtual-style requests (BucketName.s3.amazonaws.com).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region that is used select a regional endpoint to make requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expect</td>
            <td>When this property is set to 100-continue, the request does not send the request body until it receives an acknowledgment. If the message is rejected based on the headers, the body of the message is not sent.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentLength</td>
            <td>Length of the message without the headers according to RFC 2616.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMfa</td>
            <td>Required to permanently delete a versioned object if versioning is configured with MFA Delete enabled. The value is the concatenation of the authentication device's serial number, a space, and the value displayed on your authentication device.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>deleteConfig</td>
            <td>The configuration for deleting the objects. It contains the following properties:
                <ul>
                    <li>Delete: Container for the request.</li>
                        <ul>
                            <li>Quiet: Enable quiet mode for the request. When you add this element, you must set its value to true. Default is false.</li>
                            <li>Object: Container element that describes the delete request for each object.</li>
                                <ul>
                                    <li>Key: Key name of the object to delete.</li>
                                    <li>VersionId: Version ID for the specific version of the object to delete.</li>
                                </ul>
                        </ul>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <methodType>{$ctx:methodType}</methodType>
        <contentType>{$ctx:contentType}</contentType>
        <bucketName>{$ctx:bucketName}</bucketName>
        <isXAmzDate>{$ctx:isXAmzDate}</isXAmzDate>
        <xAmzSecurityToken>{$ctx:xAmzSecurityToken}</xAmzSecurityToken>
        <host>{$ctx:host}</host>
        <region>{$ctx:region}</region>
        <expect>{$ctx:expect}</expect>
        <contentLength>{$ctx:contentLength}</contentLength>
        <xAmzMfa>{$ctx:xAmzMfa}</xAmzMfa>
    </amazons3.init>

    <amazons3.deleteMultipleObjects>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <quiet>{$ctx:quiet}</quiet>
        <deleteConfig>{$ctx:deleteConfig}</deleteConfig>
    </amazons3.deleteMultipleObjects>
    ```
    
    **Sample request**

    ```xml
    <deleteMultipleObjects>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <methodType>POST</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken/>
        <expect/>
        <xAmzMfa/>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <quiet>true</quiet>
        <deleteConfig>
            <Objects>
                <Object>
                    <Key>testobject33</Key>
                    <VersionId>M46OVgxl4lHBNCeZwBpEZvGhj0k5vvjK</VersionId>
                </Object>
                <Object>
                    <Key>testObject1</Key>
                    <VersionId>PwbvPU.yn3YcHOCF8bntKeTdzfKQC6jN</VersionId>
                </Object>
            </Objects>
        </deleteConfig>
    </deleteMultipleObjects>
    ```

??? note "getObject"
    The getObject operation retrieves objects from Amazon S3. To use this operation, the user must have READ access to the object. If the user grants READ access to the anonymous user, the object can be returned without using an authorization header. By default, this operation returns the latest version of the object.

    An Amazon S3 bucket has no directory hierarchy such as in a typical computer file system. However, a logical hierarchy can be created by using object key names that imply a folder structure. For example, instead of naming an object sample.jpg, it could be named photos/2006/February/sample.jpg. To retrieve an object from such a logical hierarchy, the full key name for the object should be specified.

    For a virtual hosted-style request example, if you have the object photos/2006/February/sample.jpg, specify the resource as /photos/2006/February/sample.jpg. For a path-style request example, if you have the object photos/2006/February/sample.jpg in the bucket named examplebucket, specify the resource as /examplebucket/photos/2006/February/sample.jpg. If the object to be retrieved is a GLACIER storage class object, the object is archived in Amazon Glacier, and you must first restore a copy using the POST Object restore API before retrieving the object. Otherwise, this operation returns the "InvalidObjectStateError" error.

    When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectGET.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object to retrieve details for.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>query</td>
            <td>Query for search parameters.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>responseContentType</td>
            <td>Content-Type header of the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>responseContentLanguage</td>
            <td>Content-Language header of the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>responseExpires</td>
            <td>Expires header of the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>responseCacheControl</td>
            <td>Cache-Control header of the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>responseContentDisposition</td>
            <td>Content-Disposition header of the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>responseContentEncoding</td>
            <td>Content-Encoding header of the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>range</td>
            <td>HTTP range header.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifModifiedSince</td>
            <td>Return the object only if it has been modified.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifUnmodifiedSince</td>
            <td>Return the object only if it has not been modified.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifMatch</td>
            <td>Return the object only if its ETag is the same.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifNoneMatch</td>
            <td>Returns the object only if its ETag is not the same as the one specified.</td>
            <td>Yes</td>
        </tr>
            <td>Return the object only if its ETag is not same.</td>
            <td>Yes</td>
        </tr>        
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObject>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
        <responseContentType>{$ctx:responseContentType}</responseContentType>
        <responseContentLanguage>{$ctx:responseContentLanguage}</responseContentLanguage>
        <responseExpires>{$ctx:responseExpires}</responseExpires>
        <responseCacheControl>{$ctx:responseCacheControl}</responseCacheControl>
        <responseContentDisposition>{$ctx:responseContentDisposition}</responseContentDisposition>
        <responseContentEncoding>{$ctx:responseContentEncoding}</responseContentEncoding>
        <range>{$ctx:range}</range>
        <ifModifiedSince>{$ctx:ifModifiedSince}</ifModifiedSince>
        <ifUnmodifiedSince>{$ctx:ifUnmodifiedSince}</ifUnmodifiedSince>
        <ifMatch>{$ctx:ifMatch}</ifMatch>
        <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
    </amazons3.getObject>
    ```
    
    **Sample request**

    ```xml
    <getObject>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <methodType>GET</methodType>
        <contentType>application/xml</contentType>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken/>
        <contentMD5/>
        <objectName>Tree2.png</objectName>
        <rangeBytes/>
        <responseContentType/>
        <responseContentLanguage/>
        <responseExpires/>
        <responseCacheControl/>
        <responseContentDisposition/>
        <range/>
        <ifModifiedSince/>
        <ifUnmodifiedSince/>
        <ifMatch/>
        <ifNoneMatch/>
    </getObject>
    ```

??? note "createObject"
    The createObject operation adds an object to a bucket. You must have WRITE permissions on a bucket to add an object to it. Amazon S3 does not add partial objects, so if a success response is received, the entire object is added to the bucket. Because Amazon S3 is a distributed system, if it receives multiple write requests for the same object simultaneously, it overwrites all but the last object written.

    To ensure that data is not corrupted traversing the network, use the Content-MD5 header. When it is used, Amazon S3 checks the object against the provided MD5 value and, if they do not match, it returns an error. Additionally, you can calculate the MD5 value while putting an object to Amazon S3 and compare the returned ETag with the calculated MD5 value.

    When uploading an object, you can specify the accounts or groups that should be granted specific permissions on the object. There are two ways to grant the appropriate permissions using the request headers: either specify a canned (predefined) ACL using the "x-amz-acl" request header, or specify access permissions explicitly using the "x-amz-grant-read", "x-amz-grant-read-acp", "x-amz-grant-write-acp", and "x-amz-grant-full-control" headers. These headers map to the set of permissions Amazon S3 supports in an ACL. Use only one approach, not both.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectPOST.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object to retrieve details for.</td>
            <td>Yes</td>
        </tr>   
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createObject>
        <bucketUrl>{$url:bucketUrl}</bucketUrl>
        <objectName>{$url:objectName}</objectName>
    </amazons3.createObject>
    ```
    
??? note "createObjectACL"
    The createObjectACL operation sets the access control list (ACL) permissions for an object that already exists in a bucket. You can specify the ACL in the request body or specify permissions using request headers, depending on the application needs. For example, if there is an existing application that updates an object ACL using the request body, you can continue to use that approach.

    The ACL of an object is set at the object version level. By default, createObjectACL sets the ACL of the latest version of an object. To set the ACL of a different version, use the versionId property.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectGET.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>Name of the object whose acl needs to be set.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ownerId</td>
            <td>ID of the bucket owner.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ownerDisplayName</td>
            <td>Screen name of the bucket owner.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessControlList</td>
            <td>Container for ACL information, which includes the following:
                    <ul>
                        <li>Grant: Container for the grantee and permissions.</li>
                            <ul>
                                <li>Grantee: The subject whose permissions are being set.</li>
                                    <ul>
                                        <li>ID: ID of the grantee.</li>
                                        <li>DisplayName: Screen name of the grantee.</li>
                                    </ul>
                                <li>Permission: Specifies the permission to give to the grantee.</li>
                            </ul>
                    </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>Version Id of an object to remove a specific object version.</td>
            <td>Yes</td>
        </tr>  
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createObjectACL>
        <objectName>{$ctx:objectName}</objectName>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <ownerId>{$ctx:ownerId}</ownerId>
        <ownerDisplayName>{$ctx:ownerDisplayName}</ownerDisplayName>
        <accessControlList>{$ctx:accessControlList}</accessControlList>
        <versionId>{$ctx:versionId}</versionId>
    </amazons3.createObjectACL>
    ```
    
    **Sample request**

    ```xml
    <createObjectACL>
        <accessKeyId>AKIAIGURZMDFG7TRO6KQ</accessKeyId>
        <secretAccessKey>asAX8CJoDKzdfg0Ve5dMCFk4STUFDRHkGX6m0CcY</secretAccessKey>
        <methodType>PUT</methodType>
        <contentLength>256</contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect></expect>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <objectName>testObject2</objectName>
        <versionId>FHbrL3xf2TK54hLNWWArYI79woSElvHf</versionId>
        <xAmzAcl></xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <ownerId>f422baefcd6a519ea3c43bec8874b6c3f71c83f72549f4fb4c0e23044efd2531</ownerId>
        <ownerdisplayName>rhettige@yahoo.com</ownerdisplayName>
        <accessControlList>
            <Grant>
                <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser">
                    <ID>c6567b8c9274b78d6af4a3080c5e43e700f560f3517b7d9acc87251412044c35</ID>
                    <DisplayName>pe.chanaka.ck@gmail.com</DisplayName>
                </Grantee>
                <Permission>WRITE_ACP</Permission>
            </Grant>
            <Grant>
                <Grantee xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:type="CanonicalUser">
                    <ID>c6567b8c9274b78d6af4a3080c5e43e700f560f3517b7d9acc87251412044c35</ID>
                    <DisplayName>pe.chanaka.ck@gmail.com</DisplayName>
                </Grantee>
                <Permission>READ</Permission>
            </Grant>
        </accessControlList>
    </createObjectACL>
    ```

??? note "createObjectCopy"
    The createObjectCopy operation creates a copy of an object that is already stored in Amazon S3. This operation is the same as performing a GET and then a PUT. Adding the request header "x-amz-copy-source" enables the PUT operation to copy the source object into the destination bucket.

    When copying an object, most of the metadata (default) can be preserved, or new metadata can be specified. However, the ACL is not preserved and is set to "private" for the user making the request. All copy requests must be authenticated and cannot contain a message body. Additionally, the user must have the READ access to the source object and WRITE access to the destination bucket. To copy an object only under certain conditions, such as whether the ETag matches or whether the object was modified before or after a specified date, the request headers such as "x-amz-copy-source-if-match", "x-amz-copy-source-if-none-match", "x-amz-copy-source-if-unmodified-since", or "x-amz-copy-source-if-modified-since" must be used (all headers prefixed with "x-amz-" must be signed, including "x-amz-copy-source").

    There are two instances when the copy request could return an error. One is when Amazon S3 receives the copy request, and the other can occur while Amazon S3 is copying the files. If the error occurs before the copy operation starts, you receive a standard Amazon S3 error. If the error occurs during the copy operation, the error response is embedded in the 200 OK response. This means that a 200 OK response can contain either a success or an error. If the request is an HTTP 1.1 request, the response is chunk encoded. Otherwise, it will not contain the content-length, and you will need to read the entire body.

    When copying an object, the accounts or groups that should be granted specific permissions on the object can be specified. There are two ways to grant the appropriate permissions using the request headers: one is to specify a canned (predefined) ACL using the "x-amz-acl" request header, and the other is to s pecify access permissions explicitly using the "x-amz-grant-read", "x-amz-grant-read-acp", "x-amz-grant-write-acp", and "x-amz-grant-full-control" headers. These headers map to the set of permissions Amazon S3 supports in an ACL. Use one approach, not both .

    Following is the proxy configuration for init and createObjectCopy. The init section has additional parameters and parameters that need to be removed apart from those mentioned in the Connecting to Amazon S3 section.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectCOPY.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>methodType</td>
            <td>HTTP method type.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentLength</td>
            <td>Length of the message without the headers according to RFC 2616.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>Content type of the resource.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentMD5</td>
            <td>Base64 encoded 128-bit MD5 digest of the message according to RFC 1864.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expect</td>
            <td>When this property is set to 100-continue, the request does not send the request body until it receives an acknowledgment. If the message is rejected based on the headers, the body of the message is not sent.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>host</td>
            <td>The path-style requests (s3.amazonaws.com) or virtual-style requests (BucketName.s3.amazonaws.com).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region that is used to select a regional endpoint to make requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isXAmzDate</td>
            <td>Specifies whether the current date and time are considered to calculate the signature. Valid values: true or false.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzSecurityToken</td>
            <td>The security token based on whether Amazon DevPay operations or temporary security credentials are used.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzAcl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWrite</td>
            <td>Allows the specified grantee or grantees to create, overwrite, and delete any object in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantReadAcp</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWriteAcp</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzCopySource</td>
            <td>The name of the source bucket and key name of the source object, separated by a slash (/).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMetadataDirective</td>
            <td>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfMatch</td>
            <td>Copies the object if its entity tag (ETag) matches the specified tag. Otherwise, the request returns a 412 HTTP status code error (failed precondition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfNoneMatch</td>
            <td>Copies the object if its entity tag (ETag) is different from the specified ETag. Otherwise, the request returns a 412 HTTP status code error (failed precondition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfUnmodifiedSince</td>
            <td>Copies the object if it has not been modified since the specified time. Oherwise, the request returns a 412 HTTP status code error (failed precondition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzCopySourceIfModifiedSince</td>
            <td>Copies the object if it has been modified since the specified time. Otherwise, the request returns a 412 HTTP status code error (failed condition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzServeEncryption</td>
            <td>Specifies the server-side encryption algorithm to use when Amazon S3 creates the target object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzStorageClass</td>
            <td>RRS enables customers to reduce their costs by storing non-critical, reproducible data at lower levels of redundancy than Amazon S3's standard storage.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzWebsiteLocation</td>
            <td>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>destinationObject</td>
            <td>The destination where the source will be copied.</td>
            <td>Yes</td>
        </tr> 
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <methodType>{$ctx:methodType}</methodType>
        <contentLength>{$ctx:contentLength}</contentLength>
        <contentType>{$ctx:contentType}</contentType>
        <contentMD5>{$ctx:contentMD5}</contentMD5>
        <expect>{$ctx:expect}</expect>
        <host>{$ctx:host}</host>
        <region>{$ctx:region}</region>
        <isXAmzDate>{$ctx:isXAmzDate}</isXAmzDate>
        <xAmzSecurityToken>{$ctx:xAmzSecurityToken}</xAmzSecurityToken>
        <bucketName>{$ctx:bucketName}</bucketName>
        <xAmzAcl>{$ctx:xAmzAcl}</xAmzAcl>
        <xAmzGrantRead>{$ctx:xAmzGrantRead}</xAmzGrantRead>
        <xAmzGrantWrite>{$ctx:xAmzGrantWrite}</xAmzGrantWrite>
        <xAmzGrantReadAcp>{$ctx:xAmzGrantReadAcp}</xAmzGrantReadAcp>
        <xAmzGrantWriteAcp>{$ctx:xAmzGrantWriteAcp}</xAmzGrantWriteAcp>
        <xAmzGrantFullControl>{$ctx:xAmzGrantFullControl}</xAmzGrantFullControl>
        <xAmzCopySource>{$ctx:xAmzCopySource}</xAmzCopySource>
        <xAmzMetadataDirective>{$ctx:xAmzMetadataDirective}</xAmzMetadataDirective>
        <xAmzCopySourceIfMatch>{$ctx:xAmzCopySourceIfMatch}</xAmzCopySourceIfMatch>
        <xAmzCopySourceIfNoneMatch>{$ctx:xAmzCopySourceIfNoneMatch}</xAmzCopySourceIfNoneMatch>
        <xAmzCopySourceIfUnmodifiedSince>{$ctx:xAmzCopySourceIfUnmodifiedSince}</xAmzCopySourceIfUnmodifiedSince>
        <xAmzCopySourceIfModifiedSince>{$ctx:xAmzCopySourceIfModifiedSince}</xAmzCopySourceIfModifiedSince>
        <xAmzServeEncryption>{$ctx:xAmzServeEncryption}</xAmzServeEncryption>
        <xAmzStorageClass>{$ctx:xAmzStorageClass}</xAmzStorageClass>
        <xAmzWebsiteLocation>{$ctx:xAmzWebsiteLocation}</xAmzWebsiteLocation>
    </amazons3.init>

    <amazons3.createObjectCopy>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <destinationObject>{$ctx:destinationObject}</destinationObject>
    </amazons3.createObjectCopy>
    ```
    
    **Sample request**

    ```xml
    <createObjectCopy>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <methodType>PUT</methodType>
        <contentLength></contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect></expect>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <destinationObject>testObject5</destinationObject>
        <xAmzAcl></xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <xAmzCopySource>/imagesBucket5/testObject37</xAmzCopySource>
        <xAmzMetadataDirective></xAmzMetadataDirective>
        <xAmzCopySourceIfMatch></xAmzCopySourceIfMatch>
        <xAmzCopySourceIfNoneMatch></xAmzCopySourceIfNoneMatch>
        <xAmzCopySourceIfUnmodifiedSince></xAmzCopySourceIfUnmodifiedSince>
        <xAmzCopySourceIfModifiedSince></xAmzCopySourceIfModifiedSince>
        <xAmzServeEncryption></xAmzServeEncryption>
        <xAmzStorageClass></xAmzStorageClass>
        <xAmzWebsiteLocation></xAmzWebsiteLocation>
    </createObjectCopy>
    ```

??? note "getObjectMetaData"
    The getObjectMetaData operation retrieves metadata from an object without returning the object itself. This operation is useful if you are interested only in an object's metadata. To use this operation, you must have READ access to the object. The response is identical to the GET response except that there is no response body.

    When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectHEAD.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object to retrieve details for.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>range</td>
            <td>Downloads the specified range bytes of an object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifModifiedSince</td>
            <td>Returns the object only if it has been modified since the specified time. Otherwise, returns 304.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifUnmodifiedSince</td>
            <td>Returns the object only if it has not been modified since the specified time. Otherwise, returns 412.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifMatch</td>
            <td>Returns the object only if its entity tag (ETag) is the same as the one specified. Otherwise, returns 412.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>ifNoneMatch</td>
            <td>Returns the object only if its entity tag (ETag) is different from the one specified. Otherwise, returns 304.</td>
            <td>Yes</td>
        </tr>        
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObjectMetaData>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
        <range>{$ctx:range}</range>
        <ifModifiedSince>{$ctx:ifModifiedSince}</ifModifiedSince>
        <ifUnmodifiedSince>{$ctx:ifUnmodifiedSince}</ifUnmodifiedSince>
        <ifMatch>{$ctx:ifMatch}</ifMatch>
        <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
    </amazons3.getObjectMetaData>
    ```
    
    **Sample request**

    ```xml
    <getObjectMetaData>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEOj+343HD82s</secretAccessKey>
        <methodType>HEAD</methodType>
        <contentLength></contentLength>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <expect></expect>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <objectName>testObject2</objectName>
        <range></range>
        <ifModifiedSince></ifModifiedSince>
        <ifUnmodifiedSince></ifUnmodifiedSince>
        <ifMatch></ifMatch>
        <ifNoneMatch></ifNoneMatch>
    </getObjectMetaData>
    ```

??? note "uploadPart"
    The uploadPart operation uploads a part in a multipart upload. In this operation, you provide part data in your request. However, you have an option to specify your existing Amazon S3 object as the data source for the part being uploaded. You must initiate a multipart upload (see initMultipartUpload) before you can upload any part. In response to your initiate request, Amazon S3 returns an upload ID, which is the unique identifier that must be included in the upload part request.

    Part numbers can be any number from 1 to 10,000 (inclusive). A part number uniquely identifies a part and also defines its position within the object being created. If a new part is uploaded using the same part number that was used with a previous part, the previously uploaded part is overwritten. Each part must be at least 5 MB in size, except the last part. There is no size limit on the last part of your multipart upload.

    To ensure that data is not corrupted when traversing the network, specify the Content-MD5 header in the upload part request. Amazon S3 checks the part data against the provided MD5 value. If they do not match, Amazon S3 returns an error. After the multipart upload is initiated and one or more parts are uploaded, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload will Amazon S3 free up the parts storage and stop charging you for the parts storage.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadUploadPart.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name to give for the newly created object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>This specifies the ID of the initiated multipart upload.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>partNumber</td>
            <td>Part number that identifies the part.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample request**

    ```xml
    <amazons3.init>
        <accessKeyId>AKIAIGUASDRZM7GJ7TRO6KQAD</accessKeyId>
        <secretAccessKey>asAX8CJoDKsdfzeOd0Ve5dMCFk4STUFDRHkGX6m0CSLKcY</secretAccessKey>
        <isXAmzDate>true</isXAmzDate>
        <contentType>text/plain</contentType>
        <methodType>PUT</methodType>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
    </amazons3.init>

    <!-- Use the following for the uploading part method -->

    http://localhost:8889/services/multipart?objectName=testFile1.txt&uploadId=VSMdi3EgFYBq_DpBv6G0LWXydidqO9WIw90UIp81EripQrJNuxOo.jf3tkA.23aURwTOZPBD4iCfcogwtMc8_A--&partNumber=1&bucketUrl=http://sinhala.com.s3-us-west-2.amazonaws.com&accessKeyId=AKIAIGUASDRZM7GJ7TRO6KQAD&secretAccessKey=asAX8CJoDKsdfzeOd0Ve5dMCFk4STUFDRHkGX6m0CSLKcY&bucketName=sinhala.com&isXAmzDate=true&methodType=PUT
    ```
    
??? note "completeMultipartUpload"
    The completeMultipartUpload operation completes a multipart upload by assembling previously uploaded parts. You should first initiate the multipart upload using initMultipartUpload, and then upload all parts using uploadParts. After you successfully upload all relevant parts of an upload, call completeMultipartUpload to complete the upload. When you call completeMultipartUpload, Amazon S3 concatenates all the parts in ascending order by part number to create a new object. In the completeMultipartUpload request, you must provide the complete parts list (see listParts). For each part in the list, the part number and the ETag header value must be provided. When the part is uploaded the part number and the ETag header value should be returned.

    Processing of a completeMultipartUpload request can take several minutes. After Amazon S3 begins processing the request, it sends an HTTP response header that specifies a 200 OK response. While processing is in progress, Amazon S3 periodically sends whitespace characters to keep the connection from timing out. Because a request could fail after the initial 200 OK response has been sent, it is important that you check the response body to determine whether the request succeeded. If completeMultipartUpload fails, applications should be prepared to retry the failed requests.

    When calling init before this operation, the following headers should be removed: xAmzAcl, xAmzGrantRead, xAmzGrantWrite, xAmzGrantReadAcp, xAmzGrantWriteAcp, and xAmzGrantFullControl.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadComplete.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>partDetails</td>
            <td>The container that holds the part details. The part details are as follows:
                    <ul>
                        <li>part: The container for elements related to a previously uploaded part.</li>
                            <ul>
                                <li>partNumber: The part number that identifies the part.</li>
                                <li>ETag: The entity tag returned when the part is uploaded.</li>
                            </ul>
                    </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name to give the newly created object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>cacheControl</td>
            <td>This can be used to specify caching behavior along the request or reply chain.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentDisposition</td>
            <td>This specifies presentational information for the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentEncoding</td>
            <td>This specifies what content encodings have been applied to the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expires</td>
            <td>This specifies the date and time at which the object is no longer cacheable.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>This specifies the ID of the current multipart upload.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>partDetails</td>
            <td>This contains all the part numbers and the corresponding Etags.</td>
            <td>Yes</td>
        </tr>           
    </table>

    **Sample configuration**

    ```xml
    <amazons3.completeMultipartUpload>
        <partDetails>{$ctx:partDetails}</partDetails>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
        <uploadId>{$ctx:uploadId}</uploadId>
    </amazons3.completeMultipartUpload>
    ```
    
    **Sample request**

    ```xml
    <completeMultipartUpload>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>POST</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <contentMD5></contentMD5>
        <objectName>myimage.png</objectName>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <uploadId>VONszTPldyDo80ARdEMI2kVxEBLQYY1tncD7PpB54WDtLTACJIn.jWRIGo7iL_EkJYn9Z2BT3MM.kEqju9CgLyUveDtl6MgXzRYqjb8R4L.ZVpUhv25d56P2Tk1XnD0C</uploadId>
        <partDetails>
            <Part>
                <PartNumber>1</PartNumber>
                <ETag>LKJLINTLNM9879NL7jNLk</ETag>
            </Part>
        </partDetails>
        <xAmzSecurityToken></xAmzSecurityToken>
        <expect></expect>
        <contentLength></contentLength>
        <expires></expires>
    </completeMultipartUpload>
    ```

??? note "abortMultipartUpload"
    The abortMultipartUpload operation aborts a multipart upload. After a multipart upload is aborted, no additional parts can be uploaded using that upload ID. The storage consumed by any previously uploaded parts will be freed. However, if any part uploads are currently in progress, those part uploads might or might not succeed. As a result, it might be necessary to abort a given multipart upload multiple times in order to completely free all storage consumed by all parts. To verify that all parts have been removed so that you do not get charged for the part storage, call the listParts operation and ensure the parts list is empty.

    Following is the proxy configuration for init and abortMultipartUpload. The init section has additional parameters and parameters that need to be removed apart from those mentioned in the Connecting to Amazon S3 section.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadAbort.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>methodType</td>
            <td>HTTP method type.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentLength</td>
            <td>Length of the message without the headers according to RFC 2616.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>Content type of the resource.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentMD5</td>
            <td>Base64 encoded 128-bit MD5 digest of the message according to RFC 1864.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expect</td>
            <td>When this property is set to 100-continue, the request does not send the request body until it receives an acknowledgment. If the message is rejected based on the headers, the body of the message is not sent.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>host</td>
            <td>The path-style requests (s3.amazonaws.com) or virtual-style requests (BucketName.s3.amazonaws.com).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region that is used to select a regional endpoint to make requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isXAmzDate</td>
            <td>Specifies whether the current date and time are considered to calculate the signature. Valid values: true or false.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzSecurityToken</td>
            <td>The security token based on whether Amazon DevPay operations or temporary security credentials are used.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzAcl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWrite</td>
            <td>Allows the specified grantee or grantees to create, overwrite, and delete any object in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantReadAcp</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWriteAcp</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMeta</td>
            <td>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzServeEncryption</td>
            <td>Specifies the server-side encryption algorithm to use when Amazon S3 creates the target object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzStorageClass</td>
            <td>RRS enables customers to reduce their costs by storing non-critical, reproducible data at lower levels of redundancy than Amazon S3's standard storage.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzWebsiteLocation</td>
            <td>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>cacheControl</td>
            <td>This can be used to specify caching behavior along the request or reply chain.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentDisposition</td>
            <td>This specifies presentational information for the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentEncoding</td>
            <td>This specifies what content encodings have been applied to the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expires</td>
            <td>The Expires header of the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>This specifies the ID of the current multipart upload.</td>
            <td>Yes</td>
        </tr>         
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <methodType>{$ctx:methodType}</methodType>
        <contentLength>{$ctx:contentLength}</contentLength>
        <contentType>{$ctx:contentType}</contentType>
        <contentMD5>{$ctx:contentMD5}</contentMD5>
        <expect>{$ctx:expect}</expect>
        <host>{$ctx:host}</host>
        <region>{$ctx:region}</region>
        <isXAmzDate>{$ctx:isXAmzDate}</isXAmzDate>
        <xAmzSecurityToken>{$ctx:xAmzSecurityToken}</xAmzSecurityToken>
        <bucketName>{$ctx:bucketName}</bucketName>
        <xAmzAcl>{$ctx:xAmzAcl}</xAmzAcl>
        <xAmzGrantRead>{$ctx:xAmzGrantRead}</xAmzGrantRead>
        <xAmzGrantWrite>{$ctx:xAmzGrantWrite}</xAmzGrantWrite>
        <xAmzGrantReadAcp>{$ctx:xAmzGrantReadAcp}</xAmzGrantReadAcp>
        <xAmzGrantWriteAcp>{$ctx:xAmzGrantWriteAcp}</xAmzGrantWriteAcp>
        <xAmzGrantFullControl>{$ctx:xAmzGrantFullControl}</xAmzGrantFullControl>
        <xAmzMeta>{$ctx:xAmzMeta}</xAmzMeta>
        <xAmzServeEncryption>{$ctx:xAmzServeEncryption}</xAmzServeEncryption>
        <xAmzStorageClass>{$ctx:xAmzStorageClass}</xAmzStorageClass>
        <xAmzWebsiteLocation>{$ctx:xAmzWebsiteLocation}</xAmzWebsiteLocation>
    </amazons3.init>

    <amazons3.abortMultipartUpload>
        <cacheControl>{$ctx:cacheControl}</cacheControl>
        <contentDisposition>{$ctx:contentDisposition}</contentDisposition>
        <contentEncoding>{$ctx:contentEncoding}</contentEncoding>
        <expires>{$ctx:expires}</expires>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
        <uploadId>{$ctx:uploadId}</uploadId>
    </amazons3.abortMultipartUpload>
    ```
    
    **Sample request**

    ```xml
    <abortMultipartUpload>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>DELETE</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <contentMD5></contentMD5>
        <objectName>myimage.png</objectName>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <uploadId>VONszTPldyDo80ARdEMI2kVxEBLQYY1tncD7PpB54WDtLTACJIn.jWRIGo7iL_EkJYn9Z2BT3MM.kEqju9CgLyUveDtl6MgXzRYqjb8R4L.ZVpUhv25d56P2Tk1XnD0C</uploadId>
        <expect></expect>
        <xAmzAcl></xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <contentDisposition></contentDisposition>
        <contentEncoding></contentEncoding>
        <contentLength></contentLength>
        <expires></expires>
        <xAmzMeta>Content-Language:enus</xAmzMeta>
        <xAmzStorageClass>STANDARD</xAmzStorageClass>
        <xAmzWebsiteLocation></xAmzWebsiteLocation>
    </abortMultipartUpload>
    ```

??? note "listParts"
    The listParts operation lists the parts that have been uploaded for a specific multipart upload.

    This operation must include the upload ID, which can be obtained using the initMultipartUpload operation. The listParts operation returns a maximum of 1,000 uploaded parts. The default number of parts returned is 1,000 parts, but you can restrict the number of parts using the maxParts property. If the multipart upload consists of more than 1,000 parts, the response returns an IsTruncated field with the value of true and a NextPartNumberMarker element. In subsequent listParts requests, you can include the partNumberMarker query string parameter and set its value to the NextPartNumberMarker field value from the previous response.

    Following is the proxy configuration for init and listParts. The init section has additional parameters and parameters that need to be removed apart from those mentioned in the Connecting to Amazon S3 section.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadListParts.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>methodType</td>
            <td>HTTP method type.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>Content type of the resource.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isXAmzDate</td>
            <td>Specifies whether the current date and time are considered to calculate the signature. Valid values: true or false.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expect</td>
            <td>When this property is set to 100-continue, the request does not send the request body until it receives an acknowledgment. If the message is rejected based on the headers, the body of the message is not sent.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentMD5</td>
            <td>Base64 encoded 128-bit MD5 digest of the message according to RFC 1864.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzSecurityToken</td>
            <td>The security token based on whether Amazon DevPay operations or temporary security credentials are used.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>host</td>
            <td>The path-style requests (s3.amazonaws.com) or virtual-style requests (BucketName.s3.amazonaws.com).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region that is used to select a regional endpoint to make requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uriRemainder</td>
            <td>The URI syntax consists of a sequence of components separated by reserved characters, with the first component defining the semantics for the remainder of the URI string.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentLength</td>
            <td>Length of the message without the headers according to RFC 2616.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxParts</td>
            <td>Maximum number of parts allowed in the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>partNumberMarker</td>
            <td>Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentEncoding</td>
            <td>The Content-Encoding header of the request.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>encodingType</td>
            <td>Requests Amazon S3 to encode the response and specifies the encoding method to use.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>The ID of the upload.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <methodType>{$ctx:methodType}</methodType>
        <contentType>{$ctx:contentType}</contentType>
        <bucketName>{$ctx:bucketName}</bucketName>
        <isXAmzDate>{$ctx:isXAmzDate}</isXAmzDate>
        <expect>{$ctx:expect}</expect>
        <contentMD5>{$ctx:contentMD5}</contentMD5>
        <xAmzSecurityToken>{$ctx:xAmzSecurityToken}</xAmzSecurityToken>
        <host>{$ctx:host}</host>
        <region>{$ctx:region}</region>
        <uriRemainder>{$ctx:uriRemainder}</uriRemainder>
        <contentLength>{$ctx:contentLength}</contentLength>
    </amazons3.init>

    <amazons3.listParts>
        <maxParts>{$ctx:maxParts}</maxParts>
        <partNumberMarker>{$ctx:partNumberMarker}</partNumberMarker>
        <contentEncoding>{$ctx:contentEncoding}</contentEncoding>
        <encodingType>{$ctx:encodingType}</encodingType>
        <uploadId>{$ctx:uploadId}</uploadId>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
    </amazons3.listParts>
    ```
    
    **Sample request**

    ```xml
    <listParts>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>oSDz22F2mwtR+qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>GET</methodType>
        <contentLength></contentLength>
        <contentEncoding></contentEncoding>
        <encodingType>url</encodingType>
        <contentType>application/xml</contentType>
        <contentMD5></contentMD5>
        <uploadId>KyxZ7yjpSSZM9f0bdRectMF5dPg2h08BqTsmWf.8OEIq2Z4YvYg01LmJL0kVDqVcz2utci2CDE2Cn7k647j_84GhExGAN9uer65jljH_oapI758RA_AmcyW4N2usGHH0</uploadId>
        <expect></expect>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <objectName>myimage.png</objectName>
        <isXAmzDate>true</isXAmzDate>
        <maxParts>100</maxParts>
        <partNumberMarker>8</partNumberMarker>
        <xAmzSecurityToken></xAmzSecurityToken>
    </listParts>
    ```

??? note "initMultipartUpload"
    The initMultipartUpload operation initiates a multipart upload and returns an upload ID. This upload ID is used to associate all the parts in the specific multipart upload. You specify this upload ID in each of your subsequent uploadPart requests. You also include this upload ID in the final request to either complete or abort the multipart upload request.

    For request signing, multipart upload is just a series of regular requests: you initiate multipart upload, send one or more requests to upload parts (uploadPart), and finally complete multipart upload (completeMultipartUpload). You sign each request individually. After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload will Amazon S3 free up the parts storage and stop charging you for the parts storage.

    Following is the proxy configuration for init and initMultipartUpload. The init section has additional parameters and parameters that need to be removed apart from those mentioned in the Connecting to Amazon S3 section.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadInitiate.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>methodType</td>
            <td>HTTP method type.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>Content type of the resource.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isXAmzDate</td>
            <td>Specifies whether the current date and time are considered to calculate the signature. Valid values: true or false.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expect</td>
            <td>When this property is set to 100-continue, the request does not send the request body until it receives an acknowledgment. If the message is rejected based on the headers, the body of the message is not sent.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentMD5</td>
            <td>Base64 encoded 128-bit MD5 digest of the message according to RFC 1864.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzSecurityToken</td>
            <td>The security token based on whether Amazon DevPay operations or temporary security credentials are used.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>host</td>
            <td>The path-style requests (s3.amazonaws.com) or virtual-style requests (BucketName.s3.amazonaws.com).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region that is used to select a regional endpoint to make requests.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uriRemainder</td>
            <td>The URI syntax consists of a sequence of components separated by reserved characters, with the first component defining the semantics for the remainder of the URI string.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentLength</td>
            <td>Length of the message without the headers according to RFC 2616.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzAcl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWrite</td>
            <td>Allows the specified grantee or grantees to create, overwrite, and delete any object in the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantReadAcp</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantWriteAcp</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzGrantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>xAmzMeta</td>
            <td>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzServeEncryption</td>
            <td>Specifies the server-side encryption algorithm to use when Amazon S3 creates the target object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzStorageClass</td>
            <td>RRS enables customers to reduce their costs by storing non-critical, reproducible data at lower levels of redundancy than Amazon S3's standard storage.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>xAmzWebsiteLocation</td>
            <td>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>cacheControl</td>
            <td>This can be used to specify caching behavior along the request or reply chain.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentDisposition</td>
            <td>This specifies presentational information for the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentEncoding</td>
            <td>This specifies what content encodings have been applied to the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expires</td>
            <td>The date and time at which the object is no longer cacheable.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <methodType>{$ctx:methodType}</methodType>
        <contentType>{$ctx:contentType}</contentType>
        <bucketName>{$ctx:bucketName}</bucketName>
        <isXAmzDate>{$ctx:isXAmzDate}</isXAmzDate>
        <expect>{$ctx:expect}</expect>
        <contentMD5>{$ctx:contentMD5}</contentMD5>
        <xAmzSecurityToken>{$ctx:xAmzSecurityToken}</xAmzSecurityToken>
        <host>{$ctx:host}</host>
        <region>{$ctx:region}</region>
        <uriRemainder>{$ctx:uriRemainder}</uriRemainder>
        <contentLength>{$ctx:contentLength}</contentLength>
        <xAmzAcl>{$ctx:xAmzAcl}</xAmzAcl>
        <xAmzGrantRead>{$ctx:xAmzGrantRead}</xAmzGrantRead>
        <xAmzGrantWrite>{$ctx:xAmzGrantWrite}</xAmzGrantWrite>
        <xAmzGrantReadAcp>{$ctx:xAmzGrantReadAcp}</xAmzGrantReadAcp>
        <xAmzGrantWriteAcp>{$ctx:xAmzGrantWriteAcp}</xAmzGrantWriteAcp>
        <xAmzGrantFullControl>{$ctx:xAmzGrantFullControl}</xAmzGrantFullControl>
        <xAmzMeta>{$ctx:xAmzMeta}</xAmzMeta>
        <xAmzServeEncryption>{$ctx:xAmzServeEncryption}</xAmzServeEncryption>
        <xAmzStorageClass>{$ctx:xAmzStorageClass}</xAmzStorageClass>
        <xAmzWebsiteLocation>{$ctx:xAmzWebsiteLocation}</xAmzWebsiteLocation>
    </amazons3.init>

    <amazons3.initMultipartUpload>
        <cacheControl>{$ctx:cacheControl}</cacheControl>
        <contentDisposition>{$ctx:contentDisposition}</contentDisposition>
        <contentEncoding>{$ctx:contentEncoding}</contentEncoding>
        <expires>{$ctx:expires}</expires>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
    </amazons3.initMultipartUpload>
    ```
    
    **Sample request**

    ```xml
    <initMultipartUpload>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>POST</methodType>
        <contentType>application/xml</contentType>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <contentMD5></contentMD5>
        <objectName>myImage.png</objectName>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <expect></expect>
        <xAmzAcl></xAmzAcl>
        <xAmzGrantRead></xAmzGrantRead>
        <xAmzGrantWrite></xAmzGrantWrite>
        <xAmzGrantReadAcp></xAmzGrantReadAcp>
        <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
        <xAmzGrantFullControl></xAmzGrantFullControl>
        <contentDisposition></contentDisposition>
        <contentEncoding></contentEncoding>
        <contentLength></contentLength>
        <expires></expires>
        <xAmzMeta>Content-Language:enus</xAmzMeta>
        <xAmzServeEncryption>AES256</xAmzServeEncryption>
        <xAmzStorageClass>STANDARD</xAmzStorageClass>
        <xAmzWebsiteLocation></xAmzWebsiteLocation>
    </initMultipartUpload>
    ```

??? note "getObjectACL"
    The getObjectACL operation uses the ACL subresource to return the access control list (ACL) of an object. To use this operation, you must have READ_ACP access to the object.

    Following is the proxy configuration for getObjectACL.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectGETacl.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>      
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObjectACL>
        <objectName>{$ctx:objectName}</objectName>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getObjectACL>
    ```
    
    **Sample request**

    ```xml
    <getObjectACL>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>GET</methodType>
        <contentType>application/xml; charset=UTF-8</contentType>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <contentMD5></contentMD5>
        <expect>100-continue</expect>
        <contentLength></contentLength>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead>GrantRead</xAmzGrantRead>
        <xAmzGrantWrite>Grantwrite</xAmzGrantWrite>
        <xAmzGrantReadAcp>GrantReadAcp</xAmzGrantReadAcp>
        <xAmzGrantWriteAcp>GrantWriteAcp</xAmzGrantWriteAcp>
        <xAmzGrantFullControl>GrantFullControl</xAmzGrantFullControl>
        <objectName>testFile.txt</objectName>
    </getObjectACL>
    ```

??? note "getObjectTorrent"
    The getObjectTorrent operation uses the torrent subresource to return torrent files from a bucket. BitTorrent can save you bandwidth when you're distributing large files.

    You can get torrent only for objects that are less than 5 GB in size and that are not encrypted using server-side encryption with customer-provided encryption key.

    To use this operation, you must have READ access to the object.

    Following is the proxy configuration for getObjectTorrent.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectGETtorrent.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>      
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObjectTorrent>
        <objectName>{$ctx:objectName}</objectName>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
    </amazons3.getObjectTorrent>
    ```
    
    **Sample request**

    ```xml
    <getObjectTorrent>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>GET</methodType>
        <contentType>application/xml; charset=UTF-8</contentType>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <contentMD5></contentMD5>
        <expect>100-continue</expect>
        <contentLength></contentLength>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead>GrantRead</xAmzGrantRead>
        <xAmzGrantWrite>Grantwrite</xAmzGrantWrite>
        <xAmzGrantReadAcp>GrantReadAcp</xAmzGrantReadAcp>
        <xAmzGrantWriteAcp>GrantWriteAcp</xAmzGrantWriteAcp>
        <xAmzGrantFullControl>GrantFullControl</xAmzGrantFullControl>
        <objectName>testFile.txt</objectName>
    </getObjectTorrent>
    ```

??? note "restoreObject"
    The restoreObject operation restores a temporary copy of an archived object. You can optionally provide version ID to restore specific object version. If version ID is not provided, it will restore the current version. The number of days that you want the restored copy will be determined by numberOfDays. After the specified period, Amazon S3 deletes the temporary copy. Note that the object remains archived; Amazon S3 deletes only the restored copy.

    An object in the Glacier storage class is an archived object. To access the object, you must first initiate a restore request, which restores a copy of the archived object. Restore jobs typically complete in three to five hours.

    Following is the proxy configuration for restoreObject.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectPOSTrestore.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>   
        <tr>
            <td>numberOfDays</td>
            <td>Lifetime of the restored (active) copy.</td>
            <td>Yes</td>
        </tr>  
        <tr>
            <td>versionId</td>
            <td>Version Id of an object to restore a specific object version.</td>
            <td>Yes</td>
        </tr>       
    </table>

    **Sample configuration**

    ```xml
    <amazons3.restoreObject>
        <objectName>{$ctx:objectName}</objectName>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <numberOfDays>{$ctx:numberOfDays}</numberOfDays>
        <versionId>{$ctx:versionId}</versionId>
    </amazons3.restoreObject>
    ```
    
    **Sample request**

    ```xml
    <restoreObject>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>POST</methodType>
        <contentType>application/xml; charset=UTF-8</contentType>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <contentMD5></contentMD5>
        <expect>100-continue</expect>
        <contentLength></contentLength>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <xAmzAcl>public-read</xAmzAcl>
        <xAmzGrantRead>GrantRead</xAmzGrantRead>
        <xAmzGrantWrite>Grantwrite</xAmzGrantWrite>
        <xAmzGrantReadAcp>GrantReadAcp</xAmzGrantReadAcp>
        <xAmzGrantWriteAcp>GrantWriteAcp</xAmzGrantWriteAcp>
        <xAmzGrantFullControl>GrantFullControl</xAmzGrantFullControl>
        <objectName>testFile.txt</objectName>
        <numberOfDays>7</numberOfDays>
        <versionId></versionId>
    </restoreObject>
    ```

??? note "uploadPartCopy"
    The uploadPartCopy operation uploads a part by copying data from an existing object as data source. You specify the data source by adding the x-amz-copy-source in your request and a byte range by adding the x-amz-copy-source-range in your request. The minimum allowable part size for a multipart upload is 5 MB.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/mpUploadUploadPartCopy.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name to give the newly created object.</td>
            <td>Yes</td>
        </tr>   
        <tr>
            <td>uploadId</td>
            <td>This specifiy the ID of the initiated multipart upload.</td>
            <td>Yes</td>
        </tr>  
        <tr>
            <td>partNumber</td>
            <td>This specifiy the number or the index of the uploaded part.</td>
            <td>Yes</td>
        </tr>       
    </table>

    **Sample configuration**

    ```xml
    <amazons3.uploadPartCopy>
        <objectName>{$ctx:objectName}</objectName>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <uploadId>{$ctx:uploadId}</uploadId>
        <partNumber>{$ctx:partNumber}</partNumber>
    </amazons3.uploadPartCopy>
    ```
    
    **Sample request**

    ```xml
    <uploadPartCopy>
        <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
        <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
        <methodType>PUT</methodType>
        <contentType>application/xml; charset=UTF-8</contentType>
        <contentLength>256</contentLength>
        <contentMD5></contentMD5>
        <objectName>testFile1.txt</objectName>
        <isXAmzDate>true</isXAmzDate>
        <xAmzSecurityToken></xAmzSecurityToken>
        <region>us-east-2</region>
        <host>s3.us-east-2.amazonaws.com</host>
        <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
        <bucketName>signv4test</bucketName>
        <expect></expect>
        <uploadId>SsNUDqUklMaoV_IfePCpGAZHjaxJx.cGXEcX6TVW4I6WzOQFnAKomYevz5qi5LtkfTvlpwjY9M6QDGsIIvdGEQzBURo3MMU2Yh.ZEQDsk_lsnx3Z8m9jsglW6FIfKGQ_</uploadId>
        <partNumber>2</partNumber>
        <uriRemainder>/testFile1.txt?partNumber=2&amp;uploadId=SsNUDqUklMaoV_IfePCpGAZHjaxJx.cGXEcX6TVW4I6WzOQFnAKomYevz5qi5LtkfTvlpwjY9M6QDGsIIvdGEQzBURo3MMU2Yh.ZEQDsk_lsnx3Z8m9jsglW6FIfKGQ_</uriRemainder>
        <xAmzCopySource>/testBucket1/testFile.jpg</xAmzCopySource>
        <xAmzCopySourceRange>bytes=0-9</xAmzCopySourceRange>
        <xAmzCopySourceIfMatch></xAmzCopySourceIfMatch>
        <xAmzCopySourceIfNoneMatch></xAmzCopySourceIfNoneMatch>
        <xAmzCopySourceIfUnmodifiedSince></xAmzCopySourceIfUnmodifiedSince>
        <xAmzCopySourceIfModifiedSince></xAmzCopySourceIfModifiedSince>
    </uploadPartCopy>
    ```

??? note "headObject"
    The headObject operation retrieves metadata from an object without returning the object itself. This operation is useful if you are interested only in an object's metadata. To use this operation, you must have READ access to that object. A HEAD request has the same options as a GET operation on an object. The response is identical to the GET response except that there is no response body.

    See the [related API documentation](http://docs.aws.amazon.com/AmazonS3/latest/API/RESTObjectHEAD.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketUrl</td>
            <td>The URL of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectName</td>
            <td>The name to give the newly created object.</td>
            <td>Yes</td>
        </tr>   
        <tr>
            <td>range</td>
            <td>The specified range bytes of an object to download.</td>
            <td>Optional</td>
        </tr>  
        <tr>
            <td>ifModifiedSince</td>
            <td>Return the object only if it has been modified since the specified time.</td>
            <td>Optional</td>
        </tr> 
        <tr>
            <td>ifUnmodifiedSince</td>
            <td>Return the object only if it has not been modified since the specified time.</td>
            <td>Optional</td>
        </tr>  
        <tr>
            <td>ifMatch</td>
            <td>Return the object only if its entity tag (ETag) is the same as the one specified.</td>
            <td>Optional</td>
        </tr>    
        <tr>
            <td>ifNoneMatch</td>
            <td>Return the object only if its entity tag (ETag) is different from the one specified.</td>
            <td>Optional</td>
        </tr>      
    </table>

    **Sample configuration**

    ```xml
    <amazons3.headObject>
        <bucketUrl>{$ctx:bucketUrl}</bucketUrl>
        <objectName>{$ctx:objectName}</objectName>
        <range>{$ctx:range}</range>
        <ifModifiedSince>{$ctx:ifModifiedSince}</ifModifiedSince>
        <ifUnmodifiedSince>{$ctx:ifUnmodifiedSince}</ifUnmodifiedSince>
        <ifMatch>{$ctx:ifMatch}</ifMatch>
        <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
    </amazons3.headObject>
    ```
    
    **Sample request**

    ```xml
      <accessKeyId>AKIXXXXXHXQXXG5XX</accessKeyId>
      <secretAccessKey>qHXXBXXXXASYQc4oMCEXXX343HD82s</secretAccessKey>
      <methodType>PUT</methodType>
      <contentLength>256</contentLength>
      <contentType>application/xml</contentType>
      <contentMD5></contentMD5>
      <expect></expect>
      <region>us-east-2</region>
      <host>s3.us-east-2.amazonaws.com</host>
      <bucketUrl>http://s3.us-east-2.amazonaws.com/signv4test</bucketUrl>
      <bucketName>signv4test</bucketName>
      <isXAmzDate>true</isXAmzDate>
      <xAmzSecurityToken></xAmzSecurityToken>
      <objectName>testObject2</objectName>
      <xAmzAcl></xAmzAcl>
      <xAmzGrantRead></xAmzGrantRead>
      <xAmzGrantWrite></xAmzGrantWrite>
      <xAmzGrantReadAcp></xAmzGrantReadAcp>
      <xAmzGrantWriteAcp></xAmzGrantWriteAcp>
      <xAmzGrantFullControl></xAmzGrantFullControl>
      <range></range>
      <ifModifiedSince></ifModifiedSince>
      <ifMatch></ifMatch>
      <ifNoneMatch></ifNoneMatch>
      <ifUnmodifiedSince></ifUnmodifiedSince>
    </headObject>
    ``` 
    
