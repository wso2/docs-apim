## Why migrate to EI 7.1?

Listed below are some of the advantages of moving to EI 7.1 from the ESB.

-	The Micro Integrator of EI 7.1 is now the most improved version of the battle-tested WSO2 ESB runtime.

	!!! Tip
		WSO2 ESB 5.0, the ESB profile of WSO2 EI 6.x, as well as the Micro Integrator of WSO2 EI 7.x contains versions of the same WSO2 ESB runtine. 

-	All the ESB runtimes of WSO2 can use the same developer tool ([WSO2 Integration Studio](../../../develop/WSO2-Integration-Studio)) for developing integrations. 

-	All the integration capabilities that you used in the ESB can be used in the Micro Integrator with minimal changes.

-	The Micro Integrator contains improvements to ease your product experience.

	!!! Note
		The most significant change in EI 7.1 is the [Toml-based configuration strategy](../../../references/config-catalog), which replaces the XML configurations in previous versions of the ESB runtime. Some of the features are [removed from WSO2 Micro Integrator](../../../overview/about-this-release-7.1.0/#features-removed) as they are not frequently used. 

Migration from WSO2 ESB is recommended for the following requirements:
 
-	You need to switch to a microservices architecture from the conventional centralized architecture.
-	You need a more lightweight, user-friendly version of the battle-tested WSO2 ESB.
-	You need a more lightweight, container-friendly runtime in a centralized architecture.
-	You need native support for Kubernetes.

## Before you begin

Note the following:

-	Ports are different in the Micro Integrator of EI 7.1.0. Find out about [ports in the Micro Integrator](../../../setup/changing_default_ports).
-	The Micro Integrator of EI 7.1 contains changes that will impact your migration process. Be sure to read the following resources before you start. 

	-	[Comparison: ESB vs the Micro Integrator](../../../overview/about-this-release-7.1.0/#feature-comparison)
	-	[Features removed from the Micro Integrator](../../../overview/about-this-release-7.1.0/#features-removed)

-	Note that EI 7.x is a **WUM-only release**, which means that manual patches are not allowed. You can use [WSO2 Update Manager(WUM)](https://docs.wso2.com/display/updates/WSO2+Updates) to get the latest fixes or updates for this release..