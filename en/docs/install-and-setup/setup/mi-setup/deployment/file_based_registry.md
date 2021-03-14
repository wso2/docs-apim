# Configuring the File-Based Registry

WSO2 Micro Integrator is shipped with a file-system-based registry. By default, the `MI_HOME/registry/` folder acts as the registry that stores registry artifacts. This root registry folder consists of the following sub-registry folders:

* **Local**
* **Config**
* **Governance**

The artifacts can be stored in any of the above folders based on the requirement and use case. The directory structure is maintained to have backward compatibility with previous EI versions.

If you want to change the default locations of the registry folders, uncomment and change the following configuration in the `MI_HOME/repository/deployment/server/synapse-configs/default/registry.xml` file:

```xml
<registry xmlns="http://ws.apache.org/ns/synapse" provider="org.wso2.micro.integrator.registry.MicroIntegratorRegistry">
    <parameter name="cachableDuration">15000</parameter>
    <!--
        Uncomment below parameters (ConfigRegRoot, GovRegRoot, LocalRegRoot) to configure registry root paths
        Default : <MI_HOME>/registry/{governance | config | local}
        Example : <parameter name="GovRegRoot">file:///Users/JohnDoe/registry/governance</parameter>
    -->
    <!--
    <parameter name="ConfigRegRoot">{Root directory path for configuration Registry}</parameter>
    <parameter name="GovRegRoot">{Root directory path for governance Registry}</parameter>
    <parameter name="LocalRegRoot">{Root directory path for local Registry}</parameter>
    -->
</registry>
```
