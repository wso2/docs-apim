# Importing and Exporting Rate Limiting Policies

Rate limiting policies exist at different levels such as Application Level, Subscriber Level, Advanced Policy Level, etc. These rate limiting policies can belong to different environments according to the product lifecycle and are related to different APIs or Applications. Of these rate limiting policies, some of them exist as default policies belonging to every environment, and rate limiting policies can be custom-made. You may need to import custom-made or default rate limiting policies from one environment to another.

You may encounter an error when an API or an Application is imported from an environment that has custom-made rate limiting policies to another environment. This happens if the API or the Application has subscribed to a rate limiting policy that is not in the destination environment. Importation fails to indicate the rate limiting policy is not supported.

Before importing either the API or App to the destination environment, rate limiting policies are imported to the destination environment using a separate step. After rate limiting policies are imported to the destination environment, you can import the API/Application to the destination environment without any rate limiting policy support errors.

## Operations

This feature introduces 3 new operations

1. Get rate limiting policies
2. Export rate limiting policy
3. Import rate limiting policy

Alongside those new operations, 3 new Admin APIs and 3 new APICTL commands are introduced.

## Get rate limiting policies

Get rate limiting policies operation allows users to list the available rate limiting policies. It also allows the user to filter the rate limiting policies by rate limiting policy levels like Application, Subscription, Advanced, and Custom.

Follow the instructions below to display a list of rate limiting API Policies in an environment using apictl:

1.  Make sure that the WSO2 API Manager (WSO2 API-M) is started and that the relevant version of apictl is set up.   
     For more information, see [Download and Initialize the apictl]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#download-and-initialize-the-apictl).
2.  Log in to the WSO2 API-M in the environment by following the instructions in [Login to an Environment]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/#login-to-an-environment).
3.  Run the corresponding apictl command below to get (list) rate limiting Policies in an environment.

    - **Command**
        ```bash
        apictl get policies rate-limiting -e &lt;env name>  -q &lt;query>

        `-q (query)` - This only allows the user to filter out rate limiting policies by type
        ```

        !!! example

            ```bash
            apictl get  policies  rate-limiting  -e prod  -q type:sub
            ```

## Import a rate limiting policy

Import rate limiting policy operation allows users to import exported rate limiting policy files to a different environment and it also has the capability to overwrite existing policies.

Run the following apictl command to import a rate limiting policy.

    -   **Command**

        ```bash
        import policy rate-limiting  -f &lt;file path>   -e &lt;env name>    -- update
        ```

        !!! example
            ```bash
            import  policy rate-limiting   -f ~/Application-Gold  -e prod   -- update

            ```

        !!! Info

            **Flag**
            
            `--update` - Update an existing rate limiting policy or create a new rate limiting policy


## Export a rate limiting policy

Export rate limiting policy allows the user to export a rate limiting policy by name. Since rate limiting policies can exist with the same name across different policy levels, policy levels can also be specified.

Run the following apictl command to export a rate limiting policy.

    -   **Command**

        ```bash
        apictl export policy rate-limiting  -e &lt;env name> -n &lt;policy name>    -- type &lt;policy type>  -- format
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
            version: v4.1.0
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


