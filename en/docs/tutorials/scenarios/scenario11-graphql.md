# Scenario 11 - GraphQL Support

Quantis is more focused on providing more capability to the developer community. They expect the developer community to build their own mobile applications and web apps to use their APIs. To make this process much easier, Quantis wants to expose GraphQL API to the public.

**_Time to Complete : 5 mins_**

<img src="{{base_path}}/assets/img/tutorials/scenario-tutorials/scenario11.png" title="GraphQL Description" width="630"/>

WSO2 API Manager supports creating GraphQL APIs using the GraphQL schema. Following steps can be used to create a sample API.

1. Log in to Publisher Portal [https://localhost:9443/publisher](https://localhost:9443/publisher) using `apiprovider@quantis.com` and password `user123`.
2. Select **Create API → Import GraphQL SDL**

    ![Select GraphQL]({{base_path}}/assets/img/tutorials/scenarios/select-graphql.png)

3. Import the **train.graphql** in the **/resources** and create the API. Use `http://backend-service:8080/train-operations/graphql` as the backend endpoint URL.

    ![Import GraphQL]({{base_path}}/assets/img/tutorials/scenarios/import-graphql.png)

4. Deploy the API and publish it. 
5. Go to the Developer Portal and navigate to the Quantis tenant domain. You will see the GraphQL API in the Developer Portal.

    ![View GraphQL]({{base_path}}/assets/img/tutorials/scenarios/view-graphql.png)
6. Log in to the Quantis Developer Portal using `bob@quantis.com` with password `user123` and subscribe to the GraphQL API using an application and get the access token.
7. You could use the **Try out** tab to try out this GraphQL API. Following is a sample request payload.

```
  schedules {
    entryId
    from
    to
    trainType 
  }
}
```

You receive a response as shown below.

![GraphQL invoke]({{base_path}}/assets/img/tutorials/scenarios/response-graphql.png)

