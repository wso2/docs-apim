# Amazon DynamoDB Connector Reference

The following operations allow you to work with the Amazon DynamoDB Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Amazon DynamoDB connector, add the <amazondynamodb.init> element in your configuration before carrying out any other operations. To authenticate, it uses the Signature Version 4 signing specification, which describes how to construct signed requests to AWS. Whenever you send a request to AWS, you must include authorization information with your request so that AWS can verify the authenticity of the request. AWS uses the authorization information from your request to recreate your signature and then compares that signature with the one that you sent. These two signatures must match for you to successfully access AWS. Click here for further reference on the signing process.

??? note "init"
    The init operation is used to initialize the connection to Amazon S3.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>region</td>
            <td>The region of the application access.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>The secret access key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>The accessKeyId of the user account to generate the signature.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>blocking</td>
            <td>Boolean type, this property helps the connector perform blocking invocations to Amazon DynamoDB.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.init>
        <region>{$ctx:region}</region>
        <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <blocking>{$ctx:blocking}</blocking>
    </amazondynamodb.init>
    ```

    Ensure that the following Axis2 configurations are added and enabled in the `<EI_HOME>\conf\axis2\axis2.xml` file.

    ```xml
    <messageFormatter contentType="application/x-amz-json-1.0" class="org.apache.synapse.commons.json.JsonStreamFormatter"/>
    ...
    <messageBuilder contentType="application/x-amz-json-1.0" class="org.apache.synapse.commons.json.JsonStreamBuilder"/>
    ```

    > **Note**: If you want to perform blocking invocations, ensure that the above builder and formatter are added and enabled in the `<EI_HOME>\conf\axis2\axis2_blocking_client.xml` file.
    
---

### Items

??? note "batchGetItem"
    The batchGetItem operation returns the attributes of one or more items from one or more tables. The requested items are identified by the primary key. A single operation can retrieve up to 16 MB of data, which can contain as many as 100 items.

    The batchGetItem operation returns a partial result if the response size limit is exceeded, the table's provisioned throughput is exceeded, or an internal processing failure occurs. If a partial result is returned, the operation returns a value for UnprocessedKeys. You can use this value to retry the operation starting with the next item to get. For example, if you ask to retrieve 100 items, but each individual item is 300 KB in size, the system returns 52 items (so that the16 MB limit is not exceeded) and an appropriate UnprocessedKeys value, so that you can get the next page of results. If required, your application can include its own logic to assemble the pages of results into one dataset.

    If none of the items can be processed due to insufficient provisioned throughput on all of the tables in the request, batchGetItem will throw an exception. If at least one of the items is successfully processed, batchGetItem completes successfully while returning the keys of the unread items in UnprocessedKeys. By default, batchGetItem performs eventually consistent reads on every table in the request. If you want strongly consistent reads instead, you can set ConsistentRead to true for any or all tables. To minimize response latency, batchGetItem retrieves items in parallel. See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_BatchGetItem.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>requestItems</td>
            <td>requestItems: A map of one or more table names and, for each table, the corresponding primary keys for the items to retrieve. Each table name can be invoked only once. Each element in the map consists of the following:
                <ul>
                    <li>Keys - Required - An array of primary key attribute values that define specific items in the table. For each primary key, you must provide all of the key attributes. For example, with a hash type primary key, you only need to specify the hash attribute. For a hash-and-range type primary key, you must specify both the hash attribute and the range attribute.</li>
                    <li>AttributesToGet - Optional - One or more attributes to be retrieved from the table. By default, all attributes are returned. If a specified attribute is not found, it does not appear in the result. Note that AttributesToGet has no effect on provisioned throughput consumption. DynamoDB determines capacity units consumed based on the item size, not on the amount of data that is returned to an application.</li>
                    <li>ConsistentRead - Optional - If true, a strongly consistent read is used; if false (the default), an eventually consistent read is used.</li>
                    <li>ExpressionAttributeNames - Optional - One or more substitution tokens for attribute names in the ProjectionExpression property.</li>
                    <li>ProjectionExpression - Optional - A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas. If attribute names are not specified, then all attributes are returned. If any of the specified attributes are not found, they do not appear in the result.</li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response. If set to TOTAL, the response includes the consumed capacity for tables and indexes. If set to INDEXES, the response includes the consumed capacity for indexes. If set to NONE (the default), the consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.batchGetItem>
        <requestItems>{$ctx:requestItems}</requestItems>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity>
    </amazondynamodb.batchGetItem>
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "requestItems": {
            "Thread": {
                "Keys": [
                    {
                        "ForumName": {
                            "S": "Amazon Dynamo"
                        },
                        "Subject": {
                            "S": "How do I update multiple items?"
                        }
                    }
                ],
                "AttributesToGet": [
                    "Tags",
                    "Message"
                ]
            }
        },
    "returnConsumedCapacity":"TOTAL"
    }
    ```

    **Sample response**

    ```json
    {
        "Responses":{
            "Test4782":[
                {
                    "Message":{
                        "S":"I want to update multiple items in a single call. What's the best way to do that?"
                    },
                    "Tags":{
                        "SS":[
                            "HelpMe",
                            "Multiple Items",
                            "Update"
                        ]
                    }
                }
            ]
        },
        "UnprocessedKeys":{
        }

    }
    ```

??? note "batchWriteItem"
    The batchWriteItem operation puts or deletes multiple items in one or more tables. A single call to batchWriteItem can write up to 16 MB of data, which can comprise as many as 25 put or delete requests. Individual items to be written can be as large as 400 KB. This operation cannot update items.

    The individual PutRequest and DeleteRequest operations specified in batchWriteItem are atomic, but batchWriteItem as a whole is not. If any requested operations fail because the table's provisioned throughput is exceeded or an internal processing failure occurs, the failed operations are returned in the UnprocessedItems response property. You can investigate and optionally resend the requests. Typically, you would call batchWriteItem in a loop. Each iteration would check for unprocessed items and submit a new batchWriteItem request with those unprocessed items until all items have been processed.

    Note that if none of the items can be processed due to insufficient provisioned throughput on all of the tables in the request, batchWriteItem will throw an exception. With batchWriteItem, you can efficiently write or delete large amounts of data, such as from Amazon Elastic MapReduce (EMR), or copy data from another database into DynamoDB. To improve performance with these large-scale operations, batchWriteItem does not behave in the same way as individual PutRequest and DeleteRequest calls would. For example, you cannot specify conditions on individual put and delete requests, and batchWriteItem does not return deleted items in the response.

    If one or more of the following is true, DynamoDB rejects the entire batch write operation:

    * One or more tables specified in the batchWriteItem request does not exist.
    * Primary key attributes specified on an item in the request do not match those in the corresponding table's primary key schema.
    * You try to perform multiple operations on the same item in the same batchWriteItem request. For example, you cannot put and delete the same item in the same batchWriteItem request.
    * There are more than 25 requests in the batch.
    * The total request size exceeds 16 MB.
    * Any individual item in a batch exceeds 400 KB. 
    
    See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_BatchGetItem.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>requestItems</td>
            <td>A map of one or more table names and, for each table, the corresponding primary keys for the items to retrieve. Each table name can be invoked only once. Each element in the map consists of the following:
                <ul>
                    <li>Keys - Required - An array of primary key attribute values that define specific items in the table. For each primary key, you must provide all of the key attributes. For example, with a hash type primary key, you only need to specify the hash attribute. For a hash-and-range type primary key, you must specify both the hash attribute and the range attribute.</li>
                    <li>AttributesToGet - Optional - One or more attributes to be retrieved from the table. By default, all attributes are returned. If a specified attribute is not found, it does not appear in the result. Note that AttributesToGet has no effect on provisioned throughput consumption. DynamoDB determines capacity units consumed based on the item size, not on the amount of data that is returned to an application.</li>
                    <li>ConsistentRead - Optional - If true, a strongly consistent read is used; if false (the default), an eventually consistent read is used.</li>
                    <li>ExpressionAttributeNames - Optional - One or more substitution tokens for attribute names in the ProjectionExpression property.</li>
                    <li>ProjectionExpression - Optional - A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas. If attribute names are not specified, then all attributes are returned. If any of the specified attributes are not found, they do not appear in the result.</li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response. If set to TOTAL, the response includes the consumed capacity for tables and indexes. If set to INDEXES, the response includes the consumed capacity for indexes. If set to NONE (the default), the consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.batchGetItem>
        <requestItems>{$ctx:requestItems}</requestItems>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity>
    </amazondynamodb.batchGetItem>
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "requestItems": {
            "Thread": {
                "Keys": [
                    {
                        "ForumName": {
                            "S": "Amazon Dynamo"
                        },
                        "Subject": {
                            "S": "How do I update multiple items?"
                        }
                    }
                ],
                "AttributesToGet": [
                    "Tags",
                    "Message"
                ]
            }
        },
    "returnConsumedCapacity":"TOTAL"
    }
    ```

    **Sample response**

    ```json
    {
        "Responses":{
            "Test4782":[
                {
                    "Message":{
                        "S":"I want to update multiple items in a single call. What's the best way to do that?"
                    },
                    "Tags":{
                        "SS":[
                            "HelpMe",
                            "Multiple Items",
                            "Update"
                        ]
                    }
                }
            ]
        },
        "UnprocessedKeys":{
        }

    }
    ```

??? note "deleteItem"
    The deleteItem operation deletes a single item in a table by primary key. You can perform a conditional delete operation that deletes the item if it exists, or if it has an expected attribute value. In addition to deleting an item, you can also return the item's attribute values in the same operation, using the returnValues property. Unless you specify conditions, deleteItem is an idempotent operation, and running it multiple times on the same item or attribute does not result in an error response. Conditional deletes are useful for only deleting items if specific conditions are met. If those conditions are met, DynamoDB performs the delete operation. Otherwise, the item is not deleted. 
    
    See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_DeleteItem.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>expected</td>
            <td>A map of attribute/condition pairs. This is the conditional block for the deleteItem operation. Each element of this property consists of an attribute name, a comparison operator, and one or more values. DynamoDB uses the comparison operator to compare the attribute with the value(s) you supply. For each element of this property, the result of the evaluation is either true or false. (For example, {"ForumName":{"ComparisonOperator": "EQ", "AttributeValueList": [ {"S":"Amazon DynamoDB" }]}})</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table from which to delete the item. (Minimum length of 3. Maximum length of 255).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>returnValues</td>
            <td>Use returnValues if you want to get the item attributes as they appeared before they were deleted. For deleteItem, the valid values are:
                <ul>
                    <li>NONE - If returnValues is not specified or if its value is NONE (the default), nothing is returned.</li>
                    <li>ALL_OLD - The content of the old item is returned. Valid Values: NONE | ALL_OLD | UPDATED_OLD | ALL_NEW | UPDATED_NEW.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnItemCollectionMetrics</td>
            <td>Determines whether item collection metrics are returned: If set to SIZE, statistics about item collection, if any, that were modified during the operation are returned in the response. If set to NONE (the default), no statistics are returned.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>conditionalOperator</td>
            <td>A logical operator to apply to the conditions in the expected map:
                <ul>
                    <li>AND - If all of the conditions evaluate to true, the entire map evaluates to true (default).</li>
                    <li>OR - If at least one of the conditions evaluate to true, the entire map evaluates to true. The operation will succeed only if the entire map evaluates to true.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>conditionExpression</td>
            <td>A condition that must be satisfied in order for a conditional deleteItem operation to succeed. An expression can contain any of the following:
                <ul>
                    <li>Functions: attribute_exists | attribute_not_exists | attribute_type | contains | begins_with | size These function names are case-sensitive.</li>
                    <li>Comparison operators: = | <> | < | > | <= | >= | BETWEEN | IN</li>
                    <li>Logical operators: AND | OR | NOT</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeNames</td>
            <td>One or more substitution tokens for attribute names in an expression. (For example, {"#LP":"LastPostDateTime"}).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeValues</td>
            <td>One or more values that can be substituted in an expression. (For example, { ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} })</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response: If set to TOTAL, the response includes the consumed capacity for tables and indexes. If set to INDEXES, the response includes consumed capacity for indexes. If set to NONE (the default), consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>key</td>
            <td>A map of attribute names to AttributeValue objects, representing the primary key of the item to delete. For the primary key, you must provide all of the attributes. For example, with a hash type primary key, you only need to specify the hash attribute. For a hash-and-range type primary key, you must specify both the hash attribute and the range attribute.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.deleteItem>
        <expected>{$ctx:expected}</expected>
        <tableName>{$ctx:tableName}</tableName>
        <returnValues>{$ctx:returnValues}</returnValues>
        <returnItemCollectionMetrics>{$ctx:returnItemCollectionMetrics}</returnItemCollectionMetrics>
        <conditionalOperator>{$ctx:conditionalOperator}</conditionalOperator>
        <conditionExpression>{$ctx:conditionExpression}</conditionExpression>
        <expressionAttributeNames>{$ctx:expressionAttributeNames}</expressionAttributeNames>
        <expressionAttributeValues>{$ctx:expressionAttributeValues}</expressionAttributeValues>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity>
        <key>{$ctx:key}</key>
    </amazondynamodb.deleteItem>
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIxxxxxxxxxx",
        "secretAccessKey":"id4xxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "Thread",
        "key": {
            "ForumName": {
                "S": "Amazon DynamoDB"
            },
            "Subject": {
                "S": "How do I update multiple items?"
            }
        },
        "conditionExpression":"attribute_not_exists",
        "returnValues": "ALL_OLD",
        "returnConsumedCapacity":"TOTAL"
    }
    ```

    **Sample response**

    ```json
    {
        "Attributes":{
        "LastPostedBy":{
            "S":"fred@example.com"
        },
        "ForumName":{
            "S":"Amazon DynamoDB"
        },
        "LastPostDateTime":{
            "S":"201303201023"
        },
        "Tags":{
            "SS":[
                "Update",
                "Multiple Items",
                "HelpMe"
            ]
        },
        "Subject":{
            "S":"How do I update multiple items?"
        },
        "Message":{
            "S":"I want to update multiple items in a single call. What's the best way to do that?"
        }
   }

    }
    ```

??? note "getItem"
    The getItem operation returns a set of attributes for the item with the given primary key. If there is no matching item, getItem does not return any data. This operation provides an eventually consistent read by default. If your application requires a strongly consistent read, set consistentRead to true. Although a strongly consistent read might take more time than an eventually consistent read, it always returns the last updated value.
    
    See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_GetItem.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>attributesToGet</td>
            <td>The names of one or more attributes to retrieve. If no attribute names are specified, all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result. Note that attributesToGet has no effect on provisioned throughput consumption. DynamoDB determines capacity units consumed based on item size, not on the amount of data that is returned to an application. (For example, ["ForumName", "Subject"]).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table containing the requested item. (Minimum length of 3. Maximum length of 255).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>consistentRead</td>
            <td>Determines the read consistency model. If set to true, the operation uses strongly consistent reads. Otherwise, the operation uses eventually consistent reads.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>key</td>
            <td>A map of attribute names to AttributeValue objects, representing the primary key of the item to retrieve. For the primary key, you must provide all of the attributes. For example, with a hash type primary key, you only need to specify the hash attribute. For a hash-and-range type primary key, you must specify both the hash attribute and the range attribute.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expressionAttributeNames</td>
            <td>One or more substitution tokens for attribute names in an expression. (For example, {"#LP":"LastPostDateTime"})</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>projectionExpression</td>
            <td>A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas. If attribute names are not specified, then all attributes are returned. If any of the specified attributes are not found, they do not appear in the result.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response: If set to TOTAL, the response includes the consumed capacity data for tables and indexes. If set to INDEXES, the response includes consumed capacity for indexes. If set to NONE (the default), consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.getItem>
        <attributesToGet>{$ctx:attributesToGet}</attributesToGet>
        <tableName>{$ctx:tableName}</tableName>
        <consistentRead>{$ctx:consistentRead}</consistentRead>
        <key>{$ctx:key}</key>
        <expressionAttributeNames>{$ctx:expressionAttributeNames}</expressionAttributeNames>
        <projectionExpression>{$ctx:projectionExpression}</projectionExpression>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity> 
    </amazondynamodb.getItem> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIxxxxxxxxxx",
        "secretAccessKey":"id4xxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "Thread",
        "key": {
            "ForumName": {
                "S": "Amazon DynamoDB"
            },
            "Subject": {
                "S": "How do I update multiple items?"
            }
        },
        "projectionExpression":"#LP, Message, Tags",
        "consistentRead": true,
        "returnConsumedCapacity": "TOTAL",
        "expressionAttributeNames":{"#LP":"LastPostDateTime"}
    }
    ```

    **Sample response**

    ```json
    {
        "ConsumedCapacity":{
            "CapacityUnits":1,
            "TableName":"Thread"
        },
        "Item":{
            "Tags":{
                "SS":[
                    "Update",
                    "Multiple Items",
                    "HelpMe"
                ]
            },
            "LastPostDateTime":{
                "S":"201303190436"
            },
            "Message":{
                "S":"I want to update multiple items in a single call. What's the best way to do that?"
            }
        }
    }
    ```

??? note "putItem"
    The putItem operation creates a new item, or replaces an old item with a new item. If an item already exists in the specified table with the same primary key, the new item completely replaces the existing item. You can perform a conditional put (insert a new item if one with the specified primary key does not exist), or replace an existing item if it has certain attribute values.

    In addition to creating an item, you can also return the attribute values of the item in the same operation using the returnValues property. When you add an item, the primary key attribute(s) are the only required attributes. Attribute values cannot be null. String and binary type attributes must have a length greater than zero. Set type attributes cannot be empty. Requests with empty values will be rejected with a validation exception. You can request that the putItem operation should return either a copy of the old item (before the update) or a copy of the new item (after the update).

    To prevent a new item from replacing an existing item, use a conditional expression with the putItem operation. The conditional expression should contain the attribute_not_exists function with the name of the attribute being used as the partition key for the table. Since every record must contain that attribute, the attribute_not_exists function will only succeed if no matching item exists. For more information about using this API, see Working with Items.
    
    See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_PutItem.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>expected</td>
            <td>A map of attribute/condition pairs. This is the conditional block for the deleteItem operation. Each element of this property consists of an attribute name, a comparison operator, and one or more values. DynamoDB uses the comparison operator to compare the attribute with the value(s) you supply. For each element of this property, the result of the evaluation is either true or false. (For example, {"ForumName":{"ComparisonOperator": "EQ", "AttributeValueList": [ {"S":"Amazon DynamoDB" }]}})</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table from which to delete the item. (Minimum length of 3. Maximum length of 255).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>item</td>
            <td>A map of attribute name/value pairs, one for each attribute. Only the primary key attributes are required, but you can optionally provide other attribute name-value pairs for the item. You must provide all of the attributes for the primary key. For example, with a hash type primary key, you only need to specify the hash attribute. For a hash-and-range type primary key, you must specify both the hash attribute and the range attribute. If you specify any attributes that are part of an index key, the data types for those attributes must match those of the schema in the table's attribute definition. Each element in the item map is an AttributeValue object.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>returnValues</td>
            <td>Use returnValues if you want to get the item attributes as they appeared before they were updated with the putItem request. The possible values are:
                <ul>
                    <li>NONE - If returnValues is not specified or if its value is NONE (the default), nothing is returned.</li>
                    <li>ALL_OLD - The content of the old item is returned. Valid Values: NONE | ALL_OLD | UPDATED_OLD | ALL_NEW | UPDATED_NEW.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnItemCollectionMetrics</td>
            <td>Determines whether item collection metrics are returned: If set to SIZE, statistics about item collection, if any, that were modified during the operation are returned in the response. If set to NONE (the default), no statistics are returned.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>conditionalOperator</td>
            <td>A logical operator to apply to the conditions in the expected map:
                <ul>
                    <li>AND - If all of the conditions evaluate to true, the entire map evaluates to true (default).</li>
                    <li>OR - If at least one of the conditions evaluate to true, the entire map evaluates to true. The operation will succeed only if the entire map evaluates to true.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>key</td>
            <td>A map of attribute names to AttributeValue objects, representing the primary key of the item to delete. For the primary key, you must provide all of the attributes. For example, with a hash type primary key, you only need to specify the hash attribute. For a hash-and-range type primary key, you must specify both the hash attribute and the range attribute.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>conditionExpression</td>
            <td>A condition that must be satisfied in order for a conditional deleteItem operation to succeed. An expression can contain any of the following:
                <ul>
                    <li>Functions: attribute_exists | attribute_not_exists | attribute_type | contains | begins_with | size These function names are case-sensitive.</li>
                    <li>Comparison operators: = | <> | < | > | <= | >= | BETWEEN | IN</li>
                    <li>Logical operators: AND | OR | NOT</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeNames</td>
            <td>One or more substitution tokens for attribute names in an expression. (For example, {"#LP":"LastPostDateTime"}).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeValues</td>
            <td>One or more values that can be substituted in an expression. (For example, { ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} })</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response: If set to TOTAL, the response includes the consumed capacity for tables and indexes. If set to INDEXES, the response includes consumed capacity for indexes. If set to NONE (the default), consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.putItem>
        <expected>{$ctx:expected}</expected>
        <tableName>{$ctx:tableName}</tableName>
        <item>{$ctx:item}</item>
        <returnValues>{$ctx:returnValues}</returnValues>
        <returnItemCollectionMetrics>{$ctx:returnItemCollectionMetrics}</returnItemCollectionMetrics>
        <conditionalOperator>{$ctx:conditionalOperator}</conditionalOperator>
        <conditionExpression>{$ctx:conditionExpression}</conditionExpression>
        <expressionAttributeNames>{$ctx:expressionAttributeNames}</expressionAttributeNames>
        <expressionAttributeValues>{$ctx:expressionAttributeValues}</expressionAttributeValues>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity>
    </amazondynamodb.putItem> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIxxxxxxxxxx",
        "secretAccessKey":"id4xxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "Thread",
        "item": {
            "LastPostDateTime": {
                "S": "201303190422"
            },
            "Tags": {
                "SS": ["Update","Multiple Items","HelpMe"]
            },
            "ForumName": {
                "S": "Amazon Dynamo"
            },
            "Message": {
                "S": "I want to update multiple items in a single call. What's the best way to do that?"
            },
            "Subject": {
                "S": "How do I update multiple items?"
            },
            "LastPostedBy": {
                "S": "fred@example.com"
            }
        },
        "returnValues":"ALL_OLD",
        "returnConsumedCapacity":"TOTAL",
        "returnItemCollectionMetrics":"SIZE",
        "expected":{
            "Message":{
                "ComparisonOperator": "EQ",
                "AttributeValueList": [ {"S":"I want to update multiple item." }]
            }
         
        }
    }
    ```

    **Sample response**

    ```json
    {
        
    }
    ```

??? note "query"
    The query operation uses the primary key of a table or a secondary index, to directly access items from that table or index. You can use the KeyConditionExpression property to provide a specific value for the partition key, and the query operation returns all of the items from the table or index with that partition key value. Optionally, you can narrow the scope of the query operation by specifying a sort key value and a comparison operator in KeyConditionExpression. You can use the ScanIndexForward property to get results in forward or reverse order, by sort key.

    Queries that do not return results consume the minimum read capacity units according to the type of read. If the total number of items meeting the query criteria exceeds the result set size limit of 1 MB, the query stops and results are returned to the user with a LastEvaluatedKey to continue the query in a subsequent operation. Unlike a scan operation, a query operation never returns an empty result set and a LastEvaluatedKey . The LastEvaluatedKey is only provided if the results exceed 1 MB, or if you have used limit.

    You can query a table, a local secondary index, or a global secondary index. For a query on a table or on a local secondary index, you can set consistentRead to true and obtain a strongly consistent result. Global secondary indexes support eventually consistent reads only, so do not specify consistentRead when querying a global secondary index.
    
    See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Query.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>limit</td>
            <td>The maximum number of items to evaluate (not necessarily the number of matching items). If DynamoDB processes the number of items up to the limit while processing the results, it stops the operation and returns the matching values up to that point, and a LastEvaluatedKey to apply in a subsequent operation, so that you can pick up from where you left off. Also, if the processed data set size exceeds 1 MB before DynamoDB reaches this limit, it stops the operation and returns the matching values up to the limit, and a LastEvaluatedKey to apply in a subsequent operation to continue the operation. For more information, see <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html">Query and Scan in the Amazon DynamoDB Developer Guide</a>.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>exclusiveStartKey</td>
            <td>The primary key of the first item that this operation will evaluate. Use the value that was returned for LastEvaluatedKey in the previous operation. The data type for exclusiveStartKey must be String, Number or Binary. No set data types are allowed. See <a href="https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html">exclusiveStartKey in Amazon DynamoDB API documentation</a> for more information.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>keyConditions</td>
            <td>The selection criteria for the query. (For example, "SongTitle": {ComparisonOperator: "BETWEEN", AttributeValueList: ["A", "M"]}). See <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.KeyConditions.html">keyConditions in Amazon DynamoDB Developer Guide</a> for more information.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>attributesToGet</td>
            <td>The names of one or more attributes to retrieve. If no attribute names are specified, all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result. Note that attributesToGet has no effect on provisioned throughput consumption. DynamoDB determines capacity units consumed based on item size, not on the amount of data that is returned to an application. (For example, ["ForumName", "Subject"]) You cannot use both attributesToGet and select (see below) together in a query request, unless the value for select is SPECIFIC_ATTRIBUTES. (This usage is equivalent to specifying attributesToGet without any value for select.) If you are querying a local secondary index and request only attributes that are projected into that index, the operation will read only the index and not the table. If any of the requested attributes are not projected into the local secondary index, DynamoDB fetches each of these attributes from the parent table. If you are querying a global secondary index, you can only request attributes that are projected into the index. Global secondary index queries cannot fetch attributes from the parent table. (Minimum of 1 item in the list.) See <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html">attributesToGet in Amazon DynamoDB Developer Guide</a></td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table containing the requested items. (Minimum length of 3. Maximum length of 255.)</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>select</td>
            <td>The attributes to be returned in the result. You can retrieve all item attributes, specific item attributes, the count of matching items, or in the case of an index, some or all of the attributes projected into the index. Set to SPECIFIC_ATTRIBUTES if you are also using attributesToGet (see above). Possible values: ALL_ATTRIBUTES | ALL_PROJECTED_ATTRIBUTES | SPECIFIC_ATTRIBUTES | COUNT</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>scanIndexForward</td>
            <td>Specifies ascending (true) or descending (false) traversal of the index. DynamoDB returns results reflecting the requested order determined by the range key. If the data type is Number, the results are returned in numeric order. For String, the results are returned in the order of ASCII character code values. For Binary, DynamoDB treats each byte of the binary data as unsigned when it compares binary values. Defaults to the ascending order.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queryFilter</td>
            <td>Evaluates the query results and returns only the desired values. If you specify more than one condition in the queryFilter map, by default all of the conditions must evaluate to true. (You can use the conditionalOperator property described below to OR the conditions instead. If you do this, at least one of the conditions must evaluate to true, rather than all of them). Each queryFilter element consists of an attribute name to compare, along with the following:
                <ul>
                    <li>AttributeValueList - One or more values to evaluate against the supplied attribute. The number of values in the list depend on the ComparisonOperator that is used. For the type Number, value comparisons are numeric. String value comparisons for greater than, equals, or less than are based on ASCII character code values. For example, a is greater than A, and aa is greater than B. For Binary, DynamoDB treats each byte of the binary data as unsigned when it compares binary values, for example when evaluating query expressions.</li>
                    <li>ComparisonOperator - A comparator for evaluating attributes. For example: equals, greater than, less than, etc. The following comparison operators are available: EQ | NE | LE | LT | GE | GT | NOT_NULL | NULL | CONTAINS | NOT_CONTAINS | BEGINS_WITH | IN | BETWEEN. For complete descriptions of all comparison operators, see conditions. For example, "LastPostDateTime": {ComparisonOperator: "GT", AttributeValueList: [ 201303190421 ]}.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>consistentRead</td>
            <td>Determines the read consistency model. If set to true, the operation uses strongly consistent reads. Otherwise, eventually consistent reads are used. Strongly consistent reads are not supported on global secondary indexes. If you query a global secondary index with consistentRead set to true, you will receive an error message.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>indexName</td>
            <td>The name of an index to query. This can be any local secondary index or global secondary index on the table (Minimum length of 3. Maximum length of 255.)</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>conditionalOperator</td>
            <td>A logical operator to apply to the conditions in the expected map:
                <ul>
                    <li>AND - If all of the conditions evaluate to true, the entire map evaluates to true (default).</li>
                    <li>OR - If at least one of the conditions evaluate to true, the entire map evaluates to true. The operation will succeed only if the entire map evaluates to true.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeNames</td>
            <td>One or more substitution tokens for attribute names in an expression. (For example, {"#LP":"LastPostDateTime"}).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeValues</td>
            <td>One or more values that can be substituted in an expression. (For example, { ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} })</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>filterExpression</td>
            <td>A string that contains conditions that DynamoDB applies after the query operation, but before the data is returned. Items that do not satisfy the FilterExpression criteria are not returned. (For example, "LastPostDateTime > :LP") For more information, see <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html#FilteringResults">Filter Expressions in the Amazon DynamoDB Developer Guide</a>.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>keyConditionExpression</td>
            <td>The condition that specifies the key value(s) for items to be retrieved by the query operation.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>projectionExpression</td>
            <td>A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas. If attribute names are not specified, then all attributes are returned. If any of the specified attributes are not found, those attributes do not appear in the result.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response: If set to TOTAL, the response includes the consumed capacity for tables and indexes. If set to INDEXES, the response includes consumed capacity for indexes. If set to NONE (the default), consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.query>
        <limit>{$ctx:limit}</limit>
        <exclusiveStartKey>{$ctx:exclusiveStartKey}</exclusiveStartKey>
        <keyConditions>{$ctx:keyConditions}</keyConditions>
        <attributesToGet>{$ctx:attributesToGet}</attributesToGet>
        <tableName>{$ctx:tableName}</tableName>
        <select>{$ctx:select}</select>
        <scanIndexForward>{$ctx:scanIndexForward}</scanIndexForward>
        <queryFilter>{$ctx:queryFilter}</queryFilter>
        <consistentRead>{$ctx:consistentRead}</consistentRead>
        <indexName>{$ctx:indexName}</indexName>
        <conditionalOperator>{$ctx:conditionalOperator}</conditionalOperator>
        <expressionAttributeNames>{$ctx:expressionAttributeNames}</expressionAttributeNames>
        <expressionAttributeValues>{$ctx:expressionAttributeValues}</expressionAttributeValues>
        <filterExpression>{$ctx:filterExpression}</filterExpression>
        <keyConditionExpression>{$ctx:keyConditionExpression}</keyConditionExpression>
        <projectionExpression>{$ctx:projectionExpression}</projectionExpression>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity>
    </amazondynamodb.query> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIxxxxxxxxxx",
        "secretAccessKey":"id4xxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "Thread",
        "indexName": "LastPostIndex",
        "limit": 3,
        "consistentRead": true,
        "projectionExpression": "ForumName, #LP",
        "keyConditionExpression": "ForumName = :v1 AND #LP BETWEEN :v2a AND :v2b",
        "expressionAttributeNames":{"#LP":"LastPostDateTime"},
        "expressionAttributeValues": {
            ":v1": {"S": "Amazon Dynamo"},
            ":v2a": {"S": "201303190421"},
            ":v2b": {"S": "201303190425"}
        },
        "returnConsumedCapacity": "TOTAL"
    }
    ```

    **Sample response**

    ```json
    {
        "Count":2,
        "ScannedCount":2
    }
    ```

??? note "scan"
    The scan operation returns one or more items and item attributes by accessing every item in the table. To have DynamoDB return fewer items, you can provide a scanFilter.

    If the total number of scanned items exceeds the maximum data set size limit of 1 MB, the scan stops and results are returned to the user with a LastEvaluatedKey to continue the scan in a subsequent operation. The results also include the number of items exceeding the limit. A scan can result in no table data meeting the filter criteria. The result set is eventually consistent.

    By default, scan operations proceed sequentially. For faster performance on large tables, applications can request a parallel scan by specifying the segment and totalSegments properties. For more information, see [Parallel Scan](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html#QueryAndScanParallelScan).
    
    See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_Query.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>limit</td>
            <td>The maximum number of items to evaluate (not necessarily the number of matching items). If DynamoDB processes the number of items up to the limit while processing the results, it stops the operation and returns the matching values up to that point, and a LastEvaluatedKey to apply in a subsequent operation, so that you can pick up from where you left off. Also, if the processed data set size exceeds 1 MB before DynamoDB reaches this limit, it stops the operation and returns the matching values up to the limit, and a LastEvaluatedKey to apply in a subsequent operation to continue the operation. For more information, see <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html">Query and Scan in the Amazon DynamoDB Developer Guide</a>.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>totalSegments</td>
            <td>For a parallel scan request, totalSegments represents the total number of segments into which the scan operation will be divided. The value of totalSegments corresponds to the number of application workers that will perform the parallel scan. For example, if you want to scan a table using four application threads, you would specify a totalSegments value of 4. The value for totalSegments must be greater than or equal to 1, and less than or equal to 1000000. If you specify a totalSegments value of 1, the scan will be sequential rather than parallel. If you specify totalSegments, you must also specify segment.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>exclusiveStartKey</td>
            <td>The primary key of the first item that this operation will evaluate. Use the value that was returned for LastEvaluatedKey in the previous operation. The data type for exclusiveStartKey must be String, Number or Binary. No set data types are allowed. See <a href="https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html">exclusiveStartKey in Amazon DynamoDB API documentation</a> for more information.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>attributesToGet</td>
            <td>The names of one or more attributes to retrieve. If no attribute names are specified, all attributes will be returned. If any of the requested attributes are not found, they will not appear in the result. Note that attributesToGet has no effect on provisioned throughput consumption. DynamoDB determines capacity units consumed based on item size, not on the amount of data that is returned to an application. (For example, ["ForumName", "Subject"]) You cannot use both attributesToGet and select (see below) together in a query request, unless the value for select is SPECIFIC_ATTRIBUTES. (This usage is equivalent to specifying attributesToGet without any value for select.) If you are querying a local secondary index and request only attributes that are projected into that index, the operation will read only the index and not the table. If any of the requested attributes are not projected into the local secondary index, DynamoDB fetches each of these attributes from the parent table. If you are querying a global secondary index, you can only request attributes that are projected into the index. Global secondary index queries cannot fetch attributes from the parent table. (Minimum of 1 item in the list). See <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/LegacyConditionalParameters.AttributesToGet.html">attributesToGet in Amazon DynamoDB Developer Guide</a></td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>select</td>
            <td>The attributes to be returned in the result. You can retrieve all item attributes, specific item attributes, the count of matching items, or in the case of an index, some or all of the attributes projected into the index. Set to SPECIFIC_ATTRIBUTES if you are also using attributesToGet (see above). Possible values: ALL_ATTRIBUTES | ALL_PROJECTED_ATTRIBUTES | SPECIFIC_ATTRIBUTES | COUNT</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>segment</td>
            <td>The attributes to be returned in the result. You can retrieve all item attributes, specific item attributes, the count of matching items, or in the case of an index, some or all of the attributes projected into the index. Set to SPECIFIC_ATTRIBUTES if you are also using attributesToGet (see above). Possible values: ALL_ATTRIBUTES | ALL_PROJECTED_ATTRIBUTES | SPECIFIC_ATTRIBUTES | COUNT</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table containing the requested items. (Minimum length of 3. Maximum length of 255.)</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>scanFilter</td>
            <td>Evaluates the scan results and returns only the desired values. If you specify more than one condition in the scanFilter map, by default all of the conditions must evaluate to true. In other words, the conditions are ANDed together. (You can use the conditionalOperator property to OR the conditions instead. If you do this, at least one of the conditions must evaluate to true, rather than all of them).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>conditionalOperator</td>
            <td>A logical operator to apply to the conditions in the expected map:
                <ul>
                    <li>AND - If all of the conditions evaluate to true, the entire map evaluates to true (default).</li>
                    <li>OR - If at least one of the conditions evaluate to true, the entire map evaluates to true. The operation will succeed only if the entire map evaluates to true.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>consistentRead</td>
            <td>Determines the read consistency model. If set to true, the operation uses strongly consistent reads. Otherwise, eventually consistent reads are used. Strongly consistent reads are not supported on global secondary indexes. If you query a global secondary index with consistentRead set to true, you will receive an error message.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeNames</td>
            <td>One or more substitution tokens for attribute names in an expression. (For example, {"#LP":"LastPostDateTime"}).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeValues</td>
            <td>One or more values that can be substituted in an expression. (For example, { ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} })</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>filterExpression</td>
            <td>A string that contains conditions that DynamoDB applies after the query operation, but before the data is returned. Items that do not satisfy the FilterExpression criteria are not returned. (For example, "LastPostDateTime > :LP") For more information, see <a href="https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Query.html#FilteringResults">Filter Expressions in the Amazon DynamoDB Developer Guide</a>.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>indexName</td>
            <td>The name of an index to query. This can be any local secondary index or global secondary index on the table (Minimum length of 3. Maximum length of 255.)</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>keyConditionExpression</td>
            <td>The condition that specifies the key value(s) for items to be retrieved by the query operation.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>projectionExpression</td>
            <td>A string that identifies one or more attributes to retrieve from the table. These attributes can include scalars, sets, or elements of a JSON document. The attributes in the expression must be separated by commas. If attribute names are not specified, then all attributes are returned. If any of the specified attributes are not found, those attributes do not appear in the result.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response: If set to TOTAL, the response includes the consumed capacity for tables and indexes. If set to INDEXES, the response includes consumed capacity for indexes. If set to NONE (the default), consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.scan>
        <limit>{$ctx:limit}</limit>
        <totalSegments>{$ctx:totalSegments}</totalSegments>
        <exclusiveStartKey>{$ctx:exclusiveStartKey}</exclusiveStartKey>
        <attributesToGet>{$ctx:attributesToGet}</attributesToGet>
        <select>{$ctx:select}</select>
        <segment>{$ctx:segment}</segment>
        <tableName>{$ctx:tableName}</tableName>
        <scanFilter>{$ctx:scanFilter}</scanFilter>
        <conditionalOperator>{$ctx:conditionalOperator}</conditionalOperator>
        <consistentRead>{$ctx:consistentRead}</consistentRead>
        <expressionAttributeNames>{$ctx:expressionAttributeNames}</expressionAttributeNames>
        <expressionAttributeValues>{$ctx:expressionAttributeValues}</expressionAttributeValues>
        <filterExpression>{$ctx:filterExpression}</filterExpression>
        <indexName>{$ctx:indexName}</indexName>
        <projectionExpression>{$ctx:projectionExpression}</projectionExpression>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity>
    </amazondynamodb.scan> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIxxxxxxxxxx",
        "secretAccessKey":"id4xxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "Thread",
        "expressionAttributeNames":{"#LP":"LastPostDateTime"},
        "filterExpression": "#LP = :val",
        "expressionAttributeValues": {":val": {"S": "201303190422"}},
        "returnConsumedCapacity": "TOTAL"
    }
    ```

    **Sample response**

    ```json
    {
        "ConsumedCapacity":{
            "CapacityUnits":0.5,
            "TableName":"Reply"
        },
        "Count":4,
        "Items":[
            {
                "PostedBy":{
                    "S":"joe@example.com"
                },
                "ReplyDateTime":{
                    "S":"20130320115336"
                },
                "Id":{
                    "S":"Amazon DynamoDB#How do I update multiple items?"
                },
                "Message":{
                    "S":"Have you looked at BatchWriteItem?"
                }
            },
            {
                "PostedBy":{
                    "S":"fred@example.com"
                },
                "ReplyDateTime":{
                    "S":"20130320115342"
                },
                "Id":{
                    "S":"Amazon DynamoDB#How do I update multiple items?"
                },
                "Message":{
                    "S":"No, I didn't know about that.  Where can I find more information?"
                }
            },
            {
                "PostedBy":{
                    "S":"joe@example.com"
                },
                "ReplyDateTime":{
                    "S":"20130320115347"
                },
                "Id":{
                    "S":"Amazon DynamoDB#How do I update multiple items?"
                },
                "Message":{
                    "S":"BatchWriteItem is documented in the Amazon DynamoDB API Reference."
                }
            },
            {
                "PostedBy":{
                    "S":"fred@example.com"
                },
                "ReplyDateTime":{
                    "S":"20130320115352"
                },
                "Id":{
                    "S":"Amazon DynamoDB#How do I update multiple items?"
                },
                "Message":{
                    "S":"OK, I'll take a look at that.  Thanks!"
                }
            }
        ],
        "ScannedCount":4
    }
    ```

??? note "updateItem"
    The updateItem operation edits an existing item's attributes, or inserts a new item if it does not already exist. You can put, delete, or add attribute values. You can also perform a conditional update (insert a new attribute name-value pair if it doesn't exist, or replace an existing name-value pair if it has certain expected attribute values). In addition to updating an item, you can also return the item's attribute values in the same operation using the returnValues property.
    
    See the [related API documentation](http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_UpdateItem.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>expected</td>
            <td>A map of attribute/condition pairs. This is the conditional block for the updateItem operation. Each element of expected consists of an attribute name, a comparison operator, and one or more values. DynamoDB uses the comparison operator to compare the attribute with the value(s) you supplied. For each expected element, the result of the evaluation is either true or false. If you specify more than one element in the expected map, by default all of the conditions must evaluate to true. In other words, the conditions are ANDed together. (You can use the ConditionalOperator property to OR the conditions instead. If you do this, at least one of the conditions must evaluate to true, rather than all of them.) If the expected map evaluates to true, the conditional operation succeeds. If it evaluates to false, it fails.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table containing the requested items. (Minimum length of 3. Maximum length of 255.)</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>returnValues</td>
            <td>Use returnValues if you want to get the item attributes as they appeared before they were updated with the putItem request. The possible values are:
                <ul>
                    <li>NONE - If returnValues is not specified or if its value is NONE (the default), nothing is returned.</li>
                    <li>ALL_OLD - The content of the old item is returned. Valid Values: NONE | ALL_OLD | UPDATED_OLD | ALL_NEW | UPDATED_NEW.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnItemCollectionMetrics</td>
            <td>Determines whether item collection metrics are returned: If set to SIZE, statistics about item collection, if any, that were modified during the operation are returned in the response. If set to NONE (the default), no statistics are returned.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>conditionalOperator</td>
            <td>A logical operator to apply to the conditions in the expected map:
                <ul>
                    <li>AND - If all of the conditions evaluate to true, the entire map evaluates to true (default).</li>
                    <li>OR - If at least one of the conditions evaluate to true, the entire map evaluates to true. The operation will succeed only if the entire map evaluates to true.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>attributeUpdates</td>
            <td>The names of attributes to be modified, the action to perform on each, and the new value for each. If you are updating an attribute that is an index key attribute for any indexes on that table, the attribute type must match the index key type defined in the AttributesDefinition of the table description. You can use updateItem to update any non-key attributes. Attribute values cannot be null. String and binary type attributes must have lengths greater than zero. Set type attributes must not be empty. Requests with empty values will be rejected with a ValidationException .</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>key</td>
            <td>A map of attribute names to AttributeValue objects, representing the primary key of the item to delete. For the primary key, you must provide all of the attributes. For example, with a hash type primary key, you only need to specify the hash attribute. For a hash-and-range type primary key, you must specify both the hash attribute and the range attribute.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>conditionExpression</td>
            <td>A condition that must be satisfied in order for a conditional deleteItem operation to succeed. An expression can contain any of the following:
                <ul>
                    <li>Functions: attribute_exists | attribute_not_exists | attribute_type | contains | begins_with | size These function names are case-sensitive.</li>
                    <li>Comparison operators: = | <> | < | > | <= | >= | BETWEEN | IN</li>
                    <li>Logical operators: AND | OR | NOT</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeNames</td>
            <td>One or more substitution tokens for attribute names in an expression. (For example, {"#LP":"LastPostDateTime"}).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>expressionAttributeValues</td>
            <td>One or more values that can be substituted in an expression. (For example, { ":avail":{"S":"Available"}, ":back":{"S":"Backordered"}, ":disc":{"S":"Discontinued"} })</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>returnConsumedCapacity</td>
            <td>Determines the level of detail about provisioned throughput consumption that is returned in the response: If set to TOTAL, the response includes the consumed capacity for tables and indexes. If set to INDEXES, the response includes consumed capacity for indexes. If set to NONE (the default), consumed capacity is not included in the response.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>updateExpression</td>
            <td>An expression that defines one or more attributes to be updated, the action to be performed on them, and new value(s) for them.
                <ul>
                    <li>SET: Adds one or more attributes and values to an item. If any of these attribute already exist, they are replaced by the new values. You can also use SET to add or subtract from an attribute that is of type Number.</li>
                    <li>REMOVE: Removes one or more attributes from an item.</li>
                    <li>ADD: Adds the specified value to the item, if the attribute does not already exist.</li>
                    <li>DELETE: Deletes an element from a set. For more information on update expressions, see Modifying Items and Attributes in the Amazon DynamoDB Developer Guide.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.updateItem>
        <expected>{$ctx:expected}</expected>
        <tableName>{$ctx:tableName}</tableName>
        <returnValues>{$ctx:returnValues}</returnValues>
        <returnItemCollectionMetrics>{$ctx:returnItemCollectionMetrics}</returnItemCollectionMetrics>
        <conditionalOperator>{$ctx:conditionalOperator}</conditionalOperator>
        <attributeUpdates>{$ctx:attributeUpdates}</attributeUpdates>
        <key>{$ctx:key}</key>
        <conditionExpression>{$ctx:conditionExpression}</conditionExpression>
        <expressionAttributeNames>{$ctx:expressionAttributeNames}</expressionAttributeNames>
        <expressionAttributeValues>{$ctx:expressionAttributeValues}</expressionAttributeValues>
        <returnConsumedCapacity>{$ctx:returnConsumedCapacity}</returnConsumedCapacity>
        <updateExpression>{$ctx:updateExpression}</updateExpression>
    </amazondynamodb.updateItem> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIxxxxxxxxxx",
        "secretAccessKey":"id4xxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "Thread",
        "key": {
            "ForumName": {
                "S": "Amazon Dynamo"
            },
            "Subject": {
                "S": "How do I update multiple items?"
            }
        },
        "updateExpression": "set LastPostedBy = :val1",
        "conditionExpression": "LastPostedBy = :val2",
        "expressionAttributeValues": {
            ":val1": {"S": "alice@example.com"},
            ":val2": {"S": "fred@example.com"}
        },
        "returnValues": "ALL_NEW"
    }
    ```

    ```json
        "accessKeyId":"AKIxxxxxxxxxx",
        "secretAccessKey":"id4xxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "Thread",
        "key": {
            "ForumName": {
                "S": "Amazon Dynamo"
            },
            "Subject": {
                "S": "How do I update multiple items?"
            }
        },
        "expected":{ 
            "ForumName":{ 
            "ComparisonOperator":"EQ",
            "AttributeValueList":[ 
                { 
                    "S":"Amazon DynamoDB"
                }
            ]
            }
        },
        "attributeUpdates":{ 
            "Message":{ 
                "Action":"PUT",
                "Value":{ 
                    "S":"The new Message."
                }
            }
        },
        "returnValues": "ALL_NEW"
    ```

    **Sample response**

    ```json
    {
        
    }
    ```

### Tables

??? note "createTable"
    The createTable operation creates a new table. Table names must be unique within each region. See the [related API documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>attributeDefinitions</td>
            <td>A list of attributes that describe the key schema for the table and indexes.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table to create. (Should be of minimum length 3, and maximum length 255.)</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>keySchema</td>
            <td>Specifies the attributes that make up the primary key for a table or an index. The attributes in keySchema must also be defined in attributeDefinitions. Each KeySchemaElement in the array is composed of:
                <ul>
                    <li>AttributeName - The name of the key attribute.</li>
                    <li>KeyType - The role that the key attribute will assume. Possible values are as follows: HASH - partition key RANGE - sort key Note : The partition key of an item is also known as its hash attribute, and the sort key of an item is also known as its range attribute. For a simple primary key (partition key), you must provide exactly one element with a KeyType of HASH . For a composite primary key(partition key and sort key), you must provide exactly two elements, in the following order: The first element must have a KeyType of HASH , and the second element must have a KeyType of RANGE.</li>
                </ul>
            </td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>localSecondaryIndexes</td>
            <td>One or more local secondary indexes (the maximum is five) to be created on the table. Each index is scoped to a given partition key value. There is a 10 GB size limit per partition key value. Else, the size of a local secondary index is unconstrained. Each local secondary index in the array includes the following:
                <ul>
                    <li>IndexName - The name of the local secondary index. Should be unique for this table.</li>
                    <li>KeySchema - Specifies the key schema for the local secondary index. The key schema should begin with the same partition key as the table.</li>
                        <ul>
                            <li>ProjectionType - Possible values are as follows:</li>
                                <ul>
                                    <li>KEYS_ONLY - Only the index and primary keys are projected into the index.</li>
                                    <li>INCLUDE - Only the specified table attributes are projected into the index. The list of projected attributes are in NonKeyAttributes.</li>
                                    <li>ALL - All of the table attributes are projected into the index.</li>
                                </ul>
                            <li>NonKeyAttributes - A list of one or more non-key attribute names that are projected into the secondary index. The total count of attributes provided in NonKeyAttributes, summed across all of the secondary indexes, should not exceed 20.</li>
                        </ul>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>provisionedThroughput</td>
            <td>Represents the provisioned throughput setting for a specified table or index.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>StreamSpecification</td>
            <td>The settings for DynamoDB streams on the table. These settings consist of:
                <ul>
                    <li>StreamEnabled - Indicates whether to be enabled (true) or disabled (false) streams.</li>
                    <li>StreamViewType - When an item in the table is modified, the StreamViewType determines what information is written to the table's stream. Possible values for StreamViewType are:</li>
                        <ul>
                            <li>KEYS_ONLY - Only the key attributes of the modified item are written to the stream.</li>
                            <li>NEW_IMAGE - The entire item, as it appears after it was modified, is written to the stream.</li>
                            <li>OLD_IMAGE - The entire item, as it appeared before it was modified, is written to the stream.</li>
                            <li>NEW_AND_OLD_IMAGES - Both the new and the old item images of the item are written to the stream.</li>
                        </ul>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>globalSecondaryIndexes</td>
            <td>One or more global secondary indexes (the maximum is five) to be created on the table. Each global secondary index in the array includes the following:
                <ul>
                    <li>IndexName - The name of the global secondary index. Should be unique for this table.</li>
                    <li>KeySchema - Specifies the key schema for the global secondary index.</li>
                    <li>Projection - Specifies attributes that are copied (projected) from the table into the index. These are in addition to the primary key attributes and index key attributes, which are automatically projected. Each attribute specification is composed of:</li>
                        <ul>
                            <li>ProjectionType - Possible values are as follows:</li>
                                <ul>
                                    <li>KEYS_ONLY - Only the index and primary keys are projected into the index.</li>
                                    <li>INCLUDE - Only the specified table attributes are projected into the index. The list of projected attributes are in NonKeyAttributes.</li>
                                    <li>ALL - All of the table attributes are projected into the index.</li>
                                </ul>
                            <li>NonKeyAttributes - A list of one or more non-key attribute names that are projected into the secondary index. The total count of attributes provided in NonKeyAttributes, summed across all of the secondary indexes, should not exceed 20.</li>
                        </ul>
                    <li>ProvisionedThroughput - Specifies the provisioned throughput setting for the global secondary index.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.createTable>
        <attributeDefinitions>{$ctx:attributeDefinitions}</attributeDefinitions>
        <tableName>{$ctx:tableName}</tableName>
        <keySchema>{$ctx:keySchema}</keySchema>
        <localSecondaryIndexes>{$ctx:localSecondaryIndexes}</localSecondaryIndexes>
        <provisionedThroughput>{$ctx:provisionedThroughput}</provisionedThroughput>
        <StreamSpecification>{$ctx:StreamSpecification}</StreamSpecification>
        <globalSecondaryIndexes>{$ctx:globalSecondaryIndexes}</globalSecondaryIndexes>
    </amazondynamodb.createTable> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "attributeDefinitions": [
            {
                "AttributeName": "ForumName",
                "AttributeType": "S"
            },
            {
                "AttributeName": "Subject",
                "AttributeType": "S"
            },
            {
                "AttributeName": "LastPostDateTime",
                "AttributeType": "S"
            }
        ],
        "tableName": "Thread",
        "keySchema": [
            {
                "AttributeName": "ForumName",
                "KeyType": "HASH"
            },
            {
                "AttributeName": "Subject",
                "KeyType": "RANGE"
            }
        ],
        "localSecondaryIndexes": [
            {
                "IndexName": "LastPostIndex",
                "KeySchema": [
                    {
                        "AttributeName": "ForumName",
                        "KeyType": "HASH"
                    },
                    {
                        "AttributeName": "LastPostDateTime",
                        "KeyType": "RANGE"
                    }
                ],
                "Projection": {
                    "ProjectionType": "KEYS_ONLY"
                }
            }
        ],
        "provisionedThroughput": {
            "ReadCapacityUnits": 5,
            "WriteCapacityUnits": 5
        }
    }
    ```

    **Sample response**

    ```json
    {
        "TableDescription":{
            "TableArn":"arn:aws:dynamodb:us-west-2:123456789012:table/Thread",
            "AttributeDefinitions":[
                {
                    "AttributeName":"ForumName",
                    "AttributeType":"S"
                },
                {
                    "AttributeName":"LastPostDateTime",
                    "AttributeType":"S"
                },
                {
                    "AttributeName":"Subject",
                    "AttributeType":"S"
                }
            ],
            "CreationDateTime":1.36372808007E9,
            "ItemCount":0,
            "KeySchema":[
                {
                    "AttributeName":"ForumName",
                    "KeyType":"HASH"
                },
                {
                    "AttributeName":"Subject",
                    "KeyType":"RANGE"
                }
            ],
            "LocalSecondaryIndexes":[
                {
                    "IndexArn":"arn:aws:dynamodb:us-west-2:123456789012:table/Thread/index/LastPostIndex",
                    "IndexName":"LastPostIndex",
                    "IndexSizeBytes":0,
                    "ItemCount":0,
                    "KeySchema":[
                        {
                            "AttributeName":"ForumName",
                            "KeyType":"HASH"
                        },
                        {
                            "AttributeName":"LastPostDateTime",
                            "KeyType":"RANGE"
                        }
                    ],
                    "Projection":{
                        "ProjectionType":"KEYS_ONLY"
                    }
                }
            ],
            "ProvisionedThroughput":{
                "NumberOfDecreasesToday":0,
                "ReadCapacityUnits":5,
                "WriteCapacityUnits":5
            },
            "TableName":"Thread",
            "TableSizeBytes":0,
            "TableStatus":"CREATING"
        }
    }
    ```

??? note "deleteTable"
    The deleteTable operation deletes a table and all of its items. See the [related API documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_DeleteTable.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table to delete. (Should be of minimum length 3, and maximum length 255.)</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.deleteTable>
        <tableName>{$ctx:tableName}</tableName>
    </amazondynamodb.deleteTable> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "TestTable"
    }
    ```

    **Sample response**

    ```json
    {
        "TableDescription":{
            "TableArn":"arn:aws:dynamodb:us-west-2:123456789012:table/Reply",
            "ItemCount":0,
            "ProvisionedThroughput":{
                "NumberOfDecreasesToday":0,
                "ReadCapacityUnits":5,
                "WriteCapacityUnits":5
            },
            "TableName":"Reply",
            "TableSizeBytes":0,
            "TableStatus":"DELETING"
        }
    }
    ```

??? note "describeTable"
    The describeTable operation retrieves information about a table, such as the current status of the table, when it was created, the primary key schema, and any indexes on the table. See the [related API documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_DescribeTable.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table for which information is to be retrieved. (Should be of minimum length 3, and maximum length 255.)</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.deleteTable>
        <tableName>{$ctx:tableName}</tableName>
    </amazondynamodb.deleteTable> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName": "TestTable"
    }
    ```

    **Sample response**

    ```json
    {
        "Table":{
            "TableArn":"arn:aws:dynamodb:us-west-2:123456789012:table/Thread",
            "AttributeDefinitions":[
                {
                    "AttributeName":"ForumName",
                    "AttributeType":"S"
                },
                {
                    "AttributeName":"LastPostDateTime",
                    "AttributeType":"S"
                },
                {
                    "AttributeName":"Subject",
                    "AttributeType":"S"
                }
            ],
            "CreationDateTime":1.363729002358E9,
            "ItemCount":0,
            "KeySchema":[
                {
                    "AttributeName":"ForumName",
                    "KeyType":"HASH"
                },
                {
                    "AttributeName":"Subject",
                    "KeyType":"RANGE"
                }
            ],
            "LocalSecondaryIndexes":[
                {
                    "IndexArn":"arn:aws:dynamodb:us-west-2:123456789012:table/Thread/index/LastPostIndex",
                    "IndexName":"LastPostIndex",
                    "IndexSizeBytes":0,
                    "ItemCount":0,
                    "KeySchema":[
                        {
                            "AttributeName":"ForumName",
                            "KeyType":"HASH"
                        },
                        {
                            "AttributeName":"LastPostDateTime",
                            "KeyType":"RANGE"
                        }
                    ],
                    "Projection":{
                        "ProjectionType":"KEYS_ONLY"
                    }
                }
            ],
            "ProvisionedThroughput":{
                "NumberOfDecreasesToday":0,
                "ReadCapacityUnits":5,
                "WriteCapacityUnits":5
            },
            "TableName":"Thread",
            "TableSizeBytes":0,
            "TableStatus":"ACTIVE"
        }
    }
    ```

??? note "listTables"
    The listTables operation retrieves the tables that you own in the current AWS region. The output from listTables is paginated, with each page returning a maximum of 100 table names. See the [related API documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_ListTables.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>exclusiveStartTableName</td>
            <td>The first table name that the listTables operation evaluates. Use the value returned for LastEvaluatedTableName (this is the name of the last table in the current page of results) in the previous operation, so that you can obtain the next page of result.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>limit</td>
            <td>The maximum number of table names to retrieve. If this parameter is not specified, the limit is 100.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.listTables>
        <exclusiveStartTableName>{$ctx:exclusiveStartTableName}</exclusiveStartTableName>
        <limit>{$ctx:limit}</limit>
    </amazondynamodb.listTables> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "exclusiveStartTableName":"Music",
        "limit":4
    }
    ```

    **Sample response**

    ```json
    {
        "LastEvaluatedTableName":"Thread",
        "TableNames":[
            "Forum",
            "Reply",
            "Thread"
        ]
    }
    ```

??? note "updateTable"
    The updateTable operation updates provisioned throughput settings, global secondary indexes, or DynamoDB Streams settings for a given table. You can only perform one of the following operations at a time:

    * Modify the provisioned throughput settings of the table.
    * Enable or disable streams on the table.
    * Remove a global secondary index from the table.
    * Create a new global secondary index on the table. Once the index begins backfilling, you can use updateTable to perform other operations. 
    
    See the [related API documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_UpdateTable.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>tableName</td>
            <td>The name of the table to be updated. (Should be of minimum length 3, and maximum length 255).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>attributeDefinitions</td>
            <td>A list of attributes that describe the key schema for the table and indexes. If you are adding a new global secondary index to the table, AttributeDefinitions should include the key element(s) of the new index.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>globalSecondaryIndexUpdates</td>
            <td>An array of one or more global secondary indexes for the table. For each index in the array, you can request one of the following actions:
                <ul>
                    <li>Create - To add a new global secondary index to the table.</li>
                    <li>Update - To modify the provisioned throughput settings of an existing global secondary index.</li>
                    <li>Delete - To remove a global secondary index from the table.</li>
                </ul>
            </td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>StreamSpecification</td>
            <td>Represents the DynamoDB streams configuration for the table.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>provisionedThroughput</td>
            <td>The new provisioned throughput setting for the specified table or index.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazondynamodb.updateTable>
        <tableName>{$ctx:tableName}</tableName>
        <attributeDefinitions>{$ctx:attributeDefinitions}</attributeDefinitions>
        <globalSecondaryIndexUpdates>{$ctx:globalSecondaryIndexUpdates}</globalSecondaryIndexUpdates>
        <StreamSpecification>{$ctx:StreamSpecification}</StreamSpecification>
        <provisionedThroughput>{$ctx:provisionedThroughput}</provisionedThroughput>
    </amazondynamodb.updateTable> 
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false",
        "tableName":"Thread",
        "provisionedThroughput":{ 
            "ReadCapacityUnits":12,
            "WriteCapacityUnits":12
        }
    }
    ```

    **Sample response**

    ```json
    {
        "TableDescription":{
            "TableArn":"arn:aws:dynamodb:us-west-2:123456789012:table/Thread",
            "AttributeDefinitions":[
                {
                    "AttributeName":"ForumName",
                    "AttributeType":"S"
                },
                {
                    "AttributeName":"LastPostDateTime",
                    "AttributeType":"S"
                },
                {
                    "AttributeName":"Subject",
                    "AttributeType":"S"
                }
            ],
            "CreationDateTime":1.363801528686E9,
            "ItemCount":0,
            "KeySchema":[
                {
                    "AttributeName":"ForumName",
                    "KeyType":"HASH"
                },
                {
                    "AttributeName":"Subject",
                    "KeyType":"RANGE"
                }
            ],
            "LocalSecondaryIndexes":[
                {
                    "IndexName":"LastPostIndex",
                    "IndexSizeBytes":0,
                    "ItemCount":0,
                    "KeySchema":[
                        {
                            "AttributeName":"ForumName",
                            "KeyType":"HASH"
               },
               {
                  "AttributeName":"LastPostDateTime",
                  "KeyType":"RANGE"
               }
            ],
            "Projection":{
               "ProjectionType":"KEYS_ONLY"
            }
         }
      ],
      "ProvisionedThroughput":{
         "LastIncreaseDateTime":1.363801701282E9,
         "NumberOfDecreasesToday":0,
         "ReadCapacityUnits":5,
         "WriteCapacityUnits":5
      },
      "TableName":"Thread",
      "TableSizeBytes":0,
      "TableStatus":"UPDATING"
   }
    }
    ```

??? note "describeLimits"
    The describeLimits operation retrieves the current provisioned-capacity limits allowed in a region. 
    
    See the [related API documentation](https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_DescribeLimits.html) for more information.

    **Sample configuration**

    ```xml
    <amazondynamodb.describeLimits/>  
    ```
    
    **Sample request**

    ```json
    {
        "accessKeyId":"AKIAxxxxxxxxxxxx",
        "secretAccessKey":"id4qxxxxxxxx",
        "region":"us-east-1",
        "blocking":"false"
    }
    ```

    **Sample response**

    ```json
    {
        "AccountMaxReadCapacityUnits":20000,
        "AccountMaxWriteCapacityUnits":20000,
        "TableMaxReadCapacityUnits":10000,
        "TableMaxWriteCapacityUnits":10000
    }
    ```