# Migrating Rate Limiting Policies to Different Environments

Rate limiting policies exist at different levels such as Application Level, Subscriber Level, Advanced Policy Level, etc. These rate limiting policies can belong to different environments according to the product lifecycle and are related to different APIs or Applications. Of these rate limiting policies, some of them exist as default policies belonging to every environment, and rate limiting policies can be custom-made. You may need to import custom-made or default rate limiting policies from one environment to another.

!!! note
    You may encounter an error when an API or an Application is imported from an environment that has custom-made rate limiting policies to another environment. This happens if the API or the Application has subscribed to a rate limiting policy that is not in the destination environment. Importation fails to indicate the rate limiting policy is not supported.

Before importing either the API or App to the destination environment, rate limiting policies are imported to the destination environment using a separate step. After rate limiting policies are imported to the destination environment, you can import the API/Application to the destination environment without any rate limiting policy support errors.

!!! info
    **Before you begin** 

    -   Make sure apictl is initialized and setup, if not follow the steps in [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).

    -  Make sure to add an environment before you start working with the following apictl commands, because all API Products need to be imported or exported to/from a specific environment.      
    For more information, visit [Add an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller#add-an-environment).

## Export a rate limiting policy

Export rate limiting policy allows the user to export a rate limiting policy by name. Since rate limiting policies can exist with the same name across different policy levels, policy levels can also be specified.

In order to export a specific rate limiting policy, the rate limiting policy name should be known. In a case where rate limiting policies exist with the same name in different policy levels, policy type should be known too. For this purpose, the **get policies rate-limiting** command should be used if the policy name/type is unknown.

Run the following apictl command to export a rate limiting policy.

-   **Command**

    ```bash
    apictl export policy rate-limiting  -e <environment name> -n <policy name>    -- type <policy type>  -- format
    ```

    !!! Info
        **Flags**

        `-- type` - Here the type is optional and when the type is not given, the first rate limiting policy found with the name is exported. If the user wants to specify a certain policy, then the type can be used.

        | Parameter     | Description                                      |
        |-------------- |------------------------------------------------- |
        | advanced      | to export  advanced rate limiting policies          |
        | custom        | to export only custom rate limiting policies        |
        | subscription  | to export only subscription rate limiting policies  |
        | application   | to export only application rate limiting policies   |

        `-- format` - File format of exported file(json or yaml) (default "YAML")

    !!! example

        ```bash
        apictl export  policy  rate-limiting   -n Silver  -e prod   -- type subscription
        ```

    !!! info "Exported File"

        ```
        type: throttling policy
        subtype: subscription policy
        version: v4.2.0
        data:
        policyId: 15797f4c-3742-4909-920c-13f164fd2b1c
        policyName: Silver
        displayName: Silver
        description: Allows 2000 requests per minute
        isDeployed: true
        type: SubscriptionThrottlePolicy
        graphQLMaxComplexity: 0
        graphQLMaxDepth: 0
        defaultLimit:
            type: REQUESTCOUNTLIMIT
            requestCount:
            timeUnit: min
            unitTime: 1
            requestCount: 2000
            bandwidth: null
            eventCount: null
        monetization: null
        rateLimitCount: 0
        rateLimitTimeUnit: null
        subscriberCount: 0
        customAttributes: []
        stopOnQuotaReach: true
        billingPlan: FREE
        permissions: null
        ```


## Import a rate limiting policy

Import rate limiting policy operation allows users to import exported rate limiting policy files to a different environment and it also has the capability to overwrite existing policies.

Run the following apictl command to import a rate limiting policy.

-   **Command**

    ```bash
    apictl import policy rate-limiting  -f <file path>   -e <environment name>    -- update
    ```

    !!! example
        ```bash
        apictl import  policy rate-limiting   -f ~/Application-Gold  -e prod   -- update

        ```

    !!! Info
        **Flag**
        
        `--update` - Update an existing rate limiting policy or create a new rate limiting policy


