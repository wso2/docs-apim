# WS-Security Implementations

Web services security, or to be more precise, SOAP message security
identifies and provides solutions for general computer security threats
as well as threats unique to Web services. WSO2 Micro Integrator supports WS-Security,
WS-Policy, and WS-Security Policy specifications. These specifications
define a behavioral model for Web services. 

Since a requirement for one
web service may not be valid for another, the WSO2 Micro Integrator also helps define service-specific security.
It provides 16 predefined, commonly-used security scenarios. All you
have to do is apply the required security scenario when you define the service. You can also define a custom security
policy. Understanding the exact security requirement is the first step
in planning to secure web services. Consider what security aspects are
important to your service; integrity, confidentiality,
or both.

## Applying WS-Security

See the following resources on how to apply WS security to integration artifacts:

-	[Securing a proxy service]({{base_path}}/integrate/develop/advanced-development/applying-security-to-a-proxy-service)
-	[Securing a data service]({{base_path}}/integrate/develop/creating-artifacts/data-services/securing-data-services)
-	[Securing a REST API]({{base_path}}/integrate/develop/advanced-development/applying-security-to-an-api)

!!! Note
	An [external user store](../../../setup/user_stores/setting_up_a_userstore) should be configured for the Micro Integrator in order to use these security implementation.

## Security scenarios

The topics below explain the 16 default security scenarios supported by WSO2 Micro Integrator.

### UsernameToken

![ws scenario 1]({{base_path}}/assets/img/integrate/ws-security/scenario1.png)

### Non-repudiation

![ws scenario 2]({{base_path}}/assets/img/integrate/ws-security/scenario2.png)

### Integrity

![ws scenario 3]({{base_path}}/assets/img/integrate/ws-security/scenario3.png)

### Confidentiality

![ws scenario 4]({{base_path}}/assets/img/integrate/ws-security/scenario4.png)

### Sign and Encrypt - X509 Authentication

![ws scenario 5]({{base_path}}/assets/img/integrate/ws-security/scenario5.png)

### Sign and Encrypt - Anonymous clients

![ws scenario 6]({{base_path}}/assets/img/integrate/ws-security/scenario6.png)

### Encrypt Only - Username Token Authentication

![ws scenario 7]({{base_path}}/assets/img/integrate/ws-security/scenario7.png)

### Sign and Encrypt - Username Token Authentication

![ws scenario 8]({{base_path}}/assets/img/integrate/ws-security/scenario8.png)

### Secure Conversation - Sign only - Service as STS - Bootstrap policy - Sign and Encrypt , X509 Authentication

![ws scenario 9]({{base_path}}/assets/img/integrate/ws-security/scenario9.png)

### Secure Conversation - Encrypt Only - Service as STS - Sign and Encrypt , X509 Authentication

![ws scenario 10]({{base_path}}/assets/img/integrate/ws-security/scenario10.png)

### Secure Conversation - Sign and Encrypt - Service as STS - Bootstrap policy - Sign and Encrypt , X509 Authentication

![ws scenario 11]({{base_path}}/assets/img/integrate/ws-security/scenario11.png)

### Secure Conversation - Sign Only - Service as STS - Bootstrap policy - Sign and Encrypt , Anonymous clients

![ws scenario 3]({{base_path}}/assets/img/integrate/ws-security/scenario12.png)

### Secure Conversation - Encrypt Only - Service as STS - Bootstrap policy - Sign and Encrypt , Anonymous clients

![ws scenario 13]({{base_path}}/assets/img/integrate/ws-security/scenario13.png)

### Secure Conversation - Encrypt Only - Service as STS - Bootstrap policy - Sign and Encrypt , Username Token Authentication

![ws scenario 14]({{base_path}}/assets/img/integrate/ws-security/scenario14.png)

### Secure Conversation - Sign and Encrypt - Service as STS - Bootstrap policy - Sign and Encrypt , Username Token Authentication

![ws scenario 15]({{base_path}}/assets/img/integrate/ws-security/scenario15.png)

### Kerberos Token-based Security

If you apply security scenario 16 (Kerberos Token-based Security), you
must associate your service with a service principal. Security scenario
16 is only applicable if you have a Key Distribution Center (KDC) and an
Authentication Server in your environment. Ideally you can find KDC and
an Authentication Server in an LDAP Directory server.

Two configuration files are used to specify Kerberos related parameters
as follows.

-   **krb5.conf** - Includes KDC server details, encryption/decryption
    algorithms etc.
-   **jaas.conf** - Includes information relevant to authorization.

The above files are located in the `MI_HOMErepository/conf/security` folder.  

After selecting scenario 16, fill in the information about the service
principal to associate the Web service . You must specify the
service principal name and password. The service principal must be
already defined in the LDAP Directory server.
