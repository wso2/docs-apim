# DB Event Inbound Endpoint Reference

The following configurations allow you to configure DB Event Inbound Endpoint for your scenario. 

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg th{font-family:Arial, sans-serif;font-size:20px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:black;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<table class="tg">
  <tr>
    <th class="tg-0pky">Parameter</th>
    <th class="tg-0pky">Description</th>
    <th class="tg-0pky">Required</th>
    <th class="tg-0pky">Possible Values</th>
    <th class="tg-0pky">Default Value</th>
  </tr>
  <tr>
    <td class="tg-0pky">sequential</td>
    <td class="tg-0pky">Whether the messages should be polled and injected sequentially.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">true , false</td>
    <td class="tg-0pky">TRUE</td>
  </tr>
  <tr>
    <td class="tg-0pky">driverName</td>
    <td class="tg-0pky">The class name of the database driver.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">com.mysql.jdbc.Driver</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">url</td>
    <td class="tg-0pky">The JDBC URL of the database.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">jdbc:mysql://&lt;HOST&gt;/&lt;DATABASE_NAME&gt;</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">username</td>
    <td class="tg-0pky">The user name to connect to the database.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">-</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">password</td>
    <td class="tg-0pky">The password to connect to the database.</td>
    <td class="tg-0pky">Required if you have set a password for the database.</td>
    <td class="tg-0pky">-</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">tableName</td>
    <td class="tg-0pky">The name of the table to capture changes to records.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">-</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">filteringCriteria</td>
    <td class="tg-0pky">The criteria to poll the database for record changes. Possible criteria are as follows:<br>
        <li><b>byLastUpdatedTimestampColumn:</b> Specify this to poll the database for a record that has changed since the last modified timestamp.</li>
        <li><b>byBooleanColumn:</b> Specify this to poll the database for record changes according to a column where it contains the boolean (true or false) value. By default, values are set to true. Each polling cycle takes only the records with the value true and updates it as false after polling. <b>Note:</b> When you create this database table column, you have to specify the data type as varchar instead of boolean data type.</li>
        <li><b>deleteAfterPoll:</b> Specify this if you want to delete records after polling.</li>
    </td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">-</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">filteringColumnName</td>
    <td class="tg-0pky">The actual name of the column that captures changes.<br/>
        <li>If filteringCriteria is `byLastUpdatedTimestampColumn`, this needs to be a column of type `Timestamp` and should be updated with the record.</li>
        <li>If filteringCriteria is `byBooleanColumn` this needs to be a column of type `Varchar`.</li>
    </td>
    <td class="tg-0pky">Required if the value of the filteringCriteria parameter is specified as byLastUpdatedTimestampColumn or byBooleanColumn</td>
    <td class="tg-0pky">-</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">primaryKey</td>
    <td class="tg-0pky">The primary key column name.</td>
    <td class="tg-0pky">Yes</td>
    <td class="tg-0pky">ID</td>
    <td class="tg-0pky">-</td>
  </tr>
  <tr>
    <td class="tg-0pky">connectionValidationQuery</td>
    <td class="tg-0pky">The query to check the availability of the connection.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">SELECT 1</td>
    <td class="tg-0pky">SELECT 1</td>
  </tr>
  <tr>
    <td class="tg-0pky">registryPath</td>
    <td class="tg-0pky">The registry path of the timestamp. This is used to retrieve records when the value of the filteringCriteria parameter is specified as byLastUpdatedTimestampColumn.</td>
    <td class="tg-0pky">No</td>
    <td class="tg-0pky">-</td>
    <td class="tg-0pky">Name of the Inbound Endpo</td>
  </tr>
</table>

<br/>

## Rollback the events

Once processing of an event fails, it will trigger a specified `fault sequence`. It is possible to specify the following property in such a situation. 
```xml
<property name="SET_DB_ROLLBACK_ONLY" value="true"/>
```
Once this property is set to `true`, DB event listener will not do any updates to the database. That is, it will not delete the row associated with the event or it will not update the boolean value being monitored. Also, it will not consider that event as received by the endpoint. Upon the next DB event poll, the same event will be triggered again. You can build a re-try mechanism upon mediation failures using this feature. 