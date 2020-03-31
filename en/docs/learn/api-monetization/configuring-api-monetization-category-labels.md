# Configuring API Monetization Category Labels

When defining throttling tiers using the Admin Portal, you have the option to specify a given billing plan for tiers. A tier is defined as either a free or paid tier. Depending on the tiers available for a given API, the following API monetization categories are displayed as labels in the Developer Portal.

-   **Free** - If all subscription tiers are defined as Free, the API uses the **Free billing plan** and the API is labeled as Free in the Developer Portal.

-   **Paid** - If all subscription tiers are defined as Paid, the API uses the **Commercial billing plan** and the API is labeled as Paid in the Developer Portal.

-   **Freemium** - If the API has a combination of Free and Paid subscription tiers, the API uses the **Freemium billing plan** and the API is labeled as Freemium in the Developer Portal.

Follow the configuration steps below to enable API monetization category labels:

1.  Sign in to the API Manager's Management Console ( `https://<hostname>:9443/carbon` ).
2.  Navigate to the **Main** menu, and click **Browse** , which is under the **Resources** tab.
3.  Enter the following path in the **Location:** text-box and click **Go** .
`/_system/config/apimgt/applicationdata/          tenant-conf.json         `
    ![]({{base_path}}/assets/attachments/103333418/103333419.png)4.  In the **Contents** panel, click the **Edit as text** link and the `tenant-conf.json` file opens.
5.  To enable monetization categories for APIs, set the `EnableMonetization` property to true. By default, it is set to false.
6.  Define the subscription tiers as required.
    For example if you are working with the unlimited tier,

    -   To define the unlimited tier as **paid** , set the `IsUnlimitedTierPaid` property to true.
    -   To define the unlimited tier as **free** , set the `IsUnlimitedTierPaid` property to false.

        !!! tip
    As Freemium APIs has a combination of paid and free subscription tiers, the configuration involved in defining the subscription tiers will be the same as above. However, Freemium APIs need to have a minimum of one subscription defined as paid and free.


7.  After the edits, click **Save Content** .

!!! tip
Note that the above configuration can be done independently on a per tenant basis.


When the above `EnableMonetization` property is set to true for the respective tenant, the API monetization category labels are displayed in the tenant Developer Portal.

![]({{base_path}}/assets/attachments/103333418/103333420.png)
**Related links**

For more information on Monetization of APIs, see [Enabling Monetization of APIs-](https://docs.wso2.com/pages/viewpage.action?pageId=97564601) .
