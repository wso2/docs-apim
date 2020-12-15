# Configuring Workflows in a Cluster

If you are working in a clustered API Manager setup with the Developer Portal, Publisher, Gateway and Key Manager in separate servers, do the workflow configurations that are discussed in the previous topics in the **Developer Portal node** . In addition, do the following configurations.

In this guide, you access the Admin Portal ( `https://:9443/admin` ) Web application using the same node as the API Publisher. This is recommended because workflow management is an administrative task and is meant to reside within a private network as the Publisher. Typically, the Admin Portal from the same user store as the API Manager. Therefore, you can use the Admin Portal residing in the Publisher node instead of having it separately. This eliminates the need for a dedicated workflow management node. You need a dedicated node if the Admin Portal users reside in a separate user store.

1.  If you want to change the user roles that can access the Admin Portal, open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/admin/site/conf/site.json` file that is in the node from where you access the Admin Portal (the API Publisher node in this example) and change its `Allowed Roles` parameter. You can add multiple user roles as a comma-separated list.

2.  By default, workflow related configuration files have the port of the Business Process Server with an offset of 2. If you set up the BPS with a different port offset, change the workflow server URLs in the site.json file accordingly.
3.  Point the `uri-template` sub element of the `<endpoint>` element to the node where the Admin Portal is enabled (preferably the Publisher node) in the `<API-M_HOME>/repository/deployment/server/synapse-configs/default/proxy-services/WorkflowCallbackService.xml` file of the Developer Portal node.

    ``` java
            <send>
                <endpoint>
                    <http method="POST"
                          uri-template="https://<PUBLISHER_IP>:9443/api/am/admin/v0.16/workflows/update-workflow-status?workflowReferenceId={uri.var.workflowRef}"/>
                </endpoint>
            </send>
    ```

4.  Add the IP address and the port of the Developer Portal to the `<Address>` element of the .epr file of the workflow that you configure. You can find the .epr file by the name of the workflow in the `<API-M_HOME>/business-processes/epr` folder.

5.  Go to the `<API-M_HOME>/business-processes/<workflow name>/BPEL` folder and unzip the file that is there by the name of the workflow. For example, `<API-M_HOME>/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0.zip` .

6.  Go inside the unzipped folder and do the following:

    <table>
    <colgroup>
    <col width="50%" />
    <col width="50%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th>Action</th>
    <th>Example</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>Open the ApprovalTask WSDL file and point the address elements of the server where the BPEL runs.</td>
    <td><p>In the <code>                &lt;APIM_HOME&gt;/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0/UserApprovalTask.wsdl</code> file:</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeContent panelContent pdl">
    <pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;wsdl:service name=&quot;UserApprovalService&quot;&gt;
       &lt;wsdl:port name=&quot;UserApprovalPort&quot; binding=&quot;tns:UserApprovalBinding&quot;&gt;
          &lt;soap:address location=&quot;http://localhost:9765/services/UserApprovalService&quot; /&gt;
          &lt;/wsdl:port&gt;
       &lt;/wsdl:service&gt;
       &lt;wsdl:service name=&quot;UserApprovalServiceCB&quot;&gt;
          &lt;wsdl:port name=&quot;UserApprovalPortCB&quot; binding=&quot;tns:UserApprovalBindingCB&quot;&gt;
             &lt;soap:address location=&quot;http://localhost:9765/services/UserApprovalServiceCB&quot; /&gt;
          &lt;/wsdl:port&gt;
       &lt;/wsdl:service&gt;
    &lt;/wsdl:service&gt;</code></pre>
    </div>
    </div>
        !!! tip
        <p><strong>Note</strong> that all workflow process services of the BPS run on port 9765 because you changed its default port (9763) with an offset of 2.</p>
    </td>
    </tr>
    <tr class="even">
    <td>Open the <code>               CallbackService              </code> WSDL file and point the address elements to the Developer Portal node in NIO port.</td>
    <td><p>In the <code>                &lt;APIM_HOME&gt;/business-processes/user-signup/BPEL/UserSignupApprovalProcess_1.0.0/WorkflowCallbackService.wsdl</code> file:</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeContent panelContent pdl">
    <pre class="java" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence"><code>&lt;wsdl:service name=&quot;WorkflowCallbackService&quot;&gt;
            &lt;wsdl:port name=&quot;WorkflowCallbackServiceHttpsSoap11Endpoint&quot; binding=&quot;ns:WorkflowCallbackServiceSoap11Binding&quot;&gt;
                &lt;soap:address location=&quot;https://localhost:8243/services/WorkflowCallbackService.WorkflowCallbackServiceHttpsSoap11Endpoint&quot;/&gt;
            &lt;/wsdl:port&gt;
            &lt;wsdl:port name=&quot;WorkflowCallbackServiceHttpSoap11Endpoint&quot; binding=&quot;ns:WorkflowCallbackServiceSoap11Binding&quot;&gt;
                &lt;soap:address location=&quot;http://localhost:8280/services/WorkflowCallbackService.WorkflowCallbackServiceHttpSoap11Endpoint&quot;/&gt;
            &lt;/wsdl:port&gt;         
            &lt;wsdl:port name=&quot;WorkflowCallbackServiceHttpsSoap12Endpoint&quot; binding=&quot;ns:WorkflowCallbackServiceSoap12Binding&quot;&gt;
                &lt;soap12:address location=&quot;https://localhost:8243/services/WorkflowCallbackService.WorkflowCallbackServiceHttpsSoap12Endpoint&quot;/&gt;
            &lt;/wsdl:port&gt;
            &lt;wsdl:port name=&quot;WorkflowCallbackServiceHttpSoap12Endpoint&quot; binding=&quot;ns:WorkflowCallbackServiceSoap12Binding&quot;&gt;
                &lt;soap12:address location=&quot;http://localhost:8280/services/WorkflowCallbackService.WorkflowCallbackServiceHttpSoap12Endpoint&quot;/&gt;
            &lt;/wsdl:port&gt;
            &lt;wsdl:port name=&quot;WorkflowCallbackServiceHttpsEndpoint&quot; binding=&quot;ns:WorkflowCallbackServiceHttpBinding&quot;&gt;
                &lt;http:address location=&quot;https://localhost:8243/services/WorkflowCallbackService.WorkflowCallbackServiceHttpsEndpoint&quot;/&gt;
            &lt;/wsdl:port&gt;
            &lt;wsdl:port name=&quot;WorkflowCallbackServiceHttpEndpoint&quot; binding=&quot;ns:WorkflowCallbackServiceHttpBinding&quot;&gt;
                &lt;http:address location=&quot;http://localhost:8280/services/WorkflowCallbackService.WorkflowCallbackServiceHttpEndpoint&quot;/&gt;
            &lt;/wsdl:port&gt;
    &lt;/wsdl:service&gt;</code></pre>
    </div>
    </div></td>
    </tr>
    </tbody>
    </table>

7.  Go to the `<APIM_HOME>/business-processes/<workflow name>/HumanTask` folder and unzip the file that is there by the name of the workflow. For example, `<APIM_HOME>/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0.zip` .

8.  Go inside the unzipped folder and do the following:

    <table>
    <colgroup>
    <col width="50%" />
    <col width="50%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th>Action</th>
    <th>Example</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td>If you changed the default admin role, open the <code>               ApprovalTask              </code> HT file and apply the changes there.</td>
    <td><p>Change the admin instances in <code>                &lt;APIM_HOME&gt;/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0/UserApprovalTask.ht</code> file. Here's an example, a ssuming that the new admin role is <code>                apimadmin               </code> .</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeContent panelContent pdl">
    <pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;htd:peopleAssignments&gt;
       &lt;htd:potentialOwners&gt;
          &lt;htd:from logicalPeopleGroup=&quot;admin&quot;&gt;
              &lt;htd:argument name=&quot;role&quot;&gt;apimadmin&lt;/htd:argument&gt;
          &lt;/htd:from&gt;
       &lt;/htd:potentialOwners&gt;            
    &lt;/htd:peopleAssignments&gt;</code></pre>
    </div>
    </div></td>
    </tr>
    <tr class="even">
    <td>Open the <code>               ApprovalTask              </code> WSDL file and point the two address elements to the Business Process Server node.</td>
    <td><p>In the <code>                &lt;APIM_HOME&gt;/business-processes/user-signup/HumanTask/UserApprovalTask-1.0.0/UserApprovalTask.wsdl</code> file:</p>
    <div class="code panel pdl" style="border-width: 1px;">
    <div class="codeContent panelContent pdl">
    <pre class="xml" data-syntaxhighlighter-params="brush: xml; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: xml; gutter: false; theme: Confluence"><code>&lt;wsdl:service name=&quot;UserApprovalService&quot;&gt;
            &lt;wsdl:port name=&quot;UserApprovalPort&quot; binding=&quot;tns:UserApprovalBinding&quot;&gt;
                &lt;soap:address location=&quot;http://localhost:9765/services/UserApprovalService&quot; /&gt;
            &lt;/wsdl:port&gt;
    &lt;/wsdl:service&gt;
    &lt;wsdl:service name=&quot;UserApprovalServiceCB&quot;&gt;
            &lt;wsdl:port name=&quot;UserApprovalPortCB&quot; binding=&quot;tns:UserApprovalBindingCB&quot;&gt;
                &lt;soap:address location=&quot;http://localhost:9765/services/UserApprovalServiceCB&quot; /&gt;
            &lt;/wsdl:port&gt;
    &lt;/wsdl:service&gt; </code></pre>
    </div>
    </div>
        !!! tip
        <p><strong>Note</strong> that all workflow process services of the BPS run on port 9765 because you changed its default port (9763) with an offset of 2.</p>
    </td>
    </tr>
    </tbody>
    </table>


