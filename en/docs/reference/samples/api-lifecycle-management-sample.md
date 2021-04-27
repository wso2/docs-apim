# API Lifecycle Management Sample

### Usecase

-   Ability to run full lifecycle API Management from the inception stage of an API until it's retirement.

-   Notification mechanisms for informing developers on API changes.

-   Application lifecycle management mechanisms in sync with API lifecycle management.

-   Introduce and execute organization specific lifecycle states.

### Business story

The API lifecycle is one of the key factors in API development. An API lifecycle has predefined states. These states represent the stages that an API has in the process of starting to develop an API until it's retirement. The following is a diagram that describes the current states of an API lifecycle.

![](https://lh4.googleusercontent.com/LJ5_Cspo-HOwG0L6oqDciEVqFRNAURiim11eLRe1PLR1FAfyZioz87xVvAlQLPKrGwFA1MZw4m-i2p3jSuVlEQ2d9EliLVYYhqP75YmU4Zh7WwOfLKbVA1RmBviv6K3px9tfWaTS)

### API lifecycle states

| State      | Description                                                                                                                                                                                                                                                    |
|------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| PUBLISHED  | The API is ready to be used by users in the Developer Portal.                                                                                                                                                                                                         |
| CREATED    | The API has been created, but it is not available for usage.                                                                                                                                                                                                   |
| PROTOTYPED | An API prototype is created for the purpose of early promotion and testing. You can deploy a new API or a new version of an existing API as a prototype. It gives subscribers an early implementation of the API that they can try out without a subscription. |
| BLOCKED    | The API is temporarily blocked from being used. A publisher can publish the API from the BLOCKED state.                                                                                                                                                        |
| DEPRECATED | The old version of the API is DEPRECATED when a newer version of the API is created and PUBLISHED.                                                                                                                                                             |
| RETIRED    | The API is no longer in use and has been moved to the RETIRED state.                                                                                                                                                                                           |

### Business use cases

Assume that ABC is a mobile phone manufacturing company that needs the following:

-   Employee salary details
-   Employee personal details
-   Available stock details
-   Produce sales promotions
-   Stop offering promotions when they capture the market

### How can this business scenario be achieved using WSO2 API Manager?

Separate APIs are required for the following scenario:

-   API needs to get employee salary details while in the PUBLISHED state.

-   API to the is still not published which is in created state to get employee personal details in CREATED state

-   Old API to get available Stock details in DEPRECATED STATE

-   A New API version of the API which is to get available  Stock details PUBLISHED state

-   API to produce sales\_promotions which will be in PUBLISHED state and BLOCKED state when there are no promotions available.

-   API developers must get notifications when a specific API is promoted to published state. This point is by subscribing to the lifecycle state change notification. How to subscribe will be explained below.

For details on how to enable notifications, see [Enabling Notifications]({{base_path}}/design/api-versioning/enabling-notifications).

Follow the steps below to configure API lifecycle state notifications.

1.  Login to carbon console (https://&lt;hostname&gt;:9443/carbon).

2.  Select API media type.

    ![](https://lh5.googleusercontent.com/4I8Y0JG_1Na2Z_rNDtjvb1TepjtZPn_IHzsq2deSJAQxEg7d3QfTpWUjO3-ZfkR3nFC91WdYyJtYtXVC_M0jJZT5_Zp8Eei63j0YHP5C6e3O3VSNiUfsfDmJLV9rXYR9c-K7dNq7)

3.  Select the API from the list.

    ![](https://lh6.googleusercontent.com/1XNRBAgEP2277bVbYyYVSUs7LZ92D14lY8Rc9co4eKL81cXvp_1h2QxpV2E77mk9F4uTmR6_ufDS_aMjKNi-6M_OFT4Me_hdWYtqszyfHejWRhym90bUhElmFCmDlZET5t_Cj6CE)

4.  Go to the API resource and add a subscription to Change\_LC\_State.

    ![](https://lh5.googleusercontent.com/ZjiUmKvz34DkfvuZLuSfJpNv7fRWEM8F7EuKbqAJTCNH2e8DQUU9zFGIgM5Xnsssm8evav31amRqo4EHtCzxmkMNOKKKyFDRLLIvFgEuNW0yqoBDJoBAxKdjjankSvsoj_eC3pO_)
    
5.  Now you will be getting notifications for the API you have subscribed.
    The API to produce sales promotions will be in REJECTED state once the organization decides there will be no longer promotions available in future (since we need to represent the sales promotions when the API is in the BLOCKING state as well, we are creating a new API sales\_promotions\_2 to represent the REJECTED state).

### Running the sample to populate the sample data

1.  Go to `<API-M_HOME>/sample-scenarios`. Execute the `run.sh` file. Enter the scenario number as 7, when prompted.

    After running the sample two APIs in different states (PUBLISHED and BLOCKED) will be created. Note that both APIs have the same name.

    ![](https://lh3.googleusercontent.com/nN7SejYfQj-dANNYF5Km42AvJcA6u3PBlobsRZ_-l076sbtSK1EQULT4NTxEux7BZxDIydZ3P2wL32rKMRU4RTWYEGtuA-XDxNCPK-87Wgmf5VWcCuAzJcUGocDD7warobbTwa4y)

!!! info
    **Related Links**

    -   [Customize the API Life Cycle](https://docs.wso2.com/display/AM260/Customize+API+Life+Cycle)
    -   [Eventing and Notifications with WSO2 Governance Registry](https://wso2.com/library/articles/eventing-notifications-wso2-governance-registry/)
    -   [Adding a Subscription](https://docs.wso2.com/display/Governance530/Adding+a+Subscription)
