# WSO2 API Manager Best Practices

Here are the guidelines and recommendations to design and deploy APIs using WSO2 API Manager:

-   [Proper Naming APIs](#WSO2APIManagerBestPractices-ProperNamingAPIs)
    -   [Naming Resources](#WSO2APIManagerBestPractices-NamingResources)
    -   [Naming Complex Resources](#WSO2APIManagerBestPractices-NamingComplexResources)
-   [Proper Versioning](#WSO2APIManagerBestPractices-ProperVersioning)
    -   [Advantages of API Versioning](#WSO2APIManagerBestPractices-AdvantagesofAPIVersioning)
    -   [Major, Minor, Patch Versions](#WSO2APIManagerBestPractices-Major,Minor,PatchVersions)

### Best practices for creating an API

-   [Create APIs](https://docs.wso2.com/display/AM260/Create+and+Publish+an+API) for dedicated backend services.
-   For each of the resources, decide on the [HTTP methods that are used to perform the required application functions](https://docs.wso2.com/display/AM210/Key+Concepts#KeyConcepts-HTTPmethods) . This includes the use of applicable HTTP headers.
-   Decide on special behaviors required by the application (e.g., concurrency control, long running requests).
-   Identify potential [error-prone situations and define corresponding error messages](_Error_Handling_) .

#### Proper Naming APIs

It's important to have proper names for services and service paths. For example, if you create an API related to camera-related operations, you can select a name with camera-related terms such a “camera-api”. When you create a resource for the API, you can select names such as “capture-image”, “delete-image”. Resources must be named properly through URIs (Uniform Resource Identifiers). Proper naming of resources is key to increase the understandability of an API to its users.

Following are some of the guidelines for designing proper API/Resource paths and names. Note that these are not mandatory rules but best practices.

##### Naming Resources

Atomic resources, collection resources, and composite resources should be named as nouns because they represent ‘things’; not ‘actions’. Actions lean more towards verbs as names of resources. Processing-function resources and controller resources should be named as verbs because they represent actions. Function resources and controller resources should not be sub-resources of individual resources.

##### Naming Complex Resources

Use lower case characters only in names. This is because the rules about which URI element names are case sensitive and which are not might cause confusion. If multiple words are used to name a resource, separate the words by dashes (-) or some other separator. Use singular nouns to name atomic resources. Use pluralized names for collections. That is, the name should be the plural noun of the grouped concept (atomic resource or composite resource). Use forward slashes /) to specify hierarchical relations between resources. A forward slash separates the names of the hierarchically structured resources. The parent name precedes the name of its immediate children.

#### Proper Versioning

The version of an API is part of its URI. It is usually given as a pair of integers (separated by a dot) referred to as the major and the minor number of the version, preceded by the lowercase letter "v". For example, a valid version string in the base path is v2.1, indicating the first minor version of the second major version of the corresponding API.

##### Advantages of API Versioning

A proper versioning strategy is helpful for all API users and clients to communicate with APIs easily and effectively. WSO2 API Manager has versioning support. You can copy existing APIs and create new versions of the same APIs. The recommended way to change the functionality of a running API is to create a new version from the existing API. You can then modify the new version, and test the functionalities of the new version before publishing it.

##### Major, Minor, Patch Versions

In general, a version number following the semantic versioning concept and have the structure major.minor.patch. The significance, in terms of client impact, increases from left to right. As a best practice, you should support the current major version and at least one previous, major version. In case you release new versions frequently (e.g., every few months), it is recommended to support more previous major versions.

1.  Patch Version - An incremental patch number means that the underlying modification to the API cannot even be noticed by a client and therefore, the patch number is omitted from the version string. Only the internal implementation of the API has changed while the signature of the API is unchanged. A new patch number can be due to a bug fix, a minor internal modification, etc.
2.  Minor Version - An incremented minor number means that new features have been added to the API, but this addition must be backward compatible. That is, the client can use the old API without failures. For example, the API might add new optional parameters or a completely new request.
3.  Major Version - An incremented major number means that the changes are not backward compatible. For example, new mandatory parameters have been added, former parameters have been dropped, or complete former requests are no longer available.

