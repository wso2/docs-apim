# Scenario 11 - GraphQL Support

## User Story

**Quantis is more focused on providing more capability to the developer community. They expect the developer community to build their own mobile applications and web apps to use their APIs. To make this process much easier, Quantis wants to expose GraphQL API to the public.**

**_Time to Complete : 5 mins_**

![GraphQL description]({{base_path}}/assets/img/tutorials/scenarios/graphql-schema-import.png)

WSO2 API Manager supports creating GraphQL APIs using the GraphQL schema. Following steps can be used to create a sample API.

1. Log in to publisher portal [https://localhost:9443/publisher](https://localhost:9443/publisher) using apiprovider@quantis.com and password _user123_
2. Select **Create API → Import GraphQL SDL**

    ![Select GraphQL]({{base_path}}/assets/img/tutorials/scenarios/select-graphql.png)

3. Import the **train.graphql** in the **/resources** and create the API. use `http://backend-service:8080/train-operations/graphql` as the backend endpoint url

    ![Import GraphQL]({{base_path}}/assets/img/tutorials/scenarios/import-graphql.png)

4. Deploy the API and publish it. 
5. Go to the Dev portal and navigate to the Quantis tenant domain. You will see the GraphQL API in the portal.

    ![View GraphQL]({{base_path}}/assets/img/tutorials/scenarios/view-graphql.png)
6. Log in to the Quantis developer portal using bob@quantis.com with password user123 and subscribe to the GraphQL API using an application and get the access token.
7. You could use the **Try out** tab to try out this GraphQL API. Following is a sample request payload

```
  schedules {
    entryId
    from
    to
    trainType 
  }
}
```

You should be able to get a response as below

![GraphQL invoke]({{base_path}}/assets/img/tutorials/scenarios/response-graphql.png)

