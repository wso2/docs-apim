# Setting up the Ceridian Dayforce Environment

The Dayforce Connector allows you to access the REST API of [Ceridian Dayforce HCM](https://www.ceridian.com/products/dayforce), which lets you store your human capital information and retrieve them back when needed. 

To use the Dayforce cloud service, you must have a [Dayforce HCM](https://www.dayforcehcm.com) account. To test the REST API of Dayforce we will use a Dayforce developer account, which is free and lets us access a developer Dayforce instance.

## Signing Up for Dayforce Developer Account

* **To sign up for Dayforce Developer Account:**

    1. Navigate to [Ceridian Dayforce Developer Network](https://developers.dayforce.com) and select **Register**.
    2. Follow the online instructions.

If your company has already purchased a namespace in Dayforce, use that to sign up. Otherwise, you can still use their 
sample environment by selecting sample option.

## Obtaining Test User Credentials

Navigate to **API Explorer > Employee > GET Employees**. There you can see the basic authentication credentials, username and password for the sample environment. Click on the GET method to expand it. Execute the method to view the request and response corresponding to the GET Employees method. In the request you can see the sample environment URI.
