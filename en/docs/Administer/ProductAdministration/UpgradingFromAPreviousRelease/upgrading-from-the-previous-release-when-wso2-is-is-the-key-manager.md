# Upgrading from the Previous Release when WSO2 IS is the Key Manager

The following information describes how to upgrade your **WSO2 API Manager (WSO2 API-M)** environment **from APIM 1.8.0/1.9.0/1.9.1/1.10.0/2.0.0** / **2.1.0/2.2.0/2.5.0 to 2.6.0** when **WSO2 Identity Server (WSO2 IS)** is the **Key Manager** .

!!! tip
You can download the **pre-packaged WSO2 Identity Server 5.7.0, which is also known as Identity Server as the Key Manager 5.7.0** from [here](https://wso2.com/api-management/install/key-manager/) .


-   [**Upgrading from 2.5.0 to 2.6.0**](#250)
-   [**Upgrading from 2.2.0 to 2.6.0**](#220)
-   [**Upgrading from 2.1.0 to 2.6.0**](#210)
-   [**Upgrading from 2.0.0 to 2.6.0**](#200)
-   [**Upgrading from 1.10.0 to 2.6.0**](#110)
-   [**Upgrading from 1.8.0/1.9.0/1.9.1 to 2.6.0**](#8910)

!!! note
-   You can use the following steps in either one of the following situations:
    -   You are currently using a WSO2 IS 5.6.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
    -   You are currently using a pre-packaged WSO2 Identity Server 5.6.0 distribution.

-   If you wish to upgrade your APIM environment from **API-M 2.5.0 to 2.6.0** , which is using the **internal** WSO2 Identity Server ( **WSO2 IS** ) **capabilities** , follow the instructions in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) .

Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 2.5.0 to 2.6.0** when using **WSO2 IS** as the **Key Manager:**

1.  [Migrate the WSO2 Identity Server (WSO2 IS) from version 5.6.0 to 5.7.0](https://docs.wso2.com/display/IS570/Upgrading+from+the+Previous+Release) as described in the WSO2 Identity Server 5.7.0 documentation.

2.  Migrate WSO2 API-M from 2.5.0 to 2.6.0.
    Follow the instructions mentioned in the Upgrading from 2.5.0 to 2.6.0 tab, which is in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#250) , but **skip** **step 2 - (5)** , which explains how to migrate the WSO2 API-M Identity component.

!!! note
-   You can use the following steps in either one of the following situations:
    -   You are currently using a WSO2 IS 5.5.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
    -   You are currently using a pre-packaged WSO2 Identity Server 5.5.0 distribution.

-   If you wish to upgrade your APIM environment from **API-M 2.2.0 to 2.6.0** , which is using the **internal** WSO2 Identity Server ( **WSO2 IS** ) **capabilities** , follow the instructions in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#220) .

Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 2.2.0 to 2.6.0** when using **WSO2 IS** as the **Key Manager:**

1.  Migrate the WSO2 Identity Server (WSO2 IS) from version 5.5.0 to 5.7.0.
    Follow the instructions given in [Upgrading From an Older Version of WSO2 IS](https://docs.wso2.com/display/IS570/Upgrading+From+an+Older+Version+of+WSO2+IS) section of the WSO2 Identity Server 5.7.0 documentation.

2.  Migrate WSO2 API-M from 2.2.0 to 2.6.0.
    Follow the instructions mentioned in the Upgrading from 2.2.0 to 2.6.0 tab, which is in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#220) , but **skip** **step 2 - (6)** , which explains how to migrate the WSO2 API-M Identity component.

!!! note
-   You can use the following steps in either one of the following situations:
    -   You are currently using a WSO2 IS 5.3.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
    -   You are currently using a pre-packaged WSO2 Identity Server 5.3.0 distribution.

-   If you wish to upgrade your APIM environment from **API-M 2.1.0 to 2.6.0** , which is using the **internal** WSO2 Identity Server ( **WSO2 IS** ) **capabilities** , follow the instructions in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#210) .

Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 2.1.0 to 2.6.0** when using **WSO2 IS** as the **Key Manager:**

1.  Migrate the WSO2 Identity Server (WSO2 IS) from version 5.3.0 to 5.7.0.
    Follow the instructions given in [Upgrading From an Older Version of WSO2 IS](https://docs.wso2.com/display/IS570/Upgrading+From+an+Older+Version+of+WSO2+IS) section of the WSO2 Identity Server 5.7.0 documentation.
2.  Migrate WSO2 API-M from 2.1.0 to 2.6.0.
    Follow the instructions mentioned in the Upgrading from 2.1.0 to 2.6.0 tab, which is in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#210) , but **skip** **step 2 - (7)** , which explains how to migrate the WSO2 API-M Identity component.

!!! note
-   You can use the following steps in either one of the following situations:
    -   You are currently using a WSO2 IS 5.2.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
    -   You are currently using a pre-packaged WSO2 Identity Server 5.2.0 distribution.
-   If you wish to upgrade your APIM environment from **API-M 2.0.0 to 2.6.0** , which is using the **internal** WSO2 Identity Server ( **WSO2 IS** ) **capabilities** , follow the instructions in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#200) .
Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 2.0.0 to 2.6.0** when using **WSO2 IS** as the **Key Manager:**

1.  Migrate the WSO2 Identity Server (WSO2 IS) from version 5.2.0 to 5.7.0.
    Follow the instructions given in [Upgrading From an Older Version of WSO2 IS](https://docs.wso2.com/display/IS570/Upgrading+From+an+Older+Version+of+WSO2+IS) section of the WSO2 Identity Server 5.7.0 documentation.
2.  Migrate WSO2 API-M from 2.0.0 to 2.6.0.
    Follow the instructions mentioned in the Upgrading from 2.0.0 to 2.6.0 tab, which is in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#200) , but **skip** **step 2 - (6)** , which explains how to migrate the WSO2 API-M Identity component.

!!! note
-   You can use the following steps in either one of the following situations:
    -   You are currently using a WSO2 IS 5.1.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
    -   You are currently using a pre-packaged WSO2 Identity Server 5.1.0 distribution.

-   If you wish to upgrade your APIM environment from 1.10.0 to 2.6.0, which is using the **internal** WSO2 Identity Server ( **WSO2 IS** ) **capabilities** that exists in WSO2 API Manager ( **WSO2 API-M** ), go to [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#110) .

Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 1.10.0 to 2.6.0** when using **WSO2 IS** as the **Key Manager:**

1.  Migrate the WSO2 Identity Server (WSO2 IS) from version 5.1.0 to 5.7.0 .
    Follow the instructions given in [Upgrading From an Older Version of WSO2 IS](https://docs.wso2.com/display/IS570/Upgrading+From+an+Older+Version+of+WSO2+IS) of the WSO2 Identity Server 5.7.0 documentation.

2.  Migrate **WSO2 API-M** from **1.10.0 to 2.6.0.**
    Follow the instructions mentioned under **Upgrading from 1.10.0 to 2.6.0** , which is in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#110) , but **skip** **step 2 - (4) and (9)** , which explains how to migrate the WSO2 API-M Identity component.

!!! note
-   You can use the following steps in either one of the following situations:
    -   You are currently using a WSO2 IS 5.0.0 vanilla distribution that has WSO2 API Management related Key Manager features installed on top of it.
    -   You are currently using a pre-packaged WSO2 Identity Server 5.0.0 distribution.

-   If you wish to upgrade your APIM environment from 1.8.0/1.9.0/1.9.1 to 2.6.0, which is using the **internal** WSO2 Identity Server ( **WSO2 IS** ) **capabilities** that exists in WSO2 API Manager ( **WSO2 API-M** ), go to [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#8910) .

Follow the instructions below to upgrade WSO2 API-M **from WSO2 API-M 1.8.0/1.9.0/1.9.1 to 2.6.0** when using **WSO2 IS** as the **Key Manager:**

1.  Migrate the WSO2 Identity Server (WSO2 IS) from version 5.0.0 to 5.7.0.
    Follow the instructions given in [Upgrading From an Older Version of WSO2 IS](https://docs.wso2.com/display/IS570/Upgrading+From+an+Older+Version+of+WSO2+IS) of the WSO2 Identity Server 5.7.0 documentation.

2.  Migrate **WSO2 API-M** from **1.8.0/1.9.0/1.9.1 to 2.6.0.**
    1.  Migrate WSO2 API-M from **1.8.0/1.9.0/1.9.1 to 2.0.0** .
        Follow the instructions mentioned in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM200/Upgrading+from+the+Previous+Release) , but **skip** **steps (7) to (10)** , which explains how to migrate the WSO2 API-M Identity component.

    2.  Migrate WSO2 API-M from **2.0.0 to 2.6.0** .
        Follow the instructions mentioned under **Upgrading from 2.0.0 to 2.6.0** , which is in [Upgrading from the Previous Release](https://docs.wso2.com/display/AM260/Upgrading+from+the+Previous+Release#200) , but **skip** **step 2 - (6)** , which explains how to migrate the APIM Identity component.


