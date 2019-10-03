# Deploy and Test Mock APIs

An **API prototype** is created for the purpose of early promotion and testing. You can deploy a new API or a new version of an existing API as a prototype. It gives subscribers an early implementation of the API that they can try out without a subscription or monetization, and provide feedback to improve. After a period of time, publishers can make changes that the users request and publish the API.

!!! note
The example here uses the API `PhoneVerification 2.0.0` , which you created in the [previous tutorial](_Create_a_New_API_Version_) .


1.  Sign in to the WSO2 API Publisher and select the API (e.g., `PhoneVerification 2.0.0` ) that you want to prototype.
`https://<hostname>:9443/publisher         `
    ![Select API - PhoneVerification 2.0.0](/assets/attachments/103328581/103328591.png)

2.  Click **GO TO OVERVIEW** .

3.  Click the **Lifecycle** tab of the API and click **Deploy as Prototype** .
    After creating a new version, you typically deploy it as a prototype for the purpose of testing and early promotion.
    ![](/assets/attachments/103328581/103328582.png)
        !!! tip
    -   Leave the **Requires Re-Subscription** check box cleared if you want all users who are subscribed to the older version of the API to be automatically subscribed to the new version. If not, they need to subscribe to the new version again.

    -   You can choose to deprecate old versions of this API at this stage by selecting the **Deprecate Old Versions** check box.


4.  Sign in to the API Store and click on the newly prototyped API.
`https://<hostname>:9443/store          `
    ![](/assets/attachments/103328581/103328588.png)
    The APIs **Overview** page opens. Note the following:

    -   There are no subscription options.
    -   There are two sets of URLs (with and without the version). This is because you marked the 2.0.0 version as the default version in [step 4 of the previous tutorial](Create-a-New-API-Version_103328571.html#CreateaNewAPIVersion-step4) .
    -   Other features such as documentation, social media, and forums are available.

    ![View overview of PhoneVerification 2.0.0 API](/assets/attachments/103328581/103328585.png)
5.  Click the **API Console** tab.
    Note that the POST method is not available as we removed that in the new version.
    ![Note that the POST method is not available](/assets/attachments/103328581/103328583.png)
    Let's invoke the prototyped API.

6.  In the **API Console** of the prototyped API, expand the GET method, click **Try it out** , and enter the following parameter values.

    |                 |                              |
    |-----------------|------------------------------|
    | **PhoneNumber** | E.g., 18006785432            |
    | **LicenseKey**  | Give 0 for testing purposes. |

    ![Try out the PhoneVerification 2.0.0 API](/assets/attachments/103328581/103328584.png)
7.  Click **Execute** to invoke the API.
    Note the response that appears in the console. You do not have to subscribe to the API or pass an authorization key to invoke a prototyped API.
    ![Response based on the try out option of the PhoneVerification 2.0.0 API](/assets/attachments/103328581/103328587.png)
8.  Similarly, try to invoke the 1.0.0 version of the API without an access token.
    Note that you get an authentication error as "Missing credentials", because version 1.0.0 is a published API.
    ![Try out the PhoneVerification 1.0.0 API](/assets/attachments/103328581/103328586.png)
In this tutorial, you have prototyped an API and tested it along with its older and published versions. In the [next tutorial](_Deprecate_the_Old_Version_) , you can learn how to publish the prototyped API and deprecate its older versions.
