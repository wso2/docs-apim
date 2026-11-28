# OpenSearch Based Analytics Installation Guide

<a href="{{base_path}}/assets/img/analytics/opensearch/architecture.png"><img src="{{base_path}}/assets/img/analytics/opensearch/architecture.png" width="70%" alt="Deployment diagram"></a>

### Analytics Data flow

The OpenSearch Based Analytics solution for WSO2 API Manager will publish analytics data into a log file and that file will be used as the source for the analytics solution.

OpenSearch based WSO2 API Manager On-Premise Analytics deployment architecture has 3 main components.

1. Fluent Bit
2. OpenSearch
3. OpenSearch Dashboards

This section will cover the steps required to configure the WSO2 API-M and then publish it to an external OpenSearch cluster. 

### Step 1 - Configuring API Manager

#### Step 1.1 - Configuring the deployment.toml file.

Open the `wso2am-4.x.x/repository/conf` directory. Edit `apim.analytics` configurations in the `deployment.toml` file with the following configuration.

```toml
[apim.analytics]
enable = true
type = "opensearch"
```


### Step 2 - Installing OpenSearch

- Follow the [OpenSearch installation guide](https://opensearch.org/docs/latest/install-and-configure/install-opensearch/index) to install the **OpenSearch Cluster**.
- Follow the [OpenSearch dashboard installation guide](https://opensearch.org/docs/latest/install-and-configure/install-dashboards/index/) to install the **OpenSearch dashboards**.

### Step 3 - Installing and Configuring Fluent Bit

1. To install Fluent Bit, follow one of the guides below based on your operating system.

    - If you are a Linux user, follow this [guide](https://docs.fluentbit.io/manual/installation/linux/ubuntu).
    - If you are a MacOS user, follow this [guide](https://docs.fluentbit.io/manual/installation/macos).

2. After installing Fluent Bit and OpenSearch, create a Fluent Bit configuration file (fluent-bit.conf) with the following attributes to direct WSO2 APIM metrics logs in the `repository/logs` folder to the OpenSearch cluster.

!!! note 
    In the below configuration, update `<APIM_HOME>`, `<TAIL_FILE_PATH>`, `<PATH_TO_PARSER_CONFIG>`, and, `<PASSWORD>` to match your setup.

``` yaml
[SERVICE]
    Flush               1
    Daemon              Off
    Log_Level           info
    Parsers_File        <PATH_TO_PARSER_CONFIG>/parsers.conf

# --- INPUT: APIM Metrics ---
[INPUT]
    Name                tail
    Tag                 apim.metrics
    Path                <APIM_HOME>/repository/logs/apim_metrics.log
    Refresh_Interval    5
    Buffer_Chunk_Size   32KB
    Buffer_Max_Size     2MB
    Mem_Buf_Limit       256MB
    Read_from_Head      true
    DB                  <TAIL_FILE_PATH>/metrics-tail-status.db

# --- FILTERS for APIM Metrics ---
[FILTER]
    Name                parser
    Match               apim.metrics
    Key_Name            log
    Parser              apim_metrics_parser
    Reserve_Data        On
    Preserve_Key        Off

[FILTER]
    Name                parser
    Match               apim.metrics
    Key_Name            properties
    Parser              jsonparser
    Reserve_Data        On
    Preserve_Key        Off

[FILTER]
    Name                rewrite_tag
    Match               apim.metrics
    Rule                $apimMetrics   ^apim:response$   metrics.response   false

[FILTER]
    Name                rewrite_tag
    Match               apim.metrics
    Rule                $apimMetrics   ^apim:faulty$     metrics.faulty     false

# --- OUTPUT: Metrics Response ---

[OUTPUT]
    Name                opensearch
    Match               metrics.response
    Host                127.0.0.1
    Port                9200
    HTTP_User           admin
    HTTP_Passwd         <PASSWORD>
    Logstash_Format     On
    Logstash_DateFormat %Y-%m-%d
    Logstash_Prefix     apim_event_response
    Replace_Dots        On
    Suppress_Type_Name  On
    tls                 On
    tls.verify          Off
    Trace_Error         On

# --- OUTPUT: Metrics Faulty ---
[OUTPUT]
    Name                opensearch
    Match               metrics.faulty
    Host                127.0.0.1
    Port                9200
    HTTP_User           admin
    HTTP_Passwd         <PASSWORD>
    Logstash_Format     On
    Logstash_DateFormat %Y-%m-%d
    Logstash_Prefix     apim_event_faulty
    Replace_Dots        On
    Suppress_Type_Name  On
    tls                 On
    tls.verify          Off
    Trace_Error         On
```

Create a parser configuration file (parsers.conf) with the following configurations.

```yaml
[PARSER]
    Name        apim_metrics_parser
    Format      regex
    Regex       ^\s*(?:.*?)\s+apimMetrics:\s*(?<apimMetrics>[^,]+?),\s*(?:.*?)\s*:\s*(?<properties>\{.*\})\s*(?:.*)$

[PARSER]
    Name        jsonparser
    Format      json
    Time_Key    time
    Time_Keep   On
```

### View Analytics from OpenSearch Dashboards

1. Start the OpenSearch cluster and dashboards. Once started,Opensearch dashboard can be accessed at http://0.0.0.0:5601.

2. Start Fluent Bit using the following command:

    ```
    fluent-bit -c <path_to_your_fluent-bit.conf>
    ```

3. Log in to the OpenSearch dashboards.

4. Navigate to Stack Management > index pattern. If you already have any index patterns created under the following names, delete them before importing the saved artifacts.
    ```
    apim_event*
    apim_event_faulty
    apim_event_response
    ```

5. Download the artifact file from below.<br />
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [Artifacts]({{base_path}}/assets/img/analytics/cloud/opensearch-analytics-dashboards.ndjson)
6. Navigate to **Dashboard Management** > **Saved Objects** and click on **Import**. Add the downloaded artifact file as an import object, and import.