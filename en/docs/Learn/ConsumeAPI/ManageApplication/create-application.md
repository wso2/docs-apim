# Create Application

#### Overview

An application is a logical representation of an physical application such as mobile app, webapp, device etc. If an 
application to consume an API, it should subscribe to the required API over a 
selected 
business 
plan, which determined the usage quota the application is allowed to have. A single application can 
have 
multiple 
API subscriptions. Each application 
has consumer key 
and 
consumer secret pair and the requests to the subscribed APIs are authenticated via the tokens generated using them. 

Applications allow you to:

-   Generate and use a single key for multiple APIs
-   Subscribe multiple times to a single API with different Service Level Agreements (SLAs)/business plans which 
operate on per access token basis



The API Manager comes with a pre-created default application, which allows unlimited access by default. You can also 
[create](create-application.md####Create Applications) your own.

#### **Create Applications**

1.  Sign in to WSO2 API developer portal ( `https://<hostname>:9443/devportal`).

2.  Click **Applications** tab.

3.  Click **ADD NEW APPLICATION** button.
![Add new application option](../../../assets/img/Learn/add-new-application-option.png)   

4.  Enter the application details and click **SAVE** button to create the application.
   
       Let's create an application with the following details.
   
     <html>
        <table>
        <th>Field</th><th>Value</th>
        <tr><td>Application Name</td><td>PizzaShackApp</td></tr>
        <tr><td>Per Token Quota</td><td>10PerMin</td></tr>
        <tr><td>Token Type</td><td>JWT</td></tr>
        <tr><td>Description</td><td>PizzaShack Application</td></tr>
        </table>
     </html>
   
     ![Add new Application](../../../assets/img/Learn/create-new-application.png)
      
    If the application creation is successful, you will be redirected to the application overview page

     ![Application_overview](../../../assets/img/Learn/application-overview.png)
    
5.  Navigate to Applications listing page, and you will find the PizzaShack application listed with other applications
. The application can be edited or deleted by the application owner.

    ![Applications_listing](../../../assets/img/Learn/applications-listing.png)

    
