# Using Symmetric Encryption

!!! note
The capability of using symmetric encryption was introduced by the Carbon 4.4.3 release. Therefore, note that this feature is only applicable to products that are based on Carbon 4.4.3 or later versions.


WSO2 Carbon-based products use [asymmetric encryption](https://docs.wso2.com/display/ADMIN44x/Using+Asymmetric+Encryption) by default as explained in the previous section. From Carbon 4.4.3 onwards, you have the option of switching to symmetric encryption in your WSO2 product. Using symmetric encryption means that a single key will be shared for encryption and decryption of information.

Follow the steps given below to enable symmetric encryption.

1.  Open the `carbon.xml` file from the `<PRODUCT_HOME>/repository/conf` directory.
2.  Add the following properties:

    ``` java
        <SymmetricEncryption>
            <IsEnabled>true</IsEnabled>
            <Algorithm>AES</Algorithm>
            <SecureVaultAlias>symmetric.key.value</SecureVaultAlias>
        </SymmetricEncryption>
    ```

    -   The `IsEnabled` property is used to set symmetric encryption to ' `true` ' or ' `false` '.

    -   The `Algorithm` property specifies the symmetric key algorithm used.
    -   The `SecureVaultAlias` property is used to specify the secret alias if secure vault has been used to encrypt the secret key.

3.  Create a file named ' `symmetric-key.properties` ' in the `<PRODUCT_HOME>/repository/resources/security` folder and enter the symmetric key using the `symmetric.key` property. See the following example where a plain text key is entered in the `symmetric-key.properties` file:

    ``` java
            symmetric.key=samplekeyvalue
    ```

    If Secure Vault has been used for encrypting the symmetric key, this value will be replaced by the secret alias as shown below. F or detailed instructions on how the secret key can be encrypted using Secure Vault, s ee [Encrypting Passwords with Cipher Tool](https://docs.wso2.com/display/Carbon443/Encrypting+Passwords+with+Cipher+Tool) .

    ``` java
            symmetric.key=secretAlias:symmetric.key.value
    ```


