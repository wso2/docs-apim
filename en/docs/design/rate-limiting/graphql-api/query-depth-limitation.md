Since GraphQL schemas often have circular relationships, the depth can grow without bounds. 
An example of such a query is as follows:

[![GraphQL Depth Limitation]({{base_path}}/assets/img/learn/graphql-depth-limitation.png)]({{base_path}}/assets/img/learn/graphql-depth-limitation.png)


This relationship allows a bad actor to construct an expensive nested query. WSO2 API-Manager introduces GraphQL **Query 
Depth Limitation** to avoid such cyclic relationships.

The request allowed or rejected based on the depth of the requested query, and the maximum depth value which has been 
configured to the corresponding subscription policy of the API.

For example, assume an API configured with the  GraphQL **Max Depth value of 5**. The **depth value of the following 
requested query is 7**. Therefore, the request query will be **rejected** from the Gateway before reaching the backend.

  ```
        query{							            # depth 0
            allFilms{						        # depth 1
                id							        # depth 2
                Species{
                    id						        # depth 3
                    films{
                        title					    # depth 4
                        planets{
                            id					    # depth 5
                            residents{
                                eyeColor			# depth 6
                                films{
                                    director		# depth 7
                                    producers
                                }
                            }
                        }
                    }
                }
            }
        }

        # depth value of query : 7


  ```

Let's see how **GraphQL Query Depth Limitation** can be managed with your GraphQL API.

### Adding a new Subscription policy with GraphQL Max Depth value

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials 
(admin/admin by default).
2.  Click **Subscription Policies** under the **Rate Limiting Policies** section to see the set of existing 
subscription policies.
3.  To add a new Subscription Policy, click **Add Policy** .
[![Add new Subscription Policy]({{base_path}}/assets/img/learn/add-new-subscription-policy-graphql-query-complexity.png)]({{base_path}}/assets/img/learn/add-new-subscription-policy-graphql-query-complexity.png)
4.  Fill in the required details.
[![Add new Subscription Policy with Max Depth]({{base_path}}/assets/img/learn/create-subscription-policy-with-graphql-depth.png)]({{base_path}}/assets/img/learn/create-subscription-policy-with-graphql-depth.png)
5. click **Save** Button
[![Add Subscription Policy]({{base_path}}/assets/img/learn/save-subscription-policy-graphql-query-analysis.png)]({{base_path}}/assets/img/learn/save-subscription-policy-graphql-query-analysis.png)


### Design a GraphQL API

To design a GraphQL API, see [Create a GraphQL API]({{base_path}}/design/create-api/create-a-graphql-api).

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>
Instead of giving Business Plans of GraphQL API related details in 
<a href="{{base_path}}/design/create-api/create-a-graphql-api">Create a GraphQL API</a>, 
Use Business Plans that you create in the previous steps.
</p>
</div> 
</html>

### Invoke a GraphQL API

To invoke a GraphQL API, see 
[Invoke a GraphQL API]({{base_path}}/consume/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console).

To perform **GraphQL Query Depth Limitation**: 

Enter the following sample query. Then click on execute button as follows.

   ```
    query{
      character(id:1000){
        id
        name
        friendsConnection{
          totalCount
          friends{
            name
            friendsConnection{
              friends{
                name
              }
            }
          }
        }
      }
    }

   ```

   [![GraphQL Depth Limitation]({{base_path}}/assets/img/learn/graphql-depth-limitation-console.png)]({{base_path}}/assets/img/learn/graphql-depth-limitation-console.png)

You have now successfully blocked a GraphQL API query using the **Max Depth** value that you assigned before.

