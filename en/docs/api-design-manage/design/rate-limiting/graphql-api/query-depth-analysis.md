# Limit Query Depth

GraphQL schemas often have circular relationships between types. For example, a Film can have Characters, and each Character can reference Films, creating a potentially infinite loop. Without protection, clients could construct deeply nested queries that consume excessive resources.

Query Depth Limitation protects your GraphQL API by restricting how many levels deep a query can nest. Queries exceeding the configured maximum depth are rejected before reaching your backend.

!!! tip
    Depth limits are defined in subscription tiers by Administrators. As a Publisher, you select which tiers to make available for your GraphQL API. For creating custom subscription tiers with depth limits, see [Adding a new subscription-level Rate Limiting tier]({{base_path}}/design/rate-limiting/adding-new-throttling-policies/#adding-a-new-subscription-level-rate-limiting-tier).

## Understanding Query Depth

Query depth is calculated by counting the levels of nesting in a GraphQL query. Each level of selection adds one to the depth.

**Example of a deeply nested query:**

```graphql
query {                         # depth 0
    allFilms {                  # depth 1
        id                      # depth 2
        Species {
            id                  # depth 3
            films {
                title           # depth 4
                planets {
                    id          # depth 5
                    residents {
                        eyeColor            # depth 6
                        films {
                            director        # depth 7
                            producers
                        }
                    }
                }
            }
        }
    }
}

# Query depth: 7
```

If your API has a subscription tier configured with a maximum depth of 5, this query would be rejected because its depth (7) exceeds the limit.

## How Depth Protection Works

When a client sends a query:

1. The Gateway analyzes the query structure before execution
2. Calculates the maximum depth of nested selections
3. Compares it against the depth limit in the application's subscription tier
4. Rejects the query if it exceeds the limit, preventing it from reaching your backend

This protects your backend services from expensive nested queries that could:

- Trigger cascading database queries
- Consume excessive memory and CPU
- Cause slow response times or timeouts
- Enable denial-of-service attacks

## Assigning Subscription Tiers with Depth Limits

To apply depth-based limits to your GraphQL API:

1. Log in to the API Publisher.
2. Select your GraphQL API and navigate to **Portal Configurations** > **Subscriptions**.
3. Select subscription tiers that include GraphQL Max Depth values.

Applications subscribing to your API will be limited by the depth value defined in their chosen tier.

!!! note
    Choose appropriate depth limits based on your schema structure and backend capabilities. Consider the deepest legitimate queries your clients need to make, and set limits slightly above that to allow flexibility while preventing abuse.

By assigning subscription tiers with appropriate depth limits, you protect your GraphQL backend from expensive nested queries while ensuring legitimate use cases remain functional.
