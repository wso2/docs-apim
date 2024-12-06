# AI Related operations with apictl

To ensure that the Marketplace Assistant is fully informed about all published APIs and API Products, it is essential to update the vector database with the current APIs.
**WSO2 API Controller (apictl)** allows you to update the vector Database with the current APIs.

First you have to download and intialize the apictl.

1.  Make sure that the WSO2 API-M is started and that the corresponding version of apictl is set up.   
For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl commands below to delete and upload APIs and API Products from a logged in user's tenant.

### Set token as a config variable

Set the Token (Which is generated for AI features) as a config.

  - **Command**

      ```bash
      apictl set --ai-token "<use token that you generated>"
      ```

### Delete APIs and API Products from vector database.

Run the following command to delete all the APIs and API Products from the vector database from the currently logged-in user's tenant within a specified environment.

- **Command**

      ```bash
      apictl ai delete artifacts -e "<environment>"
      ```

      ```bash
      apictl ai delete artifacts --token "<use token that you generated>" -e "<environment>"
      ```

      ```bash
      apictl ai delete artifacts --token "<use token that you generated>" --endpoint "<endpoint of ai service>" -e "<environment>"
      ```

    !!! info
        **Flags:**  

          -  Required :  
              `--environment` or `-e` : Environment to be searched
          -  Optional :  
              `--token` : On prem key of AI services  
              `--endpoint` : Endpoint url of AI services

    !!! example
          ```bash
              apictl ai delete artifacts -e dev
          ```

          ```bash
              apictl ai delete artifacts --token 2fdca1b6-6a28-4aea-add6-77c97033bdb9 artifacts -e dev
          ```

          ```bash
              apictl ai delete artifacts --token 2fdca1b6-6a28-4aea-add6-77c97033bdb9 artifacts --endpoint https://dev-tools.wso2.com/apim-ai-service -e dev
          ```
    !!! note
          - Note that if you have already set the token to the config variable, you dont have to use the --token flag


### Upload APIs to vector database.

Run the following command to upload all the APIs to the vector database from the currently logged-in user's tenant within a specified environment.

  - **Command**

    ```bash
    apictl ai upload apis -e "<environment>"
    ```

    ```bash
    apictl ai upload apis -e "<environment>" --all
    ```

    ```bash
    apictl ai upload apis --token "<use token that you generated>" --endpoint "<endpoint of ai service>" -e "<environment>"
    ```

    !!! info
        **Flags:**

          -   Required :  
              `--environment` or `-e` : Environment to be searched
          -   Optional :  
              `--token` : On prem key of AI services  
              `--endpoint` : Endpoint url of AI services  
              `--all` : Upload both APIs and API Products.

    !!! example
          ```bash
          apictl ai upload apis -e dev
          ```

          ```bash
          apictl ai upload apis -e dev --all
          ```

          ```bash
          apictl ai upload apis --token 2fdca1b6-6a28-4aea-add6-77c97033bdb9 artifacts -e dev
          ```

          ```bash
          apictl ai upload apis --token 2fdca1b6-6a28-4aea-add6-77c97033bdb9 artifacts --endpoint https://dev-tools.wso2.com/apim-ai-service -e dev
          ```
    !!! note
          - Note that if you have already set the token to the config variable, you dont have to use the --token flag

### Upload API Products to vector database.

Run the following command to upload all the API Products to the vector database from the currently logged-in user's tenant within a specified environment.
  - **Command**
    ```bash
    apictl ai upload api-products -e "<environment>"
    ```
    ```bash
    apictl ai upload api-products -e "<environment>" --all
    ```
    ```bash
    apictl ai upload api-products --token "<use token that you generated>" --endpoint "<endpoint of ai service>" -e "<environment>"
    ```
    !!! info
        **Flags:**
          -   Required :  
              `--environment` or `-e` : Environment to be searched
          -   Optional :  
              `--token` : On prem key of AI services  
              `--endpoint` : Endpoint url of AI services  
              `--all` : Upload both APIs and API Products.  
    !!! example
          ```bash
          apictl ai upload api-products -e dev
          ```
          ```bash
          apictl ai upload api-products -e dev --all
          ```
          ```bash
          apictl ai upload api-products --token 2fdca1b6-6a28-4aea-add6-77c97033bdb9 artifacts -e dev
          ```
          ```bash
          apictl ai upload api-products --token 2fdca1b6-6a28-4aea-add6-77c97033bdb9 artifacts --endpoint https://dev-tools.wso2.com/apim-ai-service -e dev
          ```
    !!! note
          - Note that if you have already set the token to the config variable, you dont have to use the --token flag
This process can be repeated for all tenants.
If you intend to use the same access token across different deployments, you can continue using it without generating a new one each time.
This process ensures that the Marketplace Assistant is up-to-date with all published APIs, enhancing its ability to provide accurate and relevant assistance.
