**Enabling TLS/SSL for Gateway to Traffic Manager JMS communications**

        If required, you can enable TLS/SSL for the JMS communications happening between the Gateway and Traffic Manager nodes. 
        
        Add the following configuration to the Gateway node for this purpose.

        ```
        [apim.throttling.jms]
        topic_connection_factory = "amqp://<![CDATA[<username>]]>:<![CDATA[<password>]]>@clientid/carbon?brokerlist='tcp://tm.wso2.com:8672?ssl='true'%26ssl_cert_alias='<certificate_alias_in_truststore>'%26trust_store='<path_to_trust_store>'%26trust_store_password='<truststore_password>'%26key_store='<path_to_key_store>'%26key_store_password='<keystore_password>''"
        ```

        Also update your Traffic Manager node to include the following configuration to enable secure broker connections.

        ```
        [broker.transport.amqp.ssl_connection]
        enabled = true
        port = 8672
        ssl_enabled_protocols = "TLSv1,TLSv1.2"
        ciphers = "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"

        [broker.transport.amqp.ssl_connection.keystore]
        location = "repository/resources/security/wso2carbon.jks"
        password = "wso2carbon"
        cert_type = "SunX509"

        [broker.transport.amqp.ssl_connection.truststore]
        location = "repository/resources/security/client-truststore.jks"
        password = "wso2carbon"
        cert_type = "SunX509"
        ``` 