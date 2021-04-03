# API Versioning Sample

### Use case

API versioning is a key functionality that needs to be addressed when the users, who are using a specific API for a long time, need to add, remove, or change the API. When doing this, the users of the old API should be taken into consideration. Therefore, when introducing the new API the old API should also be supported for a specific time period. The time period is offered to the users of the old API to modify the availability of the new API and to make the transition. When the given time period ends, the old API can be retired. This ensures that API updates would function smoothly when they are upgraded, versioned, or moved between environments, geographical locations, data centers , and the cloud. API versioning also transfers contracts with app developers to new versions and makes the [alpha and beta testing](http://toolsqa.com/software-testing/difference-between-alpha-testing-and-beta-testing/) processes easier.

### Business Story

-   ABC company is a mobile phone manufacturing company. They have a requirement to publish mobile phone prices through an API.
-   When the industry grows with the prices, they need to publish some additional data such as a rating, user reviews of the mobile phones, etc.
-   Users of the old API should know that there is a new API version released, and they need to be notified.

### Running the sample

-   Start wso2am-2.2.0-updateX.
-   Go to `<API-M_HOME>/sample-scenarios`. Execute the `run.sh` file:

    ``` bash
        bash run.sh
    ```

    Enter the scenario number, when prompted.

### Implement using WSO2 API Manager

-   Expose the mobile phone details through an API. The original API would be deprecated. The state of the API would change from PUBLISHED to DEPRECATED.
    ![](https://lh4.googleusercontent.com/Px0QeRqdQie5X6VSWVTItRrXWmnKoVBdaAiNUSXwtse6V681PJ0S45meQLw7Q54Tf9bLGXQGm68yrRkWET2DXDiuY6-hl1ZGKV9Z34VY84R65u3tlbZ3vMqVRVMVufqsQvj37V0Q)
-   A new version of the same API would be created and published.
    ![](https://lh6.googleusercontent.com/K5L2gQQZzI1ijIuS9KMorXA0l5bZs7x5mdsdn9NyXRYVf_a9H45pk3S_vyTTWtR_naX_xZTtOY4-yd0xRDkjE2n3s1jyzmJbVZZoEIBNGVryW_OIFV7SKfrQWDrBHOKj76u-G3ft)
-   Both APIs will exist at the same time, allowing users of the old API to access the resources.
    ![](https://lh4.googleusercontent.com/san9j-KzZXoKcKZ77uIuvo9eG4-3gz-rXE1xbaJGe4RyqVsXjcrv3QkjGIEOl0Y5Rc50z_CN-Dx7wS8JWaWwIXgdGw99kW-6g9d1Typfazf8l8AbNpbKyR3R0uI30exuLk44Y8Q_)
-   Subscribers of the old API to notified when the new API version is published.

Users can configure to get notifications for the newly created API. For more details, see [Enabling Notifications]({{base_path}}/design/api-versioning/enabling-notifications).

!!! note
    Enabling grace period to upgrade to a new version can be achieved by using the notifications when a new version of an API is created. At that time, when a new version of an API is created, a notification should be sent to existing subscribers to notify that the API will be deprecated in X months and retired in Y months. Then API Publisher have to perform those actions (deprecation and retiring) in X and Y months time period respectively.


