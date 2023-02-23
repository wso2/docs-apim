## Create an API secured with Mutual SSL

1.  [Create an API](https://apim.docs.wso2.com/en/4.1.0/design/create-api/create-rest-api/create-a-rest-api/).
2.  Click **Develop -> API Configurations -> Runtime**.
3.  Select **Mutual SSL**.
    
     [![Enable mutual SSL](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/enable-mutual-ssl.png)](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/enable-mutual-ssl.png)

4.  Click **Add Certificate** to upload a new client certificate.
    
    !!! note
        This feature currently supports only the `.crt` format for certificates.

        If you need to use a certificate in any other format, you can convert it using a standard tool before uploading it.


5.  Provide an alias and public certificate. Select the tier that should be used to throttle out the calls using this particular client certificate and click **Upload**.
    
     [![Upload Certificate](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/upload-certificate.png)](https://apim.docs.wso2.com/en/4.1.0/assets/img/learn/upload-certificate.png)
    
6.  **Save and Deploy** the API.

