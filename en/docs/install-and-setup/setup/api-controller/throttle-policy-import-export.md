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

### 1. Get Throttling Policies

Get rate limiting policies operation allows users to list the available rate limiting policies. It also allows the user to filter the rate limiting policies by rate limiting policy levels like Application, Subscription, Advanced, and Custom.

#### Request Samples

``` cURL
curl -k -H "Authorization: Bearer ae4eae22-3f65-387b-a171-d37eaa366fa8" "[https://127.0.0.1:9443/api/am/admin/v4/throttling/policies/search?query=type:app](https://127.0.0.1:9443/api/am/admin/v4/throttling/policies/search?query=type:app)"
```

!!! info "200 Response"
    ```
    {
    "count": 4,
    "list": [
        {
        "policyId": 1,
        "uuid": "93ac7ffa-56ed-4db1-bc46-44a40b5f5559",
        "policyName": "50PerMin",
        "displayName": "50PerMin",
        "description": "Allows 50 request per minute",
        "isDeployed": false,
        "type": "app"
        },
        {
        "policyId": 2,
        "uuid": "0269915e-5b21-42ee-8bc5-4244ae5b569b",
        "policyName": "20PerMin",
        "displayName": "20PerMin",
        "description": "Allows 20 request per minute",
        "isDeployed": false,
        "type": "app"
        },
        {
        "policyId": 3,
        "uuid": "53b9d218-eedb-455c-a54a-29b65d07669e",
        "policyName": "10PerMin",
        "displayName": "10PerMin",
        "description": "Allows 10 request per minute",
        "isDeployed": false,
        "type": "app"
        },
        {
        "policyId": 4,
        "uuid": "18cce6f2-bd2a-4a90-8e81-5ccabc68243c",
        "policyName": "Unlimited",
        "displayName": "Unlimited",
        "description": "Allows unlimited requests",
        "isDeployed": false,
        "type": "app"
        }
    ]
    }
    ```

#### APICTL command

``` tab="Format"
get policies rate-limiting -e &lt;env name>  -q &lt;query>

`-q (query)` - This only allows the user to filter out rate limiting policies by type
```

``` tab="Example"
get  policies  rate-limiting  -e prod  -q type:sub
```

### 2. Export Throttling Policy

Export rate limiting policy allows the user to export a rate limiting policy by name. Since rate limiting policies can exist with the same name across different policy levels, policy levels can also be specified.

``` json
GET /throttling/policies/export

Export a Throttling Policy
```

#### Request Samples

``` cURL
curl -k -H "Authorization: Bearer c7314e65-df37-36e1-8e4a-d02d12769a55" "https://127.0.0.1:9443/api/am/admin/v3/throttling/policies/export?name=Gold&type=sub"
```

!!! info "200 Response"
    ```
    {
    "type": "throttling policy",
    "subtype": "subscription policy",
    "version": "v4.1.0",
    "data": {
        "policyId": "5b7f7985-0a99-45ba-9ba4-016fcfabec54",
        "policyName": "Gold",
        "displayName": "Gold",
        "description": "Allows 5000 requests per minute",
        "isDeployed": true,
        "type": "SubscriptionThrottlePolicy",
        "graphQLMaxComplexity": 0,
        "graphQLMaxDepth": 0,
        "defaultLimit": {
        "type": "REQUESTCOUNTLIMIT",
        "requestCount": {
            "timeUnit": "min",
            "unitTime": 1,
            "requestCount": 5000
        },
        "bandwidth": null,
        "eventCount": null
        },
        "monetization": null,
        "rateLimitCount": 0,
        "rateLimitTimeUnit": null,
        "subscriberCount": 0,
        "customAttributes": [],
        "stopOnQuotaReach": true,
        "billingPlan": "FREE",
        "permissions": null
    }
    }
    ```

#### APICTL command

``` tab="Format"
export policy rate-limiting  -e &lt;env name> -n &lt;policy name>    -- type &lt;policy type>  -- format
```

`-- type` - Here the type is optional and when the type is not given, the first rate limiting policy found with the name is exported. If the user wants to specify a certain policy, then the type can be used.

| Parameter     | Description                                      |
|-------------- |------------------------------------------------- |
| advanced      | to export  advanced rate limiting policies          |
| custom        | to export only custom rate limiting policies        |
| subscription  | to export only subscription rate limiting policies  |
| application   | to export only application rate limiting policies   |

`-- format` - File format of exported file(json or yaml) (default "YAML")

``` tab="Example"
export  policy  rate-limiting   -n Silver  -e prod   -- type subscription
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

### 3. Import Throttling Policy

Import rate limiting policy operation allows users to import exported rate limiting policy files to a different environment and it also has the capability to overwrite existing policies.

```
POST /throttling/policies/import

Import a Throttling Policy
```

#### Request Samples

``` cURL
curl -k -H "Authorization: Bearer a01655d1-77f0-3b58-b90f-9283dd38fd71" "https://127.0.0.1:9443/api/am/admin/v3/throttling/policies/import?overwrite=false" -F file=@Custom-TestCustom.yaml
```

!!! info "200 Response"
    ```
    Successfully imported Custom Throttling Policy : TestCustom
    ```

!!! info "409 Response"
    ```
    {
    "code": 409,
    "message": "Resource Already Exists",
    "description": "Custom Policy with name TestCustom already exists",
    "moreInfo": "",
    "error": []
    }
    ```

#### APICTL command

``` tab="Format"
import policy rate-limiting  -f &lt;file path>   -e &lt;env name>    -- update
```

``` tab="Example"
import  policy rate-limiting   -f ~/Application-Gold  -e prod   -- update

Successfully imported Application Throttling Policy : TestApp
```

****

`--update` - Update an existing rate limiting policy or create a new rate limiting policy

## Importing a rate limiting policy from one environment to another using APICTL

This section covers the steps to import a rate limiting policy from one environment to another.

### Step 1 - Finding the required rate limiting policy name to be exported

In order to export a specific rate limiting policy, the rate limiting policy name should be known. In a case where rate limiting policies exist with the same name in different policy levels, policy type should be known too. For this purpose, the **get policies rate-limiting** command should be used if the policy name/type is unknown.

#### Step 1.1 - Login to the environment

Login to the environment where the rate limiting policy will be exported from.

```bash
$ ./apictl login dev
Username: user
Password:
Logged into the APIM dev environment
```

#### Step 1.2 - List available rate limiting policies

From the list of rate limiting policies we can use the required rate limiting policy name and the type in the export rate limiting policy command.

```bash
$ ./apictl get policies rate-limiting -e Env1
```

### Step 2 - Exporting the required rate limiting policy

Using the rate limiting policy name acquired from the list rate limiting policy is exported as follows.

```
$ ./apictl export policy rate-limiting -e dev -n Gold -t sub
```

If the policy is exported successfully, the policy will be available in the exported location as follows.

```
Subscription-Gold.yaml
```

### Step 3 - Importing the rate limiting policy

Using the exported rate limiting policy file, the rate limiting policy can be imported to the destination environment.

#### Step 3.1 - Login to the environment where the rate limiting policy will be imported to

```
$ ./apictl login prod
Username: user
Password:
Logged into the APIM prod environment
```

#### Step 3.2 - Import the rate limiting policy to the destination environment

Use the file path of the exported rate limiting policy file as the value for the flag `-f` as follows to import the rate limiting policy.

```
$ ./apictl import policy rate-limiting -e prod -f ~home/user/documents/Subscription-Gold.yaml
Successfully imported Throttling Policy : Gold
```
