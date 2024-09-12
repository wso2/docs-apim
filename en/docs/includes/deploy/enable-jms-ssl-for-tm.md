**Enabling TLS for Traffic Manager JMS communications**

        If required, you can enable TLS for the JMS communications with the traffic manager. Update your traffic manager related configurations to include the following for this purpose.

        ```
        [apim.throttling]
        throttle_decision_endpoints = ["tcp://tm.wso2.com:8672"]

        [apim.throttling.jms]
        topic_connection_factory = "amqp://<![CDATA[<username>]]>:<![CDATA[<password>]]>@clientid/carbon?brokerlist='tcp://tm.wso2.com:8672?ssl='true'%26ssl_cert_alias='<certificate_alias_in_truststore>'%26trust_store='<path_to_trust_store>'%26trust_store_password='<truststore_password>'%26key_store='<path_to_key_store>'%26key_store_password='<keystore_password>''"
        ```