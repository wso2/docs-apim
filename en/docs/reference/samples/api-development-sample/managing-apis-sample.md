# Managing APIs Sample

This sample scenario elaborates as to how you can manage public vs. partner vs. private APIs with WSO2 API Manager.

### Use case

The following are the use cases with regard to managing public vs. partner vs. private APIs.

Ability to use some of the APIs internally.

Ability to share a subset of the internal APIs with partners.

As a result of the latter mentioned use case, it should facilitate the development of an API ecosystems with partners across industries (e.g., ability to book a hotel and a car as well at the time of booking a flight).

-   Connect with APIs that are owned by your partner

-   Enable partners to connect with your APIs

Expose some of the APIs as public APIs to expand the business operations.
Maintain a further subset of the APIs so that it can be exposed as public APIs. Many of the APIs that are used internally and with partners can be used as public APIs in order to drive additional business and help obtain new customers.

### Business story

-   ABC organization is an organization that has separate departments for finance and operations other than their core business department which is mobile phone manufacturing.

-   The core business, finance, and operations departments are named `department_core` , `department_finance,` and `department_operations` respectively.

-   The finance department handles the salaries of employees. The core department is responsible for maintaining the mobile phone manufacturing stock. The operations department handles maintenance work of the organization.

Description of each API is as follows:

1.`Employee_info_API` - Used by the core and finance departments.
2.`Mobile_stock_API` - This API is used to get details of the current mobile stock details, and is used by the core department.
3.`Salary_details_API` - This API is used to get details with regard to the salary of the employees, and is used by the finance department.
4.`Maintenance_Task_API` - An API used to get maintenance tasks required for the day.

![](https://lh3.googleusercontent.com/TndW0UspSf-By5jSqI2icjTqGeMAz_OJ9IFH6Vpwi2sg-1wYGtRYo4dF8uPHaVdrnbF6THMbJGLmAGumZVcRs6DyqDg2Vbh6Ul3hQyhUxNp_I2D_bNQBK_mL_tFL5GeVy9ZOe6x1)

The following user cases are related to the above mentioned sample business scenario.

1.  The finance department ( `deparment_finance)` needs to get the salary of each and every employee. This data is private to the finance department.

2.  The core department ( `department_core)` needs to know the details about the stocks (e.g., the current stock price). This is private to the core department.

3.  The finance and core departments both need to know the details of the employees who are working in Core department. This data is only provided to the core and finance departments. The operations department should not be able to access the latter mentioned data.

4.  The core department ( `department_core)` and the public need to know the current prices of the mobile phones.

5.  The operations department ( `department_operations` ) needs to know the maintenance tasks required for the day.

6.  When a public user gets the details with regard to the price of a phone, which belongs to brand “A” and model “B”, that same user should automatically shown the prices of the phone pouches that correspond to that relevant phone model.

### Running the sample

Run the sample as follows to populate the sample data:

1.  Download the WSO2 API Manager sample scenarios.
2.  Unzip the sample-scenarios ZIP file and rename the unzipped folder to `sample-scenarios`.
3.  Copy the sample-scenarios folder to the `<API-M_HOME>` folder.
4.  Start the WSO2 API Manager Server.

5.  Go to `<API-M_HOME>/sample-scenarios` directory and execute the `run.sh` file.

    ``` java
    ./run.sh
    ```

6.  Enter the scenario number as 1, when prompted.

### User credentials

The following are the user credentials that you need to use when signing in to the WSO2 API Manager instance that has the sample data populated.

| User                          | Username               | Password |
|-------------------------------|------------------------|----------|
| Finance department user       | john@finance.abc.com   | 123123   |
| Manufacturing department user | tom@core.abc.com       | 123123   |
| Maintenance department user   | bob@operations.abc.com | 123123   |

### Implementing the scenario

You need to do the following in WSO2 API Manager.

1.  Create three different tenants for the three departments with users that can create APIs.
    The screen shot below illustrates the tenants in the system.
    ![Screen Shot 2017-11-06 at 12.44.52 PM.png](https://lh4.googleusercontent.com/oMiEmHvzB4_da7u73NFndYy9jX4kb-xPd9RGZTFvWDNELFgy3n6E5PucZGPdMLQ7g8XsB5g05JFPBAfWFqbnUjfbrkrO2vgrmWraM4QILWk20fwbcpCETr5GLi0aSPdtpDUjyL3Y)    The following screen shot depicts the created APIs.
    ![Screen Shot 2017-11-06 at 12.44.27 PM.png](https://lh5.googleusercontent.com/QP3OUsHtC5wzTRgm2NXF-xSWFDVO4P83D-e4o-7iCSK5QpkjTqbDubD0A8KB64veigzut2H1g0zU6yQ8NF6nlsUPw1GhuhmMCTLVmrDnRd5WwD3NiS4XLoj4DC9jtMyQr1VTuqQm)

2.  Create an API that is visible only to the tenant who is part of the finance department, in order to get the employee salary details.

    The screen shot below illustrates that John can subscribe to the `Salary_details_API` as John belongs to the finance department.

    ![](https://lh4.googleusercontent.com/qNWQwd8rGZtB60_-35Kvl-_pSbr6b1v-HV5xpNisC6hSmuhzwuxS7yqJ9nvGAmixiyG4yPQkKNq3-Vh8XLpWtCdCgvJLZxx-DHBwvQ2SS7DSokNedNQwAI7yqCgNeP7b0YElEs2R)
    
    The screen shot below illustrates that John can not subscribe to the `Mobile_stock_API,` because John does not belong to the core manufacturing department.

    ![](https://lh4.googleusercontent.com/4CJqeBTVFNIvpO4ru51Bmau4xKAQBfWUmSajJW9Q1lmakjliRN6CGqM42G8_s8LoIx15TL2Ik19PZEAKDpTlraD92lWzp2zka2L03wZ25p9A7lLJfqC5L0XNjXQPL94ZQmuZIiU5)

3.  Create an API that is visible only to the tenant who is part of the core department, in order to get the current mobile stock details.
    The screen shot below illustrates that Tom can subscribe to the `Mobile_stock_API` as Tom belongs to the core manufacturing department.

    ![](https://lh4.googleusercontent.com/OgzIm1qMm2rf3bMLOPDJvJoYUuYAUmOrYphz8kCEu_v4NVsJfq5pV8LGYH0VS7gSMQHT4SGhNWe0nxxdcTMfiw1ZG_dYxGk_AbuErshwZyitRBdgPK3Dd8TuECwSN7aHrVzbXbx0)

4.  Create an API that is visible only to the tenant who is part of the operations department, in order to get the maintenance tasks that are required for the day.

5.  Create an API subscription that is visible only to the finance and core departments, but restricted to the operations departments, in order to get the details of employees who are working in the core departments.

    The screen shots below illustrates that both John and Tom can subscribe to `Employee_info_API` as they have permission to access the `Employee_info_API` API.

    ![](https://lh4.googleusercontent.com/z_LemPELjVnLxEeUFnRE_k_4n_61f623W5CK40xM7pKr6eWXBhVl3l66f_GyhLDKSgz--c7TuZD9GiPJI_NnL2BLXItMl1sWEUk-L5W3L1HNjyJnPsDeB-dsK0AOgDO2M7ziCGSk)
    ![](https://lh4.googleusercontent.com/Zw-6MUwhd9t4TC1WZtuRyniG28Cz1W_R8y6329shKqdpnLqWI2CDyo2w5gkp451kxHiYrLcvLAMLOHol90pfSi6l6oVOInAVj_AObTJynbpYGF4fXUfvz6Xj4KSnmFHb0Uj11ef7)

6.  Create an API that is publicly visible, to get mobile phone prices by exposing the API to the mobile phone prices. This API should be tagged as “mobile”.

    !!! note
        Depending on the situation, you can specify the "Visibility on the Developer Portal " as Public, which means that the API is accessible to everyone, or you can restrict by roles, whereby the API is visible only to specific user roles in the tenant store that you specified).

7.  Create an API to get the prices of the mobile pouches. This should also have the tag “mobile”. In this scenario, when an application client sends a request for the mobile phone prices it will also send a request to another API that has the same tag and get the relevant results. (When a user buys a mobile, it should predict the available matching mobile pouches that are for sale.)

You can invoke and check the API’s after subscribing to the relevant API’s and generating the keys.
