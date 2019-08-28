# admin\_Managing Keystores with the UI

!!! note
**Important!**

In WSO2 products (based on Carbon 4.4.0 and later versions), you can use the management console to view details of your keystores. To do this, you must first upload the relevant keystore from the UI, and then view details such as the certificates available in the keystore. See details below.


### Prerequisites

All the required keystore files should first be created and stored in the `         <PRODUCT_HOME>/repository/resources/security/        ` directory. For information on how to create new keystore files see [Creating New Keystores](https://docs.wso2.com/display/ADMIN44x/Creating+New+Keystores) , and for information on how to update configuration files in your product with keystore information, see [Configuring Keystores in WSO2 Products](https://docs.wso2.com/display/ADMIN44x/Configuring+Keystores+in+WSO2+Products) .

!!! info
The default `         wso2carbon.jks        ` keystore cannot be deleted.


### Viewing keystore details from the UI

Follow the instructions below to upload a keystore file to the management console.

1.  Log in to the WSO2 product with your username and password.
2.  Go to the **Configure** tab and click **Key Stores** .
3.  The **Key Store Management** page appears. Click the **Add New Key store** link.
4.  Specify the **Provider** and the **Keystore Password** , which points to the password required to access the private key.
5.  In the **Keystore Type** field, specify whether the keystore file you are uploading is JKS or PKCS12.
    -   **JKS** (Java Key Store): Allows you to read and store key entries and certificate entries. However, the key entries can store only private keys.
    -   **PKCS12** (Public Key Cryptography Standards): Allows you to read a keystore in this format and export the information from that keystore. However, you cannot modify the keystore. This is used to import certificates from different browsers into your Java Key store.
6.  Click **Next** and provide the **Private Key Password** .
7.  Click **Finish** to add the new keystore to the list.

8.  The keystore file is saved to the registry of your product. To see the registry path click **Registry → Browse** on the navigator, and go to **\_system → governance → repository → security → key-stores** . The keystores added from the UI will be listed here.

Follow the instructions below to view details of the keystore you uploaded.

1.  Log in to the WSO2 product with your user name and password.
2.  Go to the **Configure** tab and click **Key Stores** .
3.  The **Key Store Management** page appears. All the keystores that are currently added to the product will be listed here.
4.  Click **View** in the list of actions. The **View Key Store** screen shows information about the available certificates.
    ![](attachments/126562694/126562697.png)
    It also displays information about private key certificates:
    ![](attachments/126562694/126562696.png)
5.  Click **Finish** to go back to the **Key Store Management** screen.

