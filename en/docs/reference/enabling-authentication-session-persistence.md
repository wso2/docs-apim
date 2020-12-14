# Enabling Authentication Session Persistence

This topic is regarding sessions in the WSO2 API Manager (WSO2 API-M) and the process of enabling session persistence for these sessions. This is particularly useful when the remember me option is selected when logging into either the service provider or the WSO2 API-M.

Uncomment the following configuration in the `<API-M_HOME>/repository/conf/identity/identity.xml` file, under the `Server` and `JDBCPersistenceManager` elements to enable authentication session persistence.

``` xml
     <SessionDataPersist>
         <Enable>true</Enable>
         <Temporary>false</Temporary>
         <PoolSize>100</PoolSize>
         <SessionDataCleanUp>
             <Enable>true</Enable>
             <CleanUpTimeout>20160</CleanUpTimeout>
             <CleanUpPeriod>1140</CleanUpPeriod>
         </SessionDataCleanUp>
         <OperationDataCleanUp>
             <Enable>true</Enable>
             <CleanUpPeriod>720</CleanUpPeriod>
         </OperationDataCleanUp>
    </SessionDataPersist>
```

The following table describes the elements of the configurations mentioned above.

<table>
<thead>
<tr class="header">
<th>Configuration element</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Enable</p></td>
<td><p>This enables the persistence of session data. Therefore, this must be configured to <code>              true             </code> if you wish to enable session persistence.</p></td>
</tr>
<tr class="even">
<td>Temporary</td>
<td><p>Setting this to <code>              true             </code> enables persistence of temporary caches that are created within an authentication request.</p></td>
</tr>
<tr class="odd">
<td>PoolSize</td>
<td>To improve performance, OAuth2 access tokens are persisted asynchronously in the database using a thread pool.<br />
This value refers to the number of threads in that thread pool.</td>
</tr>
<tr class="even">
<td><p>SessionDataCleanUp</p></td>
<td><p>This section of the configuration is related to the cleaning up of session data.</p></td>
</tr>
<tr class="odd">
<td><p>Enable</p></td>
<td>Selecting true here enables the cleanup task and ensures that it starts running.</td>
</tr>
<tr class="even">
<td><p>CleanUpTimeOut</p></td>
<td><p>This is the timeout value (in minutes) of the session data that is removed by the cleanup task. The default value is 2 weeks.</p></td>
</tr>
<tr class="odd">
<td><p>CleanUpPeriod</p></td>
<td><p>This is the time period (in minutes) that the cleanup task would run. The default value is 1 day.</p></td>
</tr>
<tr class="even">
<td>OperationDataCleanUp</td>
<td>This section of the configuration is related to the cleaning up of operation data.</td>
</tr>
</tbody>
</table>

!!! note
**Note** : If Single Sign-On is to work, you must enable at least one of the two configurations mentioned in this topic.


**Related Topics**

-   See [Configuring Single Sign-on with SAML2](https://docs.wso2.com/display/AM260/Configuring+Single+Sign-on+with+SAML2) for more information

