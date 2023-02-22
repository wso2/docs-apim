# Customize API Life Cycle

APIs created in WSO2 API Manager have their own life cycle consisting of the following: a set of life cycle states, specific actions for each state transition, and a checklist of items before a state transition occurs. An API has a predefined life cycle consists of [six states]({{base_path}}/design/lifecycle-management/api-lifecycle/#api-lifecycle-states). This tutorial demonstrates how you can edit the default API lifecycle and customize it according to your requirements.

Follow the steps below to add a new state to the default life cycle.

1.  Sign in to the API Publisher and click on the API that you created previously (e.g., PizzaShackAPI - 1.0.0).
    
2.  Click **Lifecycle** tab to view the current state and states available by default.
    ![Published life cycle state]({{base_path}}/assets/img/learn/default-lifecycle.png)

3.  Open the API Manager Management Console: <https://localhost:9443/admin>

4.  Click on the Advanced tab.

    ![]({{base_path}}/assets/img/learn/admin-dashboard-advanced.png)

5.  By default LifeCycle configuration doesn't appear in the advanced configurations. To view the default LifeCylce configuration type as **LifeCycle** and select **LifeCycle** autosuggested option.

    ![]({{base_path}}/assets/img/learn/admin-dashboard-lifecycle-config.png)    
    
    The default LifeCycle is given below.

    ``` java
    "LifeCycle": {
		"States": [
			{
				"Transitions": [
					{
						"Target": "Published",
						"Event": "Publish"
					},
					{
						"Target": "Prototyped",
						"Event": "Deploy as a Prototype"
					}
				],
				"State": "Created",
				"CheckItems": [
					"Deprecate old versions after publishing the API",
					"Requires re-subscription when publishing the API"
				]
			},
			{
				"Transitions": [
					{
						"Target": "Published",
						"Event": "Publish"
					},
					{
						"Target": "Created",
						"Event": "Demote to Created"
					},
					{
						"Target": "Prototyped",
						"Event": "Deploy as a Prototype"
					}
				],
				"State": "Prototyped",
				"CheckItems": [
					"Deprecate old versions after publishing the API",
					"Requires re-subscription when publishing the API"
				]
			},
			{
				"Transitions": [
					{
						"Target": "Blocked",
						"Event": "Block"
					},
					{
						"Target": "Prototyped",
						"Event": "Deploy as a Prototype"
					},
					{
						"Target": "Created",
						"Event": "Demote to Created"
					},
					{
						"Target": "Deprecated",
						"Event": "Deprecate"
					},
					{
						"Target": "Published",
						"Event": "Publish"
					}
				],
				"State": "Published"
			},
			{
				"Transitions": [
					{
						"Target": "Deprecated",
						"Event": "Deprecate"
					},
					{
						"Target": "Published",
						"Event": "Re-Publish"
					}
				],
				"State": "Blocked"
			},
			{
				"Transitions": [
					{
						"Target": "Retired",
						"Event": "Retire"
					}
				],
				"State": "Deprecated"
			},
			{
				"State": "Retired"
			}
		]
	}
    ```
6.  Update the API lifecycle definition.

    1.  Add a sample state to the API Lifecycle.
        Copy and paste the following sample code in the file.

        !!! info
            The sample **REJECTED** state is added between **PUBLISHED** and **RETIRED** . It uses the `Re-submit` and `Retire` state transition events to change to the consequent states. Custom checklist items are also given under `"checkItems"` , which are tasks to be done in a state transition. You can select/deselect these items in the management console.


        ``` java
         	{
				"State": "Rejected",
				"Transitions": [
					{
						"Event": "Re-Submit",
						"Target": "Published"
					},
					{
						"Event": "Retire",
						"Target": "Retired"
					}
				]
			}
        ```

    1.  Add a new transition event under the PUBLISHED state and under the Transitions, to show the state change to REJECTED.

        ``` java
        ...   
        {
            "Event": "Reject",
            "Target": "Rejected"
		}
        ...
        ```

7.  Restart the WSO2 API Manager server.

8.  Open API Publisher and check the Lifecycle tab to see the newly added state.

    ![]({{base_path}}/assets/img/learn/custom-life-cycle-states.png)

    !!! tip
        Consider the following points when extending and customizing the API lifecycle JSON configuration.

        -   Do not change the life cycle name since it needs to be engaged with the APIs dynamically.
        -   Make sure you keep the **PUBLISHED** and **PROTOTYPED** states as those two states will be used by API Publisher in the API creation wizard.

    !!! info
        By default following lifecycle diagram is added in Publisher portal to show the state changes.

        ![]({{base_path}}/assets/img/learn/lifecycle-image.png)

        If you want to change the lifecycle image in Publisher, you can follow the steps mentioned below:

        -   Search for **lifeCycleImage** in `defaultTheme.json` file resides in `<APIM-Home>/repository/deployment/server/webapps/publisher/src/main/webapp/site/public/conf` directory and uncomment it.
        -   Replace the path with correct path of image. For instance,

                lifeCycleImage: '/publisher/site/public/images/custom-lifecycle.png,

    !!! Tip "For Advanced Customization"
        If you want to add the custom lifecycle state to the existing lifecycle diagram, you have to customize the LifeCycleImage.jsx file located in  `<APIM-Home>/repository/deployment/server/webapps/publisher/src/main/webapp/source/src/app/components/Apis/Details/LifeCycle/` directory, as mentioned in the [Advanced Customization]({{base_path}}/reference/customize-product/customizations/advanced-ui-customization/) section.


For more details on customizing the API lifecycle, see [Extending the API Life Cycle]({{base_path}}/design/lifecycle-management/extending-the-api-life-cycle/).
