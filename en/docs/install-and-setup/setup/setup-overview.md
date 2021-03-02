# Setup Overview

Setting up involves doing the required configurations for the API Manager and its components before running them in the production environment. The following are some common set up tasks that you are required to do separately for each component.

- Configuring databases
- Configuring user stores
- Configuring security
- Setting up observability solutions
- Configuring transport
- Performance Tuning

The above activities need to be carried out separately for each runtime. The procedures to execute them are similar, but there can be slight differences between one component to another.

In addition, the component-specific setup tasks are as follows:

- API Manager

    - Configuring key managers
    - Configuring Secondary User Stores
    - Writing a custom user store manager
    - Configuring the authorization manager
    - Configuring caching
    - Customizing the Management Console

- Micro Integrator

    - Setting up the file-based registry
    - Setting up message brokers
    - Setting up message builders and formatters
    - Configuring message relay
    - Time stamp conversion for RDBMS

- Streaming Integrator

    - Configuring business rules deployment
    - Configuring state persistence
    - Configuring cluster coordination
    - Adding third party non-OSGi libraries
    - Enabling logs for received event count


