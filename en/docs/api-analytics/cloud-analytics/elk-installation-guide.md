# ELK Based Analytics Installation Guide



<p id="gdcalert1" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image1.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert2">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image1.png "image_tooltip")


Deployment Diagram


### Analytics Data flow

The new On-Premise Analytics solution for WSO2 API Manager will publish analytics data into a log file and that file will be used as the source for the analytics solution.

ELK based WSO2 API Manager On-Premise Analytics deployment architecture has 4 main components.



1. Filebeats
2. Logstash
3. Elasticsearch
4. Kibana

This section will cover the steps required to configure the WSO2 API-M and then publish it to an external ELK cluster.


## Configurations


### API Manager


        Step 1 - Configuring the deployment.toml file.


            	Edit apim.analytics configurations in the `deployment.toml` file located inside `wso2am-4.x.x/repository/conf` with the following configuration.


```
[apim.analytics]
enable = true
type = "elk"
```



        Step 2 - Enabling Logs


            	To enable logging for a reporter, edit `log4j2.properties` file located inside the `wso2am-4.x.x/repository/conf` directory. 


                a) Add  APIM_METRICS_APPENDER to the appenders  list:


```
appenders = APIM_METRICS_APPENDER, .... (list of other available appenders)
```



                b) Add the following configuration after the appenders:


```
appender.APIM_METRICS_APPENDER.type = RollingFile
appender.APIM_METRICS_APPENDER.name = APIM_METRICS_APPENDER
appender.APIM_METRICS_APPENDER.fileName = ${sys:carbon.home}/repository/logs/apim_metrics.log
appender.APIM_METRICS_APPENDER.filePattern = ${sys:carbon.home}/repository/logs/apim_metrics-%d{MM-dd-yyyy}.log
appender.APIM_METRICS_APPENDER.layout.type = PatternLayout
appender.APIM_METRICS_APPENDER.layout.pattern = %d{HH:mm:ss,SSS} [%X{ip}-%X{host}] [%t] %5p %c{1} %m%n
appender.APIM_METRICS_APPENDER.policies.type = Policies
appender.APIM_METRICS_APPENDER.policies.time.type = TimeBasedTriggeringPolicy
appender.APIM_METRICS_APPENDER.policies.time.interval = 1
appender.APIM_METRICS_APPENDER.policies.time.modulate = true
appender.APIM_METRICS_APPENDER.strategy.type = DefaultRolloverStrategy
appender.APIM_METRICS_APPENDER.strategy.max = 20
```



            c) Add a reporter to the loggers list:


```
loggers = reporter, ...(list of other available loggers)
```


d) Add the following configurations after the loggers:


```
logger.reporter.name = org.wso2.am.analytics.publisher.reporter.elk
logger.reporter.level = INFO
logger.reporter.additivity = false
logger.reporter.appenderRef.APIM_METRICS_APPENDER.ref = APIM_METRICS_APPENDER
```




*  Please schedule a purge task for the apim_metrics log file with an appropriate retention period.


### Configuring ELK


#### Installing Elasticsearch[**]

[Install Elasticsearch](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-elastic-stack.html#install-elasticsearch) according to your operating system.

Make sure Elasticsearch is [up and running](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-elastic-stack.html#_make_sure_that_elasticsearch_is_up_and_running).

*According to the recommendation of ELK, a minimum 3 node cluster is required for a production environment.


#### Installing Filebeat[**]

[Install Filebeat](https://www.elastic.co/guide/en/beats/filebeat/7.13/filebeat-installation-configuration.html#installation) according to your operating system.

Configure Filebeats to read the log file in the repository/logs folder. 


```
filebeat.inputs:
- type: log
  enabled: true
  paths:
    - {apim_home}/repository/logs/apim_metrics.log
  include_lines: ['(apimMetrics):']
output.logstash:
 # The Logstash hosts
 hosts: ["{LOGSTASH_URL}:5044"]
```



#### Installing Logstash[**]

[Install Logstash](https://www.elastic.co/guide/en/logstash/current/installing-logstash.html) according to your operating system.


```
input {
  beats {
    port => 5044
  }
}

filter {
 grok {match => ["message", "%{GREEDYDATA:UNWANTED}\ apimMetrics:%{GREEDYDATA:apimMetrics}\, %{GREEDYDATA:UNWANTED} \:%{GREEDYDATA:properties}"]}
 json {source => "properties"}
}
output {
 if[apimMetrics] == " apim:response" {
   elasticsearch {
     hosts => ["http://{ELK_URL}:9200"]
     index => "apim_event_response"
     user => "elastic"
     password => "Admin1234"
   }
 } else if[apimMetrics] == " apim:faulty" {
   elasticsearch {
     hosts => ["http://{ELK_URL}:9200"]
     index => "apim_event_faulty"
     user => "elastic"
     password => "Admin1234"
   }
 }
}
```



#### Installing Kibana[**]

**Step 1 **

[Install Kibana](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-elastic-stack.html#install-kibana) according to your operating system.

Step 2 

[Launch](https://www.elastic.co/guide/en/elastic-stack-get-started/current/get-started-elastic-stack.html#_access_the_kibana_web_interface) the Kibana web interface.

Step 3 

Logged in to the Kibana dashboards.

Step 4 

Navigate to Stack Management > index pattern. If already have any index patterns created under the following names, please delete them before importing the saved artifacts.


    apim_event*


    apim_event_faulty


    Apim_event_response

Step 5

	Download the artifact file from [this](https://drive.google.com/file/d/12v3EUUO1i07ixEdMXhM_FyHQ839ryVMD/view?usp=sharing) location.

Step 6

Navigate to Stack Management > Saved Object and click on the import button and add the downloaded artifact file as an import object, and import

[*] In order to Enable security follow the guidelines below

[**] Please follow the recommendations by elastic in order to optimize the performance of the system


# Configure Security in ELK

Elastic search supports several authentication modes[1] ranging from basic authentication to Single sign-on with several identity providers.

In this documentation, we mainly focus on configuring single-sign-on with WSO2 API Manager via OpenID Connect. If you are looking for other supported authentication providers, refer to the Official ElasticSearch documentation[1] accordingly.


# Configure Basic Authentication

ElasticSearch supports basic authentication via an internal user store. If you need to set up basic authentication in ElasticSearch and Kibana, refer to the ElasticSearch official documentation at [2].


# Configure Single-Sign-On with WSO2 API Manager via OpenID Connect

ElasticSearch/Kibana deployment can be configured to enable Single-sign-on with WSO2 API Manager via OpenID Connect. To set up SSO with WSO2 API Manager, please refer to the steps mentioned below.


## Prerequisites:

To enable Single-sign-on security features in ELK, an ElasticSearch Platinum subscription is required[3].


## Configure a service provider at WSO2 API Manger

To enable SSO with WSO2 API Manager, first, a service provider needs to be created at the WSO2 API Manager. Please follow the steps mentioned below to create a service provider.



1. Login to the WSO2 API Manager management console at https://&lt;APIM_HOST>:9443/carbon.
2. From the “Main” menu in the left panel, click “Add” under the “Service Providers” section.

    

<p id="gdcalert2" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image2.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert3">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image2.png "image_tooltip")


3. In the “Add New Service Provider” page, create a new service provider by providing the service provider name (ex. kibana).

    

<p id="gdcalert3" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image3.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert4">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image3.png "image_tooltip")


4. Once the service provider is created, go to the service provider, expand the “Claim Configuration” section and configure the claims as depicted in the image below and click “Update”.

    

<p id="gdcalert4" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image4.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert5">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image4.png "image_tooltip")


5. Expand the “Inbound Authentication Configuration” section, then “OAuth/OpenID Connect Configuration” and click on the “Edit” button. 

    

<p id="gdcalert5" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image5.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert6">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image5.png "image_tooltip")


6. In the “View/Update Application Settings” page, set the callback URL as follows.

    regexp=(https://kibana.example.com:5601/api/security/oidc/callback|https://kibana.example.com:5601/security/logged_out)


    

<p id="gdcalert6" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image6.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert7">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image6.png "image_tooltip")


7. Click the “Update” button to save changes.


## Configure OIDC realm in Elastic Search

To configure single sign-on to the Elastic Stack using OpenID connect, follow the steps mentioned at [4].

A sample OpenID connect realm is as follows.

# OpenID Connect realm configurations

xpack.security.authc.realms.oidc.oidc1:

 order: 2

 rp.client_id: "&lt;CLIENT_ID>"

 rp.response_type: code

 rp.redirect_uri: "https://kibana.example.com:5601/api/security/oidc/callback"

 op.issuer: "https://apim.example.com:9443/oauth2/token"

 op.authorization_endpoint: "https://apim.example.com:9443/oauth2/authorize"

 op.token_endpoint: "https://apim.example.com:9443/oauth2/token"

 op.jwkset_path: "https://apim.example.com:9443/oauth2/jwks"

 op.endsession_endpoint: "https://apim.example.com:9443/oidc/logout"

 rp.post_logout_redirect_uri: "https://kibana.example.com:5601/security/logged_out"

 claims.principal: sub

 claims.groups: groups

 ssl.verification_mode: none

 claims.name: name

 claims.mail: email


## Configure Role Mapping for Kibana dashboard

Once the above steps are completed, role mapping needs to be configured in Kibana to allow WSO2 API Manager users to access the dashboards in Kibana. For that follow the steps mentioned below.


### Create Roles are Users in WSO2 API Manager



1. Login to WSO2 API Manager management console at https://&lt;APIM_HOST>:9443/carbon.
2. From the “Main” menu in the left panel, click “Add under the “Users and Roles” section.

    

<p id="gdcalert7" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image7.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert8">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image7.png "image_tooltip")


3. In the “Add Users and Roles” page click the “Add new role” entry.

    

<p id="gdcalert8" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image8.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert9">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image8.png "image_tooltip")


4. In the “Add New Role” page create a new role (ex. AnalyticsViewer” and click the “Finish” button.

    

<p id="gdcalert9" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image9.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert10">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image9.png "image_tooltip")


5. In the “Add Users and Roles” page, click “Add new user/” as mentioned in step 3.
6. In the “Add New User” page, create a new user and click the “Next” button. 

    

<p id="gdcalert10" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image10.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert11">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image10.png "image_tooltip")


7. In the “Step 2: Select Roles of the User” page select the previously created role and click “Finish”.

    

<p id="gdcalert11" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image11.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert12">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image11.png "image_tooltip")




### Create role mapping



1. Login to Kibana using basic authentication and go to “Stack Management” under the “Management” section in the left menu. Then click the “Role Mappings” entry under the “Security” section.
2. In the “Create Role Mapping” page, add a new role mapping by providing a “Mapping name”. 
3. Select a role that has access to the particular dashboard from the “Roles” field.

    

<p id="gdcalert12" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image12.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert13">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image12.png "image_tooltip")


4. Under the “Mapping Rules” section select “groups” as the user field and name of the previously created WSO2 API Manager role as the value and click “Add”.

    

<p id="gdcalert13" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image13.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert14">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image13.png "image_tooltip")


5. Logout from the Kibana and re-login by selecting the “Log in with WSO2” option.

    

<p id="gdcalert14" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image14.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert15">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image14.png "image_tooltip")


6. This will navigate to the WSO2 API Manager login page. Try login with the previously created user credentials.



<p id="gdcalert15" ><span style="color: red; font-weight: bold">>>>>>  gd2md-html alert: inline image link here (to images/image15.png). Store image on your image server and adjust path/filename/extension if necessary. </span><br>(<a href="#">Back to top</a>)(<a href="#gdcalert16">Next alert</a>)<br><span style="color: red; font-weight: bold">>>>>> </span></p>


![alt_text](images/image15.png "image_tooltip")



## Configure SSL/TLS to secure ElasticSearch, Kibana, Beats, and Logstash

For more information regarding configuring SSL/TLS to secure ElasticSearch, Kibana, Beats, and Logstash follow the steps mentioned in the article at [5].


# References

[1] [https://www.elastic.co/guide/en/kibana/current/kibana-authentication.html#basic-authentication](https://www.elastic.co/guide/en/kibana/current/kibana-authentication.html#basic-authentication)

[2] [https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-minimal-setup.html](https://www.elastic.co/guide/en/elasticsearch/reference/7.17/security-minimal-setup.html)

[3] Elastic subscription page

[4] [https://www.elastic.co/guide/en/elasticsearch/reference/7.16/oidc-guide.html](https://www.elastic.co/guide/en/elasticsearch/reference/7.16/oidc-guide.html)

[5] [https://www.elastic.co/blog/configuring-ssl-tls-and-https-to-secure-elasticsearch-kibana-beats-and-logstash](https://www.elastic.co/blog/configuring-ssl-tls-and-https-to-secure-elasticsearch-kibana-beats-and-logstash)
