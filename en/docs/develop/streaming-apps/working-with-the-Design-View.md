# Working with the Design View

This section provides an overview of the design view of the Streaming Integrator Tooling.

## Accesing the Design View

To open the design view of the Streaming Integrator Tooling:

1.  Start the Streaming Integrator Tooling and log in with your credentials. For detailed instructions, see 
    [Streaming Integrator Tooling Overview - Starting Streaming Integrator Tooling]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview#starting-streaming-integration-studio).

2.  Click **New** and open a new Siddhi file, or click **Open** and open an existing Siddhi file.

3.  Click **Design View** to open the Design View.  
    ![Design View button]({{base_path}}/assets/img/streaming/working-with-the design-view/open-design-view.png)  
    The design view opens as shown in the example below. It consists of
    a grid to which you can drag and drop the Siddhi components
    represented by icons displayed in the left panel to design a Siddhi
    application.  
    ![Design View]({{base_path}}/assets/img/streaming/working-with-the design-view/design-view.png)

## Adding Siddhi components

To add a Siddhi component to the Siddhi application that you are creating/editing in the design view, click on the 
relevant icon in the left pane, and then drag and drop it to the grid as demonstrated in the example below.

![Dragging and dropping Siddhi components]({{base_path}}/assets/img/streaming/working-with-the design-view/drag-and-drop-siddhi-component.gif)

Once you add a Siddhi component, you can configure it as required. To
configure a Siddhi component, click the settings icon on the component.
This opens a form with parameters related to the relevant component.

![Configure Siddhi component settings]({{base_path}}/assets/img/streaming/working-with-the design-view/configure-siddhi-component-in-design-view.png)

The following is the complete list of Siddhi components that you can add
to the grid of the design view when you create a Siddhi application.

### Stream

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming//working-with-the design-view/stream-icon.png" /></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>A stream represents a logical series of events ordered in time. For a detailed description of streams, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#stream">Siddhi Query Guide - Stream</a>.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>To configure the stream, click the settings icon on the stream component you added to the grid. Then enter values as follows:</p>
               <p><strong>Stream Name</strong> <strong>:</strong> A unique name for the stream. This should be specified in title caps, and without spaces (e.g., <code>ProductionDataStream</code> ).</p>
               <p><strong>Attributes</strong> : Attributes of streams are specified as name and type pairs in the <strong>Attributes</strong> table.</p>
               <p>If you want to generate the the stream from a file or a database, click <strong>Generate Stream</strong>. However, note that you need to create the relevant file or set up the database and the tables beforehand.</p>
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/generate-stream.png"/></p>
               <p>The <strong>Generate Stream</strong> form opens as follows</p>
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/generate-stream-form.png"/></p>
               <p>To generate the stream from a file:
                <ol>
                <li>In the <strong>Generate Stream</strong> form, select <strong>From File</strong>.</li>
                <li><p>Then click <strong>Choose File</strong> and browse for the file from which you want to generate the stream. <br/> the supported file types are <code>CSV</code>, <code>JSON</code>, and <code>XML</code>. If you select a file that is not of one of these types, the <strong>Select File Type</strong> field is enabled as shown in the example below.</p>
                    <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/select-file-type.png"/></p>
                    <p>You are required to select the appropriate file type in this field in order to proceed to generate the stream from the selected file.</p>
                    <p>The rest of the fields that appear in the dialog box differ based on the file type as explained below. If required, change the default values that appear in them as required</p>
                    <ul>
                        <li style="margin-left:2em">If the file type is <strong>CSV</strong>:</li>
                        <ul>
                            <li style="margin-left:2em"><strong>Stream Name</strong>: A name for the stream that you are generating.</li>
                            <li style="margin-left:2em"><strong>Delimiter</strong>: A blank space, comma, or any other character/symbol that indicates the beginning or the end of a character string, word, or a data item.</li>
                            <li style="margin-left:2em"><strong>Is Header Exists</strong>: If this is set to <strong>true</strong>, a header exists for the purpose of identifying the attribute names and the data types of the data values in the file.</li>
                        </ul>
                        <li style="margin-left:2em">If the file type is <strong>JSON</strong>:</li>
                        <ul>
                            <li style="margin-left:2em"><strong>Stream Name</strong>: A name for the stream that you are generating.</li>
                            <li style="margin-left:2em"><strong>Enclosing Element</strong>: The symbol/element used to enclose the JSON object.</li>
                        </ul>
                        <li style="margin-left:2em">If the file type is <strong>XML</strong>:</li>
                        <ul>
                            <li style="margin-left:2em"><strong>Stream Name</strong>: A name for the stream that you are generating.</li>
                            <li style="margin-left:2em"><strong>Namespace</strong>: This is an optional field to enter an XML namespace.</li>
                            <li style="margin-left:2em"><strong>Enclosing Element</strong>: The symbol/element used to enclose the XML object.</li>
                        </ul>
                    </ul>
                </li>
                <li>Click <strong>Generate</strong>. The <strong>Stream Configuration</strong> form is populated with the values in the file you selected.</li>
                </ol>
               </p>
               <p>To generate the stream from a database:
                <ol>
                    <li>In the <strong>Generate Stream</strong> form, select <strong>From Database</strong>.</li>
                    <li>If you want to provide the data source definition inline, select <strong>Inline Configuration</strong>. If not, select <strong>Provide Datasource</strong> to select a data source that is already defined externally.</li>
                    <li> Enter details relating to the data source as follows.</li>
                        <ul>
                            <li>If you are defining the data source configuration inline, enter information as follows:</li>
                            <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/generate-stream-with-inline-datasource-configuration.png"/></p>
                                <ul>
                                    <li><strong>Stream Name</strong>: A name for the stream that you are generating.</li>
                                    <li><strong>Database URL</strong>: The URL via which you can connect to the database.</li>
                                    <li><strong>Username</strong>: The username via which you access the database.</li>
                                    <li><strong>Password</strong>: The password via which you access the database.</li>
                                    <li><strong>Table Name</strong>: The name of the database table from which you are generating the stream. To make the available tables appear in this field as a list so that you can select one, enter the relevant information in the previous fields and click <strong>Retrieve Tables</strong>.</li>
                                </ul>
                            <li>If the data source you are using is already defined externally, enter information as follows:</li>
                            <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/generate-stream-with-externally-defined-datasource.png"/></p>
                                <ul>
                                    <li><strong>Stream Name</strong>: A name for the stream that you are generating.</li>
                                    <li><strong>Datasource Name</strong>: The name of the data source from which you are generating the stream.</li>
                                    <li><strong>Table Name</strong>: The name of the database table from which you are generating the stream. To make the available tables appear in this field as a list so that you can select one, enter the relevant data source in the <strong>Datasource Name</strong> field and click <strong>Retrieve Tables</strong>.</li>
                                </ul>
                    <li>Click <strong>Generate</strong> to generate the stream.</li>
                </ol>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/stream-configuration.png"/></p>
               <p>The details entered in the above <strong></strong> form creates a stream configuration as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>define stream SweetProductionStream (amount double, name string);</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <ul>
               <li>Sources</li>
               <li>Projection queries</li>
               <li>Filter queries</li>
               <li>Window queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Sinks</li>
               <li>Projection queries</li>
               <li>Filter queries</li>
               <li>Window queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

  

### Source

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/source-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>A source receives events in the specified transport and in the specified format. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#source">Siddhi Query Guide - Source</a>.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>To configure the source, click the settings icon on the source component you added to the grid. This opens a form where you can enter the following information:<br /></p>
                   To access the form in which you can configure a source, you must first connect the source as the source (input) object to a stream component.
               <ul>
                  <li><strong>Source Type</strong> : This specifies the transport type via which the events are received. The value should be entered in lower case (e.g., <code>tcp</code> ). The other parameters displayed for the source depends on the source type selected.</li>
                  <li><strong>Map Type</strong> : This specifies the format in which you want to receive the events (e.g., <code>xml</code> ). The other parameters displayed for the map depends on the map type selected. If you want to add more configurations to the mapping, click <strong>Customized Options</strong> and set the required properties and key value pairs.<br /></li>
                  <li>
                     <p><strong>Map Attribute as Key/Value Pairs</strong> : If this check box is selected, you can define custom mapping by entering key value pairs. You can add as many key value pairs as required under this check box.</p>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming//working-with-the design-view/source-configuration.png"/></p>
               <p>The details entered in the above <strong></strong> form creates a source configuration as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: java; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: java; gutter: false; theme: Confluence">
                        <pre class="sourceCode java"><code class="sourceCode java"><a href="#cb1-1"></a>@source(type = &#39;tcp&#39;, <a href="#cb1-2"></a>    @map(type = &#39;json&#39;,
<a href="#cb1-3"></a>        @attributes(name =&quot;$.sweet&quot;, amount = &quot;$.batch.count&quot;)))</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>No connection can start from another Siddhi component and link to a source because a source is the point from which events selected into the event flow of the Siddhi application start.</td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <p>Streams</p>
         </td>
      </tr>
   </tbody>
</table>
  

### Sink

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/sink-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>A sink publishes events via the specified transport and in the specified format. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#sink">Siddhi Query Guide - Sink</a>.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>To configure the sink, click the settings icon on the sink component you added to the grid.<br /></p>
               !!! info  To access the form in which you can configure a sink, you must first connect the sink as the target object to a stream component.
               <ul>
                  <li><strong>Sink Type</strong> : This specifies the transport via which the sink publishes processed events. The value should be entered in lower case (e.g., <code>log</code> ).<br /></li>
                  <li><strong>Map Type</strong> : This specifies the format in which you want to publish the events (e.g., <code>passThrough</code> ). The other parameters displayed for the map depends on the map type selected. If you want to add more configurations to the mapping, click <strong>Customized Options</strong> and set the required properties and key value pairs.</li>
                  <li>
                     <p><strong>Map Attribute as Key/Value Pairs</strong> : If this check box is selected, you can define custom mapping by entering key value pairs. You can add as many key value pairs as required under this check box.<br /></p>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/sink-configuration-form.png"/></p>
               <p>The details entered in the above <strong></strong> form creates a sink configuration as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql">><a href="#cb1-1"></a>@sink(type = &#39;log&#39;, prefix = &quot;Sweet Totals:&quot;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>Streams</td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <p>N/A</p>
            <p>A sink cannot be followed by another Siddhi component because it represents the last stage of the event flow where the results of the processing carried out by the Siddhi application are communicated via the required interface.</p>
         </td>
      </tr>
   </tbody>
</table>

### Table

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/table-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>A table is a stored version of an stream or a table of events. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#table">Siddhi Query Guide - Table</a>.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <p>To configure the table, click the settings icon on the table component you added to the grid.</p>
            <p><strong>Name</strong> <strong>:</strong> This field specifies unique name for the table. This should be specified in title caps, and without spaces (e.g., <code>              ProductionDataTable             </code> ).</p>
            <p><strong>Attributes</strong> : Attributes of tables are specified as name and type pairs in the <strong>Attributes</strong> table. To add a new attribute, click <strong>+Attribute</strong>.</p>
            <p><strong>Store Type</strong> : This specifies the specific database type in which you want to stopre data or whether the data is to be stored in-memory. Once the store type is selected, select an option to indicate whether the datastore needs to be defined inline, whether you want to use a datasource defined in the <code>              &lt;SP_HOME&gt;/conf/worker/deployment.yaml             </code> file, or connected to a JNDI resource. For more information, see <a href="https://docs.wso2.com/display/SP440/Defining+Tables+for+Physical+Stores">Defining Tables for Physical Stores</a>. The other parameters configured under <strong>Store Type</strong> depend on the store type you select.</p>
            <p><strong>Annotations</strong> : This section allows you to specify the table attributes you want to use as the primary key and indexes via the <code>              @primarykey             </code> and <code>              @index             </code> annotations. For more information, see <a href="https://docs.wso2.com/display/SP440/Defining+Data+Tables">Defining Data Tables</a>. If you want to add any other custom annotations to your table definition, click <strong>+Annotation</strong> to define them.</p>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/table-configuration-form.png"/></p>
               <p>The details entered in the above <strong></strong> form creates a table definition as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>@store(type = &#39;rdbms&#39;, datasource = &quot;SweetProductionDB&quot;)
<a href="#cb1-2"></a>define table ShipmentDetails (name string, supplier string, amount double);</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <ul>
               <li>Projection queries</li>
               <li>Window queries</li>
               <li>Filter queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Projection queries</li>
               <li>Window queries</li>
               <li>Filter queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

### Window

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/window-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>This icon represents a window definition that can be shared across multiple queries. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#defined-window">Siddhi Query Guide - (Defined) Window</a>.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <p>To configure the window, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the window component you added to the grid, and update the following information.</p>
            <ul>
               <li><strong>Name</strong> : This field specifies a unique name for the window. <code>               PascalCase              </code> is used for window names as a convention.</li>
               <li><strong>Attributes</strong> : Attributes of windows are specified as name and type pairs in the <strong>Attributes</strong> table.</li>
               <li><strong>Window Type</strong> : This specifies the function of the window (i.e., the window type such as <code>               time              </code> , <code>               length              </code> , <code>               frequent              </code> etc.). The window types supported include <a href="https://siddhi-io.github.io/siddhi/api/latest/#time-window">time</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#timebatch-window">timeBatch</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#timelength-window">timeLength</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#length-window">length</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#lengthbatch-window">lengthBatch</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#sort-window">sort</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#frequent-window">frequent</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#lossyfrequent-window">lossyFrequent</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#cron-window">cron</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#externaltime-window">externalTime</a> , <a href="https://siddhi-io.github.io/siddhi/api/latest/#externaltimebatch-window">externalTimeBatch</a>.</li>
               <li><strong>Parameters</strong> : This section allows you to define one or more parameters for the window definition based on the window type you entered in the <strong>Window Type</strong> field.</li>
               <li><strong>Annotations</strong> : If you want to add any other custom annotations to your window definition, click <strong>+Annotation</strong> to define them.</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/window-configuration-form.png"/></p>
               <p>The details entered in the above form creates a window definition as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"<a href="#cb1-1"></a>define window FiveMinTempWindow (roomNo int, temp double) time(5 min) output all events;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <ul>
               <li>Projection queries</li>
               <li>Window queries</li>
               <li>Filter queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Projection queries</li>
               <li>Window queries</li>
               <li>Filter queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

### Trigger

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/trigger-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>A trigger allows you to generate events periodically. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#trigger">Siddhi Query Guide - Trigger</a>.</td>
      </tr>
      <tr class="odd">
      <td>Form</td>
      <td>
        <div class="content-wrapper">
            <p>To configure the trigger, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the trigger component you added to the grid, and update the following information.</p>
             <ul>
                <li><strong>Name</strong> <strong>:</strong> A unique name for the trigger</li>
                <li><strong>Trigger Criteria</strong> : This specifies the criteria based on which the trigger is activated. Possible values are as follows:
                    <ul>
                        <li><strong>start</strong> : Select this to trigger events when the Streaming Integrator server has started.</li>
                        <li><strong>every</strong> : Select this to specify a time interval at which events should be triggered.</li>
                        <li><strong>cron-expression</strong> : Select this to enter a cron expression based on which the events can be triggered. For more information about cron expressions, see the <a href="http://www.quartz-scheduler.org/documentation/quartz-2.3.0/tutorials/crontrigger.html">quartz-scheduler</a>.</li>
                    </ul>
               </li>
              </ul>
        </div>
      </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><br /></p>
               <img src="{{base_path}}/assets/img/streaming/working-with-the design-view/trigger-configuration-form.png"/>
               <p>The details entered in the above form creates a trigger definition as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>define trigger FiveMinTriggerStream at every 5;</code></pre>
                     </div>
                  </div>
               </div>
               <p><br /></p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>N/A</td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Projection queries</li>
               <li>Window queries</li>
               <li>Filter queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/trigger-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>A trigger allows you to generate events periodically. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#trigger">Siddhi Query Guide - Trigger</a>.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>To configure the trigger, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the trigger component you added to the grid, and update the following information.</p>
               <ul>
                  <li><strong>Name</strong> : A unique name for the trigger.</li>
                  <li>
                     <strong>Trigger Criteria</strong> : This specifies the criteria based on which the trigger is activated. Possible values are as follows:
                     <ul>
                        <li><strong>start</strong> : Select this to trigger events when the Streaming Integrator server has started.</li>
                        <li><strong>every</strong> : Select this to specify a time interval at which events should be triggered.</li>
                        <li><strong>cron-expression</strong> : Select this to enter a cron expression based on which the events can be triggered. For more information about cron expressions, see the <a href="http://www.quartz-scheduler.org/documentation/quartz-2.3.0/tutorials/crontrigger.html</a>.</li>
                     </ul>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><br /></p>
               <img src="{{base_path}}/assets/img/streaming/working-with-the design-view/Trigger_Configuration_Form.png"/>
               <p>The details entered in the above orm creates a trigger definition as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>define trigger FiveMinTriggerStream at every 5;</code></pre>
                     </div>
                  </div>
               </div>
               <p><br /></p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>N/A</td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Projection queries</li>
               <li>Window queries</li>
               <li>Filter queries</li>
               <li>Join queries</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

### Aggregation

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/aggregation-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>
            <div class="content-wrapper">
               <p>Incremental aggregation allows you to obtain aggregates in an incremental manner for a specified set of time periods. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#incremental-aggregation">Siddhi Query Guide - Incremental Aggregation</a>.</p>
               !!! tip
               Before you add an aggregation, make sure that you have already added the stream with the events to which the aggregation is applied is already defined.
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>To configure the aggregation, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the aggregation component you added to the grid, and update the following information.</p>
               <ul>
                  <li><strong>Aggregation Meta Information</strong> : In this section, define a unique name for the aggregation in the <strong>Name</strong> field, and specify the stream from which the input information is taken to perform the aggregations. You can also select the optional annotations you want to use in the aggregation definition by selecting the relevant check boxes. For more information about configuring the annotations once you select them, see <a href="https://docs.wso2.com/display/SP440/Incremental+Analysis#IncrementalAnalysis-annotation">Incremental Analysis</a>.</li>
                  <li><strong>Projection</strong> : This section specifies the attributes to be included in the aggregation query. In the <strong>Select</strong> field, you can select <strong>All</strong> attributes to perform the aggregation for all the attributes of the stream specified under <strong>Input</strong> , or select <strong>User Defined Attributes</strong> to select specific attributes. If you select <strong>User Defined Attributes</strong> , you can add attributes to be selected to be inserted into the output stream. Here, you can enter the names of specific attributes in the input stream, or enter expressions to convert input stream attribute values as required to generate output events. You can also specify the attribute(s) by which you want to group the output.</li>
                  <li><strong>Aggregation Criteria</strong> : Here, you can specify the time values based on which the aggregates are calculated.</li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/aggregation-configuration-form.png"/></p>
               <p>The details entered in the above form creates an aggregation definition as follows:<br /></p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>define aggregation TradeAggregation
<a href="#cb1-2"></a>from TradeStream
<a href="#cb1-3"></a>select symbol, avg(price) as avgPrice, sum(price) as total
<a href="#cb1-4"></a>    group by symbol
<a href="#cb1-5"></a>    aggregateby timestamp every seconds...years;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>N/A</td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>Join queries</td>
      </tr>
   </tbody>
</table>

### Function

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/function-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>The function icon represents <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#script">Script in Siddhi Query Language</a>. It allows you to write functions in other programming languages and execute them within Siddhi queries. A function component in a Siddhi application is not connected to ther Siddhi components in the design UI. However, the configuration of one or more Query components can include a reference to it.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <p>To configure the function, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the function component you added to the grid, and update the following information.</p>
            <ul>
               <li><strong>Name</strong> : A unique name for the function.</li>
               <li><strong>Script Type</strong> : The language in which the function is written.</li>
               <li><strong>Return Value</strong> : The data format of the value that is generated as the output via the function.<br /></li>
               <li><strong>Script Body</strong> : This is a free text field to write the function in the specified script type.<br /></li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/function-configuration-form.png"/></p>
               <p>The details entered in the above form creates a function definition as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>define function concatFN[JAVASCRIPT] return string {
<a href="#cb1-2"></a>    var str1 = ata[0];
<a href="#cb1-3"></a>    var str2 = data[1];
<a href="#cb1-4"></a>    var str3= data[2];
<a href="#cb1-5"></a>    var responce = str1 + str2 + str3;
<a href="#cb1-6"></a>    return responce;
<a href="#cb1-7"></a>};</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
   </tbody>
</table>

### Projection Query

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/projection-query-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>
            <div class="content-wrapper">
               !!! tip
               <p>Before you add a projection query:</p>
               <p>You need to add and configure the following:</p>
               <ul>
                  <li>The input stream with the events to be processed by the query.</li>
                  <li>The output stream to which the events processed by the query are directed.</li>
               </ul>
               <p>This icon represents a query to project the events in an input stream to an output stream. This invoves selectng the attributes to be included in the output, renaming attributes, introducing constant values, and using mathematical and/or logical expressions. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#query-projection">Siddhi Query Guide - Query Projection</a>.</p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>Once you connect the query to an input stream (source) and an output stream (target), you can configure it. To configure the projection query, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the projection query component you added to the grid, and update the following information.</p>
               <ul>
                  <li><strong>Query Meta Information</strong> : This section specifies the stream to be considered as the input stream with the events to which the query needs to be applied. The input stream connected to the query as the source is automatically displayed.</li>
                  <li><strong>Projection</strong> : This section specifies the attributes to be included in the output. In the <strong>Select</strong> field, you can select <strong>All Attributes</strong> to select all the attributes of the events, or select <strong>User Defined Attributes</strong> to select specific attributes from the input stream. If you select <strong>User Defined Attributes</strong> , you can add attributes to be selected to be inserted into the output stream. Here, you can enter the names of specific attributes in the input stream, or enter expressions to convert input stream attribute values as required to generate output events. You can also specify the attribute(s) by which you want to group the output.</li>
                  <li>
                     <strong>Output</strong> : This section specifies the action to be performed on the output event. The fields to be configured in this section are as follows:
                     <ul>
                        <li><strong>Operation</strong> : This field specifies the operation to be performed on the generated output event (e.g., <code>                  Insert                 </code> to insert events to a selected stream/table/window).</li>
                        <li><strong>Into</strong> : This field specifies the stream/table/window in which the operation specified need to be performed.</li>
                        <li><strong>Event Type</strong> This field specifies whether the operation needs to be performed for all output events, only current events or for only expired events.|</li>
                     </ul>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/projection-query-configuration-form.png"/></p>
               <p>The details entered in the above form creates a query as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>from TradeStream
<a href="#cb1-2"></a>select symbol, avg(price) as averagePrice, sum(volume) a total
<a href="#cb1-3"></a>insert all events into OutputStream;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <ul>
               <li>Streams</li>
               <li>Tables</li>
               <li>Triggers</li>
               <li>Windows</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Streams</li>
               <li>Tables</li>
               <li>Windows</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

### Filter Query

<table>
<tbody>
<tr class="odd">
<td>Icon</td>
<td><div class="content-wrapper">
<p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/filter-query-icon.png"/></p>
</div></td>
</tr>
<tr class="even">
<td>Description</td>
<td><div class="content-wrapper">
!!! tip
<p>Before you add a filter query:</p>
<p>You need to add and configure the following:</p>
<ul>
<li>The input stream with the events to be processed by the query.</li>
<li>The output stream to which the events processed by the query are directed.</li>
</ul>

<p>A filter query filters information in an input stream based on a given condition. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#filter">Siddhi Query Guide - Filters</a>.</p>
</div></td>
</tr>
<tr class="odd">
<td>Form</td>
<td><div class="content-wrapper">
<p>Once you connect the query to an input stream (source) and an output stream (target), you can configure it. To configure the filter query, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the filter query component you added to the grid, and update the following information.</p>
<ul>
<li><p>By default, the <strong>Stream Handler</strong> check box is selected, and a stream handler of the <code>filter</code> type is available under it to indicate that the query is a filter. Expand this stream handler, and enter the condition based on which the information needs to be filtered.</p>
<p>!!! info</p>
<p>A Siddhi application can have multiple stream handlers. To add another stream handler, click the <strong>+ Stream Handler</strong>. Multiple functions, filters and windows can be defined within the same form as stream handlers.</p>
</p></li>
<li><strong>Projection</strong> : This section specifies the attributes to be included in the output. In the <strong>Select</strong> field, you can select <strong>All Attributes</strong> to select all the attributes of the events, or select <strong>User Defined Attributes</strong> to select specific attributes from the input stream. If you select <strong>User Defined Attributes</strong> , you can add attributes to be selected to be inserted into the output stream. Here, you can enter the names of specific attributes in the input stream, or enter expressions to convert input stream attribute values as required to generate output events. You can also specify the attribute(s) by which you want to group the output.</li>
<li><strong>Output</strong> : This section specifies the action to be performed on the output event. The fields to be configured in this section are as follows:
<ul>
<li><strong>Operation</strong> : This field specifies the operation to be performed on the generated output event (e.g., <code>Insert</code> to insert events to a selected stream/table/window).</li>
<li><strong>Into</strong> : This field specifies the stream/table/window in which the operation specified need to be performed.</li>
<li><strong>Event Type</strong> This field specifies whether the operation needs to be performed for all output events, only current events or for only expired events.</li>
</ul></li>
</ul>
</div></td>
</tr>
<tr class="even">
<td>Example</td>
<td><div class="content-wrapper">
<p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/filter-query-configuration-form.png"/></p>
<p>The details entered in the above form creates a query with a filter as follows:</p>
<div class="code panel pdl" style="border-width: 1px;">
<div class="codeContent panelContent pdl">
<div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence"><pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>from TradeStream[sum(amount)&gt; 10000]
<a href="#cb1-2"></a>select symbol, avg(price) as averagePrice, sum(amount) as total
<a href="#cb1-3"></a>insert all events into OutputStream;</pre></div>
</div>
</div>
</div></td>
</tr>
<tr class="odd">
<td>Source</td>
<td><ul>
<li>Streams</li>
<li>Tables</li>
<li>Triggers</li>
<li>Windows</li>
</ul></td>
</tr>
<tr class="even">
<td>Target</td>
<td><ul>
<li>Streams</li>
<li>Tables</li>
<li>Windows</li>
</ul></td>
</tr>
</tbody>
</table>

### Window Query

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/window-query-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>
            <div class="content-wrapper">
               !!! tip
               <p>Before you add a window query:</p>
               <p>You need to add and configure the following:</p>
               <ul>
                  <li>The input stream with the events to be processed by the query.</li>
                  <li>The output stream to which the events processed by the query are directed.</li>
               </ul>
               <p>Window queries include a window to select a subset of events to be processed based on a specific criterion. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#defined-window">Siddhi Query Guide - (Defined) Window</a>.</p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>Once you connect the query to an input stream (source) and an output stream (target), you can configure it. To configure the window query, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the window query component you added to the grid, and update the following information.</p>
               <ul>
                  <li>
                     <p>By default, the <strong>Stream Handler</strong> check box is selected, and a stream handler of the <code>window</code> type is available under it to indicate that the query is a filter. Expand this stream handler, and enter details to determine the window including the window type and the basis on which the subset of events considered by the window is determined (i.e., based on the window type selected).</p>
                     <p>!!! info</p>
                     <p>A Siddhi application can have multiple stream handlers. To add another stream handler, click the <strong>+ Stream Handler</strong>. Multiple functions, filters and windows can be defined within the same form as stream handlers.</p>
                     </p>
                  </li>
                  <li><strong>Projection</strong> : This section specifies the attributes to be included in the output. In the <strong>Select</strong> field, you can select <strong>All Attributes</strong> to select all the attributes of the events, or select <strong>User Defined Attributes</strong> to select specific attributes from the input stream. If you select <strong>User Defined Attributes</strong> , you can add attributes to be selected to be inserted into the output stream. Here, you can enter the names of specific attributes in the input stream, or enter expressions to convert input stream attribute values as required to generate output events. You can also specify the attribute(s) by which you want to group the output.</li>
                  <li>
                     <strong>Output</strong> : This section specifies the action to be performed on the output event. The fields to be configured in this section are as follows:
                     <ul>
                        <li><strong>Operation</strong> : This field specifies the operation to be performed on the generated output event (e.g., <code>Insert</code> to insert events to a selected stream/table/window).</li>
                        <li><strong>Into</strong> : This field specifies the stream/table/window in which the operation specified need to be performed.</li>
                        <li><strong>Event Type</strong> This field specifies whether the operation needs to be performed for all output events, only current events or for only expired events.</li>
                     </ul>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/filter-query-configuration-form.png"/></p>
               <p>The details entered in the above <strong>Query Configuration</strong> form creates a query with a window as follows:</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>from TradeStream#window.time(1 month)
<a href="#cb1-2"></a>select symbol, avg(price) as averagePrice, sum(amount) as total
<a href="#cb1-3"></a>insert all events into OutputStream;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <div class="content-wrapper">
               !!! info
               <p>A window query can have only one source at a given time.</p>
               <ul>
                  <li>Streams</li>
                  <li>Tables</li>
                  <li>Triggers</li>
                  <li>Windows</li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Streams</li>
               <li>Tables</li>
               <li>Windows</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

### Join Query

<table>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/join-query-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>A join query derives a combined result from two streams in real-time based on a specified condition. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#join-stream">Siddhi Query Guide - Join</a>.</td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>Once you connect two Siddhi components to the join query as sources and another Siddhi component as the target, you can configure the join query. To configure the join query, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the join query component you added to the grid and update the following information.</p>
               <ul>
                  <li><strong>Query Meta Information</strong> : In this section, enter a unique name for the query and any annotations that you want to include in the query. The <code>                @dist               </code> annotation is supported by default to use the query in a fully distributed deployment if required (for more information, see <a href="https://docs.wso2.com/display/SP440/Converting+to+a+Distributed+Streaming+Application">Converting to a Distributed Streaming Application</a> ). You can also add customized annotations.<br /></li>
                  <li><strong>Input</strong> : Here, you can specify the input sources, the references, the join type, join condition, and stream handlers for the left source and right source of the join. For a detailed explanation of the join concept, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#join-stream">Siddhi Query Guide - Joins</a>.</li>
                  <li><strong>Projection</strong> : This section specifies the attributes to be included in the output. In the <strong>Select</strong> field, you can select <strong>All Attributes</strong> to select all the attributes of the events, or select <strong>User Defined Attributes</strong> to select specific attributes from the input stream. If you select <strong>User Defined Attributes</strong> , you can add attributes to be selected to be inserted into the output stream. Here, you can enter the names of specific attributes in the input stream, or enter expressions to convert input stream attribute values as required to generate output events. You can also specify the attribute(s) by which you want to group the output.</li>
                  <li>
                     <strong>Output</strong> : This section specifies the action to be performed on the output event. The fields to be configured in this section are as follows:
                     <ul>
                        <li><strong>Operation</strong> : This field specifies the operation to be performed on the generated output event (e.g., <code>                  Insert                 </code> to insert events to a selected stream/table/window).</li>
                        <li><strong>Into</strong> : This field specifies the stream/table/window in which the operation specified need to be performed.</li>
                        <li><strong>Event Type</strong> This field specifies whether the operation needs to be performed for all output events, only current events or for only expired events.</li>
                     </ul>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p>A join query is configured as follows:</p>
               <p><strong><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/join-query-configuration-form.png" /><br />
                  </strong> The above configurations result in creating the following join query.
               </p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>from TempStream[temp &gt; 30.0]#window.time(1 min) as T
<a href="#cb1-2"></a>  join RegulatorStream[isOn == false]#window.length(1) as R
<a href="#cb1-3"></a>  on T.roomNo == R.roomNo
<a href="#cb1-4"></a>select T.roomNo, R.deviceID, &#39;start&#39; as action
<a href="#cb1-5"></a>insert into RegulatorActionStream;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <div class="content-wrapper">
               !!! info
               A join query must always be connected to two sources, and at least one of them must be a defined stream/trigger/window.
               <ul>
                  <li>Streams</li>
                  <li>Tables</li>
                  <li>Aggregations</li>
                  <li>Windows</li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <div class="content-wrapper">
               !!! info
               A join query must always be connected to a single target.
               <ul>
                  <li>Streams</li>
                  <li>Tables</li>
                  <li>Windows</li>
               </ul>
            </div>
         </td>
      </tr>
   </tbody>
</table>

### Pattern Query

<table style="width:100%;">
   <colgroup>
      <col style="width: 7%" />
      <col style="width: 92%" />
   </colgroup>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/pattern-query-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>
            <div class="content-wrapper">
               !!! tip
               <p>Before you add a pattern query:</p>
               <p>You need to add and configure the following:</p>
               <ul>
                  <li>The input stream with the events to be processed by the query.</li>
                  <li>The output stream to which the events processed by the query are directed.</li>
               </ul>
               <p>A pattern query detects patterns in events that arrive overtime. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#pattern">Siddhi Query Guide - Patterns</a>.</p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>Once you connect the query to an input stream (source) and an output stream (target), you can configure it. To configure the pattern query, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the pattern query component you added to the grid and update the following information.<br /></p>
               <ul>
                  <li><strong>Query Meta Information</strong> : In this section, enter a unique name for the query and any annotations that you want to include in the query. The <code>                @dist               </code> annotation is supported by default to use the query in a fully distributed deployment if required (for more information, see <a href="https://docs.wso2.com/display/SP440/Converting+to+a+Distributed+Streaming+Application">Converting to a Distributed Streaming Application</a> ). You can also add customized annotations.</li>
                  <li><strong>Input</strong> : This section defines the conditions based on which patterns are identified. This involves specifying a unique ID and the input stream considered for each condition. Multiple conditions can be added. Each condition is configured in a separate tab within this section. For more information about the Pattern concept, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#pattern">Siddhi Query Guide - Patterns</a>.</li>
                  <li><strong>Projection</strong> : This section specifies the attributes to be included in the output. In the <strong>Select</strong> field, you can select <strong>All Attributes</strong> to select all the attributes of the events, or select <strong>User Defined Attributes</strong> to select specific attributes from the input stream. If you select <strong>User Defined Attributes</strong> , you can add attributes to be selected to be inserted into the output stream. Here, you can enter the names of specific attributes in the input stream, or enter expressions to convert input stream attribute values as required to generate output events. You can also specify the attribute(s) by which you want to group the output.</li>
                  <li>
                     <strong>Output</strong> : This section specifies the action to be performed on the output event. The fields to be configured in this section are as follows:
                     <ul>
                        <li><strong>Operation</strong> : This field specifies the operation to be performed on the generated output event (e.g., <code>                  Insert                 </code> to insert events to a selected stream/table/window).</li>
                        <li><strong>Into</strong> : This field specifies the stream/table/window in which the operation specified need to be performed.</li>
                        <li><strong>Event Type</strong> This field specifies whether the operation needs to be performed for all output events, only current events or for only expired events.</li>
                     </ul>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/pattern-query-configuration.png"/></p>
               <p>The above configuration results in creating the following query.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a>from every (e1=MaterialSupplyStream) -&gt; not MaterialConsumptionStream[name == e1.name and amount == e1.amount]
<a href="#cb1-2"></a>    for 15 sec
<a href="#cb1-3"></a>select e1.name, e1.amount
<a href="#cb1-4"></a>insert into ProductionDelayAlertStream;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <ul>
               <li>Streams</li>
               <li>Tables</li>
               <li>Triggers</li>
               <li>Windows</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Streams</li>
               <li>Tables</li>
               <li>Windows</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

  

### Sequence Query

<table style="width:100%;">
   <colgroup>
      <col style="width: 7%" />
      <col style="width: 92%" />
   </colgroup>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/sequence-query-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>
            <div class="content-wrapper">
               !!! tip
               <p>Before you add a sequence query:</p>
               <p>You need to add and configure the following:</p>
               <ul>
                  <li>The input stream with the events to be processed by the query.</li>
                  <li>The output stream to which the events processed by the query are directed.</li>
               </ul>
               <p>A sequence query detects sequences in event occurrences over time. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#sequence">Siddhi Query Guide - Sequence</a>.</p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>Once you connect the query to an input stream (source) and an output stream (target), you can configure it. To configure the sequence query, <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the sequence query component you added to the grid and update the following information.</p>
               <ul>
                  <li><strong>Query Meta Information</strong> : In this section, enter a unique name for the query and any annotations that you want to include in the query. The <code>                @dist               </code> annotation is supported by default to use the query in a fully distributed deployment if required (for more information, see <a href="https://docs.wso2.com/display/SP440/Converting+to+a+Distributed+Streaming+Application">Converting to a Distributed Streaming Application</a> ). You can also add customized annotations.</li>
                  <li><strong>Input</strong> : This section defines the conditions based on which sequences are identified. This involves specifying a unique ID and the input stream considered for each condition. Multiple conditions can be added. Each condition is configured in a separate tab within this section. For more information about the Sequence concept, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#sequence">Siddhi Query Guide - Sequences</a>.</li>
                  <li><strong>Projection</strong> : This section specifies the attributes to be included in the output. In the <strong>Select</strong> field, you can select <strong>All Attributes</strong> to select all the attributes of the events, or select <strong>User Defined Attributes</strong> to select specific attributes from the input stream. If you select <strong>User Defined Attributes</strong> , you can add attributes to be selected to be inserted into the output stream. Here, you can enter the names of specific attributes in the input stream, or enter expressions to convert input stream attribute values as required to generate output events. You can also specify the attribute(s) by which you want to group the output.</li>
                  <li>
                     <strong>Output</strong> : This section specifies the action to be performed on the output event. The fields to be configured in this section are as follows:
                     <ul>
                        <li><strong>Operation</strong> : This field specifies the operation to be performed on the generated output event (e.g., <code>                  Insert                 </code> to insert events to a selected stream/table/window).</li>
                        <li><strong>Into</strong> : This field specifies the stream/table/window in which the operation specified need to be performed.</li>
                        <li><strong>Event Type</strong> This field specifies whether the operation needs to be performed for all output events, only current events or for only expired events.</li>
                     </ul>
                  </li>
               </ul>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/sequence-query-configuration.png"/></p>
               <p>The above configuration results in creating the following query.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><<a href="#cb1-1"></a>from every e1=SweetProductionStream,
<a href="#cb1-2"></a>e2=SweetProductionStream[e1.amount &gt; amount and (timestamp - e1.timestamp) &lt; 10 * 6000]*,
<a href="#cb1-3"></a>e3=SweetProductionStream[timestamp - e1.timestam &gt; <10 * 60000 and e1.amount &gt; amount]
<a href="#cb1-4"></a>select e1.name, e1.amount as initialAmount, e2.amount as finalAmount, e2.timestamp
<a href="#cb1-5"></a>insert into DecreasingTrendAlertStream;</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>
            <ul>
               <li>Streams</li>
               <li>Tables</li>
               <li>Triggers</li>
               <li>Windows</li>
            </ul>
         </td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>
            <ul>
               <li>Streams</li>
               <li>Tables</li>
               <li>Windows</li>
            </ul>
         </td>
      </tr>
   </tbody>
</table>

### Partitions

<table style="width:100%;">
   <colgroup>
      <col style="width: 7%" />
      <col style="width: 92%" />
   </colgroup>
   <tbody>
      <tr class="odd">
         <td>Icon</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/partition-query-icon.png"/></p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Description</td>
         <td>
            <div class="content-wrapper">
               !!! tip
               <p>Before you add a partition:</p>
               <p>You need to add the stream to be partitioned.</p>
               <p>Partitions divide streams and queries into isolated groups in order to process them in parallel and in isolation. For more information, see <a href="https://siddhi-io.github.io/siddhi/documentation/siddhi-4.x/query-guide-4.x/#partition">Siddhi Query Guide - Partition</a>.</p>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Form</td>
         <td>
            <div class="content-wrapper">
               <p>Once the stream to be partitioned is connected as a source to the partition, you can configure the partition. In order to do so, move the cursor over the partition and <a href="#WorkingwiththeDesignView-Settings">click the settings icon</a> on the partition component. This opens the <strong>Partition Configuration</strong> form. In this form, you can enter expressions to convert the attributes of the stream that is selected to be partitioned.</p>
            </div>
         </td>
      </tr>
      <tr class="even">
         <td>Example</td>
         <td>
            <div class="content-wrapper">
               <p><img src="{{base_path}}/assets/img/streaming/working-with-the design-view/partition-configuration.png"/></p>
               <p>The above configuration creates the following partition query.</p>
               <div class="code panel pdl" style="border-width: 1px;">
                  <div class="codeContent panelContent pdl">
                     <div class="sourceCode" id="cb1" data-syntaxhighlighter-params="brush: sql; gutter: false; theme: Confluence" data-theme="Confluence" style="brush: sql; gutter: false; theme: Confluence">
                        <pre class="sourceCode sql"><code class="sourceCode sql"><a href="#cb1-1"></a><partition with ( roomNo &gt;= 1030 as &#39;serverRoom&#39; o
<a href="#cb1-2"></a>                 roomNo &lt; <1030 and roomNo &gt;= 330 as &#39;officeRoom&#39; or
<a href="#cb1-3"></a>                 roomNo &lt; 330 as &#39;lobby&#39; of TempStream)
<a href="#cb1-4"></a>begin
<a href="#cb1-5"></a>    from TempStream#window.time(10 min)
<a href="#cb1-6"></a>    select roomNo, deviceID, avg(temp) as avgTemp
<a href="#cb1-7"></a>    insert into AreaTempStream
<a href="#cb1-8"></a>end</code></pre>
                     </div>
                  </div>
               </div>
            </div>
         </td>
      </tr>
      <tr class="odd">
         <td>Source</td>
         <td>Streams</td>
      </tr>
      <tr class="even">
         <td>Target</td>
         <td>N/A</td>
      </tr>
   </tbody>
</table>

  

## Connecting Siddhi components

In order to define how the Siddhi components in a Siddhi application
interact with each other to process events, you need to define
connections between Siddhi components. A connection is defined by
drawing an arrow from one component to another by dragging the cursor as
demonstrated below.

![Connecting Siddhi components]({{base_path}}/assets/img/streaming/working-with-the design-view/connect-siddhi-components.gif)

## Saving and running Siddhi applications

To save a Siddhi application that you created in the design view, you need to switch to the source view. You also need to switch to the source view to run a Siddhi application. For more information, see [Streaming Integrator Tooling Overview]({{base_path}}/develop/streaming-apps/streaming-integrator-studio-overview).

