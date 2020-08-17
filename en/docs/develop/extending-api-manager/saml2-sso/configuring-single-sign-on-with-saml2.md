# Configuring Single Sign-on with SAML2

Single Sign-On (SSO) allows users, who are authenticated against one application, to gain access to multiple other related applications without having to repeatedly authenticate themselves. It also allows the web applications to gain access to a set of back-end services with the logged-in user's access rights, and the back-end services can authorize the user based on different **claims** like the user role.

!!! info
    A claim is a piece of information about a particular subject and it is an attribute of the user that is mapped to the underlying user store. A claim can be anything that the subject is owned by or associated with, such as name, group, preferences, etc. A claim provides a single and general notion to define the identity information related to the subject. A set of claims is called a dialect (e.g., http://wso2.org/claims)


This section covers the following topics.

-   [Configuring Identity Server as IDP for SSO]({{base_path}}/develop/extending-api-manager/saml2-sso/configuring-identity-server-as-idp-for-sso)
-   [Configuring External IDP through Identity Server for SSO]({{base_path}}/develop/extending-api-manager/saml2-sso/configuring-external-idp-through-identity-server-for-sso)

!!! info
    The **Single Sign-On with openID Connect** feature is enabled by default in the API Manager.  
    
!!! tip
    For more information on SAML related terminologies discussed in the sections above, go to [Assertions and Protocols for the OASIS SAML 2.0](https://docs.oasis-open.org/security/saml/v2.0/saml-core-2.0-os.pdf) documentation.


