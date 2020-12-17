# Amazon SQS Connector Reference

The following operations allow you to work with the Amazon SQS Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Amazon SQS connector, add the <amazonsqs.init> element in your configuration before carrying out any other Amazon SQS operations. This uses the standard HTTP Authorization header to pass authentication information. Developers are issued an AWS access key ID and an AWS secret access key when they register. For request authentication, the secret access key and the access key ID elements will be used to compute the signature. The authentication uses the "HmacSHA256" signature method and the signature version "4". Click [here](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/RequestAuthenticationArticle.html) for further information on the authentication process. To use the HTTPS amazon AWS url, you need to import the certificate into the WSO2 EI client keystore.

??? note "init"
    The init operation is used to initialize the connection to Amazon SQS.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>secretAccessKey</td>
            <td>The secret access key (a 40-character sequence).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>accessKeyId</td>
            <td>The access key ID that corresponds to the secret access key that you used to sign the request (a 20-character, alphanumeric sequence).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>version</td>
            <td>The version of the API, which is "2009-02-01".</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>region</td>
            <td>The regional endpoint to make your requests (e.g., us-east-1).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>enableSSL</td>
            <td>Whether the Amazon AWS URL should be HTTP or HTTPS. Set to true if you want the URL to be HTTPS.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>The content type that is used to generate the signature.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>blocking</td>
            <td>Boolean type, this property helps the connector perform blocking invocations to Amazon SQS.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonsqs.init>
       <secretAccessKey>{$ctx:secretAccessKey}</secretAccessKey>
        <accessKeyId>{$ctx:accessKeyId}</accessKeyId>
        <version>{$ctx:version}</version>
        <region>{$ctx:region}</region>
        <enableSSL>{$ctx:enableSSL}</enableSSL>
        <contentType>{$ctx:contentType}</contentType>
        <blocking>{$ctx:blocking}</blocking>
    </amazonsqs.init>
    ```
    
---

### Messages

??? note "receiveMessage"
    This operation retrieves one or more messages, with a maximum limit of 10 messages, from the specified queue. The default behavior is short poll, where a weighted random set of machines is sampled. This means only the messages on the sampled machines are returned. If the number of messages in the queue is small (less than 1000), it is likely you will get fewer messages than you requested per call. If the number of messages in the queue is extremely small, you might not receive any messages in a particular response. In this case, you should repeat the request. See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_ReceiveMessage.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>maxNumberOfMessages</td>
            <td>The maximum number of messages to be returned. Values can be from 1 to 10. Default is 1.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>waitTimeSeconds</td>
            <td>The duration (in seconds) for which the call will wait for a message to arrive in the queue before returning. If a message is available, the call will return sooner than WaitTimeSeconds. Long poll support is enabled by using this parameter. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-long-polling.html">Amazon SQS Long Poll</a>.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>messageAttributeNames</td>
            <td>The name of the message attribute. The message attribute name can contain the following characters: A-Z, a-z, 0-9, underscore (_), hyphen (-), and period (.). The name must not start or end with a period, and it should not have successive periods. The name is case sensitive and must be unique among all attribute names for the message. The name can be up to 256 characters long. The name cannot start with "AWS." or "Amazon." (including any case variations), because these prefixes are reserved for use by Amazon Web Services. When using the operation, you can send a list of attribute names to receive, or you can return all of the attributes by specifying "All" or ".*" in your request. You can also use "foo.*" to return all message attributes starting with the "foo" prefix.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>visibilityTimeout</td>
            <td>The duration (in seconds) in which the received messages are hidden from subsequent retrieve requests after being retrieved by the request.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>attributes</td>
            <td>A list of attributes that need to be returned along with each message.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <amazonsqs.receiveMessage>
        <maxNumberOfMessages>{$ctx:maxNumberOfMessages}</maxNumberOfMessages>
        <waitTimeSeconds>{$ctx:waitTimeSeconds}</waitTimeSeconds>
        <messageAttributeNames>{$ctx:messageAttributeNames}</messageAttributeNames>
        <visibilityTimeout>{$ctx:visibilityTimeout}</visibilityTimeout>
        <attributes>{$ctx:attributes}</attributes>
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
    </amazonsqs.receiveMessage>
    ```
    
    **Sample request**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWR2ZDDVPEBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MdfaL7Li1P3hJu1GTdtOO7Kd7NfPlyYG8f/6</secretAccessKey>
        <version>2009-02-01</version>
        <region>us-east-1</region>
        <queueId>899940420354</queueId>
        <queueName>Test</queueName>
        <maxNumberOfMessages>10</maxNumberOfMessages>
    </root>
    ```

??? note "sendMessage"
    This operation delivers a message to the specified queue. You can send payload messages up to 256 KB (262,144 bytes) in size. See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SendMessage.html) for more information.

    > **Note**: The following list shows the characters (in Unicode) allowed in your message, according to the W3C XML specification. For more information, go to [http://www.w3.org/TR/REC-xml/#charsets](http://www.w3.org/TR/REC-xml/#charsets). If you send any characters not included in the list, your request will be rejected. #x9 | #xA | #xD | [#x20 to #xD7FF] | [#xE000 to #xFFFD] | [#x10000 to #x10FFFF].
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageBody</td>
            <td>The message to be sent, a String that is a maximum of 256 KB in size. For a list of allowed characters, see the preceding important note.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>delaySeconds</td>
            <td>The number of seconds (0 to 900, which is 15 minutes) to delay a specific message. Messages with a positive delaySeconds value become available for processing after the delay time is finished. If you do not specify a value, the default value for the queue applies.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>messageAttributes</td>
            <td>Each message attribute consists of a Name, Type, and Value. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV">Message Attribute Items</a>.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>messageDeduplicationId</td>
            <td>The ID used for deduplication of sent messages. If a message with a particular messageDeduplicationId is sent successfully, any messages sent with the same messageDeduplicationId are accepted successfully but aren't delivered during the 5-minute deduplication interval, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queue-recommendations.html#using-messagededuplicationid-property">Using the MessageDeduplicationId Property</a>.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>messageGroupId</td>
            <td>The ID that specifies that a message belongs to a specific message group. Messages that belong to the same message group are processed in a FIFO manner, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/FIFO-queue-recommendations.html#using-messagegroupid-property">Using the MessageGroupId Property</a>.</td>
            <td>Optional</td>
        </tr>
    </table>

    > **Note**: The messageGroupId and messageDeduplicationId parameters apply only to FIFO (first-in-first-out) queues and valid values are alphanumeric characters (a-z, A-Z, 0-9) and punctuation (!"#$%&'()*+,-./:;<=>?@[\]^_`{|}~). When you set FIFOQueue, you can't set delaySeconds per message. You can set this parameter only on a queue level.

    **Sample configuration**

    ```xml
    <amazonsqs.sendMessage>
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
        <messageBody>{$ctx:messageBody}</messageBody>
        <delaySeconds>{$ctx:delaySeconds}</delaySeconds>
        <messageAttributes>{$ctx:messageAttributes}</messageAttributes>
        <messageDeduplicationId>{$ctx:messageDeduplicationId}</messageDeduplicationId>
        <messageGroupId>{$ctx:messageGroupId}</messageGroupId>  
    </amazonsqs.sendMessage> 
    ```
    
    **Sample request for sendMessage**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWRDD2ZVPfghEBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MaL7LikjhyhJu1GTtOO7Kd7NfPlfghyYG8f/6</secretAccessKey>
        <version>2009-02-01</version>
        <region>us-east-1</region>
        <queueId>899940420354</queueId>
        <queueName>Test</queueName>
        <messageBody>Testing the operation</messageBody>
    </root>
    ```

    **Sample request for sendMessage to FIFOQueue**

    ```xml
    <root>
        <accessKeyId>AKIAJXHxxxxxx</accessKeyId>
        <secretAccessKey>N9VT2P3xxxxxx</secretAccessKey>
        <version>2012-11-05</version>
        <region>us-west-2</region>
        <queueId>899940420354</queueId>
        <queueName>test.fifo</queueName>
        <messageGroupId>MyMessageGroupId1234567890</messageGroupId>
        <messageDeduplicationId>MyMessageDeduplicationId1234567890</messageDeduplicationId>
        <messageBody>Testing the operation</messageBody>
    </root>
    ```

??? note "sendMessageBatch"
    This operation delivers batch messages to the specified queue. You can send payload messages up to 256 KB (262,144 bytes) in size. See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SendMessageBatch.html) for more information.

    > **Note**: The following list shows the characters (in Unicode) allowed in your message, according to the W3C XML specification. For more information, go to [http://www.w3.org/TR/REC-xml/#charsets](http://www.w3.org/TR/REC-xml/#charsets). If you send any characters not included in the list, your request will be rejected. #x9 | #xA | #xD | [#x20 to #xD7FF] | [#xE000 to #xFFFD] | [#x10000 to #x10FFFF]
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>delaySeconds</td>
            <td>The number of seconds (0 to 900, which is 15 minutes) to delay a specific message. Messages with a positive delaySeconds value become available for processing after the delay time is finished. If you do not specify a value, the default value for the queue applies.</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>messageAttributes</td>
            <td>List of SendMessageBatchRequestEntry items.</td>
            <td>Yes</td>
        </tr>
    </table>

   **Sample configuration**

    ```xml
    <amazonsqs.sendMessageBatch>
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
        <delaySeconds>{$ctx:delaySeconds}</delaySeconds>
        <messageRequestEntry>{$ctx:messageRequestEntry}</messageRequestEntry>
    </amazonsqs.sendMessageBatch> 
    ```
    
    **Sample request**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWRDD2ZVPfghEBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MaL7Li1P3hjgGTtOO7Kd7NfPlfghyYG8f/6</secretAccessKey>
        <version>2009-02-01</version>
        <region>us-east-1</region>
        <queueId>492228198692</queueId>
        <queueName>TestCo1n</queueName>      
        <messageRequestEntry>SendMessageBatchRequestEntry.1.Id=test_msg_001&amp;SendMessageBatchRequestEntry.1.MessageBody=test%20message%20body%201&amp;SendMessageBatchRequestEntry.2.Id=test_msg_002&amp;SendMessageBatchRequestEntry.2.MessageBody=test%20message%20body%202</messageRequestEntry>
    </root>
    ```

??? note "deleteMessage"
    This operation deletes the specified message from the specified queue. You specify the message by using the message's receipt handle and not the message ID you received when you sent the message. Even if the message is locked by another reader due to the visibility timeout setting, it is still deleted from the queue. If you leave a message in the queue for longer than the queue's configured retention period, Amazon SQS automatically deletes it. See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_DeleteMessage.html) for more information.

    > **Note**: The receipt handle is associated with a specific instance of receiving the message. If you receive a message more than once, the receipt handle you get every time you receive the message is different. When you use this operation, if you do not provide the most recently received receipt handle for the message, the request will still succeed, but the message might not be deleted.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>receiptHandle</td>
            <td>The receipt handle associated with the message to be deleted.</td>
            <td>Yes</td>
        </tr>
    </table>

    > **Note**: It is possible you will receive a message even after you have deleted it. This might happen on rare occasions if one of the servers storing a copy of the message is unavailable when you request to delete the message. The copy remains on the server and might be returned to you again on a subsequent receive request. You should create your system to be idempotent so that receiving a particular message more than once is not a problem.

   **Sample configuration**

    ```xml
    <amazonsqs.deleteMessage>
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
        <receiptHandle>{$ctx:receiptHandle}</receiptHandle>
    </amazonsqs.deleteMessage> 
    ```
    
    **Sample request**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWR2ZVSDPEBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MaL7Li1PjkhGTtOO7Kddf7NfPlyYG8f/6</secretAccessKey>
        <version>2009-02-01</version>
        <region>us-east-1</region>
        <queueId>899940420354</queueId>
        <queueName>Test</queueName>
        <receiptHandle>ib8MCWgVft0d03wCmmzGU9b41lxRVMYIHLnfckXhkh/6DmqOhu+qHcsuzXUik5HvhGLa/A3tnTUTOXydKJoTOTlP3KUjOSOrwVxKoOi+bhLyLJuYAtkhfRMY/ZF1Jh4CzGSk3tLfPSfzOo3bqgf7mWklwM18BnufuWjSl8HjJQYnegs5yDDypAZZqtBuMv6gT/1aMbQbL15Vo8b0Fr06hFjSZzPpA0vxbb9NpksToMq4yPf8X3jt/Njn1sPZSG0OKqdgACiavmi0mzAT/4QLi+waSFnyG0h+wN1z9OdHsr1+4=</receiptHandle>
    </root> 
    ```

??? note "deleteMessageBatch"
    This operation deletes multiple messages from the specified queue. See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_DeleteMessageBatch.html) for more information.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageRequestEntry</td>
            <td>A list of receipt handles for the messages to be deleted.</td>
            <td>Yes</td>
        </tr>
    </table>

   **Sample configuration**

    ```xml
    <amazonsqs.deleteMessageBatch>
        <messageRequestEntry>{$ctx:messageRequestEntry}</messageRequestEntry>
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
    </amazonsqs.deleteMessageBatch> 
    ```
    
    **Sample request**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWR2ZVSDPEBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MaL7Li1PjkhGTtOO7Kddf7NfPlyYG8f/6</secretAccessKey>
        <version>2009-02-01</version>
        <region>us-east-1</region>
        <queueId>899940420354</queueId>
        <queueName>Test</queueName>
        <messageRequestEntry>DeleteMessageBatchRequestEntry.1.Id=msg1
        &amp;DeleteMessageBatchRequestEntry.1.ReceiptHandle=gfk0T0R0waama4fVxIVNgeNP8ZEDcw7zZU1Zw%3D%3D&amp;DeleteMessageBatchRequestEntry.2.Id=msg2&amp;DeleteMessageBatchRequestEntry.2.ReceiptHandle=gfk0T0R0waama4fVFffkjKzmhMCymjQvfTFk2LxT33G4ms5subrE0deLKWSscPU1oD3J9zgeS4PQQ3U30qOumIE6AdAv3w%2F%2Fa1IXW6AqaWhGsEPaLm3Vf6IiWqdM8u5imB%2BNTwj3tQRzOWdTOePjOjPcTpRxBtXix%2BEvwJOZUma9wabv%2BSw6ZHjwmNcVDx8dZXJhVp16Bksiox%2FGrUvrVTCJRTWTLc59oHLLF8sEkKzRmGNzTDGTiV%2BYjHfQj60FD3rVaXmzTsoNxRhKJ72uIHVMGVQiAGgB%2BqAbSqfKHDQtVOmJJgkHug%3D%3D</messageRequestEntry>
    </root>  
    ```

??? note "changeMessageVisibility"
    This operation changes the visibility timeout of a specified message in a queue to a new value. The maximum allowed timeout value you can set the value to is 12 hours. This means you can't extend the timeout of a message in an existing queue to more than a total visibility timeout of 12 hours. (For more information on visibility timeout, see [Visibility Timeout in the Amazon SQS Developer Guide](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html)).
    
    For example, let's say you have a message whose default message visibility timeout is 30 minutes. You could call this operation with a value of two hours, and the effective timeout would be two hours and 30 minutes. When that time is reached, you could again extend the time-out by calling changeMessageVisiblity; but this time, the maximum allowed timeout would be 9 hours and 30 minutes. See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_ChangeMessageVisibility.html) for more information.

    > **Note**: There is a 120,000 limit for the number of in-flight messages per queue. Messages are in flight after they have been received from the queue by a consuming component but have not yet been deleted from the queue. If you reach the 120,000 limit, you will receive an OverLimit error message from Amazon SQS. To help avoid reaching the limit, you should delete the messages from the queue after they have been processed. You can also increase the number of queues you use to process the messages.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>receiptHandle</td>
            <td>The receipt handle associated with the message whose visibility timeout you are changing.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>visibilityTimeout</td>
            <td>The new value (in seconds from 0 to 43200, which is 12 hours) for the message's visibility timeout.</td>
            <td>Yes</td>
        </tr>
    </table>

    > **Note**: If you attempt to set visibilityTimeout to an amount more than the maximum time left, Amazon SQS returns an error. It will not automatically recalculate and increase the timeout to the maximum time remaining.
    > 
    > Unlike with a queue, when you change the visibility timeout for a specific message, that timeout value is applied immediately but is not saved in memory for that message. If you don't delete a message after it is received, the visibility timeout for the message the next time it is received reverts to the original timeout value, not the value you set with the changeMessageVisibility operation.

   **Sample configuration**

    ```xml
    <amazonsqs.changeMessageVisibility>       
        <receiptHandle>{$ctx:receiptHandle}</receiptHandle>       
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
        <visibilityTimeout>{$ctx:visibilityTimeout}</visibilityTimeout>
    </amazonsqs.changeMessageVisibility> 
    ```
    
    **Sample request**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWR2ZVPESSBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MaL7Lhgu1GTtOO7Kd7NfPlyYG8f/6</secretAccessKey>
        <version>2009-02-01</version>
        <region>us-east-1</region>
        <queueId>899940420354</queueId>
        <queueName>Test</queueName>
        <receiptHandle>ib8MCWgVft3IGz2EvDZBjzlBHi0rmXxJUcKbqlvkuH9WO9LaWQNQ8isW3IX8iCZBHovl8NQeC/EbbsLCSS2bMDGMZ5mxQ9C+UudaXRNxwj+VeLP4DQoTOMXEnw3V3Pk7GoVJ62YwrbnfH9U6c7qd8xCptVK1FIn6Pu4zNYRRiQmO8ENP3Tt0S81gHCz8sGdunXuro1tymIhxxliq29uPX8plYmvmkeCc9Fezib1cccpPpUkFhIHY8PkCXxI04i6zSM/o1o/wag2d0iDBVS20hBR2g8e6h8il1z9OdHsr1+4=</receiptHandle>
        <visibilityTimeout>10</visibilityTimeout>
    </root>  
    ```

??? note "changeMessageVisibilityBatch"
    This operation changes the visibility timeout of multiple messages. See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_ChangeMessageVisibilityBatch.html) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageRequestEntry</td>
            <td>A list of receipt handles of the messages for which the visibility timeout must be changed.</td>
            <td>Yes</td>
        </tr>
    </table>

   **Sample configuration**

    ```xml
    <amazonsqs.changeMessageVisibilityBatch>
        <messageRequestEntry>{$ctx:messageRequestEntry}</messageRequestEntry>
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
    </amazonsqs.changeMessageVisibilityBatch> 
    ```
    
    **Sample request**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWR2ZVPESSBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MaL7Li1P3GjhgDNTtOO7Kd7NfPlyYG8f/6</secretAccessKey>
        <version>2009-02-01</version>
        <region>us-east-1</region>
        <queueId>899940420354</queueId>
        <queueName>Test</queueName>
        <messageRequestEntry>ChangeMessageVisibilityBatchRequestEntry.1.Id=change_visibility_msg_1&amp;ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=ib8MCWgVft3IGz2EvDZBjzlBHi0rmXxJUcKbqlvkuH9WO9LaWQNQ8isW3IX8iCZBHovl8NQeC/EbbsLCSS2b&amp;ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=10&amp;ChangeMessageVisibilityBatchRequestEntry.2.Id=change_visibility_msg_2&amp;ChangeMessageVisibilityBatchRequestEntry.2.ReceiptHandle=ib8MCWgVft3IGz2EvDZBjzlBHi0rmXxJUcKbqlvkuH9WO9LaWQNQ8isW3IX8iCZBHovl8NQeC/EbbsLCSS2b
    </root>  
    ```

---

### Permissions

??? note "addPermission"
    This operation adds a permission to a queue for a specific [principal](http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P), enabling you to share access to the queue. When you create a queue, you have full control access rights for the queue. Only you (as owner of the queue) can grant or deny permissions to the queue. For more information about these permissions, see [Shared Queues in the Amazon SQS Developer Guide](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html). See the [related API documentation](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_ChangeMessageVisibilityBatch.html) for more information.

    > **Note**:
    > - This operation writes an Amazon SQS-generated policy. If you want to write your own policy, use SetQueueAttributes to upload your policy. For more information about writing your own policy, see Using The Access Policy Language in the Amazon SQS Developer Guide.
    > - Some API actions take lists of parameters. These lists are specified using the param.n notation. Values of n are integers starting from 1. For example, a parameter list with two elements looks like this: `&Attribute.1=this, &Attribute.2=that`.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>awsAccountNumbers</td>
            <td>The AWS account number of the <a href="http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P">principal</a> who will be given permission. The principal must have an AWS account but does not need to be signed up for Amazon SQS. For information about locating the AWS account identification, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AWSCredentials.html">Your AWS Identifiers in the Amazon SQS Developer Guide</a>.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>actionName</td>
            <td>The action the client wants to allow for the specified principal. The following are valid values: * | SendMessage | ReceiveMessage | DeleteMessage | ChangeMessageVisibility | GetQueueAttributes | GetQueueUrl. For more information about these actions, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html#PermissionTypes">Understanding Permissions in the Amazon SQS Developer Guide</a>.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>label</td>
            <td>The unique identification of the permission you are setting (e.g., AliceSendMessage). Constraints: Maximum 80 characters; alphanumeric characters, hyphens (-), and underscores (_) are allowed.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueId</td>
            <td>The unique identifier of the queue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queueName</td>
            <td>The name of the queue.</td>
            <td>Yes</td>
        </tr>
    </table>

   **Sample configuration**

    ```xml
    <amazonsqs.addPermission>
        <awsAccountNumbers>{$ctx:awsAccountNumbers}</awsAccountNumbers>
        <actionNames>{$ctx:actionNames}</actionNames>
        <label>{$ctx:label}</label>
        <queueId>{$ctx:queueId}</queueId>
        <queueName>{$ctx:queueName}</queueName>
    </amazonsqs.addPermission>
    ```
    
    **Sample request**

    ```xml
    <root>
        <accessKeyId>AKIAJXHDKJWDDR2ZVPEBTQ</accessKeyId>
        <secretAccessKey>N9VT2P3MaL7Li1P3hJu1GsdfTtOO7Kd7NfPlyYG8f/6</secretAccessKey>
        <awsAccountNumbers>AWSAccountId.1=899940420354&amp;AWSAccountId.2=294598218081</awsAccountNumbers>
        <actionNames>ActionName.1=SendMessage&amp;ActionName.2=ReceiveMessage</actionNames>
        <label>qazwsx</label>
        <queueId>899940420354</queueId>
        <queueName>Test</queueName>
        <version>2009-02-01</version>
        <region>us-east-1</region>
    </root>  
    ```