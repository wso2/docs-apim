**Enabling TLS/SSL for event hub JMS communications**

        If required, you can enable TLS/SSL for the JMS communications of event hub. Update your event hub configurations to include the following for this purpose.

        ```
        [apim.event_hub]
        enable = true
        jms.username = "<username>"
        jms.password = "<password>"
        jms.ssl = "true'&amp;ssl_cert_alias='<certificate_alias_in_truststore>'&amp;trust_store='<path_to_trust_store>'&amp;trust_store_password='<truststore_password>'&amp;key_store='<path_to_key_store>'&amp;key_store_password='<keystore_password>"
        ssl = "true'&amp;ssl_cert_alias='<certificate_alias_in_truststore>'&amp;trust_store='<path_to_trust_store>'&amp;trust_store_password='<truststore_password>'&amp;key_store='<path_to_key_store>'&amp;key_store_password='<keystore_password>"
        event_listening_endpoints = ["tcp://control-plane-host:8672"]
        ```
        To enable secure broker connections add the following configuration to the Control Plane node.

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