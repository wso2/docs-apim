# Collaborative API Development Sample

This sample scenario elaborates as to how you can develop APIs in a collaborative manner while maintaining different levels of ownership and permissions.

### Use case

-   Each business unit is responsible for their APIs and data. Some of them contain sensitive data. They need to consider security and controllability while providing value to the other business units.

-   Ability to restrict an API (and its development) by business units (e.g., Ability to restrict APIs (view/edit access) that are developed by financial business units to other business units.

-   Selected APIs should be able to be shared (view/edit access) with different business units.

### Business story

-   ABC organization has separate departments for finance and for operations other than their core business department, which is mobile phone manufacturing (manufacturing department).

-   The core business department is named `department_core` , the finance department is named `department_finance` , and the operations department is named `department_operations`.

-   The finance department handles the salaries of the employees. The core department is responsible for maintaining the mobile phone manufacturing stock. The operations department handles the maintenance work of the organization.

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

6.  Enter the scenario number as 2, when prompted.

### User credentials

The following are the user credentials that you need to use when signing in to the WSO2 API Manager instance that has the sample data populated.

| User                                   | Username               | Password |
|----------------------------------------|------------------------|----------|
| Finance department user                | john@finance.abc.com   | 123123   |
| Manufacturing department user          | tom@core.abc.com       | 123123   |
| Operations/Maintenance department user | bob@operations.abc.com | 123123   |

### Implement the scenario

Follow the instructions below to implement the latter mentioned business scenario using WSO2 API Manger.

1.  Create three [different tenants]({{base_path}}/administer/multitenancy/managing-tenants) (`finance.abc.com, core.abc.com,` and `operations.abc.com`) for the three departments, with [users]({{base_path}}/administer/managing-users-and-roles/introduction-to-user-management) (John, Tom, and Bob respectively) who can [create APIs]({{base_path}}/getting-started/quick-start-guide/#step-1-create-and-publish-an-api).

2.  Sign in as a finance department user, [subscribe]({{base_path}}/getting-started/quick-start-guide/#step-2-subscribe-to-the-api) to the `Salary_details_API` API to get the employee salary details.
    The screen shot below shows that user John can subscribe to the `Salary_details_API` API as John belongs to the finance department.

    ![](https://lh4.googleusercontent.com/ykQQyMJbIYkQQMwPA93NAVc1x3JP60x4xmQIkSWaCW8tHKGXFn0_UbmvxZOC3S4NIerRUC9Vmp5mV1MJ38Gs4R6ydL3IXjMP3rFMl_-3Exy937qBC5X1vS9fMvdYVO9cye0z-375)    The screen shot below shows that John can see the API in the publisher view and develop it.
    ![](https://lh3.googleusercontent.com/-GU1vsT-x5CUir1rXiQ32KWww0QVtGszBxWV4rH358Ue57FGbPn3MTQI7Z1gKUQLh8Oegsj2VpmPJeXZSOd_WtU3Uf0npV-cOG71cBv7jw7Kgo2YEl_2Fgu9ZGBUDUjDaRroPgwC)
3.  Sign in as a manufacturing department (core department) user, [subscribe]({{base_path}}/getting-started/quick-start-guide/#step-2-subscribe-to-the-api) to the `Mobile_stock_API` API to get current mobile stock details.
    The screen shot below shows that user **Tom** can subscribe to the `Mobile_stock_API` API as Tom belongs to the core manufacturing department.

    ![](https://lh5.googleusercontent.com/mTtGZel0XK3noSYPGSuHqp0XWpD6-Fl7PX1xTfjO91K4bnj2EVfJ7TPNBeDHHiN3gxrXs2WK3DOrsdxwHbR7n1qM_wJJFwpsR-mxt13TvySLxBAapowTRknt77zwOhXIVc-alqUM)
    The screen shot below shows that Tom can develop the `Mobile_stock_API` API as Tom belongs to core manufacturing department.

    ![](https://lh5.googleusercontent.com/Dj2QKr_rc0uV_j8l35o6O5P_d8vCnFz5f3nCUDniMpz9UXdiZU7l_LTKR7P1AGff7NVdSOLsK8yqO1YZF2Krno4T_E3yi0fnNcsIGNlhOIg0WnE0aS0IQYpNL4ZdTo06fCBMG7np)
    The screen shot below shows that John cannot subscribe to the `Mobile_stock_API` API as John does not belong to the core manufacturing department.

    ![](https://lh5.googleusercontent.com/BNuL3PLtGf2I7p4dboo1I_CNCAyD9-ajT8dEtnCV83XFtQzxx-TiJeNXiqTqSxoVGhvn4uEl9eHIjSK72rvHwsBVao0VLeIAs69MT5uHb350OfzBJ_QE_AObHTHkKmLtWt5oOm4v)
4.  Sign in as an operations' department (maintenance department) user, [subscribe]({{base_path}}/getting-started/quick-start-guide/#step-2-subscribe-to-the-api) to the `Maintenance_ask_API` API to get the required maintenance tasks for the day.

5.  [Allow visibiliy]({{base_path}}/design/advanced-topics/control-api-visibility-and-subscription-availability-in-developer-portal) of the `Employee_info_API` API only to the finance and manufacturing departments, and restrict it to the operations departments, so that the finance and manufacturing departments can get the number of employees working in the core departments.

    !!! tip
        From this you can share/restrict the consumption of the API in the Developer Portal , but you can not share/restrict editing of the API in Publisher. This has been identified as a GAP in WSO2 API Manager 2.1.0


    The screen shots below show that both John and Tom can subscribe to the `Employee_info_API` API as both of them have been given the privilege to access the `Employee_info_API` API.
    ![](https://lh5.googleusercontent.com/ekp5Ym8HxGTHZllT-xKkjyVrEttKOjSTCCYqASvjez4n6L4kM8pNEvBX28ar-G4UJNaJXwgrongIIg0peH-QBe-YCM51ftzgNBnm3GYIOBegsw_69AX9gI4svGNPkQEslp9THf2y)

