# Gmail Connector Reference

The following operations allow you to work with the Gmail Connector. Click an operation name to see parameter details and samples on how to use it.

---

To use the Gmail connector, add the `<gmail.init>` element in your configuration before carrying out any other Gmail operations. 

??? note "gmail.init"
    The Gmail API uses OAuth2 authentication with Tokens. For more information on authentication, go to [Authorizing Your App with Gmail](https://developers.google.com/gmail/api/auth/about-auth).
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>accessToken</td>
            <td>Value of the Access Token to access the Gmail REST API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>refreshToken</td>
            <td>Value of the Refresh Token, which generates a new Access Token when the previous one gets expired.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>The API URL of Gmail (https://www.googleapis.com/gmail).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>userId</td>
            <td>User mail ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientSecret</td>
            <td>Value of the Client Secret you obtained when you registered your application with the Gmail API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>Value of the Client ID you obtained when you registered your application with Gmail API.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>registryPath</td>
            <td>Registry Path of the connector where the Access Token will be stored (if not provided, the connector stores the Access Token in the connectors/Gmail/accessToken Registry Path).</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.init>
        <userId>{$ctx:userId}</userId>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
        <clientSecret>{$ctx:clientSecret}</clientSecret>
        <clientId>{$ctx:clientId}</clientId>
        <registryPath>{$ctx:registryPath}</registryPath>
        <accessToken>{$ctx:accessToken}</accessToken>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
    </gmail.init>
    ```

---

### Drafts

??? note "listDrafts"
    The listDrafts operation lists all drafts in Gmail. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/drafts/list) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>Maximum number of messages to return.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>Page token to retrieve a specific page of results in the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.listDrafts>
        <maxResults>{$ctx:maxResults}</maxResults>
        <pageToken>{$ctx:pageToken}</pageToken>
    </gmail.listDrafts>
    ```
    
    **Sample request**

    ```json
    {
        "maxResults":"10"
        "pageToken":"09876536614133772469"
    }
    ```

??? note "readDraft"
    The readDraft operation retrieves a particular draft email. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/drafts/get) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the draft email to be retrieve</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The <a href="https://developers.google.com/gmail/api/v1/reference/users/drafts/get#parameters">format</a> to return the draft in</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.readDraft>
        <id>{$ctx:id}</id>
        <format>{$ctx:format}</format>
    </gmail.readDraft>
    ```
    
    **Sample request**

    ```json
    {
        "id": "1492984134337920839",
        "format":"raw"
    }
    ```

??? note "deleteDraft"
    The deleteDraft operation deletes an existing draft. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/drafts/delete) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the draft email to be deleted.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.deleteDraft>
        <id>{$ctx:id}</id>
    </gmail.deleteDraft>
    ```
    
    **Sample request**

    ```json
    {
        "id":"1491513685150755887"
    }
    ```

??? note "createDraft"
    The createDraft operation creates a new draft. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/drafts/create) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>to</td>
            <td>The email address of the recipient of this email.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>subject</td>
            <td>Subject of the email.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>from</td>
            <td>The email address of the sender of the email.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>cc</td>
            <td>The email addresses of recipients who will receive a copy of this email.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bcc</td>
            <td>The email addresses of recipients who will privately receive a copy of this email (their email addresses will be hidden from each other).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>threadId</td>
            <td>ID of the thread.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>id</td>
            <td>ID of the email.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageBody</td>
            <td>Content of the email.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>If the message body is in the format of HTML or if you need to send a rich text then you must give the parameter value as "text/html; charset=UTF-8" otherwise it takes the default value as text/plain.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.createDraft>
        <to>{$ctx:to}</to>
        <subject>{$ctx:subject}</subject>
        <from>{$ctx:from}</from>
        <cc>{$ctx:cc}</cc>
        <bcc>{$ctx:bcc}</bcc>
        <id>{$ctx:id}</id>
        <threadId>{$ctx:threadId}</threadId>
        <messageBody>{$ctx:messageBody}</messageBody>
        <contentType>{$ctx:contentType}</contentType>
    </gmail.createDraft>
    ```
    
    **Sample request**

    ```json
    {
        "to":"tharis63@hotmail.com",
        "from":"tharis63@gmail.com",
        "subject":"test",
        "messageBody":"Hi hariprasath",
        "cc":"tharis63@outlook.com",
        "bcc":"tharis63@yahoo.com",
        "id":"154b8c77e551c509",
        "threadId":"154b8c77e551c509"
        "contentType":"text/html; charset=UTF-8"
    }
    ```

### Labels

??? note "listLabels"
     The listLabels operation lists all existing labels. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/labels/list) for more information.

    **Sample configuration**

    ```xml
    </gmail.listLabels>
    ```
    

??? note "readLabel"
    The readLabel operation gets a label's details. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/labels/get) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the label whose details you want to retrieve.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.readLabel>
        <id>{$ctx:id}</id>
    </gmail.readLabel>
    ```
    
    **Sample request**

    ```json
    {
        "id":"Label_1"
    }
    ```

??? note "deleteLabel"
    The deleteLabel operation deletes a label. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/labels/delete) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the label to be deleted.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.deleteLabel>
        <id>{$ctx:id}</id>
    </gmail.deleteLabel>
    ```
    
    **Sample request**

    ```json
    {
        "id":"57648478394803"
    }
    ```

??? note "createLabels"
    The createLabels operation creates a new label. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/labels/create) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>name</td>
            <td>The display name of the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageListVisibility</td>
            <td>The visibility of messages with this label in the message list in the Gmail web interface.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>labelListVisibility</td>
            <td>The visibility of the label in the label list in the Gmail web interface.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The owner type for the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messagesTotal</td>
            <td>The total number of messages with the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messagesUnread</td>
            <td>The number of unread messages with the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>threadsTotal</td>
            <td>The total number of threads with the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>threadsUnread</td>
            <td>The number of unread threads with the label.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.createLabels>
        <name>{$ctx:name}</name>
        <messageListVisibility>{$ctx:messageListVisibility}</messageListVisibility>
        <labelListVisibility>{$ctx:labelListVisibility}</labelListVisibility>
        <type>{$ctx:type}</type>
        <messagesTotal>{$ctx:messagesTotal}</messagesTotal>
        <messagesUnread>{$ctx:messagesUnread}</messagesUnread>
        <threadsTotal>{$ctx:threadsTotal}</threadsTotal>
        <threadsUnread>{$ctx:threadsUnread}</threadsUnread>
    </gmail.createLabels>
    ```
    
    **Sample request**

    ```json
    {
        "name": "TestESB2",
        "threadsUnread": 100,
        "messageListVisibility": "show",
        "threadsTotal": 100,
        "type": "user",
        "messagesTotal": 100,
        "messagesUnread": 100,
        "labelListVisibility": "labelShow"
    }
    ```

??? note "updateLabels"
    The updateLabels operation updates an existing label. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/labels/update) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>name</td>
            <td>The display name of the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageListVisibility</td>
            <td>The visibility of messages with this label in the message list in the Gmail web interface.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>labelListVisibility</td>
            <td>The visibility of the label in the label list in the Gmail web interface.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>type</td>
            <td>The owner type for the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messagesTotal</td>
            <td>The total number of messages with the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messagesUnread</td>
            <td>The number of unread messages with the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>threadsTotal</td>
            <td>The total number of threads with the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>threadsUnread</td>
            <td>The number of unread threads with the label.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the label to update.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.updateLabels>
        <name>{$ctx:name}</name>
        <messageListVisibility>{$ctx:messageListVisibility}</messageListVisibility>
        <labelListVisibility>{$ctx:labelListVisibility}</labelListVisibility>
        <type>{$ctx:type}</type>
        <messagesTotal>{$ctx:messagesTotal}</messagesTotal>
        <messagesUnread>{$ctx:messagesUnread}</messagesUnread>
        <threadsTotal>{$ctx:threadsTotal}</threadsTotal>
        <threadsUnread>{$ctx:threadsUnread}</threadsUnread>
        <id>{$ctx:id}</id>
    </gmail.updateLabels>
    ```
    
    **Sample request**

    ```json
    {
        "id":"426572682792",
        "name": "TestESB2",
        "threadsUnread": 100,
        "messageListVisibility": "show",
        "threadsTotal": 100,
        "type": "user",
        "messagesTotal": 100,
        "messagesUnread": 100,
        "labelListVisibility": "labelShow"
    }
    ```

### Messages

??? note "listAllMails"
    The listAllMails operation lists all messages. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/labels/get) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>includeSpamTrash</td>
            <td>Includes messages from SPAM and TRASH in the results (default: false).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>labelIds</td>
            <td>Only returns messages with labels that match all of the specified label IDs.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>Maximum number of messages to return.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>Page token to retrieve a specific page of results in the list.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>q</td>
            <td>Only returns messages matching the specified query. Supports the same query format as the Gmail search box.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.listAllMails>
        <includeSpamTrash>{$ctx:includeSpamTrash}</includeSpamTrash>
        <labelIds>{$ctx:labelIds}</labelIds>
        <maxResults>{$ctx:maxResults}</maxResults>
        <pageToken>{$ctx:pageToken}</pageToken>
        <q>{$ctx:q}</q>
    </gmail.listAllMails>
    ```
    
    **Sample request**

    ```json
    {
        "maxResults":"10",
        "includeSpamTrash":"true",
        "pageToken":"00965906535058580458",
        "labelIds":"UNREAD",
        "q":"Jira"
    }
    ```

??? note "readMail"
    The readMail operation retrieves a message by its ID. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/messages/get) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the message to retrieve.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The format to return.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>metadataHeaders</td>
            <td>When the format is METADATA, only include the headers specified in this property.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.readMail>
        <id>{$ctx:id}</id>
        <format>{$ctx:format}</format>
        <metadataHeaders>{$ctx:metadataHeaders}</metadataHeaders>
    </gmail.readMail>
    ```
    
    **Sample request**

    ```json
    {
        "id":"14bbb686ba287e1d",
        "format":"minimal"
    }
    ```

??? note "sendMail"
    The sendMail operation sends a plain message. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/messages/send) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>to</td>
            <td>The email address of the recipient of the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>subject</td>
            <td>Subject of the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>from</td>
            <td>The email address of the sender of the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>cc</td>
            <td>The email addresses of recipients who will receive a copy of this message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bcc</td>
            <td>The email addresses of recipients who will privately receive a copy of this message (their email addresses will be hidden).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageBody</td>
            <td>The content of the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>contentType</td>
            <td>If the message body is in the format of html or need to send a rich text then we must give the parameter value as "text/html; charset=UTF-8" otherwise it takes the default value as text/plain.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.sendMail>
        <to>{$ctx:to}</to>
        <subject>{$ctx:subject}</subject>
        <from>{$ctx:from}</from>
        <cc>{$ctx:cc}</cc>
        <bcc>{$ctx:bcc}</bcc>
        <messageBody>{$ctx:messageBody}</messageBody>
        <contentType>{$ctx:contentType}</contentType>
    </gmail.sendMail>
    ```
    
    **Sample request**

    ```json
    {
        "to":"ashalya86@gmail.com",
        "subject":"Hello",
        "cc":"vanii@gamil.com",
        "bcc":"elil@gmail.com",
        "messageBody":"Hello! Thank you for contacting us."
        "contentType":"text/html; charset=UTF-8"
    }
    ```

??? note "modifyExistingMessages"
    The modifyExistingMessages operation modifies an existing message. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/messages/modify) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the message to modify.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>addLabelIds</td>
            <td>A list of IDs of labels to add to this message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>removeLabelIds</td>
            <td>A list of IDs of labels to remove from this message.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.modifyExistingThreads>
        <id>{$ctx:id}</id>
        <addLabelIds>{$ctx:addLabelIds}</addLabelIds>
        <removeLabelIds>{$ctx:removeLabelIds}</removeLabelIds>
    </gmail.modifyExistingThreads>
    ```
    
    **Sample request**

    ```json
    {
        "id":"14ba5cd56fcb61ee",
        "addLabelIds": [
            "Label_33",
            "Label_24"],
        "removeLabelIds": [
            "Label_28",
            "Label_31"]
    }
    ```

??? note "trashMessages"
    The trashMessages operation sends a message to the trash. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/messages/trash) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the message to send to trash.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.trashMessages>
        <id>{$ctx:id}</id>
    </gmail.trashMessages>
    ```
    
    **Sample request**

    ```json
    {
        "id":"4647683792802"
    }
    ```

??? note "unTrashMessages"
    The unTrashMessages operation removes a message from trash. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/messages/untrash) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the message to untrash.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.unTrashMessages>
        <id>{$ctx:id}</id>
    </gmail.unTrashMessages>
    ```
    
    **Sample request**

    ```json
    {
        "id":"4647683792802"
    }
    ```

??? note "deleteMessages"
    The deleteMessages operation permanently deletes a message. The message cannot be recovered after it is deleted. You can use trashMessages instead if you do not want to permanently delete the message. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/messages/delete) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the message to untrash.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.deleteMessages>
        <id>{$ctx:id}</id>
    </gmail.deleteMessages>
    ```
    
    **Sample request**

    ```json
    {
        "id":"4647683792802"
    }
    ```

??? note "sendMailWithAttachment"
    The sendMailWithAttachment operation sends a message with attachments. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/messages/send) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>to</td>
            <td>The email addresses of the recipients of the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>subject</td>
            <td>Subject of the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>cc</td>
            <td>The email addresses of recipients who will receive a copy of this message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>bcc</td>
            <td>The email addresses of recipients who will privately receive a copy of this message (their email addresses will be hidden).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fileName</td>
            <td>A comma-seperated list of file names of the attachments you want to include with the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>filePath</td>
            <td>A comma-seperated list of file paths of the attachments you want to include with the message.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>messageBody</td>
            <td>Content of the message.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.sendMailWithAttachment>
        <subject>{$ctx:subject}</subject>
        <to>{$ctx:to}</to>
        <cc>{$ctx:cc}</cc>
        <bcc>{$ctx:bcc}</bcc>
        <messageBody>{$ctx:messageBody}</messageBody>
        <fileName>{$ctx:fileName}</fileName>
        <filePath>{$ctx:filePath}</filePath>
    </gmail.sendMailWithAttachment>
    ```
    
    **Sample request**

    ```json
    {
        "subject":"WSO2 Gmail Connector",
        "to":"hmrajas1990@gmail.com",
        "cc":"hmrajas1990@gmail.com",
        "bcc":"rajjaz@wso2.com",
        "messageBody":"Welcome to WSO2 ESB Gmail Connector!!!!!",
        "fileName":"/home/rajjaz/Documents/ESB/esb-connector-gmail/src/test/resources/artifacts/ESB/config/smile.png",
        "filePath":"smile.png"
    }
    ```

### Threads

??? note "listAllThreads"
    The listAllThreads operation lists all the existing email threads. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/threads/list) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>includeSpamTrash</td>
            <td>Include messages from SPAM and TRASH in the results (default: false).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>labelIds</td>
            <td>Only returns threads with labels that match all of the specified label IDs.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>Maximum number of messages to return.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>Page token to retrieve a specific page of results in the list.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>q</td>
            <td>Only returns messages matching the specified query. Supports the same query format as the Gmail search box.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.listAllThreads>
        <includeSpamTrash>{$ctx:includeSpamTrash}</includeSpamTrash>
        <labelIds>{$ctx:labelIds}</labelIds>
        <maxResults>{$ctx:maxResults}</maxResults>
        <pageToken>{$ctx:pageToken}</pageToken>
        <q>{$ctx:q}</q>
    </gmail.listAllThreads>
    ```
    
    **Sample request**

    ```json
    {
        "maxResults":"10",
        "includeSpamTrash":"true",
        "pageToken":"00965906535058580458",
        "labelIds":"UNREAD",
        "q":"Jira"
    }
    ```

??? note "readThread"
    The readThread operation retrieves an existing thread. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/threads/get) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the thread to retrieve.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>format</td>
            <td>The format in which to return the messages in the thread.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>metadataHeaders</td>
            <td>When the format is METADATA, only include the headers specified with this property.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.readThread>
        <id>{$ctx:id}</id>
        <format>{$ctx:format}</format>
        <metadataHeaders>{$ctx:metadataHeaders}</metadataHeaders>
    </gmail.readThread>
    ```
    
    **Sample request**

    ```json
    {
        "id":"14bbb686ba287e1d",
        "format":"minimal"
    }
    ```

??? note "trashThreads"
    The trashThreads operation sends a thread to the trash. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/threads/trash) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the thread to trash.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.trashThreads>
        <id>{$ctx:id}</id>
    </gmail.trashThreads>
    ```
    
    **Sample request**

    ```json
    {
        "id":"14bbb686ba287e1d"
    }
    ```

??? note "unTrashThreads"
    The unTrashThreads operation removes a thread from the trash. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/threads/untrash) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the thread to untrash.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.unTrashThreads>
        <id>{$ctx:id}</id>
    </gmail.unTrashThreads>
    ```
    
    **Sample request**

    ```json
    {
        "id":"14bbb686ba287e1d"
    }
    ```

??? note "modifyExistingThreads"
    The modifyExistingThreads operation modifies an existing thread. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/threads/modify) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>The ID of the thread to modify.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>addLabelIds</td>
            <td>A list of IDs of labels to add to this thread.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>removeLabelIds</td>
            <td>A list of IDs of labels to remove from this thread.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.modifyExistingThreads>
        <id>{$ctx:id}</id>
        <addLabelIds>{$ctx:addLabelIds}</addLabelIds>
        <removeLabelIds>{$ctx:removeLabelIds}</removeLabelIds>
    </gmail.modifyExistingThreads>
    ```
    
    **Sample request**

    ```json
    {
        "id":"14b31c7af7b778f4",
        "addLabelIds": [
            "Label_33",
            "Label_24"],
        "removeLabelIds": [
            "Label_28",
            "Label_31"]
    }
    ```

### User History

??? note "listTheHistory"
    The listTheHistory operation lists the history of changes to the user's mailbox. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/history/list) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>startHistoryId</td>
            <td>Returns history records after the specified startHistoryId.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of history records to return.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>pageToken</td>
            <td>Page token to retrieve a specific page of results in the list.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <gmail.listTheHistory>
        <startHistoryId>{$ctx:startHistoryId}</startHistoryId>
        <labelId>{$ctx:labelId}</labelId>
        <maxResults>{$ctx:maxResults}</maxResults>
        <pageToken>{$ctx:pageToken}</pageToken>
    </gmail.listTheHistory>
    ```
    
    **Sample request**

    ```json
    {
        "startHistoryId":"7399652",
        "labelId":"Label_31",
        "maxResults":"10"
    }
    ```

### User Profiles

??? note "getUserProfile"
    The getUserProfile operation lists all details about the user's profile. See the [related API documentation](https://developers.google.com/gmail/api/v1/reference/users/getProfile) for more information.

    **Sample configuration**

    ```xml
    <gmail.getUserProfile/>
    ```

### Sample configuration in a scenario

The following is a sample proxy service that illustrates how to connect to Gmail with the init operation and use the listDrafts operation. The sample request for this proxy can be found in listDrafts sample request. You can use this sample as a template for using other operations in this category.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="gmail_listDrafts"
       transports="https,http"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
    <target>
        <target>
        <inSequence>
            <property name="maxResults" expression="json-eval($.maxResults)"/>
            <property name="pageToken" expression="json-eval($.pageToken)"/>
            <property name="userId" expression="json-eval($.userId)"/>
            <property name="refreshToken" expression="json-eval($.refreshToken)"/>
            <property name="clientId" expression="json-eval($.clientId)"/>
            <property name="clientSecret" expression="json-eval($.clientSecret)"/>
            <property name="accessToken" expression="json-eval($.accessToken)"/>
            <property name="registryPath" expression="json-eval($.registryPath)"/>
            <property name="apiUrl" expression="json-eval($.apiUrl)"/>
            <gmail.init>
                <userId>{$ctx:userId}</userId>
                <refreshToken>{$ctx:refreshToken}</refreshToken>
                <clientSecret>{$ctx:clientSecret}</clientSecret>
                <clientId>{$ctx:clientId}</clientId>
                <registryPath>{$ctx:registryPath}</registryPath>
                <accessToken>{$ctx:accessToken}</accessToken>
                <apiUrl>{$ctx:apiUrl}</apiUrl>
            </gmail.init>
            <gmail.listDrafts>
                <maxResults>{$ctx:maxResults}</maxResults>
                <pageToken>{$ctx:pageToken}</pageToken>
            </gmail.listDrafts>
            <respond/>
        </inSequence>
        <outSequence>
            <log/>
            <send/>
        </outSequence>
    </target>
    <parameter name="serviceType">proxy</parameter>
    <description/>
</proxy>
```

The following is a sample proxy service that illustrates how to connect to Gmail with the init operation and use the readLabel operation. The sample request for this proxy can be found in readLabel sample request. You can use this sample as a template for using other operations in this category.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="gmail_listLabels"
       transports="https,http"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
        <target>
        <inSequence>
            <property name="id" expression="json-eval($.id)"/>
            <property name="format" expression="json-eval($.format)"/>
            <property name="metadataHeaders" expression="json-eval($.metadataHeaders)"/>
            <property name="userId" expression="json-eval($.userId)"/>
            <property name="refreshToken" expression="json-eval($.refreshToken)"/>
            <property name="clientId" expression="json-eval($.clientId)"/>
            <property name="clientSecret" expression="json-eval($.clientSecret)"/>
            <property name="accessToken" expression="json-eval($.accessToken)"/>
            <property name="registryPath" expression="json-eval($.registryPath)"/>
            <property name="apiUrl" expression="json-eval($.apiUrl)"/>
            <gmail.init>
                <userId>{$ctx:userId}</userId>
                <refreshToken>{$ctx:refreshToken}</refreshToken>
                <clientSecret>{$ctx:clientSecret}</clientSecret>
                <clientId>{$ctx:clientId}</clientId>
                <registryPath>{$ctx:registryPath}</registryPath>
                <accessToken>{$ctx:accessToken}</accessToken>
                <apiUrl>{$ctx:apiUrl}</apiUrl>
            </gmail.init>
            <gmail.readLabel>
              <id>{$ctx:id}</id>
            </gmail.readLabel>
            <respond/>
        </inSequence>
        <outSequence>
            <log/>
            <send/>
        </outSequence>
    </target>
    <parameter name="serviceType">proxy</parameter>
    <description/>
</proxy>
```

The following is a sample proxy service that illustrates how to connect to Gmail with the init operation and use the listAllMails operation. The sample request for this proxy can be found in listAllMails sample request. You can use this sample as a template for using other operations in this category.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="gmail_listAllMails"
       transports="https,http"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
    <target>
        <inSequence>
            <property name="includeSpamTrash" expression="json-eval($.includeSpamTrash)"/>
            <property name="labelIds" expression="json-eval($.labelIds)"/>
            <property name="maxResults" expression="json-eval($.maxResults)"/>
            <property name="pageToken" expression="json-eval($.pageToken)"/>
            <property name="q" expression="json-eval($.q)"/>
            <property name="userId" expression="json-eval($.userId)"/>
            <property name="refreshToken" expression="json-eval($.refreshToken)"/>
            <property name="clientId" expression="json-eval($.clientId)"/>
            <property name="clientSecret" expression="json-eval($.clientSecret)"/>
            <property name="accessToken" expression="json-eval($.accessToken)"/>
            <property name="registryPath" expression="json-eval($.registryPath)"/>
            <property name="apiUrl" expression="json-eval($.apiUrl)"/>
            <gmail.init>
                <userId>{$ctx:userId}</userId>
                <refreshToken>{$ctx:refreshToken}</refreshToken>
                <clientSecret>{$ctx:clientSecret}</clientSecret>
                <clientId>{$ctx:clientId}</clientId>
                <registryPath>{$ctx:registryPath}</registryPath>
                <accessToken>{$ctx:accessToken}</accessToken>
                <apiUrl>{$ctx:apiUrl}</apiUrl>
            </gmail.init>
            <gmail.listAllMails>
                <includeSpamTrash>{$ctx:includeSpamTrash}</includeSpamTrash>
                <labelIds>{$ctx:labelIds}</labelIds>
                <maxResults>{$ctx:maxResults}</maxResults>
                <pageToken>{$ctx:pageToken}</pageToken>
                <q>{$ctx:q}</q>
            </gmail.listAllMails>
            <respond/>
        </inSequence>
        <outSequence>
            <log/>
            <send/>
        </outSequence>
    </target>
    <parameter name="serviceType">proxy</parameter>
    <description/>
</proxy>
```

The following is a sample proxy service that illustrates how to connect to Gmail with the init operation and use the listAllThreads operation. The sample request for this proxy can be found in listAllThreads sample request. You can use this sample as a template for using other operations in this category.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="gmail_listAllThreads"
       transports="https,http"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
    <target>
        <inSequence>
            <property name="includeSpamTrash" expression="json-eval($.includeSpamTrash)"/>
            <property name="labelIds" expression="json-eval($.labelIds)"/>
            <property name="maxResults" expression="json-eval($.maxResults)"/>
            <property name="pageToken" expression="json-eval($.pageToken)"/>
            <property name="q" expression="json-eval($.q)"/>
            <property name="userId" expression="json-eval($.userId)"/>
            <property name="refreshToken" expression="json-eval($.refreshToken)"/>
            <property name="clientId" expression="json-eval($.clientId)"/>
            <property name="clientSecret" expression="json-eval($.clientSecret)"/>
            <property name="accessToken" expression="json-eval($.accessToken)"/>
            <property name="registryPath" expression="json-eval($.registryPath)"/>
            <property name="apiUrl" expression="json-eval($.apiUrl)"/>
            <gmail.init>
                <userId>{$ctx:userId}</userId>
                <refreshToken>{$ctx:refreshToken}</refreshToken>
                <clientSecret>{$ctx:clientSecret}</clientSecret>
                <clientId>{$ctx:clientId}</clientId>
                <registryPath>{$ctx:registryPath}</registryPath>
                <accessToken>{$ctx:accessToken}</accessToken>
                <apiUrl>{$ctx:apiUrl}</apiUrl>
            </gmail.init>
            <gmail.listAllThreads>
                <includeSpamTrash>{$ctx:includeSpamTrash}</includeSpamTrash>
                <labelIds>{$ctx:labelIds}</labelIds>
                <maxResults>{$ctx:maxResults}</maxResults>
                <pageToken>{$ctx:pageToken}</pageToken>
                <q>{$ctx:q}</q>
            </gmail.listAllThreads>
            <respond/>
        </inSequence>
        <outSequence>
            <log/>
            <send/>
        </outSequence>
    </target>
    <parameter name="serviceType">proxy</parameter>
    <description/>
</proxy>
```

The following is a sample proxy service that illustrates how to connect to Gmail with the init operation and use the listTheHistory operation. The sample request for this proxy can be found in listTheHistory sample request.

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="gmail_listTheHistory"
       transports="https,http"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
    <target>
        <inSequence>
            <property name="startHistoryId" expression="json-eval($.startHistoryId)"/>
            <property name="labelId" expression="json-eval($.labelId)"/>
            <property name="maxResults" expression="json-eval($.maxResults)"/>
            <property name="pageToken" expression="json-eval($.pageToken)"/>
            <property name="userId" expression="json-eval($.userId)"/>
            <property name="refreshToken" expression="json-eval($.refreshToken)"/>
            <property name="clientId" expression="json-eval($.clientId)"/>
            <property name="clientSecret" expression="json-eval($.clientSecret)"/>
            <property name="accessToken" expression="json-eval($.accessToken)"/>
            <property name="registryPath" expression="json-eval($.registryPath)"/>
            <property name="apiUrl" expression="json-eval($.apiUrl)"/>
            <gmail.init>
                <userId>{$ctx:userId}</userId>
                <refreshToken>{$ctx:refreshToken}</refreshToken>
                <clientSecret>{$ctx:clientSecret}</clientSecret>
                <clientId>{$ctx:clientId}</clientId>
                <registryPath>{$ctx:registryPath}</registryPath>
                <accessToken>{$ctx:accessToken}</accessToken>
                <apiUrl>{$ctx:apiUrl}</apiUrl>
            </gmail.init>
            <gmail.listTheHistory>
                <startHistoryId>{$ctx:startHistoryId}</startHistoryId>
                <labelId>{$ctx:labelId}</labelId>
                <maxResults>{$ctx:maxResults}</maxResults>
                <pageToken>{$ctx:pageToken}</pageToken>
            </gmail.listTheHistory>
            <respond/>
        </inSequence>
        <outSequence>
            <log/>
            <send/>
        </outSequence>
    </target>
    <parameter name="serviceType">proxy</parameter>
    <description/>
</proxy>
```

The following is a sample proxy service that illustrates how to connect to Gmail with the init operation and use the getUserProfile operation. The sample request for this proxy can be found in listTheProfile sample request. 

```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="gmail_getUserProfile"
       transports="https,http"
       statistics="disable"
       trace="disable"
       startOnLoad="true">
    <target>
        <inSequence>
            <property name="userId" expression="json-eval($.userId)"/>
            <property name="refreshToken" expression="json-eval($.refreshToken)"/>
            <property name="clientId" expression="json-eval($.clientId)"/>
            <property name="clientSecret" expression="json-eval($.clientSecret)"/>
            <property name="accessToken" expression="json-eval($.accessToken)"/>
            <property name="registryPath" expression="json-eval($.registryPath)"/>
            <property name="apiUrl" expression="json-eval($.apiUrl)"/>
                <gmail.init>
                    <userId>{$ctx:userId}</userId>
                    <refreshToken>{$ctx:refreshToken}</refreshToken>
                    <clientSecret>{$ctx:clientSecret}</clientSecret>
                    <clientId>{$ctx:clientId}</clientId>
                    <registryPath>{$ctx:registryPath}</registryPath>
                    <accessToken>{$ctx:accessToken}</accessToken>
                    <apiUrl>{$ctx:apiUrl}</apiUrl>
                 </gmail.init>
                 <gmail.getUserProfile/>
             <respond/>
        </inSequence>
        <outSequence>
            <log/>
            <send/>
        </outSequence>
    </target>
    <parameter name="serviceType">proxy</parameter>
    <description/>
</proxy>
```