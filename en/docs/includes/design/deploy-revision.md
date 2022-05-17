
Follow the instructions below to deploy a new revision for an API:

1. Sign in to the Publisher.
   
      [https://localhost:9443/publisher](https://localhost:9443/publisher)

2. Navigate to the **Deploy** section and click **Deployments**.
    
      The Deployments page appears as follows when you do not have any existing revisions.

      [![New revision](https://apim.docs.wso2.com/en/4.1.0/assets/img/design/revision/deploy-first-revision.png){: style="width:80%"}](https://apim.docs.wso2.com/en/4.1.0/assets/img/design/revision/deploy-first-revision.png)

      The Deployments page appears as follows when you have at least one revision.

      [![Deploy new revision option](https://apim.docs.wso2.com/en/4.1.0/assets/img/design/revision/deploy-new-revision.png)](https://apim.docs.wso2.com/en/4.1.0/assets/img/design/revision/deploy-new-revision.png)

3. Click **Deploy New Revision**.

    !!! note
        **Skip this step** if you are creating your very first revision.

4.  Optionally, provide a description for the revision.
5.  Select the API Gateways in which you want to deploy the API.
6.  Click **Deploy**.

!!! warning
    You cannot deploy more than 5 revisions. If you want to deploy a new revision after the maximum allowed number of revisions are reached, you need to delete one of the existing revisions.

     [![Delete revision if max count is reached](https://apim.docs.wso2.com/en/4.1.0/assets/img/design/revision/delete-and-deploy-revision.png){: style="width:60%"}](https://apim.docs.wso2.com/en/4.1.0/assets/img/design/revision/delete-and-deploy-revision.png)
