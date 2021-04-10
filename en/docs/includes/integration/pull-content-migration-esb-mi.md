## Why upgrade to WSO2 API-M 4.0.0?

Listed below are some of the advantages of moving to API-M 4.0.0 from the ESB.

-	The Micro Integrator of API-M 4.0.0 is now the most improved version of the battle-tested WSO2 ESB runtime.

	!!! Tip
		WSO2 ESB 5.0, the ESB profile of WSO2 EI 6.x, the Micro Integrator of WSO2 EI 7.x, as well as the Micro Integrator of WSO2 API-M 4.0.0 contains versions of the same WSO2 ESB runtine. 

-	All the ESB runtimes of WSO2 can use the same developer tool ([WSO2 Integration Studio](../../../integrate/develop/wso2-integration-studio)) for developing integrations. 

-	All the integration capabilities that you used in the ESB can be used in the Micro Integrator with minimal changes.

-	The Micro Integrator contains improvements to ease your product experience.

	!!! Note
		The [Toml-based configuration strategy](../../../reference/config-catalog-mi) in API-M 4.0.0 replaces the XML configurations in previous versions of the ESB runtime. Some of the features are [removed from WSO2 Micro Integrator](../../../get-started/about-this-release/#compare-this-release-with-previous-esbs) as they are not frequently used.  

Upgrading to WSO2 API-M 4.0.0 is recommended for the following requirements:

-	You need to expose integrations as managed APIs so that integration solutions can be managed and monitized in an API marketplace. 
-	You need to switch to a microservices architecture from the conventional centralized architecture.
-	You need a more lightweight, user-friendly version of the battle-tested WSO2 ESB.
-	You need a more lightweight, container-friendly runtime in a centralized architecture.
-	You need native support for Kubernetes.


## Before you begin

Note the following:

-	Ports are different in the Micro Integrator of API-M 4.0.0. Find out about [ports in the Micro Integrator](../../../install-and-setup/setup/mi-setup/changing_default_ports).
-	The Micro Integrator of API-M 4.0.0 contains changes that impact your migration process. Be sure to read the [Comparison: ESB vs the Micro Integrator](../../../get-started/about-this-release/#compare-this-release-with-previous-esbs) before you start the migration.

-	Note that API-M 4.0.0 is a **WUM-only release**, which means that manual patches are not allowed. You can use [WSO2 Update Manager(WUM)](https://updates.docs.wso2.com/en/latest/updates/overview) to get the latest fixes or updates for this release..