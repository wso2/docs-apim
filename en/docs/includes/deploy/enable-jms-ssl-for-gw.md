**Enabling TLS for JMS communications with Gateway**

        If required, you can enable TLS for receiving JMS communications from the Gateway. Update your configurations in nodes except Gateway to include the following for this purpose. Please note that the port under `[broker.transport.amqp.ssl_connection]` is the jms ssl port of the Gateway node.

        ```
        [broker.transport.amqp.ssl_connection]
        enabled = true
        port = 8672
        ssl_enabled_protocols = "TLSv1,TLSv1.2"
        ciphers = "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDH_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256"

        [broker.transport.amqp.ssl_connection.keystore]
        location = "<keystore_location>"
        password = "<keystore_password>"
        cert_type = "SunX509"

        [broker.transport.amqp.ssl_connection.truststore]
        location = "<truststore_location>"
        password = "<truststore_password>"
        cert_type = "SunX509"
        ```