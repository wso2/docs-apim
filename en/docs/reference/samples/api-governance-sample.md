# API Governance Sample

### Usecase

-   Control and track the broader operational characteristics of how APIs get exposed.

-   Manage and maintain policy characteristics such as metering, SLAs, availability and performance.

-   Policy management specific to different partners and developers.

-   People and persona-driven governance models (who can do what and when).

-   Dependency analysis; track which services fuel which APIs and which APIs fuel which apps.

### Business story

-   Assume that there is an organization that needs to get data related to their API usage. They need to give more traffic to the API’s that are accessed frequently. Out of those APIs, they need to give more traffic to a particular resource in a particular API.

-   This organization has a separate unit that needs traffic management policies to manage their API’s separately.

-   There are users that only need to invoke the APIs. They are not offered API developer capabilities.

-   They need to know how the services are consumed by the end users.

### Business use cases

-   ABC company is a mobile phone manufacturing company. Assume they had a requirement to publish mobile phone stock availability through an API and they need to give more traffic availability to this API’s `getStock` resource.

-   They have a separate finance department to which they need to allocate less traffic since this API is only accessed by the finance department.

-   They have users that do not have privilege to develop the APIs and only have rights to consume the APIs.

-   They need to monitor the API usage, to manage the traffic allocations of the APIs.

### How this business scenario is achieved using WSO2 API Manager

-   Place the `wso2am-analytics-2.2.0-updateX` pack in the same location as the `wso2am-2.2.0-updateX` pack.

-   Custom advanced throttling policies for the APIs.

-   A separate tenant is required for the finance department and custom advanced throttling policies are required for that tenant.

-   Two APIs; one for the super tenant, that exposes the mobile phone prices and the other for the tenant created for the finance department, which is a private API that retrieves salary details of the employees.

-   Engage the new advanced throttle policies with the two newly created APIs above.

-   Create a user who does not have permission to the Publisher.

-   Invoke the APIs and check the analytics graphs to check the API usability statistics.

Below are the screenshots that show the old and new APIs with their respective lifecycle states.

1. Created API for super tenant

    ![](https://lh6.googleusercontent.com/xvaAYnUpBLalpcCLYfP5blUy8P4DkPKdPSJDGd-FzOQrtEP8h3PQjcpjBwf2yeTIhTPyYI0zVnTO1nBGT-Sv8vU8oPDfYKE4XPaCq29lqSlhrSMMCJL750Z_Do8QBG4WeTliFxcL)

2. Created API for finance department

    ![](https://lh6.googleusercontent.com/x1kqXpd2q2vm_9rr5Q8rZHClJEX9h3T-87ph7b8_4zJGxp0I3p2xHCRhgLs0Ider67VOaYTY9FmARDv2WSr53hycsQALmRFoOSwYySEeqRhIcjM9IMqMOUoSpiTk4TxDyHrJ3XXo)

3. Engaged advance throttle policy for the stock `GET` request in super tenant

    ![](https://lh4.googleusercontent.com/0z7Bg6VgIuCSctQhZQ7EGCp01-8MQV7LDqv8KA3LAappv5N9hlSmyK2ynwdHqFjoZkeJcq4lcsVusOJGWPbxLvuIRBRLXEiAfwNX-790V3dpxaOZTz6tagXaJjfwOET-rGl0VN33)

4. Alex can log in to the Developer Portal 

    ![](https://lh6.googleusercontent.com/uHjIwBtisnHDsjLtKDoJgSA0o0F9IZgYCxoRdC9BNAwy1MaHyh08W-nzbA5dI7igWtGLq6vPOB_9QO04EFbRHs_CSMu3kDwQ88yd6cFmllIlDkn7yNlxo4LB1kHqqY9PPG9RvKlq)

5. Alex cannot log in to the Publisher since it has been restricted

    ![](https://lh4.googleusercontent.com/9_czETBGCV3QI3Dg28lIoUIAnG9CNflCNlFFupFN3GJZ3Y13FgMj0GaU_7hLVbr_RAA43LjTsokL21agXBycl-si6xABmbU5i3A4Cdi9RpyzEhQ78rtNlg4oJVfi8fH2RHTiFo6l)

6. Advanced throttling policy engaged to finance department

    ![](https://lh4.googleusercontent.com/bnAnECGCyGJMNpr_4aCKbhATrNphBP3dikcKLL5E8E7dNzt53YucArxmot_oZPghHlxiSlzb_zz7ej0it9Hbde42xymp749_cIpQpZH2-549jaKHksQSFVOWYzTRitKwxN0LNAbO)

7. Add advanced throttling policies in the Admin app

    ![](https://lh3.googleusercontent.com/gfdokYHDiocVtlQHmczfvW2J4znUbiiBJaRJc0RdGA680_8-bDSrhKSMuuKyqmfXsI1qmwsnFs7AM9FlT36khaoPr6kDdrZoSSUELI2Qk9NAnlpLcXHOC4v0A079QMtg_JYpkJQS)

    ![](https://lh4.googleusercontent.com/zKH7GOPOLRVijsqDXlnP_0hEk-TMjupZeeOuq60vjrp5YGiue4ZZRHNC_rbSK13LxI37g229124-ljgu29QswFayy5eq1FGl8UShIErk9jptcsGJivRjVIvot2nAn_xFKXfM8akv)

    ![](https://lh5.googleusercontent.com/zkjtXw8bmpCfC7jWKb5Sn_fplkeplvpRkn2FH5Y0W7u-e9R9sAM27w70RskZpCH5F8bDCQLMMPJdyokrS4ShzStUbjNWLIKxt5Y2CsroYs5I1Zc9XJ2ptsqwjxffdvcJFIU-E4QO)

8. After users start invoking APIs, statistics appear in the Publisher, as shown below:

    ![](https://lh6.googleusercontent.com/_wb8DxrPy4gJ6Y7fdKuf6QMmMsKbvAKSwcOSSbIT_jJGx9MjCnYF_W07PyoooyaqszKDnRYnjKGQNTpVMTmQnoPWAM3V3jY6xWCI5rx_tpyc6h8u4Ufo-BkNW_mnKqo6xL7xlTBR)

    ![](https://lh5.googleusercontent.com/gxW-eTiQfsAk81qNRUJK04JubwDrtywzL-TfEDbq0M08w20FrgW4ViLO71T283S9oiB00QJy-oKVFX-WeWEzERDUfsybG3xlAoxy87tJsVcqt_ySrzTdSYtLo_6TB-mvoj6MAuEV)

    ![](https://lh3.googleusercontent.com/P4GNkfUSNGIpeO0Q4Or0LN2bHkBErn5ktEXKbkulf2rLaoPMde9IC7d8rFH66fcBsyVfEFKQyNKelwxiMnrUdhtJ7WY1aLHlwG0rLOTsiSFRPp57OsABVGMbaDCKk2dVkqtp1ikA)

### Running the sample to populate the sample data

-   Start the wso2am-analytics-2.2.0-updateX distribution.
-   Start wso2am-2.2.0-updateX, after starting the APIM analytics node.
-   Go to `<API-M_HOME>/sample-scenarios`. Execute the `run.sh` file. Enter the scenario number as 9, when prompted.

### User credentials needed for log in

| User                    | Username              | Password |
|-------------------------|-----------------------|----------|
| Super tenant            | admin                 | admin    |
| Store only              | alex                  | 123123   |
| Finance department user | chris@finance.abc.com | 123123   |

!!! info
    **References**
    
    <https://wso2.com/library/articles/2016/09/article-generating-insights-with-wso2-api-manager-analytics/#apistore>


