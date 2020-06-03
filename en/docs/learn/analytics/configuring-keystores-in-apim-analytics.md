# Configuring Keystores in API-M Analytics

WSO2 products use asymmetric cryptography by default for authentication and data encryption. In asymmetric cryptography, keystores (with key pairs and certificates) are created and stored for the product. Keystore is a repository where private keys and certificates can be stored. It is possible to have multiple keystores so that the keys used for different use cases are kept unique. For more information about keystores and its concepts, see [About Asymmetric Cryptography]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/about-asymetric-cryptography).

In WSO2 API-M Analytics a set of keystores can be configured and used for different use cases in both dashboard and worker profiles.

The `wso2carbon.jks` keystore file, which is shipped with all WSO2 products, is used as the default keystore for all functions. However, in a production environment, it is recommended to [create new keystores]({{base_path}}/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores) with new keys and certificates. If you have created a new keystore and updated the `client-truststore.jks` file, which resides in the `<API-M_ANALYTICS_HOME>/resources/security` directory, you must update the `deployment.yaml` file of the corresponding profile in order to make the keystore work.

## Configuring keystores in dashboard profile

!!! note
    Other than explicitly mentioned, you need to do all the following configuration updates related to the dashboard profile in the `<API-M_ANALYTICS_HOME>/conf/dashboard/deployment.yaml` file.

1. Update the Databridge configurations.

    This is used for authenticating communication over SSL/TLS between API Manager and API-M Analytics. Handles thrift and binary transports.  

    ```yaml
    databridge.config:
      ... 
      keyStoreLocation : ${sys:carbon.home}/resources/security/wso2carbon.jks
      keyStorePassword : wso2carbon
      ... 
    ```
    The elements in the above configuration are described below:
       
    | Element                | Description                                                      |
    |------------------------|------------------------------------------------------------------|
    | **keyStoreLocation**   | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |
    | **keyStorePassword**   | Keystore password                                                |

2. Update the HTTP transport configurations.
   
    This is used for authentication, encryption, and signing with regard to the analytics dashboard web application.

    ```yaml
    wso2.transport.http:
      ...
      listenerConfigurations:
        - id: "default-https"
          ...
          keyStoreFile: "${carbon.home}/resources/security/wso2carbon.jks"
          keyStorePassword: wso2carbon
          certPass: wso2carbon 
    ```
    The elements in the above configuration are described below:
      
    | Element                | Description                                                      |
    |------------------------|------------------------------------------------------------------|
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |
    | **keyStorePassword**   | Keystore password                                                |
    | **certPass**           | Private key password                                             |
   
3. Update the Secure Vault configurations.
   
     1. Update the configurations in the `deployment.yaml` file.
    
         The Secure Vault configurations are used to store encrypted passwords that are mapped to aliases.

         ```yaml
         wso2.securevault:
           secretRepository:
             ...
             parameters:
               privateKeyAlias: wso2carbon
                keystoreLocation: ${sys:carbon.home}/resources/security/securevault.jks
               ... 
         ```
        The elements in the above configuration are described below:
          
        | Element                | Description                                                      |
        |------------------------|------------------------------------------------------------------|
        | **privateKeyAlias**    | Private key alias                                                |
        | **keyStoreLocation**   | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |

    2. Provide the keystore and private key password in the Base64 encoded format in the `<ANALYTICS_HOME>/conf/dashboard/master-keys.yaml` file.

        ??? info "Click here for more info on the `master-keys.yaml` file"
            The base64 encoded plaintext keystore password and the base64 encoded plaintext private password of the keystore used for Secure Vault is defined in the master-keys.yaml file. WSO2 Carbon Server reads this file to obtain these two passwords, so that it can decrypt the passwords in the `secrets.properties` file in order to start the server.

4. Set the new keystore details when you change the keystore.

      1. Navigate to the <ANALYTICS_HOME>/wso2/dashboard/bin/carbon.sh` file.
      
      2. Define the correct keystore path for the `Djavax.net.ssl.keyStore` system property.
      
      3. Define the correct keystore password for the `Djavax.net.ssl.keyStorePassword` system property.

## Configuring keystores in worker profile

!!! note
    Other than explicitly mentioned, you need to do all the following configuration updates related to the worker profile in the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file.

1. Update the databridge configurations.

    This is used for authenticating communication over SSL/TLS between API Manager and API-M Analytics. Handles thrift and binary transports.

    ```yaml
    databridge.config:
      ... 
      keyStoreLocation : ${sys:carbon.home}/resources/security/wso2carbon.jks
      keyStorePassword : wso2carbon
      ... 
    ```
    The elements in the above configuration are described below:
   
    | Element                | Description                                                      |
    |------------------------|------------------------------------------------------------------|
    | **keyStoreLocation**   | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |
    | **keyStorePassword**   | Keystore password                                                |

2. Update the HTTP transport configurations.

    This is used for authentication, encryption, and signing with regard to the analytics worker.

    ```yaml
    wso2.transport.http:
      ...
      listenerConfigurations:
        - id: "default-https"
          ...
          keyStoreFile: "${carbon.home}/resources/security/wso2carbon.jks"
          keyStorePassword: wso2carbon
          certPass: wso2carbon 
    ```
    The elements in the above configuration are described below:
      
    | Element                | Description                                                      |
    |------------------------|------------------------------------------------------------------|
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |
    | **keyStorePassword**   | Keystore password                                                |
    | **certPass**           | Private key password                                             |
   
3. Update the Secure Vault configurations.
   
     1. Update the configurations in the `deployment.yaml` file.
    
         The Secure Vault configurations are used to store encrypted passwords that are mapped to aliases.

          ```yaml
          wso2.securevault:
            secretRepository:
              ...
              parameters:
                privateKeyAlias: wso2carbon
                keystoreLocation: ${sys:carbon.home}/resources/security/securevault.jks
                ... 
          ```
          The elements in the above configuration are described below:
            
          | Element                | Description                                                      |
          |------------------------|------------------------------------------------------------------|
          | **privateKeyAlias**    | Private key alias                                                |
          | **keyStoreLocation**   | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |

     2. Provide the keystore and private key password in the Base64 encoded format in the `<ANALYTICS_HOME>/conf/worker/master-keys.yaml` file.

        ??? info "Click here for more info on the `master-keys.yaml` file"
            The base64 encoded plaintext keystore password and the base64 encoded plaintext private password of the keystore used for Secure Vault is defined in the master-keys.yaml file. WSO2 Carbon Server reads this file to obtain these two passwords, so that it can decrypt the passwords in the `secrets.properties` file in order to start the server.

4. Set the new keystore details when you change the keystore.

      1. Navigate to the <ANALYTICS_HOME>/wso2/worker/bin/carbon.sh` file.
      
      2. Define the correct keystore path for the `Djavax.net.ssl.keyStore` system property.
      
      3. Define the correct keystore password for the `Djavax.net.ssl.keyStorePassword` system property.

5. Update the Siddhi stores query API configurations.

    This is used for authentication, encryption, and signing for the communication to Siddhi store query APIs. 

    ```yaml
    wso2.transport.http:
      ...
      listenerConfigurations:
        - id: "msf4j-https"
          ...
          keyStoreFile: "${carbon.home}/resources/security/wso2carbon.jks"
          keyStorePassword: wso2carbon
          certPass: wso2carbon 
    ```
    The elements in the above configuration are described below:
         
    | Element                | Description                                                      |
    |------------------------|------------------------------------------------------------------|
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |
    | **keyStorePassword**   | Keystore password                                                |
    | **certPass**           | Private key password                                             |
      
6. Update the Siddhi gRPC service related configurations.

    This is used for authentication, encryption, and signing for the communication to Siddhi gRPC service. 

    ```yaml
    siddhi:
      ...
      extensions:
        ...
        -
          extension:
            name: 'grpc'
            ...
            properties:
              keyStoreFile : ${sys:carbon.home}/resources/security/wso2carbon.jks
              keyStorePassword : wso2carbon
              ...
    ```

    The elements in the above configuration are described below:
            
    | Element                | Description                                                      |
    |------------------------|------------------------------------------------------------------|
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in the `<API-M_ANALYTICS_HOME>/resources/security` directory.** |
    | **keyStorePassword**   | Keystore password                                                |
