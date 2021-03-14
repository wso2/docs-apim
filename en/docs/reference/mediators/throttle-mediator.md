# Throttle Mediator

The **Throttle Mediator** can be used to restrict access to services.
This is useful when services used at the enterprise level and it is
required to avoid heavy loads that can cause performance issues in the
system. It can also be used when you want to avoid certain user groups
(i.e. IP addresses and domains) accessing your system. The Throttle
mediator defines a throttle group which includes the following.

-   A throttle policy which defines the extent to which, individuals and groups of IP addresses/domains should be allowed to access the
    service.
-   A mediation sequence to handle requests that were accepted based on the throttle policy.
-   A mediation sequence to handle requests that were rejected based on the throttle policy.

!!! Info
    The Throttle mediator is a [content unaware]({{base_path}}/reference/mediators/about-mediators/#classification-of-mediators) mediator.

## Syntax

``` java
<throttle [onReject="string"] [onAccept="string"] id="string">
    (<policy key="string"/> | <policy>..</policy>)
    <onReject>..</onReject>?
    <onAccept>..</onAccept>?
</throttle>
```

## Configuration

The configuration of the Throttle mediator are divided into following
sections. Before you edit these sections, enter an ID for the Throttle
group in the **Throttle Group ID** parameter.

### Throttle Policy

This section is used to specify the throttle policy that should apply to
the requests passing through the Throttle mediator. A throttle policy
has a number of entries defining the extent to which, an individual or a
group of IP addresses/domains should be allowed to access the service.

The parameters available to be configured in this section are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Throttle Policy</strong></td>
<td><p>This section is used to specify the policy for throttling. The following options are available.</p>
<ul>
<li><strong>In-Lined Policy</strong>: If this is selected, the Throttle policy can be defined within the Throttle mediator configuration. Click <strong>Throttle Policy Editor</strong> to open the <strong>Mediator Throttling Configuration</strong> dialog box where the details relating to the Throttle policy can be entered. The parameters in this dialog box are described in the table below.</li>
<li><strong>Referring Policy</strong>: If this is selected, you can refer to a pre-defined Throttle policy which is saved in the Registry. You can enter the key to access the policy in the <strong>Referring Policy</strong> parameter. Click on either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> to select the relevant policy from the Resource Tree.</li>
</ul></td>
</tr>
</tbody>
</table>

The parameters available in the **Mediator Throttling Configuration** dialog box to configure the Throttling policy are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Maximum Concurrent Accesses</strong></td>
<td><div class="content-wrapper">
<p>The maximum number of messages that are served at a given time. The number of messages between the inflow throttle handler and the outflow throttle handler cannot exceed the value entered for this parameter at any given time. This parameter value is applied to the entire system. It is not restricted to one or more specific IP addresses/domains.</p>
<p>When this parameter is used, the same Throttle mediator ID should be included in the response flow so that the completed responses are deducted from the available limit.</p>
</div></td>
</tr>
<tr class="even">
<td><strong>Range</strong></td>
<td><p>This parameter is used to specify the IP addresses/domains to which the entry in the current row should be applied</p>
<ul>
<li>If you want to apply the entry to a range of IP addresses, enter the range in this parameter, e.g., <code>               8.100.1.30 – 8.100.1.45              </code> . Alternatively, you can enter a single IP address to apply the entry to only one IP address.</li>
<li>If you want to apply the entry to a domain, enter the required domain ID in this parameter.</li>
<li>If you want to apply the entry to all the IP addresses/domains that are not configured in the other configurations, enter <code>               other              </code> in this parameter.</li>
</ul></td>
</tr>
<tr class="odd">
<td><strong>Type</strong></td>
<td>This parameter is used to specify whether the value(s) entered in the <strong>Range</strong> parameter refers to IP addresses or domains.</td>
</tr>
<tr class="even">
<td><div class="content-wrapper">
<strong>Max Request Count</strong>
</div></td>
<td><div class="content-wrapper">
<p>This parameter specifies the maximum number of requests that should be handled within the time interval specified in the <strong>Unit Time</strong> parameter.</p>
<p>This parameter is applicable only when the value selected for the <strong>Access</strong> parameter is <code>Control</code>.</p>
</div></td>
</tr>
<tr class="odd">
<td><div class="content-wrapper">
<strong>Unit Time (ms)</strong>
</div></td>
<td><div class="content-wrapper">
<p>The time interval for which the maximum number of requests specified for the Throttle ID in the <strong>Max Request Count</strong> parameter apply.</p>
<p>This parameter is applicable only when the value selected for the <strong>Access</strong> parameter is <code>               Control</code>.</p>
</div></td>
</tr>
<tr class="even">
<td><div class="content-wrapper">
<strong>Prohibit Time Period (ms)</strong>
</div></td>
<td><div class="content-wrapper">
<p>If the number of requests entered in the <strong>Max Request Count</strong> parameter is achieved before the time interval entered in the <strong>Unit Time (ms)</strong> parameter has elapsed, no more requests are taken by the inflow throttle handler for the time period entered in this parameter. Entering a value in this parameter alters the unit time.</p>
<p>For example:</p>
<p>Max Request Count <strong>=</strong> 50<br />
Unit Time = 50000 ms<br />
Prohibit Time Period = 5000 ms</p>
<p>If 50 requests are received within 50000 milliseconds , no requests will be taken for the next 5000 milliseconds. Thus, the time slot considered as the unit time is changed to 40000 milliseconds. If no value is entered in the <strong>Prohibit Time Period (ms)</strong> parameter, no requests will be taken until 15000 more milliseconds (i.e. the remainder of the unit time) have elapsed.</p>
<p>This parameter is applicable only when the value selected for the <strong>Access</strong> parameter is <code>Control</code>.</p>
</div></td>
</tr>
<tr class="odd">
<td><strong>Access</strong></td>
<td><p>This parameter is used to specify the extent to which the IP addresses/domains specified in the <strong>Range</strong> parameter are allowed access to the service to which the throttle policy is applied. Possible values are as follows.</p>
<ul>
<li><strong>Allow</strong> : If this is selected, the specified IP addresses/domains are allowed to access the services to which the throttle ID is applied without any restrictions.</li>
<li><strong>Deny</strong> : If this is selected, specified IP addresses/domains are not allowed to access the services to which the throttle ID is applied .</li>
<li><strong>Control</strong> : If this is selected, the specified IP addresses/domains a re allowed to access the services to which the throttle ID is applied. However, the number of times they can access the services is controlled by the <strong>Max Request Count</strong>, <strong>Unit Time (ms)</strong> and the <strong>Prohibit Time Period (ms)</strong> parameters.</li>
</ul></td>
</tr>
<tr class="even">
<td><strong>Action</strong></td>
<td>This parameter can be used to delete the entry.</td>
</tr>
</tbody>
</table>

### On Acceptance

This section is used to specify the mediation sequence that should be applied when a request is accepted based on the [throttle policy](#throttle-policy) defined for the Throttle
mediator. The parameters available to be configured in this section are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Specify As</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to specify how the On Acceptance sequence is defined. The following options are available.</p>
<ul>
<li><strong>In-Lined Policy</strong> : If this is selected, the mediation sequence to be applied to accepted requests can be defined within the Throttle mediator configuration. Click on the <strong>OnAccept</strong> node in the mediation tree to define the sequence in-line.<br />
</li>
<li><strong>Referring Policy</strong> : If this is selected, you can refer to a pre-defined mediation sequence in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required sequence from the Resource Tree.</li>
</ul>
</div></td>
</tr>
</tbody>
</table>

### On Rejection

This section is used to specify the mediation sequence that should be applied when a request is rejected based on the [throttle policy](#throttle-policy) defined for the Throttle mediator. The parameters available to be configured in this section are as follows.

<table>
<thead>
<tr class="header">
<th>Parameter Name</th>
<th>Description</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><strong>Specify As</strong></td>
<td><div class="content-wrapper">
<p>This parameter is used to specify how the On Acceptance sequence is defined. The following options are available.</p>
<ul>
<li><strong>In-Lined Policy</strong> : If this is selected, the mediation sequence to be applied to rejected requests can be defined within the Throttle mediator configuration. Click on the <strong>OnReject</strong> node in the mediation tree to define the sequence in-line.<br />
</li>
<li><strong>Referring Policy</strong> : If this is selected, you can refer to a pre-defined mediation sequence in the registry. Click either <strong>Configuration Registry</strong> or <strong>Governance Registry</strong> as relevant to select the required sequence from the Resource Tree.</li>
</ul>
</div></td>
</tr>
</tbody>
</table>

## Examples

### Example for a concurrency-based policy

This sample policy only contains a component called
`         MaximumConcurrentAccess        ` . This indicates the maximum
number of concurrent requests that can pass through Synapse on a single
unit of time, and this value applies to all the IP addresses and
domains.

``` java
<in>
    <throttle id="A">
        <policy>
            <!-- define throttle policy -->
            <wsp:Policy xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy"
                        xmlns:throttle="http://www.wso2.org/products/wso2commons/throttle">
                <throttle:ThrottleAssertion>
                    <throttle:MaximumConcurrentAccess>10</throttle:MaximumConcurrentAccess>
                </throttle:ThrottleAssertion>
            </wsp:Policy>
        </policy>
        <onAccept>
            <log level="custom">
                <property name="text" value="**Access Accept**"/>
            </log>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </onAccept>
        <onReject>
            <log level="custom">
                <property name="text" value="**Access Denied**"/>
            </log>
            <makefault>
                <code value="tns:Receiver"
                      xmlns:tns="http://www.w3.org/2003/05/soap-envelope"/>
                <reason value="**Access Denied**"/>
            </makefault>
            <respond/>
            <drop/>
        </onReject>
    </throttle>
</in>
```

### Example for a rates-based policy

This sample policy only contains a rates-based policy. This indicates
the maximum number of concurrent requests that can pass through Synapse
on a single unit of time, and this value applies to all the IP addresses
and domains.

``` java
<in>
    <throttle id="A">
        <policy>
            <!-- define throttle policy -->
            <wsp:Policy xmlns:wsp="http://schemas.xmlsoap.org/ws/2004/09/policy"
                        xmlns:throttle="http://www.wso2.org/products/wso2commons/throttle">
                       <throttle:MaximumCount>4</throttle:MaximumCount>
                       <throttle:UnitTime>800000</throttle:UnitTime>
                       <throttle:ProhibitTimePeriod wsp:Optional="true">1000</throttle:ProhibitTimePeriod>
            </wsp:Policy>
        </policy>
        <onAccept>
            <log level="custom">
                <property name="text" value="**Access Accept**"/>
            </log>
            <send>
                <endpoint>
                    <address uri="http://localhost:9000/services/SimpleStockQuoteService"/>
                </endpoint>
            </send>
        </onAccept>
        <onReject>
            <log level="custom">
                <property name="text" value="**Access Denied**"/>
            </log>
            <makefault>
                <code value="tns:Receiver"
                      xmlns:tns="http://www.w3.org/2003/05/soap-envelope"/>
                <reason value="**Access Denied**"/>
            </makefault>
            <respond/>
            <drop/>
        </onReject>
    </throttle>
</in>
```
