# Saving Access Tokens in Separate Tables

!!! warning
This feature has been deprecated as it is redundant. Although it was introduced as a security measure, a compromise in the database would result in a compromise in all its tables.


You can configure the API Manager instances to store access tokens in different tables according to their user store domains. This is referred to as **user token partitioning** and it ensures better security when there are multiple user stores configured in the system. To configure user stores other than the default one, see Configuring Secondary User Stores .

The following topics explain how to enable user token partitioning:

-   [Enabling assertions](#SavingAccessTokensinSeparateTables-EnablingassertionsEnableAssertions)
-   [Storing keys in different tables](#SavingAccessTokensinSeparateTables-Storingkeysindifferenttables)

#### Enabling assertions

You use assertions to embed parameters into tokens and generate a strong access token. You can also use these parameters later for other processing. At the moment, the API Manager only supports UserName as an assertion.

By default, assertions are set to `         false        ` in the `         <APIM_HOME>/repository/conf/identity/identity.xml        ` . To enable it, set the `         <UserName>        ` element to `         true        ` . You can add a user name to an access token when generating the key, and verify it by encoding the retrieved access token with Base64.

**&lt;APIM\_HOME&gt;/repository/conf/identity/identity.xml**

``` xml
    <EnableAssertions>
            <UserName>true</UserName>
    </EnableAssertions>
```

#### Storing keys in different tables

1.  If the `           <UserName>          ` assertion is enabled, set the `           <EnableAccessTokenPartitioning>          ` element in `           <APIM_HOME>/repository/conf/identity/identity.xml          ` file to `           true          ` . It determines whether you want to store the keys in different tables or not.

    ``` xml
            <EnableAccessTokenPartitioning>true</EnableAccessTokenPartitioning> 
    ```

2.  Set the user store domain names and mappings to new table names. For example,

    -   if userId = foo.com/admin where 'foo.com' is the user store domain name, then a 'mapping:domain' combo can be defined as 'A:foo.com'
    -   'A' is the mapping for the table that stores tokens relevant to users coming from the 'foo.com' user store

    In this case, the actual table name is `           IDN_OAUTH2_ACCESS_TOKEN_A          ` . We use a mapping simply to prevent any issues caused by lengthy table names when lengthy domain names are used. You must manually create the tables you are going to use to store the access tokens in each user store (i.e., manually create the tables `           IDN_OAUTH2_ACCESS_TOKEN_A          ` and `           IDN_OAUTH2_ACCESS_TOKEN_B          ` according to the following defined domain mapping). This table structure is similar to the `           IDN_OAUTH2_ACCESS_TOKEN          ` table defined in the api-manager dbscript, which is inside the `           <APIM_HOME>/dbscripts/apimgt          ` directory.

    You can provide multiple mappings separated by commas as follows. Note that the domain names need to be specified in upper case.

    ``` html/xml
            <AccessTokenPartitioningDomains>A:FOO.COM, B:BAR.COM</AccessTokenPartitioningDomains>
    ```

3.  According to the information given above, change the `           <OAuth>          ` element in the `           <APIM_HOME>/repository/conf/identity/identity.xml          ` file as shown in the following example:

    **&lt;APIM\_HOME&gt;/repository/conf/identity/identity.xml**

    ``` xml
            <!-- Assertions can be used to embed parameters into access token.-->
            <EnableAssertions>
                 <UserName>true</UserName>
            </EnableAssertions>
    <!-- This should be set to true when using multiple user stores and keys should saved into different tables according to the user store. By default all the application keys are saved in to the same table. UserName Assertion should be 'true' to use this.-->
    <AccessTokenPartitioning>
         <EnableAccessTokenPartitioning>true</EnableAccessTokenPartitioning>
         <!-- user store domain names and mappings to new table names. eg: if you provide 'A:foo.com', foo.com should be the user store domain   
         name and 'A' represent the relavant mapping of token storing table, i.e. tokens relevant to the users comming from foo.com user store     
         will be added to a table called IDN_OAUTH2_ACCESS_TOKEN_A. --> 
         <AccessTokenPartitioningDomains>A:foo.com, B:bar.com</AccessTokenPartitioningDomains>
    </AccessTokenPartitioning>   
    ```

