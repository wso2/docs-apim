# Add Custom Attributes to Applications

Applications in the API Store are created and subscribed to APIs allowing users to consume the APIs, and helping developers to expose monetize their APIs. Applications can be created with predefined set of properties. This feature enables the functionality to provide set-of custom attributes while creating application.

Follow the steps below to configure adding custom attributes to applications

-   [Step 1 - Configuring custom attributes for applications](#AddCustomAttributestoApplications-Step1-Configuringcustomattributesforapplications)
-   [Step 2 - Creating an application with custom attributes through the API Store](#AddCustomAttributestoApplications-Step2-CreatinganapplicationwithcustomattributesthroughtheAPIStore)

### Step 1 - Configuring custom attributes for applications

Custom attributes can be configured in the following ways.

-   [Server-specific configuration](#AddCustomAttributestoApplications-Server-specificconfiguration)
-   [Tenant-specific configuration](#AddCustomAttributestoApplications-Tenant-specificconfiguration)

#### Server-specific configuration

To configure server-specific custom attributes, open the `<API-M-home>/repository/conf/api-manager.xml` file. Add `<ApplicationAttributes>` as shown in the example below.

``` java
    <ApplicationConfiguration>
        <ApplicationAttributes>
            <Attribute required="true">
                <Name>External Reference Id</Name>
                <Description>Sample description of the attribute</Description>
            </Attribute>
        </ApplicationAttributes>
    </ApplicationConfiguration>
```

#### 
Tenant-specific configuration

To configure server-specific custom attributes, open the `<API-M-home>/repository/resources/tenant-conf.json` file. Add `ApplicationConfigs` under `Attributes` as shown below.

``` java
    "ApplicationConfigs": {
        "Attributes" : [
                {
                        "Attribute" : "External Reference Number",
                        "Required" : true,
                        "Description" : "Sample description"
                },
                {
                        "Attribute" : "Tenant Billing tier"
                }
        ]
       }
```

### Step 2 - Creating an application with custom attributes through the API Store

After configuring the custom attributes as shown in the previous section, you will be able to add these attributes to the applications you create in the API Store.

1.  Log in to the API Store. Click **Add Application** , to add a new application
    ![](/assets/attachments/103333199/103333200.png)
2.  You will see the configured custom attribute as shown below.
    ![](/assets/attachments/103333199/103333201.png)
