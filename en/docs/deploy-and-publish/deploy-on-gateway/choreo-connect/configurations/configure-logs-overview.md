# Overview

Logging in choreo connect is really important when debugging issues in a short period of time and looking into the underlying details of how each component works.  Choreo connect provides facilities for getting the logs in various formats (JSON, Plain text), various output methods and various logging levels.

In addition to these, the adapter and enforcer components have been defined with a set of error codes for each of the components’ error logs, in order to narrow down the details of errors. Following are the error codes ranges for each of the components.

- Adapter error codes range from 1000 to 4999.
- Enforcer error codes range from 5000 to 8999.

!!! Info

    JSON formatted logs are not supported for HTTP Access logs in both enforcer and router. Also the router does not have these logging customization options as it's using pure envoy.

!!! note

    This documentation does not contain enough information about error codes to narrow down on errors.   
