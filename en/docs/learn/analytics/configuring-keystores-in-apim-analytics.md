# Configuring Keystores in APIM Analytics

WSO2 products use asymmetric cryptography by default for the purposes of authentication and data encryption. In asymmetric cryptography, keystores (with key pairs and certificates) are created and stored for the product. Keystore is a repository where private keys and certificates can be stored. It is possible to have multiple keystores so that the keys used for different use cases are kept unique. For more information about keystores and its concepts, see [About Asymmetric Cryptography](../../install-and-setup/setup/security/configuring-keystores/keystore-basics/about-asymetric-cryptography.md) .

In WSO2 APIM Analytics a set of keystores can be configured and used for different use cases in both dashboard and worker profiles.

The `wso2carbon.jks` keystore file, which is shipped with all WSO2 products, is used as the default keystore for all functions. However, in a production environment, it is recommended to [create new keystores](../../install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores.md) with new keys and certificates. If you have created a new keystore and updated the `client-truststore.jks` file resides in `<API-M_ANALYTICS_HOME>/resources/security` directory, you must update the `deployment.yaml` file of the corresponding profile in order to make the keystore work.

## Configuring Keystores in Dashboard Profile

For the dashboard profile the required updates need to be done to the `<API-M_ANALYTICS_HOME>/conf/dashboard/deployment.yaml` file for the following use cases.

1. **Databridge configurations**

    This is used for authenticating communication over SSL/TLS between API Manager and APIM Analytics. Handles thrift and binary transports.  
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
    | **keyStoreLocation**   | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |
    | **keyStorePassword**   | Keystore password                                                |

2. **HTTP transport configuration**
   
    This is used for authentication, encryption and signing for the analytics dashboard web application.
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
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |
    | **keyStorePassword**   | Keystore password                                                |
    | **certPass**           | Private key password                                             |
   
3. **Securevault configuration**
   
    This is used to store encrypted passwords that are mapped to aliases.
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
    | **privateKeyAlias**    | Private key password                                                |
    | **keyStoreLocation**   | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |
   

## Configuring Keystores in Worker Profile

For the dashboard profile the required updates need to be done to the `<API-M_ANALYTICS_HOME>/conf/worker/deployment.yaml` file for following use cases.

1. **Databridge configurations**

    This is used for authenticating communication over SSL/TLS between API Manager and APIM Analytics. Handles thrift and binary transports.
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
    | **keyStoreLocation**   | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |
    | **keyStorePassword**   | Keystore password                                                |

2. **HTTP transport configuration**

    This is used for authentication, encryption and signing for the analytics dashboard web application.
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
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |
    | **keyStorePassword**   | Keystore password                                                |
    | **certPass**           | Private key password                                             |
   
3. **Securevault configuration**

    This is used to store encrypted passwords that are mapped to aliases.
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
    | **privateKeyAlias**    | Private key password                                                |
    | **keyStoreLocation**   | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |

4. **Siddhi stores query API configuration**

    This is used for authentication, encryption and signing for the communication to Siddhi store query APIs. 
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
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |
    | **keyStorePassword**   | Keystore password                                                |
    | **certPass**           | Private key password                                             |
      
5. **Siddhi gRPC service**

    This is used for authentication, encryption and signing for the communication to Siddhi gRPC service. 
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
    | **keyStoreFile**       | Name of the keystore file. **The file must be located in `<API-M_ANALYTICS_HOME>/resources/security`** |
    | **keyStorePassword**   | Keystore password                                                |