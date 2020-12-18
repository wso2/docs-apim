# Salesforce SOAP Connector Reference

The following operations allow you to work with the Salesforce SOAP Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Salesforce SOAP connector, add the `<salesforcerest.init>` element in your configuration before carrying out any other Salesforce SOAP operations. 

??? note "salesforcebulk.init"
    The salesforcerest.init operation initializes the connector to interact with the Salesforce SOAP API. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_quickstart_intro.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>username</td>
            <td>The username to access the Salesforce account.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>password</td>
            <td>The password provided here is a concatenation of the user password and the security token provided by Salesforce.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>loginUrl</td>
            <td>The login URL to access the Salesforce account.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>blocking</td>
            <td>Indicates whether the connector needs to perform blocking invocations to Salesforce. (Supported in WSO2 ESB 4.9.0 and later.)</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforce.init>
        <loginUrl>{$ctx:loginUrl}</loginUrl>
        <username>{$ctx:username}</username>
        <password>{$ctx:password}</password>
        <blocking>{$ctx:blocking}</blocking>
     </salesforce.init>
    ```

    **Sample request**

    ```xml
    <salesforce.init>
        <username>MyUsername</username>
        <password>MyPassword</password>
        <loginUrl>https://login.salesforce.com/services/Soap/u/42.0</loginUrl>
        <blocking>false</blocking>
    </salesforce.init>
    ```
---

## Working with emails
    
??? note "emails"
    The salesforcebulk.emails method creates and sends an email using Salesforce based on the properties that you specify. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_sendemail.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>sendEmail</td>
            <td>XML representation of the email.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.sendEmail>
        <sendEmail xmlns:sfdc="sfdc">{//sfdc:emailWrapper}</sendEmail>
    </salesforce.sendEmail>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the sendEmail operation.
    
    ```xml
    <payloadFactory>
       <format>
         <sfdc:emailWrapper xmlns:sfdc="sfdc">
         <sfdc:messages type="urn:SingleEmailMessage">
            <sfdc:bccSender>true</sfdc:bccSender>
            <sfdc:emailPriority>High</sfdc:emailPriority>
            <sfdc:replyTo>123@gmail.com</sfdc:replyTo>
            <sfdc:saveAsActivity>false</sfdc:saveAsActivity>
            <sfdc:senderDisplayName>wso2</sfdc:senderDisplayName>
            <sfdc:subject>test</sfdc:subject>
            <sfdc:useSignature>false</sfdc:useSignature>
           <sfdc:targetObjectId>00390000001PBFn</sfdc:targetObjectId>
           <sfdc:plainTextBody>Hello, this is a holiday greeting!</sfdc:plainTextBody>    
         </sfdc:messages>
          </sfdc:emailWrapper>
        </format>
        <args/>
    </payloadFactory>
              
    <salesforce.sendEmail>
        <sendEmail xmlns:sfdc="sfdc">{//sfdc:emailWrapper}</sendEmail>
    </salesforce.sendEmail>
    ```
    **Sample response**
        
    Given below is a sample response for the sendEmail operation.
            
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>67</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <sendEmailResponse>
                <result>
                    <success>true</success>
                </result>
            </sendEmailResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```    
        
??? note "sendEmailMessage"
    The salesforcebulk.sendEmailMessage method sends emails that have already been drafted in Salesforce. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_send_email_message.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>sendEmailMessage</td>
            <td>XML representation of the email IDs to send.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.sendEmailMessage config-ref="connectorConfig">
        <sendEmailMessage xmlns:sfdc="sfdc">{//sfdc:emails}</sendEmailMessage>
    </salesforce.sendEmailMessage>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the sendEmailMessage operation.
        
    ```xml
    <payloadFactory>
        <format>
            <sfdc:emails xmlns:sfdc="sfdc">
                <sfdc:Ids>0019000000aaMkK</sfdc:Ids>
                <sfdc:Ids>0019000000bbMkK</sfdc:Ids>
            </sfdc:emails>
        </format>
        <args/>
    </payloadFactory>
     
    <salesforce.sendEmailMessage config-ref="connectorConfig">
        <sendEmailMessage xmlns:sfdc="sfdc">{//sfdc:emails}</sendEmailMessage>
    </salesforce.sendEmailMessage>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the sendEmail operation.
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>67</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <sendEmailResponse>
                <result>
                    <success>true</success>
                </result>
            </sendEmailResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```      
    
---

## Working with records

??? note "salesforcebulk.create"
    The salesforcerest.create operation creates one or more record with the Salesforce SOAP API. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_create.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>allOrNone</td>
            <td>Whether to rollback changes if an object fails (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>allowFieldTruncate</td>
            <td>Whether to truncate strings that exceed the field length (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sobjects</td>
            <td>XML representation of the records to add.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforce.create configKey="MySFConfig">
        <allOrNone>0</allOrNone>
        <allowFieldTruncate>0</allowFieldTruncate>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.create>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the create operation.    

    ```xml
    <payloadFactory>
        <format>
           <sfdc:sObjects xmlns:sfdc="sfdc" type="Account">
              <sfdc:sObject>
                  <sfdc:Name>wso2123</sfdc:Name>
               </sfdc:sObject>
               <sfdc:sObject>
                 <sfdc:Name>abc123</sfdc:Name>
               </sfdc:sObject>
            </sfdc:sObjects>
        </format>
        <args/>
    </payloadFactory>
     
    <salesforce.create>
        <allOrNone>0</allOrNone>
        <allowFieldTruncate>0</allowFieldTruncate>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.create>
    ```
    **Sample response**    
        
    Given below is a sample response that can be handled by the create operation
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>9</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <createResponse>
                <result>
                    <id>0036F00002mdwl2QAA</id>
                    <success>true</success>
                </result>
            </createResponse>
        </soapenv:Body>
    </soapenv:Envelope>    
    ```
    
??? note "salesforcebulk.update"
    The salesforcerest.update operation updates one or more existing records with the Salesforce SOAP API. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_update.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>allOrNone</td>
            <td>Whether to rollback changes if an object fails (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>allowFieldTruncate</td>
            <td>Whether to truncate strings that exceed the field length (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sobjects</td>
            <td>XML representation of the records to add.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforce.update configKey="MySFConfig">
        <allOrNone>0</allOrNone>
        <allowFieldTruncate>0</allowFieldTruncate>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.update>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the create operation.
    

    ```xml
    <payloadFactory>
        <format>
            <sfdc:sObjects xmlns:sfdc="sfdc" type="Account">
              <sfdc:sObject>
                 <sfdc:Id>0019000000aaMkZ</sfdc:Id>
                 <sfdc:Name>newname01</sfdc:Name>
              </sfdc:sObject>
              <sfdc:sObject>
                 <sfdc:Id>0019000000aaMkP</sfdc:Id>
                 <sfdc:Name>newname02</sfdc:Name>
              </sfdc:sObject>
           </sfdc:sObjects>
        </format>
        <args/>
    </payloadFactory>
     
    <salesforce.update>
        <allOrNone>0</allOrNone>
        <allowFieldTruncate>0</allowFieldTruncate>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.update>
    ```
    **Sample response**
        
    Given below is a sample response that can be handled by the update operation.
        
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>53</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <updateResponse>
                <result>
                    <id>0016F00002S4Wj0QAF</id>
                    <success>true</success>
                </result>
            </updateResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
    
??? note "salesforcebulk.upsert"
    The salesforcerest.upsert operation update existing records and insert new records in a single operation, with the Salesforce SOAP API. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_upsert.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>allOrNone</td>
            <td>Whether to rollback changes if an object fails (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>allowFieldTruncate</td>
            <td>Whether to truncate strings that exceed the field length (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>externalId</td>
            <td>The field containing the record ID, that is used by Salesforce to determine whether to update an existing record or create a new one. This is done by matching the ID to the record IDs in Salesforce. By default, the field is assumed to be named "Id".</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sObjects</td>
            <td>XML representation of the records to update and insert. When inserting a new record, you do not specify sfdc:Id.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforce.upsert configKey="MySFConfig">
        <allOrNone>0</allOrNone>
        <allowFieldTruncate>0</allowFieldTruncate>
        <externalId>Id</externalId>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.upsert>
    ```
    **Sample request**    
    
    Set the externalId field : If you need to give any existing externalId field of sObject to externalId then the payload should be with that externalId field and value as follows in sample. 
    
    Sample to set ExternalId field and value
    
    ```xml
    <payloadFactory>
        <format>
            <sfdc:sObjects xmlns:sfdc="sfdc" type="Account">
              <sfdc:sObject>
                 <sfdc:sample__c>{any value}</sfdc:sample__c>
                 <sfdc:Name>newname001</sfdc:Name>
              </sfdc:sObject>
           </sfdc:sObjects>
        </format>
        <args/>
    </payloadFactory>
     
    <salesforce.upsert>
        <allOrNone>0</allOrNone>
        <allowFieldTruncate>0</allowFieldTruncate>
        <externalId>sample__c</externalId>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.upsert>
    ```    
    Given below is a sample request that can be handled by the create operation.    

    ```xml
    <payloadFactory>
        <format>
            <sfdc:sObjects xmlns:sfdc="sfdc" type="Account">
              <sfdc:sObject>
                 <sfdc:Id>0019000000aaMkZ</sfdc:Id>
                 <sfdc:Name>newname001</sfdc:Name>
              </sfdc:sObject>
              <sfdc:sObject>
                 <sfdc:Name>newname002</sfdc:Name>
              </sfdc:sObject>
           </sfdc:sObjects>
        </format>
        <args/>
    </payloadFactory>
     
    <salesforce.upsert>
        <allOrNone>0</allOrNone>
        <allowFieldTruncate>0</allowFieldTruncate>
        <externalId>Id</externalId>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.upsert>
    ```
    
    **Sample response**
            
    Given below is a sample response that can be handled by the upsert operation.
            
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>54</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <upsertResponse>
                <result>
                    <created>false</created>
                    <id>0016F00002S4Wj0QAF</id>
                    <success>true</success>
                </result>
                <result>
                    <created>true</created>
                    <id>0016F00002pUVTMQA4</id>
                    <success>true</success>
                </result>
            </upsertResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
               
??? note "salesforcebulk.search"
    The salesforcerest.search operation searchs for records, use salesforce.search and specify the search string. If you already know the record IDs, use retrieve instead. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_search.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>searchString</td>
            <td>The SQL query to use to search for records.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforce.search configKey="MySFConfig">
        <searchString>FIND {map*} IN ALL FIELDS RETURNING Account (Id, Name), Contact, Opportunity, Lead</searchString>
    </salesforce.search>
    ```
    **Sample response**
                
    Given below is a sample response that can be handled by the search operation.
                
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:sf="urn:sobject.partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>56</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <searchResponse>
                <result>
                    <searchRecords>
                        <record xsi:type="sf:sObject">
                            <sf:type>Account</sf:type>
                            <sf:Id>0016F00002SN7qiQAD</sf:Id>
                            <sf:Id>0016F00002SN7qiQAD</sf:Id>
                            <sf:Name>GenePoint</sf:Name>
                        </record>
                    </searchRecords>
                </result>
            </searchResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```    
    
??? note "salesforcebulk.query"
    The salesforcerest.query operation retrieve data from an object, use salesforce.query with the Salesforce SOAP API. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_query.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>batchSize</td>
            <td>The number of records to return. If more records are available than the batch size, you can use the queryMore operation to get additional results.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>queryString</td>
            <td>The SQL query to use to search for records.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    Note : If you want your search results to include deleted records that are available in the Recycle Bin, use salesforce.queryAll in place of salesforce.query.

    ```xml
    <salesforce.query configKey="MySFConfig">
        <batchSize>200</batchSize>
        <queryString>select id,name from Account</queryString>
    </salesforce.query>
    ```

    **Sample request**
    
    Following is a sample configuration to query records. It also illustrates the use of queryMore operation to get additional results:
      

    ```xml
    <salesforce.query>
        <batchSize>200</batchSize>
        <queryString>select id,name from Account</queryString>
    </salesforce.query>
    <!-- Execute the following to get the other batches -->
    <iterate xmlns:sfdc="http://wso2.org/salesforce/adaptor" continueParent="true" expression="//sfdc:iterator">
        <target>
            <sequence>
                <salesforce.queryMore>
                    <batchSize>200</batchSize>
                </salesforce.queryMore>
            </sequence>
        </target>
    </iterate>
    ```
    **Sample response**
        
    Given below is a sample response for the query operation.
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:sf="urn:sobject.partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>58</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <queryResponse>
                <result xsi:type="QueryResult">
                    <done>true</done>
                    <queryLocator xsi:nil="true"/>
                    <records xsi:type="sf:sObject">
                        <sf:type>Account</sf:type>
                        <sf:Id>0016F00002SasNYQAZ</sf:Id>
                        <sf:Id>0016F00002SasNYQAZ</sf:Id>
                        <sf:Name>wso2New</sf:Name>
                    </records>
                    .
                    .
                    <size>129</size>
                </result>
            </queryResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
    
??? note "salesforcebulk.retrieve"
    The salesforcerest.retrieve operation IDs of the records you want to retrieve with the Salesforce SOAP API.  If you do not know the record IDs, use query instead. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_retrieve.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>fieldList</td>
            <td>A comma-separated list of the fields you want to retrieve from the records.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>objectType</td>
            <td> The object type of the records.</td>
            <td>Yes</td>
        </tr>
        <tr>
           <td>sobjects</td>
           <td>XML representation of the records to retrieve.</td>
           <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.retrieve configKey="MySFConfig">
        <fieldList>id,name</fieldList>
        <objectType>Account</objectType>
        <objectIDS xmlns:sfdc="sfdc">{//sfdc:sObjects}</objectIDS>
    </salesforce.retrieve>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the retrieve operation.
         

    ```xml
    <payloadFactory>
       <format>
          <sfdc:sObjects xmlns:sfdc="sfdc">
             <sfdc:Ids>0019000000aaMkK</sfdc:Ids>
             <sfdc:Ids>0019000000aaMjl</sfdc:Ids>
          </sfdc:sObjects>
       </format>
       <args/>
    </payloadFactory>
     
    <salesforce.retrieve configKey="MySFConfig">
        <fieldList>id,name</fieldList>
        <objectType>Account</objectType>
        <objectIDS xmlns:sfdc="sfdc">{//sfdc:sObjects}</objectIDS>
    </salesforce.retrieve>
    ```
    **Sample response**
            
    Given below is a sample response for the retrieve operation.
        
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:sf="urn:sobject.partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>60</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <retrieveResponse>
                <result xsi:type="sf:sObject">
                    <sf:type>Account</sf:type>
                    <sf:Id>0016F00002S4Wj0QAF</sf:Id>
                    <sf:Id>0016F00002S4Wj0QAF</sf:Id>
                    <sf:Name>newname01</sf:Name>
                </result>
            </retrieveResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
        
??? note "salesforcebulk.delete"
    The salesforcerest.delete operation delete one or more records. If you do not know the record IDs, use query instead. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_delete.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>allOrNone</td>
            <td>Whether to rollback changes if an object fails (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sobjects</td>
            <td>XML representation of the records to delete, as shown in the following example.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.delete configKey="MySFConfig">
       <allOrNone>0</allOrNone>
       <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.delete>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the delete operation.
         

    ```xml
    <payloadFactory>
       <format>
         <sfdc:sObjects xmlns:sfdc="sfdc">
             <sfdc:Ids>0019000000aaMkZ</sfdc:Ids>
             <sfdc:Ids>0019000000aaMkP</sfdc:Ids>
          </sfdc:sObjects>
       </format>
       <args/>
    </payloadFactory>
     
    <salesforce.delete>
       <allOrNone>0</allOrNone>
       <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.delete>
    ```   
    **Sample response**
        
    Given below is a sample response that can be handled by the delete operation.
             
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>63</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <deleteResponse>
                <result>
                    <id>0016F00002S4Wj0QAF</id>
                    <success>true</success>
                </result>
            </deleteResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```   
    
??? note "salesforcebulk.undelete"
    The salesforcerest.undelete operation restore records that were previously deleted. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_undelete.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>allOrNone</td>
            <td>Whether to rollback changes if an object fails (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sobjects</td>
            <td>XML representation of the records to delete, as shown in the following example.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.undelete configKey="MySFConfig">
        <allOrNone>0</allOrNone>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.undelete>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the undelete operation.
             

    ```xml
    <payloadFactory>
       <format>
          <sfdc:sObjects xmlns:sfdc="sfdc">
             <sfdc:Ids>0019000000aaMkZ</sfdc:Ids>
             <sfdc:Ids>0019000000aaMkP</sfdc:Ids>
          </sfdc:sObjects>
        </format>
        <args/>
    </payloadFactory>
     
    <salesforce.undelete>
        <allOrNone>0</allOrNone>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.undelete>
    ```
    **Sample response**
        
    Given below is a sample response that can be handled by the undelete operation.
                 
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>64</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <undeleteResponse>
                <result>
                    <id>0016F00002S4Wj0QAF</id>
                    <success>true</success>
                </result>
            </undeleteResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```    
        
??? note "salesforcebulk.getDeleted"
    The salesforcerest.getDeleted operation retrieve the list of records that were previously deleted. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_getdeleted.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>sObjectType</td>
            <td>sObjectType from which we need to retrieve deleted records</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>startDate</td>
            <td>start date and time for deleted records lookup</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>endDate</td>
            <td>end date and time for deleted records lookup</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.getDeleted configKey="MySFConfig">
        <sObjectType>{$ctx:sObjectType}</sObjectType>
        <startDate>{$ctx:startDate}</startDate>
        <endDate>{$ctx:endDate}</endDate>
    </salesforce.getDeleted>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getDeleted operation.
                

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:urn="wso2.connector.salesforce">
        <soapenv:Header/>
        <soapenv:Body>
            <urn:loginUrl>https://login.salesforce.com/services/Soap/u/30.0</urn:loginUrl>
            <urn:username>XXXXXXXXXX</urn:username>
            <urn:password>XXXXXXXXXX</urn:password>
            <urn:blocking>false</urn:blocking>
            <urn:sObjectType>Account</urn:sObjectType>
            <urn:startDate>2020-06-15T05:05:53+0000</urn:startDate>
            <urn:endDate>2020-06-30T05:05:53+0000</urn:endDate>
        </soapenv:Body>
    </soapenv:Envelope> 
    ```       
    **Sample response**
        
    Given below is a sample response that can be handled by the getDeleted operation.
                    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>55</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <getDeletedResponse>
                <result>
                    <deletedRecords>
                        <deletedDate>2020-06-18T04:10:20.000Z</deletedDate>
                        <id>0012x000007RqnHAAS</id>
                    </deletedRecords>
                    <earliestDateAvailable>2020-04-27T13:43:00.000Z</earliestDateAvailable>
                    <latestDateCovered>2020-06-30T05:05:00.000Z</latestDateCovered>
                </result>
            </getDeletedResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
    
??? note "salesforcebulk.getUpdated"
    The salesforcerest.getUpdated operation retrieve the list of records that were previously updated. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_getupdated.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>sObjectType</td>
            <td>sObjectType from which we need to retrieve deleted records</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>startDate</td>
            <td>start date and time for deleted records lookup</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>endDate</td>
            <td>end date and time for deleted records lookup</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.getUpdated configKey="MySFConfig">
        <sObjectType>{$ctx:sObjectType}</sObjectType>
        <startDate>{$ctx:startDate}</startDate>
        <endDate>{$ctx:endDate}</endDate>
    </salesforce.getUpdated>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getUpdated operation.
                   

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:urn="wso2.connector.salesforce">
        <soapenv:Header/>
        <soapenv:Body>
            <urn:loginUrl>https://login.salesforce.com/services/Soap/u/30.0</urn:loginUrl>
            <urn:username>XXXXXXXXXX</urn:username>
            <urn:password>XXXXXXXXXX</urn:password>
            <urn:blocking>false</urn:blocking>
            <urn:sObjectType>Account</urn:sObjectType>
            <urn:startDate>2020-06-15T05:05:53+0000</urn:startDate>
            <urn:endDate>2020-06-30T05:05:53+0000</urn:endDate>
        </soapenv:Body>
    </soapenv:Envelope>  
    ```
    **Sample response**
        
    Given below is a sample response that can be handled by the getUpdated operation.
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>66</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <getUpdatedResponse>
                <result>
                    <ids>0012x000007RVCcAAO</ids>
                    <ids>0012x000007RVD1AAO</ids>
                    <ids>0012x000007RVG8AAO</ids>
                    <ids>0012x000007RVw7AAG</ids>
                    <ids>0012x000007RW3uAAG</ids>
                    <latestDateCovered>2020-06-30T05:05:00.000Z</latestDateCovered>
                </result>
            </getUpdatedResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```    
    
??? note "salesforcebulk.findDuplicates"
    The salesforcerest.findDuplicates operation retrieve the list of records that are duplicate entries. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_findduplicates.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>sobjects</td>
            <td>sObjectType from which we need to retrieve duplicate records</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.findDuplicates configKey="MySFConfig">
        <sobjects xmlns:ns="wso2.connector.salesforce">{//ns:sObjects}</sobjects>
    </salesforce.findDuplicates>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the findDuplicates operation.
                       

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:urn="wso2.connector.salesforce">
        <soapenv:Header/>
        <soapenv:Body>
            <urn:loginUrl>https://login.salesforce.com/services/Soap/u/48.0</urn:loginUrl>
            <urn:username>XXXXXXXXXXXX</urn:username>
            <urn:password>XXXXXXXXXXXX</urn:password>
            <urn:blocking>false</urn:blocking>
            <urn:sObjects>
            	<urn:sObject>
            		<urn:type>Account</urn:type>
            		<urn:fieldsToNull>name</urn:fieldsToNull>
            		<urn:fieldsToNull>id</urn:fieldsToNull>
            	</urn:sObject>
            </urn:sObjects>
        </soapenv:Body>
    </soapenv:Envelope>  
    ```   
    **Sample response**
        
    Given below is a sample response that can be handled by the findDuplicates operation.
                           
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>11</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <findDuplicatesResponse>
                <result>
                    <duplicateResults>
                        <allowSave>false</allowSave>
                        <duplicateRule>Standard_Account_Duplicate_Rule</duplicateRule>
                        <duplicateRuleEntityType>Account</duplicateRuleEntityType>
                        <errorMessage xsi:nil="true"/>
                        <matchResults>
                            <entityType>Account</entityType>
                            <matchEngine>FuzzyMatchEngine</matchEngine>
                            <rule>Standard_Account_Match_Rule_v1_0</rule>
                            <size>0</size>
                            <success>true</success>
                        </matchResults>
                    </duplicateResults>
                    <success>true</success>
                </result>
            </findDuplicatesResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```    
        
??? note "salesforcebulk.findDuplicatesByIds"
    The salesforcerest.findDuplicatesByIds operation retrieves the list of records that are duplicate entries by using ids. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_findduplicatesbyids.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>ids</td>
            <td>ids for which duplicate records need to be found</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.findDuplicatesByIds configKey="MySFConfig">
        <ids xmlns:ns="wso2.connector.salesforce">{//ns:ids}</ids>
    </salesforce.findDuplicatesByIds>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the findDuplicatesByIds operation.
                       

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:urn="wso2.connector.salesforce">
        <soapenv:Header/>
        <soapenv:Body>
            <urn:loginUrl>https://login.salesforce.com/services/Soap/u/48.0</urn:loginUrl>
            <urn:username>XXXXXXXXXX</urn:username>
            <urn:password>XXXXXXXXXX</urn:password>
            <urn:blocking>false</urn:blocking>
            <urn:ids>
            	<urn:id>0012x000005mqKuAAI</urn:id>
            	<urn:id>0012x000005orjlAAA</urn:id>
            </urn:ids>
        </soapenv:Body>
    </soapenv:Envelope>  
    ```
    **Sample response**
        
    Given below is a sample response that can be handled by the findDuplicatesByIds operation.
    
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>53</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <findDuplicatesByIdsResponse>
                <result>
                    <duplicateResults>
                        <allowSave>false</allowSave>
                        <duplicateRule>Standard_Account_Duplicate_Rule</duplicateRule>
                        <duplicateRuleEntityType>Account</duplicateRuleEntityType>
                        <errorMessage xsi:nil="true"/>
                        <matchResults>
                            <entityType>Account</entityType>
                            <matchEngine>FuzzyMatchEngine</matchEngine>
                            <rule>Standard_Account_Match_Rule_v1_0</rule>
                            <size>0</size>
                            <success>true</success>
                        </matchResults>
                    </duplicateResults>
                    <success>true</success>
                </result>
            </findDuplicatesByIdsResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
    
??? note "salesforcebulk.merge"
    The salesforcerest.merge operation merge records into one master record. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_merge.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>mergerequests</td>
            <td>The merge requests according to the format defined in to Salesforce docs (See Related Salesforce documentation section)</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.merge configKey="MySFConfig">
        <mergerequests xmlns:ns="wso2.connector.salesforce">{//ns:requests}</mergerequests>
    </salesforce.merge>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the merge operation.
                   

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:urn="wso2.connector.salesforce">
        <soapenv:Header/>
        <soapenv:Body>
            <urn:loginUrl>https://login.salesforce.com/services/Soap/u/48.0</urn:loginUrl>
            <urn:password>XXXXXXXXXXX</urn:password>
            <urn:blocking>false</urn:blocking>
            <urn:requests>
                <urn:request>
                    <urn:masterRecord>
                        <urn:type>Account</urn:type>
                        <urn:Id>0012x000008un5bAAA</urn:Id>
                    </urn:masterRecord>
                    <urn:recordToMergeIds>0012x000008un5lAAA</urn:recordToMergeIds>
                </urn:request>
            </urn:requests>
        </soapenv:Body>
    </soapenv:Envelope>  
    ```     
    
    **Sample response**
        
    Given below is a sample response that can be handled by the merge operation.
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>70</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <mergeResponse>
                <result>
                    <id>0012x000008un5bAAA</id>
                    <mergedRecordIds>0012x000008un5lAAA</mergedRecordIds>
                    <success>true</success>
                </result>
            </mergeResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
    
??? note "salesforcebulk.convertLead"
    The salesforcerest.convertLead operation convert a lead into an account. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_merge.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>leadconvertrequests</td>
            <td>The lead convert requests according to the format defined in to Salesforce docs (See Related Salesforce documentation section)</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.convertLead configKey="MySFConfig">
         <leadconvertrequests xmlns:ns="wso2.connector.salesforce">{//ns:leadconvertrequests}</leadconvertrequests>
    </salesforce.convertLead>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the merge operation.
                   

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:urn="wso2.connector.salesforce">
        <soapenv:Header/>
        <soapenv:Body>
            <urn:loginUrl>https://login.salesforce.com/services/Soap/u/48.0</urn:loginUrl>
            <urn:username>XXXXXXXXXX</urn:username>
            <urn:password>XXXXXXXXXX</urn:password>
            <urn:blocking>false</urn:blocking>
            <urn:leadconvertrequests>
            	<urn:leadConverts>
            		<urn:accountId>0012x000005mqKuAAI</urn:accountId>
            		<urn:leadId>00Q2x00000AH981EAD</urn:leadId>
            		<urn:convertedStatus>Closed - Converted</urn:convertedStatus>
            	</urn:leadConverts>
            </urn:leadconvertrequests>
        </soapenv:Body>
    </soapenv:Envelope> 
    ```
    
    **Sample response**
        
    Given below is a sample response that can be handled by the merge operation.
                       
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>128</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <convertLeadResponse>
                <result>
                    <accountId>0012x000005mqKuAAI</accountId>
                    <contactId>0032x000006I2xYAAS</contactId>
                    <leadId>00Q2x00000AH981EAD</leadId>
                    <opportunityId>0062x0000053r8FAAQ</opportunityId>
                    <success>true</success>
                </result>
            </convertLeadResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```        
---

## Working with Recycle Bin

??? note "salesforcebulk.emptyRecycleBin"
    The Recycle Bin allows you to view and restore recently deleted records for a maximum of 15 days before they are permanently deleted. To purge records from the Recycle Bin so that they cannot be restored, use salesforce.emptyRecycleBin and specify the following properties. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_emptyrecyclebin.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>allOrNone</td>
            <td>Whether to rollback changes if an object fails (see Common Parameters).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>sobjects</td>
            <td>XML representation of the records to add.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforce.emptyRecycleBin config-ref="connectorConfig">
        <allOrNone>0</allOrNone>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.emptyRecycleBin>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the emptyRecycleBin operation.
        

    ```xml
    <payloadFactory>
       <format>
          <sfdc:sObjects xmlns:sfdc="sfdc">
             <sfdc:Ids>0019000000aaMkZ</sfdc:Ids>
             <sfdc:Ids>0019000000aaMkP</sfdc:Ids>
          </sfdc:sObjects>
       </format>
       <args/>
    </payloadFactory>
     
    <salesforce.emptyRecycleBin>
        <allOrNone>0</allOrNone>
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.emptyRecycleBin>
    ```
    
    **Sample response**
        
    Given below is a sample response that can be handled by the emptyRecycleBin operation.
            
    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>27</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <emptyRecycleBinResponse>
                <result>
                    <id>0016F00002S4WaGQAV</id>
                    <success>true</success>
                </result>
            </emptyRecycleBinResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
---  
    
## Working with sObjects

??? note "salesforcebulk.describeGlobal"
    The salesforcerest.describeGlobal operation retrieve a list of objects that are available in the system. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describeglobal.htm) for more information.
    

    **Sample configuration**

    ```xml
    <salesforce.describeGlobal configKey="MySFConfig"/>
    ```
    
    **Sample response**
            
    Given below is a sample response that can be handled by the describeGlobal operation.
        
        
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
            <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
                <soapenv:Header>
                    <LimitInfoHeader>
                        <limitInfo>
                            <current>29</current>
                            <limit>15000</limit>
                            <type>API REQUESTS</type>
                        </limitInfo>
                    </LimitInfoHeader>
                </soapenv:Header>
                <soapenv:Body>
                    <describeGlobalResponse>
                        <result>
                            <encoding>UTF-8</encoding>
                            <maxBatchSize>200</maxBatchSize>
                            <sobjects>
                                <activateable>false</activateable>
                                <createable>false</createable>
                                <custom>false</custom>
                                <customSetting>false</customSetting>
                                <deletable>false</deletable>
                                <deprecatedAndHidden>false</deprecatedAndHidden>
                                <feedEnabled>false</feedEnabled>
                                <keyPrefix xsi:nil="true"/>
                                <label>Accepted Event Relation</label>
                                <labelPlural>Accepted Event Relations</labelPlural>
                                <layoutable>false</layoutable>
                                <mergeable>false</mergeable>
                                <name>AcceptedEventRelation</name>
                                <queryable>true</queryable>
                                <replicateable>false</replicateable>
                                <retrieveable>true</retrieveable>
                                <searchable>false</searchable>
                                <triggerable>false</triggerable>
                                <undeletable>false</undeletable>
                                <updateable>false</updateable>
                            </sobjects>
                            .
                            .
                        </result>
                    </describeGlobalResponse>
                </soapenv:Body>
            </soapenv:Envelope>
        
    ```
    
??? note "salesforcebulk.describeSobject"
    The salesforcerest.describeSobject operation retrieve metadata (such as name, label, and fields, including the field properties) for a specific object type. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describesobject.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>sobject</td>
            <td> The object type of where you want to retrieve the metadata.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <salesforce.describeSObject configKey="MySFConfig">
        <sobject>Account</sobject>
    </salesforce.describeSObject>
    ```
    
    **Sample response**
                
    Given below is a sample response that can be handled by the describeSobject operation.
            
            
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>31</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <describeSObjectResponse>
                <result>
                    <activateable>false</activateable>
                    <childRelationships>
                        <cascadeDelete>false</cascadeDelete>
                        <childSObject>Account</childSObject>
                        <deprecatedAndHidden>false</deprecatedAndHidden>
                        <field>ParentId</field>
                        <relationshipName>ChildAccounts</relationshipName>
                    </childRelationships>
                    .
                    .
                </result>
            </describeSObjectResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
    
??? note "salesforcebulk.describeSobjects"
    The salesforcerest.describeSobjects operation retrieve metadata (such as name, label, and fields, including the field properties) for multiple object types returned as an array. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_describesobjects.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>sobjects</td>
            <td>An XML representation of the object types of where you want to retrieve the metadata.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <salesforce.describeSobjects configKey="MySFConfig">
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.describeSobjects>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the describeSobjects operation.
                   

    ```xml
    <payloadFactory>
        <format>
            <sfdc:sObjects xmlns:sfdc="sfdc">
                <sfdc:sObjectType>Account</sfdc:sObjectType>
                <sfdc:sObjectType>Contact</sfdc:sObjectType>
             </sfdc:sObjects>
         </format>
         <args/>
     </payloadFactory>
     
    <salesforce.describeSobjects configKey="MySFConfig">
        <sobjects xmlns:sfdc="sfdc">{//sfdc:sObjects}</sobjects>
    </salesforce.describeSobjects> 
    ```  
    
    **Sample response**
                    
    Given below is a sample response that can be handled by the describeSobjects operation.
                
                
    ```xml 
    <?xml version="1.0" encoding="UTF-8"?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>51</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <describeSObjectsResponse>
                <result>
                    <activateable>false</activateable>
                    <childRelationships>
                        <cascadeDelete>false</cascadeDelete>
                        <childSObject>Account</childSObject>
                        <deprecatedAndHidden>false</deprecatedAndHidden>
                        <field>ParentId</field>
                        <relationshipName>ChildAccounts</relationshipName>
                    </childRelationships>
                    .
                    .
                </result>
                <result>
                    <activateable>false</activateable>
                    <childRelationships>
                        <cascadeDelete>false</cascadeDelete>
                        <childSObject>AcceptedEventRelation</childSObject>
                        <deprecatedAndHidden>false</deprecatedAndHidden>
                        <field>RelationId</field>
                        <relationshipName>AcceptedEventRelations</relationshipName>
                    </childRelationships>
                    .
                    .
                </result>
            </describeSObjectsResponse>
        </soapenv:Body>
    </soapenv:Envelope> 
    ```
   
---

## Working with User

??? note "salesforcebulk.emptyRecycleBin"
    To retrieve information about the user who is currently logged in, use salesforce.getUserInfo. The information provided includes the name, ID, and contact information of the user. See, the [Salesforce documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_getuserinfo_getuserinforesult.htm) for details of the information that is returned using this operation.If you want to get additional information about the user that is not returned by this operation, use retrieve operation on the User object providing the ID returned from getUserInfo. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_getuserinfo.htm) for more information.

    **Sample configuration**

    ```xml
    <salesforce.getUserInfo configKey="MySFConfig"/>
    ```
    
    **Sample response**
                        
    Given below is a sample response that can be handled by the emptyRecycleBin operation.
                    
                    
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>11</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <getUserInfoResponse>
                <result>
                    <accessibilityMode>false</accessibilityMode>
                    <currencySymbol>$</currencySymbol>
                    <orgAttachmentFileSizeLimit>5242880</orgAttachmentFileSizeLimit>
                    <orgDefaultCurrencyIsoCode>USD</orgDefaultCurrencyIsoCode>
                    <orgDisallowHtmlAttachments>false</orgDisallowHtmlAttachments>
                    <orgHasPersonAccounts>false</orgHasPersonAccounts>
                    <organizationId>00D6F000002SofgUAC</organizationId>
                    <organizationMultiCurrency>false</organizationMultiCurrency>
                    <organizationName>john</organizationName>
                    <profileId>00e6F000003GTmYQAW</profileId>
                    <roleId xsi:nil="true"/>
                    <sessionSecondsValid>7200</sessionSecondsValid>
                    <userDefaultCurrencyIsoCode xsi:nil="true"/>
                    <userEmail>iamjohn@gmail.com</userEmail>
                    <userFullName>john doe</userFullName>
                    <userId>0056F000009wCJgQAM</userId>
                    <userLanguage>en_US</userLanguage>
                    <userLocale>en_US</userLocale>
                    <userName>iamjohn@gmail.com</userName>
                    <userTimeZone>America/Los_Angeles</userTimeZone>
                    <userType>Standard</userType>
                    <userUiSkin>Theme3</userUiSkin>
                </result>
            </getUserInfoResponse>
        </soapenv:Body>
    </soapenv:Envelope>    
    ``` 

??? note "salesforcebulk.setPassword"
    The salesforcerest.setPassword operation change the user password by specifying the password. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_setpassword.htm) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>userId</td>
            <td> The user's Salesforce ID.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>password</td>
            <td>If using setPassword, the new password to assign to the user.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    setPassword

    ```xml
    <salesforce.setPassword configKey="MySFConfig">
        <userId>0056F000009wCJgQAM</userId>
        <password>abc123</password>
    </salesforce.setPassword>
    ```
    
    resetPassword
    
    ```xml
    <salesforce.resetPassword configKey="MySFConfig">
        <userId>0056F000009wCJgQAM</userId>
    </salesforce.resetPassword>    
    ```
    
    **Sample setPassword**
                            
    Given below is a sample response that can be handled by the setPassword operation.
                        
                        
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>23</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <resetPasswordResponse>
                <result>
                    <password>H5fj8A6M</password>
                </result>
            </resetPasswordResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```
---

## Working with Utility

??? note "salesforcebulk.getServerTimestamp"
    The salesforcerest.getServerTimestamp operation retrieve the timestampt of the server. See the [related API documentation](https://developer.salesforce.com/docs/atlas.en-us.api.meta/api/sforce_api_calls_getservertimestamp.htm) for more information.

    **Sample configuration**

    ```xml
    <salesforce.getServerTimestamp configKey="MySFConfig"/>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the undelete operation.
        

    ```xml
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                      xmlns:urn="wso2.connector.salesforce">
        <soapenv:Header/>
        <soapenv:Body>
            <urn:loginUrl>https://login.salesforce.com/services/Soap/u/30.0</urn:loginUrl>
            <urn:username>XXXXXXXXXX</urn:username>
            <urn:password>XXXXXXXXXX</urn:password>
            <urn:blocking>false</urn:blocking>
        </soapenv:Body>
    </soapenv:Envelope> 
    ```
    
    **Sample response**
                                
    Given below is a sample response that can be handled by the getServerTimestamp operation.
                            
                            
    ```xml
    <?xml version='1.0' encoding='utf-8'?>
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns="urn:partner.soap.sforce.com">
        <soapenv:Header>
            <LimitInfoHeader>
                <limitInfo>
                    <current>58</current>
                    <limit>15000</limit>
                    <type>API REQUESTS</type>
                </limitInfo>
            </LimitInfoHeader>
        </soapenv:Header>
        <soapenv:Body>
            <getServerTimestampResponse>
                <result>
                    <timestamp>2020-07-03T09:14:41.321Z</timestamp>
                </result>
            </getServerTimestampResponse>
        </soapenv:Body>
    </soapenv:Envelope>
    ```