# Setting up the Twitter Connector in Integration Runtime

Before you start configuring the Twitter connector, you need to configure the integration runtime. 

## Adding message builders

Consider the root of the Micro Integrator/ Enterprise Integrator as `<PRODUCT_HOME>`.

If you are using the **Micro Integrator 4.2.0**, you need to add the following message builder to **`<PRODUCT_HOME>`/conf/deployment.toml** file. For more information, refer the [Working with Message Builders and Formatters](https://ei.docs.wso2.com/en/latest/micro-integrator/setup/message_builders_formatters/message-builders-and-formatters/) and [Product Configurations]({{base_path}}/reference/config-catalog-mi/) documentation.

```toml
[[custom_message_builders]]
class="org.wso2.micro.integrator.core.json.JsonStreamBuilder"
content_type = "application/problem+json"
```

If you are using **EI 6.x** version, you can enable this property by doing the following Axis2 configurations in the **`<PRODUCT_HOME>`/repository/conf/axis2/axis2.xml** and **`<PRODUCT_HOME>`/repository/conf/axis2/axis2_blocking_client.xml** files.

**messageBuilders**

```xml
<messageBuilder contentType="application/problem+json"
                class="org.wso2.carbon.integrator.core.json.JsonStreamBuilder"/>
```
