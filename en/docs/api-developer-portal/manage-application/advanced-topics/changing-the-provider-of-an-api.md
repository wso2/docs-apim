# Changing the Provider of an API

If required, you can transfer the ownership of your API to another user in your organization. Thereby, when transferring ownership, the new provider/owner will have the required permission to delete or edit the respective API.

For example, let's consider that **Chris** and **Kim** are in the same organization and that **Kim** owns testAPI and he wants to transfer the ownership of testAPI to **Chris**.

Follow the instructions below to change the ownership of an application:

1.  Start the WSO2 API-M Server.
2.  If the users do not exist in the system, create them.

     1. Sign in to the WSO2 API-M Management Console.

         `https://<APIM-hostname>:9443/carbon`

     2. Create two users named **Chris** and **Kim** with the `Internal/creator` role.
        Refer [Create New Users]({{base_path}}/administer/managing-users-and-roles/managing-users#adding-a-new-user) for more information.

3.  We can check the current provider by logging to the publisher portal and by looking at the API tiles.

    1.  Sign in to the WSO2 API-M Publisher Portal using the API owner's (Kim's) user credentials.

         `https://<APIM-hostname>:9443/publisher`

    2.  If the APIs does not exist, create it in the Publisher Portal.

4.  Change the owner/provider of the API.

    1.  Sign in to the WSO2 API-M Admin Portal using admin credentials.
        
         `https://<APIM-hostname>:9443/admin`

    2.  Click **Change Api Provider** under **Settings**.
        This shows you the list of APIs together with the respective providers.

    3.  Search for the APIs that you want to change and click **Edit**.
        [![Search for the API]({{base_path}}/assets/img/learn/changing-api-provider-search.png)]({{base_path}}/assets/img/learn/changing-api-provider-search.png)

    4.  Update the **Provider** field with the new provider's username (Chris).

        !!! Troubleshooting
            If you get a "`Not a valid user `" error (e.g., Chris123 not is a valid user) in the Admin Portal, make sure to request that specific user (e.g., Kim) by checking the spellings.


        The APIs page shows the new ownership.

        [![API page with the new ownership]({{base_path}}/assets/img/learn/changing-api-provider.png)]({{base_path}}/assets/img/learn/changing-api-provider.png)   

        Now, when Kim or Chris signs in to the publisher Portal, the provider name is changed to Chris.
        [![Kim Application List]({{base_path}}/assets/img/learn/api-chris.png)]({{base_path}}/assets/img/learn/api-chris.png)