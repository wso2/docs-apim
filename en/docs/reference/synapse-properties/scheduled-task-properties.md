# Scheduled Tasks
## Introduction

WSO2 Micro Integrator can be configured to execute tasks periodically. According to the default task scheduling implementation in WSO2 Micro Integrator, a task can be configured to inject messages, either to a defined endpoint, to a proxy service, or a specific sequence. If required, you can use a custom task scheduling implementation.

You can schedule a task to run after a time interval of 't' for an 'n' number of times, or you can schedule the task to run once when the server starts. Alternatively, you can use cron expressions to have more control over how the task should be scheduled. For example, you can use a Cron expression to schedule the task to run at 10 pm on the 20th day of every month.

<!--
!!! Info
    In a clustered environment, tasks are distributed among server nodes according to the round-robin method, by default. If required, you can change this default task handling behaviour so that tasks are distributed randomly, or according to a specific rule. 
    
    -   See the instructions on how to configure task scheduling for the Micro Integrator.
    -   You can also configure the task handling behaviour at task-level, by specifying the Pinned Servers for a task. Note that this setting overrides the server-level configuration.

    Also, note that a scheduled task will only run on one of the nodes (at a given time) in a clustered environment. The task will fail over to another node only if the first node fails.
-->

## Properties

See the topics given below for the list of properties that can be configured when you [create a Scheduled Task]({{base_path}}/integrate/develop/creating-artifacts/creating-scheduled-task).

### Required Properties

The following properties are required when [creating a scheduled task]({{base_path}}/integrate/develop/creating-artifacts/creating-scheduled-task).

<table>
   <thead>
      <tr class="header">
         <th>Parameter</th>
         <th>Description</th>
      </tr>
   </thead>
   <tbody>
      <tr class="odd">
         <td>Task Name</td>
         <td>Name of a scheduled task.</td>
      </tr>
      <tr class="even">
         <td>Task Group</td>
         <td>The <code>                 synapse.simple.quartz                </code> group will be selected by default.</td>
      </tr>
      <tr class="odd">
         <td>Task Implementation</td>
         <td>The default task implementation class ( <code>                 org.apache.synapse.startup.tasks.MessageInjector                </code> ) of the Micro Integrator will be selected by default. This class simply injects a specified message into the Synapse environment when the server starts.<br />
            If you are want to use a custom task implementation, see the instructions on <a href="{{base_path}}/integrate/develop/customizations/creating-custom-task-scheduling">writing tasks</a> .
         </td>
      </tr>
      <tr class="even">
         <td>Trigger Type</td>
         <td>
            <div class="content-wrapper">
               <p>The trigger type determines the task execution schedule.</p>
               <ul>
                  <li>
                     <p><strong>Simple Trigger:</strong> Schedules the task to run a specified number of times at specified intervals. In the <strong>Count</strong> field, enter the number of time the task should be executed, and in the <strong>Interval</strong> field, enter the time interval (in seconds) between consecutive executions of the task. See the following examples for simple triggers:</p></br>
                     <div class="localtabs-macro">
                        <div class="aui-tabs horizontal-tabs" data-aui-responsive="true" role="application">
                           <div id="4703a6be07a54b79af66ebe01fab2cb9" class="tabs-pane active-pane" name="Only once">
                              <p>To run only once after the Micro Integrator starts:</p>
                              <div class="code panel pdl" style="border-width: 1px;">
                                 <div class="codeContent panelContent pdl">
                                    <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                                       <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;task name=<span class="st">&quot;CheckPrice&quot;</span> <span class="kw">class</span>=<span class="st">&quot;org.wso2.esb.tutorial.tasks.PlaceStockOrderTask&quot;</span>&gt;</span>
    <span id="cb1-2"><a href="#cb1-2"></a>&lt;trigger once=<span class="st">&quot;true&quot;</span>/&gt;</span>
    <span id="cb1-3"><a href="#cb1-3"></a>&lt;/task&gt;</span></code></pre>
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div id="0ef990d2713b4ec2bc9faffda54498ab" class="tabs-pane" name="Every 5 seconds continuously">
                              <p>To run every 5 seconds continuously:</p>
                              <div class="code panel pdl" style="border-width: 1px;">
                                 <div class="codeContent panelContent pdl">
                                    <div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                                       <pre class="sourceCode java"><code class="sourceCode java"><span id="cb2-1"><a href="#cb2-1"></a>&lt;task name=<span class="st">&quot;CheckPrice&quot;</span> <span class="kw">class</span>=<span class="st">&quot;org.wso2.esb.tutorial.tasks.PlaceStockOrderTask&quot;</span>&gt;</span>
    <span id="cb2-2"><a href="#cb2-2"></a>&lt;trigger interval=<span class="st">&quot;5&quot;</span>/&gt;</span>
    <span id="cb2-3"><a href="#cb2-3"></a>&lt;/task&gt;</span></code></pre>
                                    </div>
                                 </div>
                              </div>
                           </div>
                           <div id="1aec3cd57f7044aa97b4bd094760ac79" class="tabs-pane" name="Every 5 seconds 10 times">
                              <p>To run every 5 seconds for 10 times:</p>
                              <div class="code panel pdl" style="border-width: 1px;">
                                 <div class="codeContent panelContent pdl">
                                    <div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                                       <pre class="sourceCode java"><code class="sourceCode java"><span id="cb3-1"><a href="#cb3-1"></a>&lt;task name=<span class="st">&quot;CheckPrice&quot;</span> <span class="kw">class</span>=<span class="st">&quot;org.wso2.esb.tutorial.tasks.PlaceStockOrderTask&quot;</span>&gt;</span>
    <span id="cb3-2"><a href="#cb3-2"></a>&lt;trigger interval=<span class="st">&quot;5&quot;</span> count=<span class="st">&quot;10&quot;</span>/&gt;</span>
    <span id="cb3-3"><a href="#cb3-3"></a>&lt;/task&gt;</span></code></pre>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </li>
                  <li>
                     <p><strong>Cron Trigger:</strong> Schedules the task according to a Cron expression. See the following example for acron trigger where the task is scheduled to run at 1:30 AM:</p>
                     <div class="code panel pdl" style="border-width: 1px;">
                        <div class="codeContent panelContent pdl">
                           <div class="sourceCode" id="cb4" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                              <pre class="sourceCode java"><code class="sourceCode java"><span id="cb4-1"><a href="#cb4-1"></a>&lt;task name=<span class="st">&quot;CheckPrice&quot;</span> <span class="kw">class</span>=<span class="st">&quot;org.wso2.esb.tutorial.tasks.PlaceStockOrderTask&quot;</span>&gt;</span>
    <span id="cb4-2"><a href="#cb4-2"></a>&lt;trigger cron=<span class="st">&quot;0 30 1 * * ?&quot;</span>/&gt;</span>
    <span id="cb4-3"><a href="#cb4-3"></a>&lt;/task&gt;</span></code></pre>
                           </div>
                        </div>
                     </div>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Pinned Servers</td>
         <td>
            <div class="content-wrapper">
               <p>The list of Micro Integrator server nodes that will run the task. You can specify the IP addresses of the required nodes.</p>
               <b>Note</b>:
               <p>This setting can be used if you want the task to run on a selected set of nodes in a product cluster. Note that the task will only run on one of the nodes at a time. It will fail over to another node, only if the first node fails. Pinned servers will override the default task handling behavior defined at server-level (for this particular task). However, if <strong>rule-based</strong> task handling is specified at server-level, you need to ensure that the same server nodes you specify as pinned servers for the task are also specified for the task handling rule at server-level.</p>
            </div>
         </td>
      </tr>
   </tbody>
</table>

### Task Implementation Properties

Listed below are the optional task implementation properties you can use when [creating a scheduled task]({{base_path}}/integrate/develop/creating-artifacts/creating-scheduled-task).

<table>
   <thead>
      <tr class="header">
         <th>Parameter Name</th>
         <th>Description</th>
      </tr>
   </thead>
   <tbody>
      <tr class="odd">
         <td>message</td>
         <td>
            <div class="content-wrapper">
               <p>Specify the body of the request that should be sent when the task is executed.</p>
               <b>Note</b>:
               <p>It is mandatory to provide a value for the message property. Therefore, even If you do not want to send a message body, you have to provide an empty payload as the value to avoid an exception being thrown.</p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>soapAction</td>
         <td>This is the SOAP action to use when sending the message to the endpoint.</td>
      </tr>
      <tr class="odd">
         <td>to</td>
         <td>
            <div class="content-wrapper">
               <p>If the task should send the message directly to the endpoint through the <strong>main</strong> sequence, the endpoint address should be specified. For example, if the address of the endpoint is <a href="http://localhost:9000/services/SimpleStockQuoteService">http://localhost:9000/services/SimpleStockQuoteService</a> , the Synapse configuration of the scheduled task will be as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb1-1"><a href="#cb1-1"></a>&lt;task <span class="kw">class</span>=<span class="st">&quot;org.apache.synapse.startup.tasks.MessageInjector&quot;</span> group=<span class="st">&quot;synapse.simple.quartz&quot;</span> name=<span class="st">&quot;CheckPrice&quot;</span>&gt;        &lt;property name=<span class="st">&quot;to&quot;</span> value=<span class="st">&quot;http://localhost:9000/services/SimpleStockQuoteService&quot;</span>/&gt;</span>
    <span id="cb1-2"><a href="#cb1-2"></a>        &lt;property name=<span class="st">&quot;soapAction&quot;</span> value=<span class="st">&quot;urn:getQuote&quot;</span>/&gt;</span>
    <span id="cb1-3"><a href="#cb1-3"></a>        &lt;property name=<span class="st">&quot;message&quot;</span>&gt;</span>
    <span id="cb1-4"><a href="#cb1-4"></a>            &lt;m0:getQuote xmlns:m0=<span class="st">&quot;http://services.samples&quot;</span> xmlns=<span class="st">&quot;http://ws.apache.org/ns/synapse&quot;</span>&gt;</span>
    <span id="cb1-5"><a href="#cb1-5"></a>                &lt;m0:request&gt;</span>
    <span id="cb1-6"><a href="#cb1-6"></a>                    &lt;m0:symbol&gt;IBM&lt;/m0:symbol&gt;</span>
    <span id="cb1-7"><a href="#cb1-7"></a>                &lt;/m0:request&gt;</span>
    <span id="cb1-8"><a href="#cb1-8"></a>            &lt;/m0:getQuote&gt;</span>
    <span id="cb1-9"><a href="#cb1-9"></a>        &lt;/property&gt;</span>
    <span id="cb1-10"><a href="#cb1-10"></a>        &lt;trigger interval=<span class="st">&quot;5&quot;</span>/&gt;</span>
    <span id="cb1-11"><a href="#cb1-11"></a>    &lt;/task&gt;</span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>injectTo</td>
         <td>If the task is not sending the message directly to the endpoint (through the main sequence), it should be injected to proxy service or a sequence. Specify <strong>sequence</strong> , or <strong>proxy</strong> .</td>
      </tr>
      <tr class="odd">
         <td>sequenceName</td>
         <td>
            <div class="content-wrapper">
               <p>If the task should inject the message to a sequence ( <strong>injectTo</strong> parameter is <strong>sequence</strong> ), enter the name of the sequence. For example, if the name of the sequence is 'SampleSequence', the synapse configuration of the scheduled task will be as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb2" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb2-1"><a href="#cb2-1"></a>&lt;task name=<span class="st">&quot;SampleInjectToSequenceTask&quot;</span></span>
    <span id="cb2-2"><a href="#cb2-2"></a>         <span class="kw">class</span>=<span class="st">&quot;org.apache.synapse.startup.tasks.MessageInjector&quot;</span></span>
    <span id="cb2-3"><a href="#cb2-3"></a>         group=<span class="st">&quot;synapse.simple.quartz&quot;</span>&gt;</span>
    <span id="cb2-4"><a href="#cb2-4"></a>      &lt;trigger count=<span class="st">&quot;2&quot;</span> interval=<span class="st">&quot;5&quot;</span>/&gt;</span>
    <span id="cb2-5"><a href="#cb2-5"></a></span>
    <span id="cb2-6"><a href="#cb2-6"></a>      &lt;property xmlns:task=<span class="st">&quot;http://www.wso2.org/products/wso2commons/tasks&quot;</span></span>
    <span id="cb2-7"><a href="#cb2-7"></a></span>
    <span id="cb2-8"><a href="#cb2-8"></a>                name=<span class="st">&quot;injectTo&quot;</span></span>
    <span id="cb2-9"><a href="#cb2-9"></a>                value=<span class="st">&quot;sequence&quot;</span>/&gt;</span>
    <span id="cb2-10"><a href="#cb2-10"></a></span>
    <span id="cb2-11"><a href="#cb2-11"></a>      &lt;property xmlns:task=<span class="st">&quot;http://www.wso2.org/products/wso2commons/tasks&quot;</span> name=<span class="st">&quot;message&quot;</span>&gt;</span>
    <span id="cb2-12"><a href="#cb2-12"></a>         &lt;m0:getQuote xmlns:m0=<span class="st">&quot;http://services.samples&quot;</span>&gt;</span>
    <span id="cb2-13"><a href="#cb2-13"></a>            &lt;m0:request&gt;</span>
    <span id="cb2-14"><a href="#cb2-14"></a>               &lt;m0:symbol&gt;IBM&lt;/m0:symbol&gt;</span>
    <span id="cb2-15"><a href="#cb2-15"></a>            &lt;/m0:request&gt;</span>
    <span id="cb2-16"><a href="#cb2-16"></a>         &lt;/m0:getQuote&gt;</span>
    <span id="cb2-17"><a href="#cb2-17"></a>      &lt;/property&gt;</span>
    <span id="cb2-18"><a href="#cb2-18"></a></span>
    <span id="cb2-19"><a href="#cb2-19"></a>      &lt;property xmlns:task=<span class="st">&quot;http://www.wso2.org/products/wso2commons/tasks&quot;</span></span>
    <span id="cb2-20"><a href="#cb2-20"></a></span>
    <span id="cb2-21"><a href="#cb2-21"></a>                name=<span class="st">&quot;sequenceName&quot;</span></span>
    <span id="cb2-22"><a href="#cb2-22"></a>                value=<span class="st">&quot;SampleSequence&quot;</span>/&gt;</span>
    <span id="cb2-23"><a href="#cb2-23"></a></span>
    <span id="cb2-24"><a href="#cb2-24"></a>   &lt;/task&gt;</span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>proxyName</td>
         <td>
            <div class="content-wrapper">
               <p>If the task should inject the message to a proxy service ( <strong>injectTo</strong> parameter is <strong>proxy</strong> ), enter the name of the proxy service. For example, if the name of the proxy service is 'SampleProxy', the synapse configuration of the scheduled task will be as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb3" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><span id="cb3-1"><a href="#cb3-1"></a> &lt;task name=<span class="st">&quot;SampleInjectToProxyTask&quot;</span></span>
    <span id="cb3-2"><a href="#cb3-2"></a>         <span class="kw">class</span>=<span class="st">&quot;org.apache.synapse.startup.tasks.MessageInjector&quot;</span></span>
    <span id="cb3-3"><a href="#cb3-3"></a>         group=<span class="st">&quot;synapse.simple.quartz&quot;</span>&gt;</span>
    <span id="cb3-4"><a href="#cb3-4"></a>      &lt;trigger count=<span class="st">&quot;2&quot;</span> interval=<span class="st">&quot;5&quot;</span>/&gt;</span>
    <span id="cb3-5"><a href="#cb3-5"></a>      &lt;property xmlns:task=<span class="st">&quot;http://www.wso2.org/products/wso2commons/tasks&quot;</span> name=<span class="st">&quot;message&quot;</span>&gt;</span>
    <span id="cb3-6"><a href="#cb3-6"></a>         &lt;m0:getQuote xmlns:m0=<span class="st">&quot;http://services.samples&quot;</span>&gt;</span>
    <span id="cb3-7"><a href="#cb3-7"></a>            &lt;m0:request&gt;</span>
    <span id="cb3-8"><a href="#cb3-8"></a>               &lt;m0:symbol&gt;IBM&lt;/m0:symbol&gt;</span>
    <span id="cb3-9"><a href="#cb3-9"></a>            &lt;/m0:request&gt;</span>
    <span id="cb3-10"><a href="#cb3-10"></a>         &lt;/m0:getQuote&gt;</span>
    <span id="cb3-11"><a href="#cb3-11"></a>      &lt;/property&gt;</span>
    <span id="cb3-12"><a href="#cb3-12"></a></span>
    <span id="cb3-13"><a href="#cb3-13"></a>      &lt;property xmlns:task=<span class="st">&quot;http://www.wso2.org/products/wso2commons/tasks&quot;</span></span>
    <span id="cb3-14"><a href="#cb3-14"></a></span>
    <span id="cb3-15"><a href="#cb3-15"></a>                name=<span class="st">&quot;proxyName&quot;</span></span>
    <span id="cb3-16"><a href="#cb3-16"></a>                value=<span class="st">&quot;SampleProxy&quot;</span>/&gt;</span>
    <span id="cb3-17"><a href="#cb3-17"></a></span>
    <span id="cb3-18"><a href="#cb3-18"></a>      &lt;property xmlns:task=<span class="st">&quot;http://www.wso2.org/products/wso2commons/tasks&quot;</span></span>
    <span id="cb3-19"><a href="#cb3-19"></a>                </span>
    <span id="cb3-20"><a href="#cb3-20"></a>                name=<span class="st">&quot;injectTo&quot;</span></span>
    <span id="cb3-21"><a href="#cb3-21"></a>                value=<span class="st">&quot;proxy&quot;</span>/&gt;</span>
    <span id="cb3-22"><a href="#cb3-22"></a></span>
    <span id="cb3-23"><a href="#cb3-23"></a>   &lt;/task&gt;</span></code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
   </tbody>
</table>