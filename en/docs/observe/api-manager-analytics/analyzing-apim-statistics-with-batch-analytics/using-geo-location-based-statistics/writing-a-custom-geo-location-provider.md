# Writing a Custom Geolocation Provider

Each Geolocation Resolver implementation in WSO2 Analytics is inherited from the `org.wso2.carbon.analytics.apim.spark.geolocation.api.LocationResolver` abstract class has the following methods.

-   **`getLocation`** : This contains the Geolocation Resolving implementation. Only this method needs to be implemented for this scenario.

-   **`init`** : This contains the Geolocation Resolver implementation

To customize the default Geolocation Resolver extension, you should override the `getLocation()` method with your custom implementation. For example, the following class is a sample implementation of the Geolocation Resolving service It returns the `Location` according to the IP of the Geolocation API that provided through the configuration on each IP resolving through the UDF.

``` java
/*
*  Copyright (c) 2016, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
*  WSO2 Inc. licenses this file to you under the Apache License,
*  Version 2.0 (the "License"); you may not use this file except
*  in compliance with the License.
*  You may obtain a copy of the License at
*
*    http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
*/

package com.wso2.carbon.analytics.apim.spark.geolocation.impl;
import org.wso2.carbon.analytics.apim.spark.geolocation.api.Location;
import org.wso2.carbon.analytics.apim.spark.geolocation.api.LocationResolver;
import org.wso2.carbon.analytics.apim.spark.geolocation.exception.GeoLocationResolverException;

public class CustomLocationResolver extends LocationResolver {
   private String restUrl;
   private String username;
   private String password;

   @Override
   public void init() throws GeoLocationResolverException {

   }

   public Location getLocation(String ip) throws GeoLocationResolverException {
       return null;
   }

   public String getRestUrl() {
       return restUrl;
   }

   public void setRestUrl(String restUrl) {
       this.restUrl = restUrl;
   }

   public String getUsername() {
       return username;
   }

   public void setUsername(String username) {
       this.username = username;
   }

   public String getPassword() {
       return password;
   }

   public void setPassword(String password) {
       this.password = password;
   }
}
```

Compile as a jar file and copy into `<Product-home>/repository/components/lib` folder.
Configure the above class in geolocation.xml under `<Product-home>/repository/conf/etc` as following way.

``` xml
<GeoLocation>
    <Implementation class="com.wso2.carbon.analytics.apim.spark.geolocation.impl.CustomLocationResolver">
        <Property name="restUrl">http://localhost:80080/geolocation/service</Property>
        <Property name="username">admin</Property>
        <Property name="password">admin</Property>
    </Implementation>
    <Cache>
        <enabled>true</enabled>
        <IpResolveCacheCount>10000</IpResolveCacheCount>
    </Cache>
</GeoLocation>
```
