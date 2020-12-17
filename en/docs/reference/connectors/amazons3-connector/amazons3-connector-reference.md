# Amazon S3 Connector Reference

The following operations allow you to work with the Amazon S3 Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Amazon S3 connector, add the <amazons3.init> element in your configuration before carrying out any Amazon S3 operations. This Amazon S3 configuration authenticates with Amazon S3 by specifying the AWS access key ID and secret access key ID, which are used for every operation.

??? note "init"
    The init operation is used to initialize the connection to Amazon S3.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>awsAccessKeyId</td>
            <td>AWS access key ID.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>awsSecretAccessKey</td>
            <td>AWS secret access key.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>name</td>
            <td>Unique name to identify the connection by.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>Region which is used select a regional endpoint to make requests, e.g.: us-east-1.</td>
            <td>Yes</td>
        </tr>
    </table>

    > **Note**: You can either pass credentials within init configuration or set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY as environment variables. The AWS SDK uses provider chains to look for AWS credentials in system/user environment variables.

    To set these environment variables on Linux, macOS, or Unix, use export :
    export AWS_ACCESS_KEY_ID=AKIXXXXXXXXXXA
    export AWS_SECRET_ACCESS_KEY=qHZXXXXXXQc4oMQMnAOj+340XXxO2s

    To set these environment variables on Windows, use set :
    set AWS_ACCESS_KEY_ID=AKIXXXXXXXXXXA
    set AWS_SECRET_ACCESS_KEY=qHZXXXXXXQc4oMQMnAOj+340XXxO2s

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>
    ```

---

### Buckets

??? note "listBuckets"
    The listBuckets implementation returns a list of all buckets owned by the authenticated sender of the request. To authenticate a request, use a valid AWS Access Key ID that is registered with Amazon S3. Anonymous requests cannot list buckets, and a user cannot list buckets that were not created by that particular user.

    **Sample configuration**

    ```xml
    <amazons3.listBuckets/>
    ```

    **Sample request**

    ```xml
    <listBuckets/>
    ```


??? note "createBucket"
    The createBucket operation creates a new bucket. To create a bucket, the user should be registered with Amazon S3 and have a valid AWS Access Key ID to authenticate requests. Anonymous requests are never allowed to create buckets. By creating the bucket, the user becomes the owner of the bucket. Not every string is an acceptable bucket name. For information on bucket naming restrictions, see [Working with Amazon S3 Buckets](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html). By default, the bucket is created in the US Standard region. The user can optionally specify a region in the request body. For example, if the user resides in Europe, the user will probably find it advantageous to create buckets in the EU (Ireland) region. For more information, see [How to Select a Region for Your Buckets](http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingBucket.html#access-bucket-intro). See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/CreateBucketRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketRegion</td>
            <td>Region for the created bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>acl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantWrite</td>
            <td>Allows the specified grantee or grantees to create, overwrite, and delete any object in the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantReadACP</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantWriteACP</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockEnabledForBucket</td>
            <td>The object lock mode that you want to apply to the copied object.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.createBucket>
        <bucketName>{$ctx:bucketName}</bucketName>
        <bucketRegion>{$ctx:bucketRegion}</bucketRegion>
        <acl>{$ctx:acl}</acl>
        <grantFullControl>{$ctx:grantFullControl}</grantFullControl>
        <grantRead>{$ctx:grantRead}</grantRead>
        <grantReadACP>{$ctx:grantReadACP}</grantReadACP>
        <grantWrite>{$ctx:grantWrite}</grantWrite>
        <grantWriteACP>{$ctx:grantWriteACP}</grantWriteACP>
        <objectLockEnabledForBucket>{$ctx:objectLockEnabledForBucket}</objectLockEnabledForBucket>
    </amazons3.createBucket>
    ```

    **Sample request**

    ```xml
    <createBucket>
        <bucketName>signv4test</bucketName>
        <bucketRegion>us-east-2</bucketRegion>
        <objectLockEnabledForBucket>false</objectLockEnabledForBucket>
    </createBucket>
    ```


??? note "putBucketWebsite"
    Sets the configuration of the website that is specified in the website subresource.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>websiteConfig</td>
            <td>Website configuration information. For information on the elements you use in the request to specify the website configuration, see [here](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketWebsiteRequest.html).</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.putBucketWebsite>
        <bucketName>{$ctx:bucketName}</bucketName>
        <websiteConfig>{$ctx:websiteConfig}</websiteConfig>
    </amazons3.putBucketWebsite>
    ```

    **Sample request**

    ```xml
    <putBucketWebsite>
        <bucketName>signv4test</bucketName>
        <WebsiteConfiguration>
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
        </WebsiteConfiguration>
    </putBucketWebsite>
    ```

??? note "putBucketPolicy"
    The putBucketPolicy operation adds or replaces a policy on a bucket. If the bucket already has a policy, the one in this request completely replaces it. To perform this operation, you must be the bucket owner.

    If you are not the bucket owner but have PutBucketPolicy permissions on the bucket, Amazon S3 returns a 405 Method Not Allowed. In all other cases, for a PUT bucket policy request that is not from the bucket owner, Amazon S3 returns 403 Access Denied. There are restrictions about who can create bucket policies and which objects in a bucket they can apply to.

    See the [https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketPolicyRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketPolicy</td>
            <td>Policy of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>confirmRemoveSelfBucketAccess</td>
            <td>Use this to change this bucket policy in the future.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.putBucketPolicy>
        <bucketName>{$ctx:bucketName}</bucketName>
        <bucketPolicy>{$ctx:bucketPolicy}</bucketPolicy>
        <confirmRemoveSelfBucketAccess>{$ctx:confirmRemoveSelfBucketAccess}</confirmRemoveSelfBucketAccess>
    </amazons3.putBucketPolicy>
    ```

    **Sample request**

    ```json
    {
        "awsAccessKeyId": "AKXXXXXXXXX5EAS",
        "awsSecretAccessKey": "qHXXXXXXNMDYadDdsQMnAOj+3XXXXPs",
        "region":"us-east-2",
        "connectionName": "amazonS3",
        "bucketName": "signv4test",
        "bucketPolicy": {
                    "Version":"2012-10-17",
                    "Statement":[{
                        "Sid":"AddPerm",
                        "Effect":"Allow",
                        "Principal": {
                                "AWS": ["*"]
                            },
                        "Action":["s3:*"],
                        "Resource":["arn:aws:s3:::signv4test/*"]
                        }]
                    },
        "confirmRemoveSelfBucketAccess":""
    }
    ```

??? note "putBucketACL"
    The putBucketACL operation uses the ACL sub-resource to set the permissions on an existing bucket using access control lists (ACL). See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketAclRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
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
    <amazons3.putBucketACL>
        <bucketName>{$ctx:bucketName}</bucketName>
        <accessControlList>{$ctx:accessControlList}</accessControlList>
    </amazons3.putBucketACL>
    ```

    **Sample request**

    ```xml
    <putBucketACL>
        <bucketName>signv4test</bucketName>
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
    </putBucketACL>
    ```

??? note "putBucketLifecycleConfiguration"
    The putBucketLifecycleConfiguration operation uses the acl subresource to set the permissions on an existing bucket using access control lists (ACL). See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketLifecycleConfigurationRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
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
    <amazons3.putBucketLifecycleConfiguration>
        <bucketName>{$ctx:bucketName}</bucketName>
        <lifecycleConfiguration>{$ctx:lifecycleConfiguration}</lifecycleConfiguration>
    </amazons3.putBucketLifecycleConfiguration>
    ```

    **Sample request**

    ```xml
    <putBucketLifecycleConfiguration>
        <bucketName>signv4test</bucketName>
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
    </putBucketLifecycleConfiguration>
    ```

??? note "putBucketReplication"
    The putBucketReplication operation uses the acl subresource to set the permissions on an existing bucket using access control lists (ACL). See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketReplicationRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>replicationConfiguration</td>
            <td>Container for replication configuration (Amazon Resource Name (ARN) of an IAM role and set of replication rules):
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
                    <li>Role: Amazon Resource Name (ARN) of an IAM role for Amazon S3 to assume when replicating the objects.</li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.putBucketReplication>
        <bucketName>signv4test</bucketName>
        <bucketName>{$ctx:bucketName}</bucketName>
        <replicationConfiguration>{$ctx:replicationConfiguration}</replicationConfiguration>
    </amazons3.putBucketReplication>
    ```

    **Sample request**

    ```xml
    <putBucketReplication>
        <bucketName>signv4test</bucketName>
        <ReplicationConfiguration>
            <Rule>
                <ID>id1</ID>
                <Prefix>documents/</Prefix>
                <Status>Enabled</Status>
                <Destination>
                    <Bucket>arn:aws:s3:::signv4testq23aa1</Bucket>
                </Destination>
            </Rule>
        </ReplicationConfiguration>
    </putBucketReplication>
    ```

??? note "putBucketTagging"
    The putBucketTagging operation uses the tagging subresource to add a set of tags to an existing bucket. Use tags to organize your AWS bill to reflect your own cost structure. To do this, sign up to get your AWS account bill with tag key values included. Then, to see the cost of combined resources, organize your billing information according to resources with the same tag key values. For example, you can tag several resources with a specific application name, and then organize your billing information to see the total cost of that application across several services. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketTaggingRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
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
    <amazons3.putBucketTagging>
        <bucketName>{$ctx:bucketName}</bucketName>
        <tagSet>{$ctx:tagSet}</tagSet>
    </amazons3.putBucketTagging>
    ```

    **Sample request**

    ```xml
    <putBucketTagging>
        <bucketName>signv4test</bucketName>
        <TagSet>
            <Tag>
                <Key>Project</Key>
                <Value>Project One</Value>
            </Tag>
            <Tag>
                <Key>User</Key>
                <Value>jsmith</Value>
            </Tag>
        </TagSet>
    </putBucketTagging>
    ```

??? note "putBucketRequestPayment"
    The putBucketRequestPayment operation uses the requestPayment subresource to set the request payment configuration of a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketRequestPaymentRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
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
    <amazons3.putBucketRequestPayment>
        <bucketName>{$ctx:bucketName}</bucketName>
        <payer>{$ctx:payer}</payer>
    </amazons3.putBucketRequestPayment>
    ```

    **Sample request**

    ```xml
    <putBucketRequestPayment>
        <bucketName>signv4test</bucketName>
        <payer>Requester</payer>
    </putBucketRequestPayment>
    ```

??? note "putBucketVersioning"
    The putBucketVersioning operation uses the requestPayment subresource to set the request payment configuration of a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketVersioningRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>status</td>
            <td>Sets the versioning state of the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>mfa</td>
            <td>The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>mfaDelete</td>
            <td>Specifies whether MFA Delete is enabled in the bucket versioning configuration.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.putBucketVersioning>
        <bucketName>{$ctx:bucketName}</bucketName>
        <status>{$ctx:status}</status>
        <mfaDelete>{$ctx:mfaDelete}</mfaDelete>
    </amazons3.putBucketVersioning>
    ```

    **Sample request**

    ```xml
    <putBucketVersioning>
        <bucketName>signv4test</bucketName>
        <status>Enabled</status>
    </putBucketVersioning>
    ```

??? note "deleteBucket"
    The deleteBucket operation deletes the bucket named in the URI. All objects (including all object versions and Delete Markers) in the bucket must be deleted before the bucket itself can be deleted. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteBucketRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucket>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.deleteBucket>
    ```

    **Sample request**

    ```xml
    <deleteBucket>
        <bucketName>signv4test</bucketName>
    </deleteBucket>
    ```

??? note "deleteBucketPolicy"
    The deleteBucketPolicy operation deletes the policy on a specified bucket. To use the operation, you must have DeletePolicy permissions on the specified bucket and be the bucket owner. If there are no DeletePolicy permissions, Amazon S3 returns a 403 Access Denied error. If there is the correct permission, but you are not the bucket owner, Amazon S3 returns a 405 Method Not Allowed error. If the bucket does not have a policy, Amazon S3 returns a 204 No Content error. There are restrictions about who can create bucket policies and which objects in a bucket they can apply to. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteBucketPolicyRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketPolicy>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.deleteBucketPolicy>
    ```

    **Sample request**

    ```xml
    <deleteBucketPolicy>
        <bucketName>signv4test</bucketName>
    </deleteBucketPolicy>
    ```

??? note "deleteBucketCORS"
    The deleteBucketCORS operation deletes the cors configuration information set for the bucket. To use this operation, you must have permission to perform the s3:PutCORSConfiguration action. The bucket owner has this permission by default and can grant this permission to others. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteBucketCorsRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketCORS>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.deleteBucketCORS>
    ```

    **Sample request**

    ```xml
    <deleteBucketCORS>
        <bucketName>signv4test</bucketName>
    </deleteBucketCORS>
    ```

??? note "deleteBucketLifecycle"
    The deleteBucketLifecycle operation deletes the lifecycle configuration from the specified bucket. Amazon S3 removes all the lifecycle configuration rules in the lifecycle subresource associated with the bucket. Your objects never expire, and Amazon S3 no longer automatically deletes any objects on the basis of rules contained in the deleted lifecycle configuration. To use this operation, you must have permission to perform the s3:PutLifecycleConfiguration action. By default, the bucket owner has this permission and the bucket owner can grant this permission to others. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteBucketLifecycleRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketLifecycle>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.deleteBucketLifecycle>
    ```

    **Sample request**

    ```xml
    <deleteBucketLifecycle>
        <bucketName>signv4test</bucketName>
    </deleteBucketLifecycle>
    ```

??? note "deleteBucketReplication"
    The deleteBucketReplication operation deletes the replication sub-resource associated with the specified bucket. This operation requires permission for the s3:DeleteReplicationConfiguration action. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteBucketReplicationRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketReplication>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.deleteBucketReplication>
    ```

    **Sample request**

    ```xml
    <deleteBucketReplication>
        <bucketName>signv4test</bucketName>
    </deleteBucketReplication>
    ```

??? note "deleteBucketTagging"
    The deleteBucketTagging operation uses the tagging sub-resource to remove a tag set from the specified bucket. To use this operation, you must have permission to perform the s3:PutBucketTagging action. By default, the bucket owner has this permission and can grant this permission to others. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteBucketTaggingRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketTagging>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.deleteBucketTagging>
    ```

    **Sample request**

    ```xml
    <deleteBucketTagging>
        <bucketName>signv4test</bucketName>
    </deleteBucketTagging>
    ```

??? note "deleteBucketWebsiteConfiguration"
    The deleteBucketWebsiteConfiguration operation removes the website configuration for a bucket. Amazon S3 returns a 207 OK response upon successfully deleting a website configuration on the specified bucket. It will give a 200 response if the website configuration you are trying to delete does not exist on the bucket, and a 404 response if the bucket itself does not exist. This operation requires the S3: DeleteBucketWebsite permission. By default, only the bucket owner can delete the website configuration attached to a bucket. However, bucket owners can grant other users permission to delete the website configuration by writing a bucket policy granting them the S3: DeleteBucketWebsite permission. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteBucketWebsiteRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.deleteBucketWebsiteConfiguration>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.deleteBucketWebsiteConfiguration>
    ```

    **Sample request**

    ```xml
    <deleteBucketWebsiteConfiguration>
        <bucketName>signv4test</bucketName>
    </deleteBucketWebsiteConfiguration>
    ```

??? note "listObjects"
    The listObjects operation returns some or all (up to 1000) of the objects in a bucket. The request parameters act as selection criteria to return a subset of the objects in a bucket. To use this implementation of the operation, the user must have READ access to the bucket. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/ListObjectsRequest.html)) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
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
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.listObjects>
        <bucketName>{$ctx:bucketName}</bucketName>
        <delimiter>{$ctx:delimiter}</delimiter>
        <encodingType>{$ctx:encodingType}</encodingType>
        <marker>{$ctx:marker}</marker>
        <maxKeys>{$ctx:maxKeys}</maxKeys>
        <prefix>{$ctx:prefix}</prefix>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.listObjects>
    ```

    **Sample request**

    ```xml
    <listObjects>
        <bucketName>signv4test</bucketName>
        <maxKeys>3</maxKeys>
        <encodingType>The name of the bucket.</encodingType>
        <delimiter>images</delimiter>
    </listObjects>
    ```

??? note "getBucketLifecycleConfiguration"
    The getBucketLifecycleConfiguration operation returns the lifecycle configuration information set on the bucket. To use this operation, permissions should be given to perform the s3:GetLifecycleConfiguration action. The bucket owner has this permission by default and can grant this permission to others. There is usually some time lag before lifecycle configuration deletion is fully propagated to all the Amazon S3 systems. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketLifecycleConfigurationRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketLifecycleConfiguration>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketLifecycleConfiguration>
    ```

    **Sample request**

    ```xml
    <getBucketLifecycleConfiguration>
        <bucketName>signv4test</bucketName>
    </getBucketLifecycleConfiguration>
    ```

??? note "putBucketCORS"
    The putBucketCORS operation returns the cors configuration information set for the bucket. To use this operation, you must have permission to perform the s3:putBucketCORS action. By default, the bucket owner has this permission and can grant it to others. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutBucketCorsRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
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
    <amazons3.putBucketCORS>
        <bucketName>{$ctx:bucketName}</bucketName>
        <corsConfiguration>{$ctx:corsConfiguration}</corsConfiguration>
    </amazons3.putBucketCORS>
    ```

    **Sample request**

    ```xml
    <putBucketCORS>
        <bucketName>signv4test</bucketName>
        <CORSConfiguration>
            <CORSRule>
                <AllowedOrigin>*</AllowedOrigin>
                <AllowedMethod>GET</AllowedMethod>
                <AllowedHeader>*</AllowedHeader>
                <MaxAgeSeconds>3000</MaxAgeSeconds>
            </CORSRule>
        </CORSConfiguration>
    </putBucketCORS>
    ```

??? note "getBucketCORS"
    The getBucketCORS operation returns the cors configuration information set for the bucket. To use this operation, you must have permission to perform the s3:getBucketCORS action. By default, the bucket owner has this permission and can grant it to others. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketCorsRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketCORS>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketCORS>
    ```

    **Sample request**

    ```xml
    <getBucketCORS>
        <bucketName>signv4test</bucketName>
    </getBucketCORS>
    ```

??? note "getBucketLocation"
    The getBucketLocation operation returns the lifecycle configuration information set on the bucket. To use this operation, you must be the bucket owner. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketLocationRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketLocation>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketLocation>
    ```

    **Sample request**

    ```xml
    <getBucketLocation>
        <bucketName>signv4test</bucketName>
    </getBucketLocation>
    ```

??? note "getBucketLogging"
    The getBucketLogging operation returns the logging status of a bucket and the permissions users have to view and modify that status. To use this operation, you must be the bucket owner. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketLoggingRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketLogging>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketLogging>
    ```

    **Sample request**

    ```xml
    <getBucketLogging>
        <bucketName>signv4test</bucketName>
    </getBucketLogging>
    ```

??? note "getBucketNotificationConfiguration"
    The getBucketNotificationConfiguration operation returns the lifecycle configuration information set on the bucket. To use this operation, you must be the bucket owner to read the notification configuration of a bucket. However, the bucket owner can use a bucket policy to grant permission to other users to read this configuration with the s3:getBucketNotificationConfiguration permission. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketNotificationConfigurationRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketNotificationConfiguration>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketNotificationConfiguration>
    ```

    **Sample request**

    ```xml
    <getBucketNotificationConfiguration>
        <bucketName>signv4test</bucketName>
    </getBucketNotificationConfiguration>
    ```

??? note "getBucketTagging"
    The getBucketTagging operation returns the lifecycle configuration information set on the bucket. To use this operation, you must have permission to perform the s3:GetBucketTagging action. By default, the bucket owner has this permission and can grant this permission to others. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketTaggingRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketTagging>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketTagging>
    ```

    **Sample request**

    ```xml
    <getBucketTagging>
        <bucketName>signv4test</bucketName>
    </getBucketTagging>
    ```

??? note "getBucketReplication"
    The getBucketReplication operation returns the lifecycle configuration information set on the bucket. To use this operation, you must have permission to perform the s3:GetReplicationConfiguration action. For more information about permissions, go to Using Bucket Policies and User Policies in the Amazon Simple Storage Service Developer Guide. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketReplicationRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketReplication>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketReplication>
    ```

    **Sample request**

    ```xml
    <getBucketReplication>
        <bucketName>signv4test</bucketName>
    </getBucketReplication>
    ```

??? note "getBucketPolicy"
    The getBucketPolicy operation returns the policy of a specified bucket. To use this operation, the user must have GetPolicy permissions on the specified bucket, and the user must be the bucket owner. If the user does not have GetPolicy permissions, Amazon S3 returns a 403 Access Denied error. If the user has correct permissions, but the user is not the bucket owner, Amazon S3 returns a 405 Method Not Allowed error. If the bucket does not have a policy, Amazon S3 returns a 404 Policy Not found error. There are restrictions about who can create bucket policies and which objects in a bucket they can apply to. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketPolicyRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketPolicy>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketPolicy>
    ```

    **Sample request**

    ```xml
    <getBucketPolicy>
        <bucketName>signv4test</bucketName>
    </getBucketPolicy>
    ```

??? note "listObjectVersions"
    The listObjectVersions operation lists metadata about all of the versions of objects in a bucket. Request parameters can be used as selection criteria to return metadata about a subset of all the object versions. To use this operation, the user must have READ access to the bucket. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/ListObjectVersionsRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
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
    <amazons3.listObjectVersions>
        <bucketName>{$ctx:bucketName}</bucketName>
        <delimiter>{$ctx:delimiter}</delimiter>
        <encodingType>{$ctx:encodingType}</encodingType>
        <keyMarker>{$ctx:keyMarker}</keyMarker>
        <maxKeys>{$ctx:maxKeys}</maxKeys>
        <prefix>{$ctx:prefix}</prefix>
        <versionIdMarker>{$ctx:versionIdMarker}</versionIdMarker>
    </amazons3.listObjectVersions>
    ```

    **Sample request**

    ```xml
    <listObjectVersions>
        <bucketName>testkeerthu1234</bucketName>
        <delimiter>/</delimiter>
        <maxKeys>3</maxKeys>
        <prefix>images</prefix>
    </listObjectVersions>
    ```

??? note "getBucketRequestPayment"
    The getBucketRequestPayment operation returns the request payment configuration of a bucket. To use this operation, the user must be the bucket owner. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketRequestPaymentRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketRequestPayment>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketRequestPayment>
    ```

    **Sample request**

    ```xml
    <getBucketRequestPayment>
        <bucketName>signv4test</bucketName>
    </getBucketRequestPayment>
    ```

??? note "getBucketVersioning"
    The getBucketVersioning operation returns the versioning state of a bucket. To retrieve the versioning state of a bucket, the user must be the bucket owner. This implementation also returns the MFA Delete status of the versioning state. If the MFA Delete status is enabled, the bucket owner must use an authentication device to change the versioning state of the bucket. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketVersioningRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketVersioning>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketVersioning>
    ```

    **Sample request**

    ```xml
    <getBucketVersioning>
        <bucketName>signv4test</bucketName>
    </getBucketVersioning>
    ```

??? note "getBucketWebsite"
    The getBucketWebsite operation returns the website configuration associated with a bucket. To host the website on Amazon S3, a bucket can be configured as a website by adding a website configuration. This operation requires the S3:GetBucketWebsite permission. By default, only the bucket owner can read the bucket website configuration. However, bucket owners can allow other users to read the website configuration by writing a bucket policy granting them the S3:GetBucketWebsite permission. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketWebsiteRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketWebsite>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketWebsite>
    ```

    **Sample request**

    ```xml
    <getBucketWebsite>
        <bucketName>signv4test</bucketName>
    </getBucketWebsite>
    ```

??? note "getBucketACL"
    The getBucketACL operation returns the access control list (ACL) of a bucket. To return the ACL of the bucket, the user must have READ_ACP access to the bucket. If READ_ACP permission is granted to the anonymous user, you can return the ACL of the bucket without the authorization. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetBucketAclRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getBucketACL>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.getBucketACL>
    ```

    **Sample request**

    ```xml
    <getBucketACL>
        <bucketName>signv4test</bucketName>
    </getBucketACL>
    ```
??? note "headBucket"
    The headBucket operation is useful to determine if a bucket exists and you have permission to access it. The operation returns a 200 OK if the bucket exists and you have permission to access it. Otherwise, the operation might return responses such as 404 Not Found and 403 Forbidden. See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/HeadBucketRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.headBucket>
        <bucketName>{$ctx:bucketName}</bucketName>
    </amazons3.headBucket>
    ```

    **Sample request**

    ```xml
    <headBucket>
        <bucketName>1513162931643testconbkt2</bucketName>
    </headBucket>
    ```

??? note "listMultipartUploads"
    The listMultipartUploads operation lists in-progress multipart uploads. A multipart upload is in progress when it has been initiated using the Initiate Multipart Upload request but has not yet been completed or aborted. It returns a default value of 1000 multipart uploads in the response. The number of uploads can be further limited in a response by specifying the maxUploads property. If additional multipart uploads satisfy the list criteria, the response will contain an "IsTruncated" element with the value "true". To list the additional multipart uploads, use the keyMarker and uploadIdMarker request parameters.

    In the response, the uploads are sorted by key. If the application has initiated more than one multipart upload using the same object key, uploads in the response are first sorted by key. Additionally, uploads are sorted in ascending order within each key by the upload initiation time.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/glacier/model/ListMultipartUploadsRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>delimiter</td>
            <td>A delimiter is a character you use to group keys. All keys that contain the same string between the prefix, if specified, and the first occurrence of the delimiter after the prefix are grouped under a single result element CommonPrefixes. If you do not specify the prefix parameter, the substring starts at the beginning of the key. The keys that are grouped under the CommonPrefixesresult element are not returned elsewhere in the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>encodingType</td>
            <td>Requests Amazon S3 to encode the response and specifies the encoding method to use. An object key can contain any Unicode character. However, XML 1.0 parser cannot parse some characters such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request Amazon S3 to encode the keys in the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>maxUploads</td>
            <td>Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>keyMarker</td>
            <td>Specifies the key to start with when listing objects in a bucket. Amazon S3 lists objects in alphabetical order.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>prefix</td>
            <td>Limits the response to keys that begin with the specified prefix.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>uploadIdMarker</td>
            <td>Specifies the multipart upload after which listing should begin.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.listMultipartUploads>
        <bucketName>{$ctx:bucketName}</bucketName>
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
        <bucketName>signv4test</bucketName>
    </listMultipartUploads>
    ```

### Objects

??? note "deleteObject"
    The deleteObject operation removes the null version (if there is one) of an object and inserts a delete marker, which becomes the latest version of the object. If there is no null version, Amazon S3 does not remove any objects.

    If the object you want to delete is in a bucket where the bucket versioning configuration is MFA Delete enabled, you must include the mfa in the request. For more information about MFA Delete, see Using MFA Delete .

    Following is the proxy configuration for init and deleteObject. The init section has connection parameters.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/clouddirectory/model/DeleteObjectRequest.html) for more information.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object to be deleted.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>Version Id of an object to remove a specific object version.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>bypassGovernanceRetention</td>
            <td>Indicates whether S3 Object Lock should bypass Governance-mode restrictions to process this operation.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>mfa</td>
            <td>Required to permanently delete a versioned object if versioning is configured with MFA Delete enabled. The value is the concatenation of the authentication device's serial number, a space, and the value displayed on your authentication device.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    > **Note**: To remove a specific version, the user must be the bucket owner and must use the versionId sub-resource, which permanently deletes the version.

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>

    <amazons3.deleteObject>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <versionId>{$ctx:versionId}</versionId>
        <bypassGovernanceRetention>{$ctx:bypassGovernanceRetention}</bypassGovernanceRetention>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.deleteObject>
    ```

    **Sample request**

    ```xml
    <deleteObject>
        <bucketName>signv4test</bucketName>
        <objectKey>testObject1</objectKey>
        <versionId>FHbrL3xf2TK54hLNWWArYI79woSElvHf</versionId>
    </deleteObject>
    ```

??? note "deleteObjects"
    The deleteObjects operation deletes multiple objects from a bucket using a single HTTP request. If object keys that need to be deleted are known, this operation provides a suitable alternative to sending individual delete requests (deleteObject). The deleteObjects request contains a list of up to 1000 keys that the user wants to delete. In the XML, you provide the object key names, and optionally provide version IDs if you want to delete a specific version of the object from a versioning-enabled bucket. For each key, Amazon S3 performs a delete operation and returns the result of that deletion, success or failure, in the response. Note that if the object specified in the request is not found, Amazon S3 returns the result as deleted.

    The deleteObjects operation supports two modes for the response: verbose and quiet. By default, the operation uses the verbose mode in which the response includes the result of deletion of each key in your request. In the quiet mode, the response includes only keys where the delete operation encountered an error. For a successful deletion, the operation does not return any information about the deletion in the response body.

    When using the deleteObjects operation that attempts to delete a versioned object on an MFA Delete enabled bucket, you must include an MFA token. If you do not provide one, even if there are non-versioned objects you are attempting to delete. Additionally, f you provide an invalid token, the entire request will fail, regardless of whether there are versioned keys in the request. For more information about MFA Delete, see MFA Delete.

    Following is the proxy configuration for init and deleteObjects. The init section has connection parameters.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/DeleteObjectsRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>Name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bypassGovernanceRetention</td>
            <td>Indicates whether S3 Object Lock should bypass Governance-mode restrictions to process this operation.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>mfa</td>
            <td>Required to permanently delete a versioned object if versioning is configured with MFA Delete enabled. The value is the concatenation of the authentication device's serial number, a space, and the value displayed on your authentication device.</td>
            <td>Optional</td>
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
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>

    <amazons3.deleteObjects>
        <bucketName>{$ctx:bucketName}</bucketName>
        <bypassGovernanceRetention>{$ctx:bypassGovernanceRetention}</bypassGovernanceRetention>
        <deleteConfig>{$ctx:deleteConfig}</deleteConfig>
        <mfa>{$ctx:mfa}</mfa>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.deleteObjects>
    ```

    **Sample request**

    ```xml
    <deleteObjects>
        <bucketName>signv4test</bucketName>
        <Delete>
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
        </Delete>
    </deleteObjects>
    ```

??? note "getObject"
    The getObject operation retrieves objects from Amazon S3. To use this operation, the user must have READ access to the object. If the user grants READ access to the anonymous user, the object can be returned without the authorization. By default, this operation returns the latest version of the object.

    An Amazon S3 bucket has no directory hierarchy such as in a typical computer file system. However, a logical hierarchy can be created by using object key names that imply a folder structure. For example, instead of naming an object sample.jpg, it could be named photos/2006/February/sample.jpg. To retrieve an object from such a logical hierarchy, the full key name for the object should be specified.

    For a virtual hosted-style request example, if you have the object photos/2006/February/sample.jpg, specify the resource as /photos/2006/February/sample.jpg. For a path-style request example, if you have the object photos/2006/February/sample.jpg in the bucket named examplebucket, specify the resource as /examplebucket/photos/2006/February/sample.jpg. If the object to be retrieved is a GLACIER storage class object, the object is archived in Amazon Glacier, and you must first restore a copy before retrieving the object. Otherwise, this operation returns the "InvalidObjectStateError" error.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/mediastoredata/model/GetObjectRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object to retrieve details for.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>responseContentType</td>
            <td>Content-Type property of the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>responseContentLanguage</td>
            <td>Content-Language property of the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>responseExpires</td>
            <td>Expires property of the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>responseCacheControl</td>
            <td>Cache-Control property of the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>responseContentDisposition</td>
            <td>Content-Disposition property of the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>responseContentEncoding</td>
            <td>Content-Encoding property of the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>range</td>
            <td>HTTP range property.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifModifiedSince</td>
            <td>Return the object only if it has been modified.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifUnmodifiedSince</td>
            <td>Return the object only if it has not been modified.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifMatch</td>
            <td>Return the object only if its ETag is the same.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifNoneMatch</td>
            <td>Return the object only if its ETag is not the same as the one specified.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>VersionId used to reference a specific version of the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerAlgorithm</td>
            <td>Specifies the algorithm to use to when encrypting the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>partNumber</td>
            <td>Part number of the object being read.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObject>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
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
        <versionId>{$ctx:versionId}</versionId>
        <sseCustomerAlgorithm>{$ctx:sseCustomerAlgorithm}</sseCustomerAlgorithm>
        <sseCustomerKey>{$ctx:sseCustomerKey}</sseCustomerKey>
        <sseCustomerKeyMD5>{$ctx:sseCustomerKeyMD5}</sseCustomerKeyMD5>
        <partNumber>{$ctx:partNumber}</partNumber>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.getObject>
    ```

    **Sample request**

    ```xml
    <getObject>
        <bucketName>signv4test</bucketName>
        <objectKey>Tree2.png</objectKey>
        <partNumber>1</partNumber>
    </getObject>
    ```

??? note "putObject"
    The putObject operation adds an object to a bucket. You must have WRITE permissions on a bucket to add an object to it. Amazon S3 does not add partial objects, so if a success response is received, the entire object is added to the bucket. Because Amazon S3 is a distributed system, if it receives multiple write requests for the same object simultaneously, it overwrites all but the last object written.

    To ensure that data is not corrupted traversing the network, use the Content-MD5 parameter. When it is used, Amazon S3 checks the object against the provided MD5 value and, if they do not match, it returns an error. Additionally, you can calculate the MD5 value while putting an object to Amazon S3 and compare the returned ETag with the calculated MD5 value.

    When uploading an object, you can specify the accounts or groups that should be granted specific permissions on the object. There are two ways to grant the appropriate permissions using the request parameters: either specify a canned (predefined) ACL using the "acl", or specify access permissions explicitly using the "grantRead", "grantReadACP", "grantWriteACP", and "grantFullControl" parameters. These parameters map to the set of permissions that Amazon S3 supports in an ACL. Use only one approach, not both.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/clouddirectory/model/putObjectRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object to retrieve details for.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>filePath</td>
            <td>The path of the source file to be uploaded.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>acl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>cacheControl</td>
            <td>This can be used to specify caching behavior along the request or reply chain.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentDisposition</td>
            <td>This specifies presentational information for the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentEncoding</td>
            <td>The language the content is in.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentLanguage</td>
            <td>This specifies what content encodings have been applied to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>A standard MIME type describing the format of the object data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentMD5</td>
            <td>The base64-encoded 128-bit MD5 digest of the message according to RFC 1864.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expires</td>
            <td>This specifies the date and time at which the object is no longer cacheable.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantReadACP</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantWriteACP</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>metadata</td>
            <td>The metadata. Comma separated key value pair. The key and value are separated by ':'t.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>serverSideEncryption</td>
            <td>Specifies the server-side encryption algorithm to use when Amazon S3 creates the target object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>storageClass</td>
            <td>RRS enables customers to reduce their costs by storing non-critical, reproducible data at lower levels of redundancy than Amazon S3's standard storage.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>websiteRedirectLocation</td>
            <td>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this parameter in the object metadata.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerAlgorithm</td>
            <td>Specifies the algorithm to use to when encrypting the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ssekmsKeyId</td>
            <td>Specifies the ID of the symmetric customer managed AWS KMS CMK to use for object encryption.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ssekmsEncryptionContext</td>
            <td>Specifies the AWS KMS Encryption Context to use for object encryption.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tagging</td>
            <td>The tag-set for the object. The tag-set must be encoded as URL Query parameters. (For example, "Key1=Value1"). This must be used in conjunction with the TaggingDirective.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockMode</td>
            <td>The object lock mode that you want to apply to the uploaded object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockRetainUntilDate</td>
            <td>Specifies the date and time when you want the Object Lock to expire.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockLegalHoldStatus</td>
            <td>Specifies whether you want to apply a Legal Hold to the uploaded object.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.putObject>
        <bucketName>{$url:bucketName}</bucketName>
        <objectKey>{$url:objectKey}</objectKey>
        <filePath>{$url:filePath}</filePath>
        <acl>{$ctx:acl}</acl>
        <cacheControl>{$ctx:cacheControl}</cacheControl>
        <contentDisposition>{$ctx:contentDisposition}</contentDisposition>
        <contentEncoding>{$ctx:contentEncoding}</contentEncoding>
        <contentLanguage>{$ctx:contentLanguage}</contentLanguage>
        <contentType>{$ctx:contentType}</contentType>
        <expires>{$ctx:expires}</expires>
        <grantRead>{$ctx:grantRead}</grantRead>
        <grantReadACP>{$ctx:grantReadACP}</grantReadACP>
        <grantWriteACP>{$ctx:grantWriteACP}</grantWriteACP>
        <grantFullControl>{$ctx:grantFullControl}</grantFullControl>
        <metadata>{$ctx:metadata}</metadata>
        <serverSideEncryption>{$ctx:serverSideEncryption}</serverSideEncryption>
        <storageClass>{$ctx:storageClass}</storageClass>
        <websiteRedirectLocation>{$ctx:websiteRedirectLocation}</websiteRedirectLocation>
        <sseCustomerAlgorithm>{$ctx:sseCustomerAlgorithm}</sseCustomerAlgorithm>
        <sseCustomerKey>{$ctx:sseCustomerKey}</sseCustomerKey>
        <sseCustomerKeyMD5>{$ctx:sseCustomerKeyMD5}</sseCustomerKeyMD5>
        <ssekmsKeyId>{$ctx:ssekmsKeyId}</ssekmsKeyId>
        <ssekmsEncryptionContext>{$ctx:ssekmsEncryptionContext}</ssekmsEncryptionContext>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
        <tagging>{$ctx:tagging}</tagging>
        <objectLockMode>{$ctx:objectLockMode}</objectLockMode>
        <objectLockRetainUntilDate>{$ctx:objectLockRetainUntilDate}</objectLockRetainUntilDate>
        <objectLockLegalHoldStatus>{$ctx:objectLockLegalHoldStatus}</objectLockLegalHoldStatus>
    </amazons3.putObject>
    ```

    **Sample request**

    ```xml
    <putObject>
        <bucketName>signv4test</bucketName>
        <objectKey>s3_image.jpg</objectKey>
        <filePath>/Users/mine/Desktop/S3_img.jpg</filePath>
    </putObject>
    ```

??? note "putObjectAcl"
    The putObjectAcl operation sets the access control list (ACL) permissions for an object that already exists in a bucket. You can specify the ACL in the request body or specify permissions using request, depending on the application needs. For example, if there is an existing application that updates an object ACL using the request body, you can continue to use that approach.

    The ACL of an object is set at the object version level. By default, putObjectAcl sets the ACL of the latest version of an object. To set the ACL of a different version, use the versionId property.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/PutObjectAclRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>Name of the object whose acl needs to be set.</td>
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
            <td>Optional</td>
        </tr>
        <tr>
            <td>acl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantWrite</td>
            <td>Allows the specified grantee or grantees to create, overwrite, and delete any object in the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantReadACP</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantWriteACP</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.putObjectAcl>
        <objectKey>{$ctx:objectKey}</objectKey>
        <bucketName>{$ctx:bucketName}</bucketName>
        <accessControlList>{$ctx:accessControlList}</accessControlList>
        <versionId>{$ctx:versionId}</versionId>
        <acl>{$ctx:acl}</acl>
        <grantRead>{$ctx:grantRead}</grantRead>
        <grantReadACP>{$ctx:grantReadACP}</grantReadACP>
        <grantWrite>{$ctx:grantWrite}</grantWrite>
        <grantWriteACP>{$ctx:grantWriteACP}</grantWriteACP>
        <grantFullControl>{$ctx:grantFullControl}</grantFullControl>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.putObjectAcl>
    ```

    **Sample request**

    ```xml
    <putObjectAcl>
        <bucketName>signv4test</bucketName>
        <objectKey>testObject2</objectKey>
        <versionId>FHbrL3xf2TK54hLNWWArYI79woSElvHf</versionId>
        <acl>authenticated-read</acl>
        <AccessControlPolicy>
            <Owner>
                <ID>c6567b8c9274b78d6af4a3080c5e43e700f560f3517b7d9acc87251412044c35</ID>
            </Owner>
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
        </AccessControlPolicy>
    </putObjectAcl>
    ```

??? note "copyBucketObject"
    The copyBucketObject operation creates a copy of an object that is already stored in Amazon S3. This operation is the same as performing a GET and then a PUT. Adding the "copySource" enables to copy the source object into the destination bucket.

    When copying an object, most of the metadata (default) can be preserved, or new metadata can be specified. However, the ACL is not preserved and is set to "private" for the user making the request. All copy requests must be authenticated and cannot contain a message body. Additionally, the user must have the READ access to the source object and WRITE access to the destination bucket. To copy an object only under certain conditions, such as whether the ETag matches or whether the object was modified before or after a specified date with the parameters such as "copySourceIfMatch", "copySourceIfNoneMatch", "copySourceIfUnmodifiedSince", or "copySourceIfModifiedSince" must be used.

    There are two instances when the copy request could return an error. One is when Amazon S3 receives the copy request, and the other can occur while Amazon S3 is copying the files. If the error occurs before the copy operation starts, you receive a standard Amazon S3 error. If the error occurs during the copy operation, the error response is embedded in the 200 OK response. This means that a 200 OK response can contain either a success or an error. If the request is an HTTP 1.1 request, the response is chunk encoded. Otherwise, it will not contain the content-length, and you will need to read the entire body.

    When copying an object, the accounts or groups that should be granted specific permissions on the object can be specified. There are two ways to grant the appropriate permissions using the request: one is to specify a canned (predefined) ACL using the "acl" parameter, and the other is to specify access permissions explicitly using the "grantRead", "grantReadACP", "grantWriteACP", and "grantFullControl" parameters. These parameters map to the set of permissions that Amazon S3 supports in an ACL. Use only one approach, not both.

    Following is the proxy configuration for init and copyBucketObject. The init section has connection parameters.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/CopyObjectRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>acl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>cacheControl</td>
            <td>This can be used to specify caching behavior along the request or reply chain.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentDisposition</td>
            <td>This specifies presentational information for the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentEncoding</td>
            <td>The language the content is in.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentLanguage</td>
            <td>This specifies what content encodings have been applied to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>A standard MIME type describing the format of the object data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantReadACP</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantWriteACP</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySource</td>
            <td>The name of the source bucket and key name of the source object, separated by a slash (/).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>metadataDirective</td>
            <td>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>metadata</td>
            <td>New metadata to replace. Comma separated key value pair. The key and value are separated by ':'.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>taggingDirective</td>
            <td>Specifies whether the object tag-set are copied from the source object or replaced with tag-set provided in the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceIfMatch</td>
            <td>Copies the object if its entity tag (ETag) matches the specified tag. Otherwise, the request returns a 412 HTTP status code error (failed precondition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceIfNoneMatch</td>
            <td>Copies the object if its entity tag (ETag) is different from the specified ETag. Otherwise, the request returns a 412 HTTP status code error (failed precondition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceIfUnmodifiedSince</td>
            <td>Copies the object if it has not been modified since the specified time. Oherwise, the request returns a 412 HTTP status code error (failed precondition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceIfModifiedSince</td>
            <td>Copies the object if it has been modified since the specified time. Otherwise, the request returns a 412 HTTP status code error (failed condition).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expires</td>
            <td>The date and time at which the object is no longer cacheable.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>serverSideEncryption</td>
            <td>Specifies the server-side encryption algorithm to use when Amazon S3 creates the target object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>storageClass</td>
            <td>RRS enables customers to reduce their costs by storing non-critical, reproducible data at lower levels of redundancy than Amazon S3's standard storage.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>websiteRedirectLocation</td>
            <td>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this parameter in the object metadata.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerAlgorithm</td>
            <td>Specifies the algorithm to use to when encrypting the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ssekmsKeyId</td>
            <td>Specifies the ID of the symmetric customer managed AWS KMS CMK to use for object encryption.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ssekmsEncryptionContext</td>
            <td>Specifies the AWS KMS Encryption Context to use for object encryption.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceSSECustomerAlgorithm</td>
            <td>Specifies the algorithm to use when decrypting the source object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceSSECustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceSSECustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tagging</td>
            <td>The tag-set for the object. The tag-set must be encoded as URL Query parameters. (For example, "Key1=Value1"). This must be used in conjunction with the TaggingDirective.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockMode</td>
            <td>The object lock mode that you want to apply to the uploaded object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockRetainUntilDate</td>
            <td>Specifies the date and time when you want the Object Lock to expire.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockLegalHoldStatus</td>
            <td>Specifies whether you want to apply a Legal Hold to the uploaded object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>destinationBucket</td>
            <td>Name of the destination bucket to copy the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>destinationKey</td>
            <td>The destination where the source will be copied.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>

    <amazons3.copyBucketObject>
        <copySource>{$ctx:copySource}</copySource>
        <acl>{$ctx:acl}</acl>
        <cacheControl>{$ctx:cacheControl}</cacheControl>
        <contentDisposition>{$ctx:contentDisposition}</contentDisposition>
        <contentEncoding>{$ctx:contentEncoding}</contentEncoding>
        <contentLanguage>{$ctx:contentLanguage}</contentLanguage>
        <contentType>{$ctx:contentType}</contentType>
        <copySourceIfMatch>{$ctx:copySourceIfMatch}</copySourceIfMatch>
        <copySourceIfModifiedSince>{$ctx:copySourceIfModifiedSince}</copySourceIfModifiedSince>
        <copySourceIfNoneMatch>{$ctx:copySourceIfNoneMatch}</copySourceIfNoneMatch>
        <copySourceIfUnmodifiedSince>{$ctx:copySourceIfUnmodifiedSince}</copySourceIfUnmodifiedSince>
        <expires>{$ctx:expires}</expires>
        <grantRead>{$ctx:grantRead}</grantRead>
        <grantReadACP>{$ctx:grantReadACP}</grantReadACP>
        <grantWriteACP>{$ctx:grantWriteACP}</grantWriteACP>
        <grantFullControl>{$ctx:grantFullControl}</grantFullControl>
        <metadataDirective>{$ctx:metadataDirective}</metadataDirective>
        <metadata>{$ctx:metadata}</metadata>
        <taggingDirective>{$ctx:taggingDirective}</taggingDirective>
        <tagging>{$ctx:tagging}</tagging>
        <serverSideEncryption>{$ctx:serverSideEncryption}</serverSideEncryption>
        <storageClass>{$ctx:storageClass}</storageClass>
        <websiteRedirectLocation>{$ctx:websiteRedirectLocation}</websiteRedirectLocation>
        <sseCustomerAlgorithm>{$ctx:sseCustomerAlgorithm}</sseCustomerAlgorithm>
        <sseCustomerKey>{$ctx:sseCustomerKey}</sseCustomerKey>
        <sseCustomerKeyMD5>{$ctx:sseCustomerKeyMD5}</sseCustomerKeyMD5>
        <ssekmsKeyId>{$ctx:ssekmsKeyId}</ssekmsKeyId>
        <ssekmsEncryptionContext>{$ctx:ssekmsEncryptionContext}</ssekmsEncryptionContext>
        <copySourceSSECustomerAlgorithm>{$ctx:copySourceSSECustomerAlgorithm}</copySourceSSECustomerAlgorithm>
        <copySourceSSECustomerKey>{$ctx:copySourceSSECustomerKey}</copySourceSSECustomerKey>
        <copySourceSSECustomerKeyMD5>{$ctx:copySourceSSECustomerKeyMD5}</copySourceSSECustomerKeyMD5>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
        <objectLockMode>{$ctx:objectLockMode}</objectLockMode>
        <objectLockRetainUntilDate>{$ctx:objectLockRetainUntilDate}</objectLockRetainUntilDate>
        <objectLockLegalHoldStatus>{$ctx:objectLockLegalHoldStatus}</objectLockLegalHoldStatus>
        <destinationBucket>{$ctx:destinationBucket}</destinationBucket>
        <destinationKey>{$ctx:destinationKey}</destinationKey>
    </amazons3.copyBucketObject>
    ```

    **Sample request**

    ```xml
    <copyBucketObject>
        <bucketName>signv4test</bucketName>
        <copySource>/imagesBucket5/testObject37</copySource>
        <destinationObject>testObject5</destinationObject>
    </copyBucketObject>
    ```

??? note "uploadPart"
    The uploadPart operation uploads a part in a multipart upload. In this operation, you provide part data in your request. However, you have an option to specify your existing Amazon S3 object as the data source for the part being uploaded. You must initiate a multipart upload (see createMultipartUpload) before you can upload any part. In response to your initiate request, Amazon S3 returns an upload ID, which is the unique identifier that must be included in the upload part request.

    Part numbers can be any number from 1 to 10,000 (inclusive). A part number uniquely identifies a part and also defines its position within the object being created. If a new part is uploaded using the same part number that was used with a previous part, the previously uploaded part is overwritten. Each part must be at least 5 MB in size, except the last part. There is no size limit on the last part of your multipart upload.

    To ensure that data is not corrupted when traversing the network, specify the Content-MD5 parameter in the upload part request. Amazon S3 checks the part data against the provided MD5 value. If they do not match, Amazon S3 returns an error. After the multipart upload is initiated and one or more parts are uploaded, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload will Amazon S3 free up the parts storage and stop charging you for the parts storage.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/UploadPartRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
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
        <tr>
            <td>filePath</td>
            <td>Path of the file to be uploaded.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sseCustomerAlgorithm</td>
            <td>Specifies the algorithm to use to when encrypting the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.uploadPart>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <uploadId>{$ctx:uploadId}</uploadId>
        <partNumber>{$ctx:partNumber}</partNumber>
        <filePath>{$url:filePath}</filePath>
        <sseCustomerAlgorithm>{$ctx:sseCustomerAlgorithm}</sseCustomerAlgorithm>
        <sseCustomerKey>{$ctx:sseCustomerKey}</sseCustomerKey>
        <sseCustomerKeyMD5>{$ctx:sseCustomerKeyMD5}</sseCustomerKeyMD5>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.uploadPart>
    ```

    **Sample request**

    ```xml
    <amazons3.uploadPart>
        <bucketName>signv4test</bucketName>
        <objectKey>testObj.jpg</objectKey>
        <uploadId>cI0BzCZ7cx69YP.dhqpwEZAhgH7IzLVuOYjZVZdrmR9LSYAnxPqyYXlzHWGG3hgyH_MuJkTO8cltkaOK.TeG_7zBjFrjJduFCuFLDwah.ZXK7pvlTTDPQAaTRLW_o4FR</uploadId>
        <partNumber>1</partNumber>
        <filePath>/Users/mine/Desktop/S3_img.jpg</filePath>
    </amazons3.uploadPart>
    ```

??? note "completeMultipartUpload"
    The completeMultipartUpload operation completes a multipart upload by assembling previously uploaded parts. You should first initiate the multipart upload using createMultipartUpload, and then upload all parts using uploadParts. After you successfully upload all relevant parts of an upload, call completeMultipartUpload to complete the upload. When you call completeMultipartUpload, Amazon S3 concatenates all the parts in ascending order by part number to create a new object. In the completeMultipartUpload request, you must provide the complete parts list (see listParts). For each part in the list, the part number and the ETag value must be provided. When the part is uploaded the part number and the ETag value should be returned.

    Processing of a completeMultipartUpload request can take several minutes. After Amazon S3 begins processing the request, it sends an HTTP response header that specifies a 200 OK response. While processing is in progress, Amazon S3 periodically sends whitespace characters to keep the connection from timing out. Because a request could fail after the initial 200 OK response has been sent, it is important that you check the response body to determine whether the request succeeded. If completeMultipartUpload fails, applications should be prepared to retry the failed requests.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/glacier/model/CompleteMultipartUploadRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>completedPartDetails</td>
            <td>The container that holds the completed part details. The part details are as follows:
                    <ul>
                        <li>part: The container for elements related to a previously uploaded part.</li>
                            <ul>
                                <li>PartNumber: The part number that identifies the part.</li>
                                <li>ETag: The entity tag returned when the part is uploaded.</li>
                            </ul>
                    </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name to give the newly created object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>This specifies the ID of the current multipart upload.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.completeMultipartUpload>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <uploadId>{$ctx:uploadId}</uploadId>
        <completedPartDetails>{$ctx:completedPartDetails}</completedPartDetails>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.completeMultipartUpload>
    ```

    **Sample request**

    ```xml
    <completeMultipartUpload>
        <bucketName>signv4test</bucketName>
        <objectKey>myimage.png</objectKey>
        <uploadId>VONszTPldyDo80ARdEMI2kVxEBLQYY1tncD7PpB54WDtLTACJIn.jWRIGo7iL_EkJYn9Z2BT3MM.kEqju9CgLyUveDtl6MgXzRYqjb8R4L.ZVpUhv25d56P2Tk1XnD0C</uploadId>
        <CompletedPartDetails>
            <CompletedPart>
                <PartNumber>1</PartNumber>
                <ETag>LKJLINTLNM9879NL7jNLk</ETag>
            </CompletedPart>
        </CompletedPartDetails>
    </completeMultipartUpload>
    ```

??? note "abortMultipartUpload"
    The abortMultipartUpload operation aborts a multipart upload. After a multipart upload is aborted, no additional parts can be uploaded using that upload ID. The storage consumed by any previously uploaded parts will be freed. However, if any part uploads are currently in progress, those part uploads might or might not succeed. As a result, it might be necessary to abort a given multipart upload multiple times in order to completely free all storage consumed by all parts. To verify that all parts have been removed so that you do not get charged for the part storage, call the listParts operation and ensure the parts list is empty.

    Following is the proxy configuration for init and abortMultipartUpload. The init section has connection parameters.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/glacier/model/AbortMultipartUploadRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>This specifies the ID of the current multipart upload.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>

    <amazons3.abortMultipartUpload>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <uploadId>{$ctx:uploadId}</uploadId>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.abortMultipartUpload>
    ```

    **Sample request**

    ```xml
    <abortMultipartUpload>
        <bucketName>signv4test</bucketName>
        <objectKey>myimage.png</objectKey>
        <uploadId>VONszTPldyDo80ARdEMI2kVxEBLQYY1tncD7PpB54WDtLTACJIn.jWRIGo7iL_EkJYn9Z2BT3MM.kEqju9CgLyUveDtl6MgXzRYqjb8R4L.ZVpUhv25d56P2Tk1XnD0C</uploadId>
    </abortMultipartUpload>
    ```

??? note "listParts"
    The listParts operation lists the parts that have been uploaded for a specific multipart upload.

    This operation must include the upload ID, which can be obtained using the createMultipartUpload operation. The listParts operation returns a maximum of 1,000 uploaded parts. The default number of parts returned is 1,000 parts, but you can restrict the number of parts using the maxParts property. If the multipart upload consists of more than 1,000 parts, the response returns an IsTruncated field with the value of true and a NextPartNumberMarker element. In subsequent listParts requests, you can include the partNumberMarker query string parameter and set its value to the NextPartNumberMarker field value from the previous response.

    Following is the proxy configuration for init and listParts. The init section has connection parameters.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/glacier/model/ListPartsRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>The ID of the upload.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxParts</td>
            <td>Maximum number of parts allowed in the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>partNumberMarker</td>
            <td>Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>

    <amazons3.listParts>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <uploadId>{$ctx:uploadId}</uploadId>
        <maxParts>{$ctx:maxParts}</maxParts>
        <partNumberMarker>{$ctx:partNumberMarker}</partNumberMarker>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.listParts>
    ```

    **Sample request**

    ```xml
    <listParts>
        <bucketName>signv4test</bucketName>
        <objectKey>myimage.png</objectKey>
        <uploadId>KyxZ7yjpSSZM9f0bdRectMF5dPg2h08BqTsmWf.8OEIq2Z4YvYg01LmJL0kVDqVcz2utci2CDE2Cn7k647j_84GhExGAN9uer65jljH_oapI758RA_AmcyW4N2usGHH0</uploadId>
        <maxParts>100</maxParts>
        <partNumberMarker>8</partNumberMarker>
    </listParts>
    ```

??? note "createMultipartUpload"
    The createMultipartUpload operation initiates a multipart upload and returns an upload ID. This upload ID is used to associate all the parts in the specific multipart upload. You specify this upload ID in each of your subsequent uploadPart requests. You also include this upload ID in the final request to either complete or abort the multipart upload request.

    For request signing, multipart upload is just a series of regular requests: you initiate multipart upload, send one or more requests to upload parts (uploadPart), and finally complete multipart upload (completeMultipartUpload). You sign each request individually. After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload will Amazon S3 free up the parts storage and stop charging you for the parts storage.

    Following is the proxy configuration for init and createMultipartUpload. The init section has connection parameters.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/CreateMultipartUploadRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>acl</td>
            <td>The canned ACL to apply to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantRead</td>
            <td>Allows the specified grantee or grantees to list the objects in the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantReadACP</td>
            <td>Allows the specified grantee or grantees to read the bucket ACL.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantWriteACP</td>
            <td>Allows the specified grantee or grantees to write the ACL for the applicable bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>grantFullControl</td>
            <td>Allows the specified grantee or grantees the READ, WRITE, READ_ACP, and WRITE_ACP permissions on the bucket.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>metadata</td>
            <td>Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>serverSideEncryption</td>
            <td>Specifies the server-side encryption algorithm to use when Amazon S3 creates the target object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>storageClass</td>
            <td>RRS enables customers to reduce their costs by storing non-critical, reproducible data at lower levels of redundancy than Amazon S3's standard storage.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>websiteRedirectLocation</td>
            <td>If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this parameter in the object metadata.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerAlgorithm</td>
            <td>Specifies the algorithm to use to when encrypting the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ssekmsKeyId</td>
            <td>Specifies the ID of the symmetric customer managed AWS KMS CMK to use for object encryption.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ssekmsEncryptionContext</td>
            <td>Specifies the AWS KMS Encryption Context to use for object encryption.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>cacheControl</td>
            <td>This can be used to specify caching behavior along the request or reply chain.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentDisposition</td>
            <td>This specifies presentational information for the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentEncoding</td>
            <td>This specifies what content encodings have been applied to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentLanguage</td>
            <td>This specifies what content encodings have been applied to the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>A standard MIME type describing the format of the object data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expires</td>
            <td>The date and time at which the object is no longer cacheable.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tagging</td>
            <td>The tag-set for the object. The tag-set must be encoded as URL Query parameters. (For example, "Key1=Value1"). This must be used in conjunction with the TaggingDirective.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockMode</td>
            <td>The object lock mode that you want to apply to the uploaded object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockRetainUntilDate</td>
            <td>Specifies the date and time when you want the Object Lock to expire.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>objectLockLegalHoldStatus</td>
            <td>Specifies whether you want to apply a Legal Hold to the uploaded object.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>

    <amazons3.createMultipartUpload>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <acl>{$ctx:acl}</acl>
        <cacheControl>{$ctx:cacheControl}</cacheControl>
        <contentDisposition>{$ctx:contentDisposition}</contentDisposition>
        <contentEncoding>{$ctx:contentEncoding}</contentEncoding>
        <contentLanguage>{$ctx:contentLanguage}</contentLanguage>
        <contentType>{$ctx:contentType}</contentType>
        <expires>{$ctx:expires}</expires>
        <grantRead>{$ctx:grantRead}</grantRead>
        <grantReadACP>{$ctx:grantReadACP}</grantReadACP>
        <grantWriteACP>{$ctx:grantWriteACP}</grantWriteACP>
        <grantFullControl>{$ctx:grantFullControl}</grantFullControl>
        <metadata>{$ctx:metadata}</metadata>
        <serverSideEncryption>{$ctx:serverSideEncryption}</serverSideEncryption>
        <storageClass>{$ctx:storageClass}</storageClass>
        <websiteRedirectLocation>{$ctx:websiteRedirectLocation}</websiteRedirectLocation>
        <sseCustomerAlgorithm>{$ctx:sseCustomerAlgorithm}</sseCustomerAlgorithm>
        <sseCustomerKey>{$ctx:sseCustomerKey}</sseCustomerKey>
        <sseCustomerKeyMD5>{$ctx:sseCustomerKeyMD5}</sseCustomerKeyMD5>
        <ssekmsKeyId>{$ctx:ssekmsKeyId}</ssekmsKeyId>
        <ssekmsEncryptionContext>{$ctx:ssekmsEncryptionContext}</ssekmsEncryptionContext>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
        <tagging>{$ctx:tagging}</tagging>
        <objectLockMode>{$ctx:objectLockMode}</objectLockMode>
        <objectLockRetainUntilDate>{$ctx:objectLockRetainUntilDate}</objectLockRetainUntilDate>
        <objectLockLegalHoldStatus>{$ctx:objectLockLegalHoldStatus}</objectLockLegalHoldStatus>
    </amazons3.createMultipartUpload>
    ```

    **Sample request**

    ```xml
    <createMultipartUpload>
        <bucketName>signv4test</bucketName>
        <objectKey>upload.png</objectKey>
        <metadata>Content-Language:enus</metadata>
        <serverSideEncryption>AES256</serverSideEncryption>
        <storageClass>STANDARD</storageClass>
    </createMultipartUpload>
    ```

??? note "multipartUpload"
    The multipartUpload operation initializes and completes a multipart upload by uploading parts to that specific multipart upload.

    Following is the proxy configuration for init and multipartUpload. The init section has connection parameters.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>partDetails</td>
            <td>This contains all the parts with the part numbers.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>filePath</td>
            <td>Path of the file to be uploaded.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.init>
        <awsAccessKeyId>{$ctx:awsAccessKeyId}</awsAccessKeyId>
        <awsSecretAccessKey>{$ctx:awsSecretAccessKey}</awsSecretAccessKey>
        <name>{$ctx:connectionName}</name>
        <region>{$ctx:region}</region>
    </amazons3.init>

    <amazons3.multipartUpload>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <partDetails>{$ctx:partDetails}</partDetails>
        <filePath>{$ctx:filePath}</filePath>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.multipartUpload>
    ```

    **Sample request**

    ```xml
    <multipartUpload>
        <bucketName>signv4test</bucketName>
        <objectKey>myimage.png</objectKey>
        <filePath>/Users/mine/Desktop/10MB.mp4</filePath>
        <PartDetails>
            <Part>
                <PartNumber>1</PartNumber>
            </Part>
            <Part>
                <PartNumber>2</PartNumber>
            </Part>
        </PartDetails>
    </multipartUpload>
    ```

??? note "getObjectACL"
    The getObjectACL operation uses the ACL subresource to return the access control list (ACL) of an object. To use this operation, you must have READ_ACP access to the object.

    Following is the proxy configuration for getObjectACL.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetObjectAclRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>VersionId used to reference a specific version of the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObjectACL>
        <objectKey>{$ctx:objectKey}</objectKey>
        <bucketName>{$ctx:bucketName}</bucketName>
        <versionId>{$ctx:versionId}</versionId>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.getObjectACL>
    ```

    **Sample request**

    ```xml
    <getObjectACL>
        <bucketName>signv4test</bucketName>
        <objectKey>testFile.txt</objectKey>
    </getObjectACL>
    ```

??? note "getObjectTagging"
    The getObjectTagging operation returns the tag-set of an object. You send the request against the tagging subresource associated with the object.

    By default, this operation returns information about current version of an object. To retrieve tags of any other version, use the versionId parameter.

    To use this operation, you must have permission to perform the s3:GetObjectTagging action. To retrieve tags of a version, you need permission for the s3:GetObjectVersionTagging action.

    Following is the proxy configuration for getObjectTagging.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetObjectTaggingRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>The version id of the object to retrieve tags of it.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObjectTagging>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <versionId>{$ctx:versionId}</versionId>
    </amazons3.getObjectTagging>
    ```

    **Sample request**

    ```xml
    <getObjectTagging>
        <bucketName>signv4test</bucketName>
        <objectKey>testFile.txt</objectKey>
    </getObjectTagging>
    ```

??? note "getObjectTorrent"
    The getObjectTorrent operation uses the torrent subresource to return torrent files from a bucket. BitTorrent can save you bandwidth when you're distributing large files.

    You can get torrent only for objects that are less than 5 GB in size and that are not encrypted using server-side encryption with customer-provided encryption key.

    To use this operation, you must have READ access to the object.

    Following is the proxy configuration for getObjectTorrent.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/GetObjectTorrentRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>torrentFilePath</td>
            <td>The path of the torrent file to be created.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.getObjectTorrent>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <torrentFilePath>{$ctx:torrentFilePath}</torrentFilePath>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.getObjectTorrent>
    ```

    **Sample request**

    ```xml
    <getObjectTorrent>
        <bucketName>signv4test</bucketName>
        <objectKey>testFile.txt</objectKey>
        <torrentFilePath>/Users/mine/Desktop/testFile.torrent</torrentFilePath>
    </getObjectTorrent>
    ```

??? note "restoreObject"
    The restoreObject operation restores a temporary copy of an archived object. You can optionally provide version ID to restore specific object version. If version ID is not provided, it will restore the current version. The number of days that you want the restored copy will be determined by numberOfDays. After the specified period, Amazon S3 deletes the temporary copy. Note that the object remains archived; Amazon S3 deletes only the restored copy.

    An object in the Glacier storage class is an archived object. To access the object, you must first initiate a restore request, which restores a copy of the archived object. Restore jobs typically complete in three to five hours.

    Following is the proxy configuration for restoreObject.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/RestoreObjectRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name of the object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>versionId</td>
            <td>Version Id of an object to restore a specific object version.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>restoreRequest</td>
            <td>Container for the RestoreRequest parameters (Days, Description, GlacierJobParameters, OutputLocation, SelectParameters, Tier and Type).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.restoreObject>
        <objectKey>{$ctx:objectKey}</objectKey>
        <bucketName>{$ctx:bucketName}</bucketName>
        <versionId>{$ctx:versionId}</versionId>
        <restoreRequest>{$ctx:restoreRequest}</restoreRequest>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.restoreObject>
    ```

    **Sample request**

    ```xml
    <restoreObject>
        <bucketName>signv4test</bucketName>
        <objectKey>testFile.txt</objectKey>
        <RestoreRequest>
            <Days>2</Days>
            <GlacierJobParameters>
                <Tier>Expedited</Tier>
            </GlacierJobParameters>
        </RestoreRequest>
    </restoreObject>
    ```

??? note "uploadPartCopy"
    The uploadPartCopy operation uploads a part by copying data from an existing object as data source. You specify the data source by adding the copySource in your request and a byte range by adding the copySourceRange in your request. The minimum allowable part size for a multipart upload is 5 MB.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/UploadPartCopyRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
            <td>The name to give the newly created object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uploadId</td>
            <td>This specify the ID of the initiated multipart upload.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>partNumber</td>
            <td>This specify the number or the index of the uploaded part.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>copySource</td>
            <td>The name of the source bucket and key name of the source object, separated by a slash (/).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>copySourceRange</td>
            <td>Copy the specified range bytes of an object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifModifiedSince</td>
            <td>Return the object only if it has been modified.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifUnmodifiedSince</td>
            <td>Return the object only if it has not been modified.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifMatch</td>
            <td>Return the object only if its ETag is the same.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>ifNoneMatch</td>
            <td>Returns the object only if its ETag is not the same as the one specified.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceSSECustomerAlgorithm</td>
            <td>Specifies the algorithm to use when decrypting the source object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceSSECustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>copySourceSSECustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerAlgorithm</td>
            <td>Specifies the algorithm to use to when encrypting the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.uploadPartCopy>
        <objectKey>{$ctx:objectKey}</objectKey>
        <bucketName>{$ctx:bucketName}</bucketName>
        <uploadId>{$ctx:uploadId}</uploadId>
        <partNumber>{$ctx:partNumber}</partNumber>
        <copySource>/imagesBucket5/testObject37</copySource>
        <copySourceRange>{$ctx:copySourceRange}</copySourceRange>
        <ifModifiedSince>{$ctx:ifModifiedSince}</ifModifiedSince>
        <ifUnmodifiedSince>{$ctx:ifUnmodifiedSince}</ifUnmodifiedSince>
        <ifMatch>{$ctx:ifMatch}</ifMatch>
        <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
        <copySourceSSECustomerAlgorithm>{$ctx:copySourceSSECustomerAlgorithm}</copySourceSSECustomerAlgorithm>
        <copySourceSSECustomerKey>{$ctx:copySourceSSECustomerKey}</copySourceSSECustomerKey>
        <copySourceSSECustomerKeyMD5>{$ctx:copySourceSSECustomerKeyMD5}</copySourceSSECustomerKeyMD5>
        <sseCustomerAlgorithm>{$ctx:sseCustomerAlgorithm}</sseCustomerAlgorithm>
        <sseCustomerKey>{$ctx:sseCustomerKey}</sseCustomerKey>
        <sseCustomerKeyMD5>{$ctx:sseCustomerKeyMD5}</sseCustomerKeyMD5>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.uploadPartCopy>
    ```

    **Sample request**

    ```xml
    <uploadPartCopy>
        <bucketName>signv4test</bucketName>
        <objectKey>testFile1.txt</objectKey>
        <uploadId>SsNUDqUklMaoV_IfePCpGAZHjaxJx.cGXEcX6TVW4I6WzOQFnAKomYevz5qi5LtkfTvlpwjY9M6QDGsIIvdGEQzBURo3MMU2Yh.ZEQDsk_lsnx3Z8m9jsglW6FIfKGQ_</uploadId>
        <partNumber>2</partNumber>
        <copySource>/testBucket1/testFile.jpg</copySource>
        <range>bytes=0-9</range>
    </uploadPartCopy>
    ```

??? note "headObject"
    The headObject operation retrieves metadata from an object without returning the object itself. This operation is useful if you are interested only in an object's metadata. To use this operation, you must have READ access to that object. A HEAD request has the same options as a GET operation on an object. The response is identical to the GET response except that there is no response body.

    See the [related API documentation](https://sdk.amazonaws.com/java/api/latest/software/amazon/awssdk/services/s3/model/HeadObjectRequest.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>bucketName</td>
            <td>The name of the bucket.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectKey</td>
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
        <tr>
            <td>versionId</td>
            <td>VersionId used to reference a specific version of the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerAlgorithm</td>
            <td>Specifies the algorithm to use to when encrypting the object.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKey</td>
            <td>Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>sseCustomerKeyMD5</td>
            <td>Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>partNumber</td>
            <td>Part number of the object being read.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>requestPayer</td>
            <td>Confirms that the requester knows that they will be charged for the request.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazons3.headObject>
        <bucketName>{$ctx:bucketName}</bucketName>
        <objectKey>{$ctx:objectKey}</objectKey>
        <range>{$ctx:range}</range>
        <ifModifiedSince>{$ctx:ifModifiedSince}</ifModifiedSince>
        <ifUnmodifiedSince>{$ctx:ifUnmodifiedSince}</ifUnmodifiedSince>
        <ifMatch>{$ctx:ifMatch}</ifMatch>
        <ifNoneMatch>{$ctx:ifNoneMatch}</ifNoneMatch>
        <versionId>{$ctx:versionId}</versionId>
        <sseCustomerAlgorithm>{$ctx:sseCustomerAlgorithm}</sseCustomerAlgorithm>
        <sseCustomerKey>{$ctx:sseCustomerKey}</sseCustomerKey>
        <sseCustomerKeyMD5>{$ctx:sseCustomerKeyMD5}</sseCustomerKeyMD5>
        <partNumber>{$ctx:partNumber}</partNumber>
        <requestPayer>{$ctx:requestPayer}</requestPayer>
    </amazons3.headObject>
    ```

    **Sample request**

    ```xml
    <headObject>
      <bucketName>signv4test</bucketName>
      <objectKey>testObject2</objectKey>
    </headObject>
    ``` 
    
