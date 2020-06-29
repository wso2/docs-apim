Often, limiting the depth of a query only is not sufficient to protect a GraphQL service from complex queries. 
This is due to some fields in a GraphQL schema being more costly to compute than others. WSO2 API-Manager introduces 
**“Query Complexity Limitation”** to address such cases. 

With this strategy, a request allowed or rejected based on the complexity of the query, and the configured max complexity 
value of the subscription policy for the corresponding API.

Here we introduced the **complexity values for each of the Fields** in the schema. That **describes the 
computation cost of resolving the particular field**. 

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>
If the field needs to call an expensive service to resolve itself, 
then the **complexity should be at a high level** but if the field is easy to resolve and not an expensive operation, 
the **complexity should be at a low level**. If **no complexity defined** for a field, **by default it will get a value of 1.** 
</p>
</div> 
</html>

In run time, we calculate the requested query complexity value. When it exceeds the max complexity, 
then the query will be **rejected.**

Here is a simple example in which you can understand how to calculate query complexity values before request the query.

If there is, no arguments provides in your requested query, can calculate complexity value simply 
adding all the complexity values.

   ```
      query {
       	   allFilms{                   # complexity 1
         		id                     # complexity 3
        		title                  # complexity 1
         		planets {              # complexity 2
           			climate            # complexity 1
         		}
       	   }
      }
      
      # total complexity = 1 + 2 + 1 + 3 + 1 = 8

   ```

With arguments, you can calculate complexity values as follows.

   ```
        query {
         	allFilms(first: 5){          # complexity 1
           		id                       # complexity 1
           		title                    # complexity 1
           		planets(first: 2) {      # complexity 1
             			climate          # complexity 1
           		}
         	}
        }
        
        # total complexity = ((( 1 + 1 ) * 2 ) + 1 + 1 + 1 ) * 5 = 35

   ```  

   ```
        query {
         	allFilms(first: 5){                 #complexity 1
          	 	id                              #complexity 3
           		title                           #complexity 1
           		planets(first: 2) {             #complexity 2
             		climate                     #complexity 3
                    films(first: 5) {           #complexity 1
                         createdAt              #complexity 1
                         director               #complexity 1
                    } 
           		}
         	}
        }

        # total complexity = ((((((1 + 1 + 1)* 5)+ 3 + 2 )* 2)+ 1 + 3 + 1)* 5) = 225

   ```  

Let's see how **GraphQL Query Complexity Limitation** can be managed with your GraphQL API.

### Adding a new Subscription policy with GraphQL Max Complexity value

1.  Sign in to the Admin Portal using the URL `https://localhost:9443/admin` and your admin credentials 
(admin/admin by default).
2.  Click **Subscription Policies** under the **Rate Limiting Policies** section to see the set of existing 
subscription policies.
3.  To add a new Subscription Policy, click **Add Policy** .
[![Add new Subscription Policy]({{base_path}}/assets/img/learn/add-new-subscription-policy-graphql-query-complexity.png)]({{base_path}}/assets/img/learn/add-new-subscription-policy-graphql-query-complexity.png)
4.  Fill in the required details and click **Save** .

### Design a GraphQL API

To design a GraphQL API, see [Create a GraphQL API]({{base_path}}/learn/design-api/create-api/create-a-graphql-api).

<html>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>
Instead of giving Business Plans of GraphQL API related details in 
<a href="{{base_path}}/learn/design-api/create-api/create-a-graphql-api">Create a GraphQL API</a>, 
Use Business Plans that you create in the previous steps.
</p>
</div> 
</html>

### Update field's complexity values of  a GraphQL API
1.  Sign in to the Publisher Portal using the URL `https://localhost:9443/publisher`.
2.  Click **edit button** of the **Query Analysis** tab under the **Run time Configuration** section to see the set of default 
    field's complexity values.
[![See Existing field's Complexity Value]({{base_path}}/assets/img/learn/modify-graphql-complexity-values.png)]({{base_path}}/assets/img/learn/modify-graphql-complexity-values.png)
3.  After Updating complexity values, click **Set** buttons.
[![Update field's Complexity Value]({{base_path}}/assets/img/learn/set-graphql-complexity.png)]({{base_path}}/assets/img/learn/set-graphql-complexity.png)
4.  click **Save** buttons to update the API.
[![Update API with field's Complexity Value]({{base_path}}/assets/img/learn/update-api-with-graphql-complexity.png)]({{base_path}}/assets/img/learn/update-api-with-graphql-complexity.png)



### Invoke a GraphQL API

To invoke a GraphQL API, see 
[Invoke a GraphQL API]({{base_path}}/learn/consume-api/invoke-apis/invoke-apis-using-tools/invoke-an-graphql-api-using-the-integrated-graphql-console).

To perform **GraphQL Query Complexity Limitation**: 

   a. Click **Complexity Analysis** tab to see the Complexity values of the fields.
   [![GraphQL Complexity Limitation]({{base_path}}/assets/img/learn/graphql-complexity-values-read-only.png)]({{base_path}}/assets/img/learn/graphql-complexity-values-read-only.png)

   b. Enter the following sample query. Then click on execute button as follows.

   ```
       query{
             allFilms(first: 5){           
                  id                       
                  title                     
                  planets(first: 2) {        
                        climate 
                        films(first: 5) {
                               createdAt
                               director
                        }          
                  }
             }
       }

   ```
   [![GraphQL Complexity Limitation]({{base_path}}/assets/img/learn/graphql-complexity-limitation-query.png)]({{base_path}}/assets/img/learn/graphql-complexity-limitation-query.png)

You have now **successfully blocked a requested GraphQL query** using the **Max Complexity** value that you assigned before.






