# CI/CD-Driven API Governance

## API Governance with WSO2 APICTL

WSO2 APICTL is a command-line tool that enables you to manage APIs and microservices within the WSO2 API Manager.  
It provides a mechanism to automate governance validations as part of your CI/CD pipeline, 
helping enforce API governance policies consistently.

To ensure that an API complies with governance policies before it is imported, you can use the `--dry-run` 
flag with the `import` command. This performs a compliance check without actually importing the API and outputs a list 
of rule violations that must be addressed before the API can be successfully imported into the API Manager environment.

```bash
apictl import api --file <path-to-API-archive> --environment <environment> --dry-run
```

!!! note "Applicable Governance Policies"
    In dry run mode, APIs are validated against all global policies configured in the target API Manager environment.

Integrating this step into your CI/CD pipeline helps ensure that only compliant APIs are promoted across environments, 
improving governance and reducing the risk of introducing faulty APIs.

For more information on how to use WSO2 APICTL, refer to the 
[WSO2 APICTL documentation]({{base_path}}/install-and-setup/setup/api-controller/getting-started-with-wso2-api-controller/).

