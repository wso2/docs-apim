**Enabling TLS for event hub JMS communications**

        If required, you can enable TLS for the JMS communications of event hub. Update your event hub configurations to include the following for this purpose.

        ```
        [apim.event_hub]
        enable = true
        jms.username = "<username>"
        jms.password = "<password>"
        jms.ssl = "true'&amp;ssl_cert_alias='<certificate_alias_in_truststore>'&amp;trust_store='<path_to_trust_store>'&amp;trust_store_password='<truststore_password>'&amp;key_store='<path_to_key_store>'&amp;key_store_password='<keystore_password>"
        ssl = "true'&amp;ssl_cert_alias='<certificate_alias_in_truststore>'&amp;trust_store='<path_to_trust_store>'&amp;trust_store_password='<truststore_password>'&amp;key_store='<path_to_key_store>'&amp;key_store_password='<keystore_password>"
        event_listening_endpoints = ["tcp://control-plane-host:8672"]
        ```