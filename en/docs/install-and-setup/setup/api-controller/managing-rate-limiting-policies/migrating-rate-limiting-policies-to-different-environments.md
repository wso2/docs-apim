# Importing a rate limiting policy from one environment to another using APICTL

This section covers the steps to import a rate limiting policy from one environment to another.

### Step 1 - Finding the required rate limiting policy name to be exported

In order to export a specific rate limiting policy, the rate limiting policy name should be known. In a case where rate limiting policies exist with the same name in different policy levels, policy type should be known too. For this purpose, the **get policies rate-limiting** command should be used if the policy name/type is unknown.

#### Step 1.1 - Login to the environment

Login to the environment where the rate limiting policy will be exported from.

```bash
$ ./apictl login dev

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
```

#### Step 3.2 - Import the rate limiting policy to the destination environment

Use the file path of the exported rate limiting policy file as the value for the flag `-f` as follows to import the rate limiting policy.

```
$ ./apictl import policy rate-limiting -e prod -f ~home/user/documents/Subscription-Gold.yaml
Successfully imported Throttling Policy : Gold
```
