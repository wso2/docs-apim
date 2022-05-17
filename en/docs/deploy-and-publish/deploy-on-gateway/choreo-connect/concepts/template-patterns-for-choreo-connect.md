# Template Patterns for OpenAPI Definitions

You can use these template patterns when defining OpenAPI (Swagger) definitions for APIs that will be deployed on Choreo Connect.
The following is a list of sample patterns that are currently supported in Choreo Connect.

| **Pattern Format** | **Sample request path** |
|-------|---------------------|
| `/{constant1}/{variable1}/{variable2}` | `/foo/p12/e001` |
| `/{constant1}/{variable1}/{variable2}/{constant2}` | `/foo/p20/e002/store` |
| `/{constant1}/{variable1}.{constant2}` | `/foo/baz.id` |
| `/{constant1}/{variable1}.{constant2}/{constant2}` | `/foo/quz.id/qux` |

!!! note
    You cannot define two resources in the same service, as follows, by only changing one path template expression.

    **Example**

    ```
    /echo/{abc}/bar
    /echo/{xyz}/bar
    ```

## Resource Ordering

Choreo Connect Router is backed by Envoy. All the resource paths defined in the OpenAPI (Swagger) definition are applied through a single Envoy configuration as routes.

The routes are matched in the order which they have been configured. Therefore, it's mandatory to order the resources in such a way that, correct resource path is matched when invoking the API.

The resources in the OpenAPI (Swagger) definition will be ordered as below.

### OpenAPI (Swagger) Definition

```
/pet
/pet/{id}
/pet/index.html
/pet/{id}/price
/pet/{id}/{price}
/pet/*
/pet/{petId}.com
/pet/pet.{anc}
/pet/{pet}.{anc}
```

### Ordered resources

```
/pet/index.html
/pet/pet.{anc}
/pet/{petId}.com
/pet/{pet}.{anc}
/pet
/pet/{id}
/pet/{id}/price
/pet/{id}/{price}
/pet/*
```

## Considerations

- The concrete paths are matched first for a given pattern.
- Any path with `.` character gets higher precedence.
- Precedence decreases when the number of path parameters increases.
- The wild card path is matched last.
