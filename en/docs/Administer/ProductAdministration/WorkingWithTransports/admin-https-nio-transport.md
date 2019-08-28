# admin\_HTTPS-NIO Transport

HTTPS-NIO transport is also a module that comes from the Apache Synapse code base. Apache Synapse (as well as the WSO2 ESB) ships the HTTPS-NIO transport as the default HTTPS transport implementation; however, other products can install the feature that has this transport if needed. The receiver class is named as follows:

`         org.apache.synapse.transport.nhttp.HttpCoreNIOSSLListener        `

The sender class is named as follows:

`         org.apache.synapse.transport.nhttp.HttpCoreNIOSSLSender        `

As far as the actual implementation of the transport is concerned, these two classes simply extend the HTTP-NIO implementation by adding SSL support to it. Therefore, they support all the configuration parameters supported by the HTTP-NIO receiver and sender. In addition to that, both HTTPS-NIO listener and the HTTPS-NIO sender support the following two parameters. The above mentioned classes are available in the `         synapse-nhttp-transport.jar        ` bundle.

Transport Parameters (Common to both receiver and the sender):

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Requried</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>keystore</p></td>
<td><p>The default keystore to be used by the receiver or the sender should be specified here along with its related parameters as an XML fragment. The path to the keystore file, its type and the passwords to access the keystore should be stated in the XML. The keystore would be used by the transport to initialize a set of key managers.</p></td>
<td><p>Yes</p></td>
<td><p>&lt;parameter name=&quot;keystore&quot;&gt;<br />
&lt;KeyStore&gt;<br />
&lt;Location&gt;lib/identity.jks&lt;/Location&gt;<br />
&lt;Type&gt;JKS&lt;/Type&gt;<br />
&lt;Password&gt;password&lt;/Password&gt;<br />
&lt;KeyPassword&gt;password&lt;/KeyPassword&gt;<br />
&lt;/KeyStore&gt;<br />
&lt;/parameter&gt;</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>truststore</p></td>
<td><p>The default trust store to be used by the receiver or the sender should be specified here along with its related parameters as an XML fragment. The location of the trust store file, its type and the password should be stated in the XML body. The truststore is used by the transport to initialize a set of trust managers.</p></td>
<td><p>Yes</p></td>
<td><p>&lt;parameter name=&quot;truststore&quot;&gt;<br />
&lt;TrustStore&gt;<br />
&lt;Location&gt;lib/identity.jks&lt;/Location&gt;<br />
&lt;Type&gt;JKS&lt;/Type&gt;<br />
&lt;Password&gt;password&lt;/Password&gt;<br />
&lt;/TrustStore&gt;<br />
&lt;/parameter&gt;</p></td>
<td><p></p></td>
</tr>
</tbody>
</table>

The HTTPS NIO transport sender supports the concept of custom SSL profiles. An SSL profile is a user defined keystore-truststore pair. Such an SSL profile can be associated with one or more target servers. When the HTTPS sender connects to a target server, it will use the SSL profile associated with the target server. If no custom SSL profiles are configured for the target server, the default keystore-truststore pair will be used. Using this feature the NIO HTTPS sender can connect to different target servers using different certificates and identities. The following table shows how to configure custom SSL profiles. The given example only contains a single SSL profile, but there can be as many profiles as required.

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th><p>Parameter Name</p></th>
<th><p>Description</p></th>
<th><p>Requried</p></th>
<th><p>Possible Values</p></th>
<th><p>Default Value</p></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>customSSLProfiles</p></td>
<td><p>Define one or more custom SSL profiles and associate them with<br />
target servers. Each profile must be associated with at least one<br />
target server. If a profile should be associated with multiple target<br />
servers, the server list should be specified as a comma separated<br />
list. A target server is identified by a host-port pair.</p></td>
<td><p>No</p></td>
<td><p>&lt;parameter name=&quot;customSSLProfiles&gt;<br />
&lt;profile&gt;<br />
&lt;servers&gt;www.test.org:80,<br />
www.test2.com:9763&lt;/servers&gt;<br />
&lt;KeyStore&gt;<br />
&lt;Location&gt;/path/to/identity/store<br />
&lt;/Location&gt;<br />
&lt;Type&gt;JKS&lt;/Type&gt;<br />
&lt;Password&gt;password&lt;/Password&gt;<br />
&lt;KeyPassword&gt;password<br />
&lt;/KeyPassword&gt;<br />
&lt;/KeyStore&gt;<br />
&lt;TrustStore&gt;<br />
&lt;Location&gt;path/to/trust/store<br />
&lt;/Location&gt;<br />
&lt;Type&gt;JKS&lt;/Type&gt;<br />
&lt;Password&gt;password&lt;/Password&gt;<br />
&lt;/TrustStore&gt;<br />
&lt;/profile&gt;<br />
&lt;/parameter&gt;</p></td>
<td><p></p></td>
</tr>
</tbody>
</table>


