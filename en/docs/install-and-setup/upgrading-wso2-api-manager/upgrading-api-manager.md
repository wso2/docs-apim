# Upgrade WSO2 API Manager

This document walks you through the process of upgrading WSO2 API Manager. 

## Why upgrade?

There are multiple reasons why you would want to upgrade the WSO2 product to the latest version. These reasons include but are not limited to the following.  

- The current product version you are using is reaching its end of life. To see if this is the case, view the [support matrix documentation](https://wso2.com/products/support-matrix/). 
- You want to leverage the new features of the latest version of the product.
- The version of the product you have does not have certain security and bug fixes that you require.

## What has changed

Over the course of its lifetime, WSO2 API Manager has changed significantly. To learn what’s new in the WSO2 API Manager 4.4.0 release, see the [About this Release page]({{base_path}}/get-started/about-this-release/).

<div class="admonition info">
    <p class="admonition-title">Seamless product upgrade from WSO2 API Manager 4.2.0</p>
    <p>If you are upgrading from WSO2 API Manager 4.2.0 to 4.4.0, you can experience a seamless product upgrade with no data migration. This pivotal change facilitates a smooth transition for current API Manager 4.2.0 users to the latest version, eliminating the need for complex migrations.</p>
    <p><strong>How to perform the seamless upgrade:</strong></p>
    <ol>
        <li><strong>For All-in-One deployment:</strong> Simply install WSO2 API Manager 4.4.0 in place of your existing 4.2.0 installation. The existing database and configuration will be automatically compatible.</li>
        <li><strong>For distributed deployments:</strong> Replace each API Manager component (Control Plane, Gateway, Traffic Manager) with the corresponding 4.4.0 version while maintaining the same deployment architecture and profiles.</li>
        <li><strong>No migration scripts required:</strong> Unlike other version upgrades, the 4.2.0 to 4.4.0 upgrade does not require running any database migration scripts or data transformation utilities.</li>
    </ol>
</div>

## Get started

To make sure that the upgrade process is smooth and you have the best experience, WSO2 recommends that you reach out to WSO2 Support in order to upgrade WSO2 API Manager with minimal difficulty.

If you are ready to start the upgrading process, follow the instructions given below.

- If you already have a WSO2 subscription, create a support ticket with your migration requirements and one of our support engineers will get in touch with you.

    [Create a ticket](https://support.wso2.com/support)

- If you are not a WSO2 customer and still need migration assistance and resources, please contact us through the following link. One of our Account Managers will get in touch with you to help.

    [Contact us](https://wso2.com/contact/)