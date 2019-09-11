# admin\_Managing User Attributes

For user and role management in WSO2 products, it is important to understand how to manage the attributes of users within it. In the products, each user store attribute can be mapped as a claim. Therefore, you need to use the claim management functionality available in the product and properly map your LDAP/AD/JDBC user store attributes with the claim URIs defined by the product. You can also add different claim URIs and manage them using claim management.

The following topics provide instructions on how to manage user attributes in WSO2 products.

-   [Managing the attributes of a user](#admin_ManagingUserAttributes-Managingtheattributesofauser)
-   [Claim mapping when using multiple user stores](#admin_ManagingUserAttributes-Claimmappingwhenusingmultipleuserstores)
-   [Attributes with multiple values](#admin_ManagingUserAttributes-Attributeswithmultiplevalues)
-   [Writing custom attributes](#admin_ManagingUserAttributes-Writingcustomattributes)
-   [Authentication using multiple attributes](#admin_ManagingUserAttributes-Authenticationusingmultipleattributes)
-   [Customizing the claim for the user attribute](#admin_ManagingUserAttributes-Customizingtheclaimfortheuserattribute)

### Managing the attributes of a user

The following are the three main ways to view, add, edit and delete attributes of a user in the product.

1.  By accessing the profile of the user and changing the attributes using the Management Console.
    1.  Log into the product's Management Console.
    2.  On the **Configure** tab in the Management Console, click **Users and Roles** .
    3.  Click **Users** . This link is only visible to users with the Admin role.
    4.  From the list of users that appear in the resulting page, identify the user whose attributes you want to modify and click **User Profile** .
        ![](attachments/43997703/44195174.png)
    5.  Click **Update** to save changes to the attributes.
2.  You can use the `RemoteUserStoreManagerService` API. This is a SOAP-based API and is very easy to use. Supposing you want to set a user attribute, you can call the following method.

    ``` java
        setUserClaimValue("username", "http://wso2.org/claims/emailaddress", "asela@soasecurity.org", null)
    ```

    Here “ http://wso2.org/claims/emailaddress ” is the claim URI that has been mapped with the user store’s email attribute. The last parameter is profile, we can just pass “null”, as there is only one profile. You can retrieve the user attribute value as follows.

    ``` java
            getUserClaimValue("username", "http://wso2.org/claims/emailaddress", null)
    ```

3.  You can use the REST Web service according to the SCIM provisioning specification.

### Claim mapping when using multiple user stores

When you are using more than one user store, you must map the attributes correctly using claim management. Under “Mapped Attribute(s)” you need to follow the pattern.

``` java
    {domain_name/attribute_Name};{domain_name/attribute_Name}; {domain_name/attribute_Name};
```

However, for the default user store, you do not need to provide the domain name. As an example, if you have two user stores, one is default and other one with domain “LDAP” then the pattern would be as follows for “ `http://wso2.org/claims/emailaddress` ".

``` java
    email;LDAP/mail
```

### Attributes with multiple values

If your user store supports having multiple values for attributes, the WSO2 product can view, add, update or delete them (normally LDAP/AD offer support for this). The following are the different ways you can do this.

1.  In the product's Management Console, multiple attribute values are separated by comma. If you want to update two email addresses using the user profile UI, you must provide it as follows.

    ``` java
            asela@soasecurity.com,aselapathberiya@soasecurity.com
    ```

    See the following screen for how this will look in the user interface of the product's Management Console.
    ![](attachments/43997703/44195175.png)

2.  When using the `RemoteUserStoreManagerService` API, call it as follows.

    ``` java
            setUserClaimValue("username", "http://wso2.org/claims/emailaddress", "asela@soasecurity.org,aselapathberiya@gmail.com", null)
    ```

    The GET results are returned in the form of comma separated values for the attribute.

    ``` java
            "asela@soasecurity.org,aselapathberiya@gmail.com"
    ```

    The following screen shows how this looks in the LDAP.
    ![](attachments/43997703/44195177.png)
### Writing custom attributes

Supposing the attributes of a user are stored in both the user store (LDAP) and another location (JDBC table), the product needs to retrieve/add the user’s attribute in both these places. In scenarios like this, some customization must be done. To customize this, you can simply extend the current user store manager implementation and write a custom implementation to do it. In the custom user store implementation, you only need to extend the following three methods that help to retrieve/add a user attribute. Other methods can be kept as they are.

-   Method 1.

    ``` java
            public Map<String, String> getUserPropertyValues(String userName, String[] propertyNames, String profileName) throws UserStoreException
    ```

-   Method 2.

    ``` java
            protected abstract void doSetUserClaimValue(String userName, String claimURI, String claimValue, String profileName) throws UserStoreException;
    ```

-   Method 3.

    ``` java
            protected abstract void doSetUserClaimValues(String userName, Map<String, String> claims, String profileName) throws UserStoreException;
    ```

### Authentication using multiple attributes

In a user store, each user has different attributes such as uid, cn, email and so on. Some of the attributes can be unique. As an example, normally **uid** and **mail** can be unique attributes for user.

Once you connect your LDAP with an application, the application can use one of the unique attributes in LDAP to authenticate the user (as the user name of the user in that application). Considering our example, it can be the **uid** or **mail** attribute. Additionally, in some cases, the application can use both attributes. So end users can be authenticated in the application using both their **uid** or **mail** .

WSO2 products can be deployed with any LDAP based server and it can expose authentication via a Web Service API, SAML, OAuth, OpenID, etc. By default, WSO2 products configured to authenticate with only one user attribute in the LDAP. This topic provides instructions on how the products can be extended to authenticate users using more than one attribute.

For the purposes of this example, we assume that users need to be authenticated using both their **uid** and **mail** attributes in the LDAP.

1.  Configure the LDAP user store related configurations using the **user-mgt.xml** file found in the `<PRODUCT_HOME>/repository/conf` directory.
    1.  Configure `UserNameSearchFilter` that helps to search for the user object in the LDAP using both **mail** and **uid** attributes.
`<Property name="UserNameSearchFilter">(&amp;(objectClass=person)(|(mail=?)(uid=?)))</Property>           `
    2.  Disable `UserDNPattern` property, if it is currently enabled.
`<!--Property name="UserDNPattern">uid={0},ou=Users,dc=wso2,dc=org</Property-->`
    3.  The mail attribute has requirements that are unique. If you are using the mail attribute, you need to open the **carbon.xml** file found in the `<PRODUCT_HOME>/repository/conf` directory and uncomment the following.
`<EnableEmailUserName>true</EnableEmailUserName>`
2.  If you want to work with multiple attributes (basically to retrieve internal roles with multiple attributes), you must add following property in the `<PRODUCT_HOME>/repository/conf/user-mgt.xml` file.
`<Property name="MultipleAttributeEnable">true</Property>`

3.  To test this, restart the product and try to log in to the Management Console by providing both the mail and uid with the same password.

### Customizing the claim for the user attribute

If you are using multiple attribute authentication and want to customize the claim to be used for user name attribute, do the following.

Edit the following element in the `<PRODUCT_HOME>/repository/conf/security/application-authentication.xml` file.

``` xml
    <AuthenticatorConfig name="BasicAuthenticator" enabled="true">
        <Parameter name="UserNameAttributeClaimUri">http://wso2.org/claims/emailaddress</Parameter>
    </AuthenticatorConfig>
```

This will return the email address of the authenticated user. It can be configured to return any attribute by changing the ' `UserNameAttributeClaimUri` ' parameter.
