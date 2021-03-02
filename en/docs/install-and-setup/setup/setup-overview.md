# Setup Overview

Setting up involves doing the required configurations for the API Manager and its components before running them in the production environment. The following are some common set up tasks that you are required to do separately for each component.

- Configuring databases

    This involves setting up databases for each component to store data.
    
- Configuring user stores

    A user store is the database where information of the users and/or user roles are stored. This topic describes how to configure and manage different types of user stores.
    
- Configuring security

    This covers topic such as key stores, securer vaults, GDPR compliance and working with secrets.

- Setting up observability solutions

    This covers setting up the observability solutions shipped with each component to observe the performance of the different components in your WSO2 API Manager setup.

- Configuring transport

    WSO2 API Manager supports a range of transports. This topic covers how each transport is set up.
    
- Performance Tuning

    This topic covers different configurations done for the WSO2 API Manager and recommends values based on your requirements to optimize performance.

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


