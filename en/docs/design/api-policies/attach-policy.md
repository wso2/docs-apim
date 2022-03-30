# Attaching Policies

Follow the instructions below to attach one or more default policies that are shipped with WSO2 API Manager to an API operation of an existing API.

1. Sign in to the WSO2 API Publisher.
    `https://<hostname>:9443/publisher`

2. Click on the API (e.g., `PizzaShackAPI 1.0.0`) for which you want to attach policies to and navigate to the Policies tab.

3. Pick out the desired operation and flow to which you want to attach policies to. Once that is decided, you can expand that API operation. At this point you will notice that by default the UI will open up the first API operation on initial page visit (for PizzaShack API, post `/order` is expanded by default). Let’s attach our first policy to the get resource of `/menu`. Scroll down through the left side column of the UI and click on get /menu API operation. You should be able to see the below screen.

4. Drag the **Add Header Policy** from the **Request** tab of the **Policy List** and drop that to the **Request Flow** dropzone. You will notice a side panel appearing from the right hand side. Enter the following details to attach a custom header to the request flow of the get resource of `/menu` operation. Then, click **Save**.

