# API Analytics Architecture

!!! note
    **Support for Choreo Analytics has been deprecated:**
    Choreo Analytics has been deprecated in favor of Moesif-powered WSO2 Analytics, which offers enhanced insights and observability.

The following diagram illustrates the basic architecture of the Analytics solution.

<a href="{{base_path}}/assets/img/analytics/apim-analytics-simplified.jpg"><img src="{{base_path}}/assets/img/analytics/apim-analytics-simplified.jpg" width="70%" alt="APIM Analytics Simplified Design"></a>

As depicted above, the Gateways will publish analytics statistics directly to the Analytics Cloud over the internet. The Analytics Cloud will have regional deployments to reduce publishing latencies and honor data privacy.
