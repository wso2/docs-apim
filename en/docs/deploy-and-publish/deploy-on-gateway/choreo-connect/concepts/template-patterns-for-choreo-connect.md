# Template Patterns for Swagger Definitions¶

The following is a list of sample patterns currently supported in Choreo Connect.

|Pattern| Sample request path |
|-------|---------------------|
|/foo/{bar}/{baz}| /foo/p12/e001 |
|/foo/{bar}/{baz}/store| /foo/p20/e002/store|
|/foo/{bar}.id| /foo/baz.id|
|/foo/{bar}.id/qux |/foo/quz.id/qux|

Note that you cannot define two resources in the same service with only a path template expression change. An example is shown below.

    /echo/{abc}/bar
    /echo/{xyz}/bar

## Resource Ordering

Choreo Connect router is backed by Envoy. All the resource paths defined in the OpenAPI/ Swagger definition are applied through a single Envoy configuration as routes.
The routes are matched in the order which they have been configured. Therefore, it's mandetory to order the resources in such a way that, correct resource path is matched when invoking the API.

The resources in the Swagger/ OpenAPI definition will be ordered as below.

#### Swagger/ OpenAPI Definition

    /pet
    /pet/{id}
    /pet/index.html
    /pet/{id}/price
    /pet/{id}/{price}
    /pet/*
    /pet/{petId}.com
    /pet/pet.{anc}
    /pet/{pet}.{anc}

#### Ordered resources

    /pet/index.html
    /pet/pet.{anc}
    /pet/{petId}.com
    /pet/{pet}.{anc}
    /pet
    /pet/{id}
    /pet/{id}/price
    /pet/{id}/{price}
    /pet/*

## Considerations

- The concrete paths are matched first for a given pattern
- Any path with . character gets higher precidence
- Precedence decreases when the number of path parameters increses.
- The wild card path is matched last.
