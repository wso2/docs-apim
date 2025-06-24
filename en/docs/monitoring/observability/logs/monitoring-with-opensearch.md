# Monitoring APIM logs with OpenSearch

WSO2 APIM facilitates integration with log management and analytics solutions for improved observability and monitoring. This guide details the procedure for configuring WSO2 APIM to monitor its logs with OpenSearch.

OpenSearch based WSO2 API Manager log monitoring setup is similar to the OpenSearch On-Premise Analytics deployment setup. The steps required to install OpenSearch and Fluent Bit can be found [here](../../api-analytics/on-prem/opensearch-installation-guide.md).

### Configuring Fluent Bit
1. After installing Fluent Bit and OpenSearch, create a Fluent Bit configuration file (fluent-bit.conf) with the following attributes to direct WSO2 API Manager logs to the OpenSearch cluster.

!!! note 
    In the below configuration, update `<APIM_HOME>`, `<TAIL_FILE_PATH>`, `<PATH_TO_PARSER_CONFIG>`, and, `<PASSWORD>` to match your setup.

```yaml
[SERVICE]
    Flush               1
    Daemon              Off
    Log_Level           info
    Parsers_File        <PATH_TO_PARSER_CONFIG>/parsers.conf

[INPUT]
    Name                tail
    Tag                 wso2_apim_logs
    Path                <APIM_HOME>/repository/logs/*.log
    Refresh_Interval    5
    Buffer_Chunk_Size   32KB
    Buffer_Max_Size     2MB
    Mem_Buf_Limit       256MB
    Read_from_Head      true
    DB                  <TAIL_FILE_PATH>/metrics-tail-status.db

[FILTER]
    name                  multiline
    match                 wso2_apim_logs
    multiline.key_content log
    multiline.parser      wso2_multiline_parser

[FILTER]
    Name                  modify
    Match                 wso2_apim_logs
    Add product           api-management
    Add component         apim

[FILTER]
    Name          rewrite_tag
    Match         wso2_apim_logs
    Rule          $log ^CARBON wso2_apim_carbon_logs false
    Emitter_Name  re_emitted_apim_carbon

[FILTER]
    Name          parser
    Match         wso2_apim_carbon_logs
    Key_Name      log
    Parser        wso2apim_carbon_parser
    Reserve_Data  True
    Preserve_Key  True

[FILTER]
    Name          rewrite_tag
    Match         wso2_apim_logs
    Rule          $log ^HTTP wso2_apim_http_logs false
    Emitter_Name  re_emitted_apim_http

[FILTER]
    Name          rewrite_tag
    Match         wso2_apim_logs
    Rule          $log ^AUDIT wso2_apim_audit_logs false
    Emitter_Name  re_emitted_apim_audit

[FILTER]
    Name          rewrite_tag
    Match         wso2_apim_logs
    Rule          $log ^CREL wso2_apim_correlation_logs false
    Emitter_Name  re_emitted_apim_correlation

[FILTER]
    Name          rewrite_tag
    Match         wso2_apim_logs
    Rule          $log ^TRACE wso2_apim_trace_logs false
    Emitter_Name  re_emitted_apim_trace
    
[OUTPUT]
    Name                opensearch
    Match               wso2_apim_carbon_logs
    Host                127.0.0.1
    Port                9200
    HTTP_User           admin
    HTTP_Passwd         <PASSWORD>
    Logstash_Format     On
    Logstash_DateFormat %Y-%m-%d
    Logstash_Prefix     wso2-apim-application-logs
    Replace_Dots        On
    Suppress_Type_Name  On
    tls                 On
    tls.verify          Off
    Trace_Error         On

[OUTPUT]
    Name                opensearch
    Match               wso2_apim_http_logs
    Host                127.0.0.1
    Port                9200
    HTTP_User           admin
    HTTP_Passwd         <PASSWORD>
    Logstash_Format     On
    Logstash_DateFormat %Y-%m-%d
    Logstash_Prefix     wso2-apim-access-logs
    Replace_Dots        On
    Suppress_Type_Name  On
    tls                 On
    tls.verify          Off
    Trace_Error         On

[OUTPUT]
    Name                opensearch
    Match               wso2_apim_correlation_logs
    Host                127.0.0.1
    Port                9200
    HTTP_User           admin
    HTTP_Passwd         <PASSWORD>
    Logstash_Format     On
    Logstash_DateFormat %Y-%m-%d
    Logstash_Prefix     wso2-apim-correlation-logs
    Replace_Dots        On
    Suppress_Type_Name  On
    tls                 On
    tls.verify          Off
    Trace_Error         On

[OUTPUT]
    Name                opensearch
    Match               wso2_apim_trace_logs
    Host                127.0.0.1
    Port                9200
    HTTP_User           admin
    HTTP_Passwd         <PASSWORD>
    Logstash_Format     On
    Logstash_DateFormat %Y-%m-%d
    Logstash_Prefix     wso2-apim-trace-logs
    Replace_Dots        On
    Suppress_Type_Name  On
    tls                 On
    tls.verify          Off
    Trace_Error         On

[OUTPUT]
    Name                opensearch
    Match               wso2_apim_audit_logs
    Host                127.0.0.1
    Port                9200
    HTTP_User           admin
    HTTP_Passwd         <PASSWORD>
    Logstash_Format     On
    Logstash_DateFormat %Y-%m-%d
    Logstash_Prefix     wso2-apim-audit-logs
    Replace_Dots        On
    Suppress_Type_Name  On
    tls                 On
    tls.verify          Off
    Trace_Error         On
```

Create a parser configuration file (parsers.conf) with the following configurations.

```yaml
[PARSER]
    Name        jsonparser
    Format      json
    Time_Key    time
    Time_Keep   On
        
[PARSER]
    Name        wso2apim_carbon_parser
    Format      regex
    Regex       ^(?<log_type>[A-Z]+) \[(?<time>[0-9-]{10} [0-9:,]{12})\]\s+(?<level>[A-Z]+)\s+\{(?<module>[^}]+)\}\s*(?:\[\s*Deployed From Artifact Container:\s+(?<package>[^\]]+)\s*\]\s*)?\s*(?:-\s+\{api:(?<api>[^}]+)\})?\s*(?<message>(.|\n)+)
    Time_Key    time
    Time_Format %Y-%m-%d %H:%M:%S,%L

[MULTILINE_PARSER]
    name          wso2_multiline_parser
    type          regex
    flush_timeout 1000
    rule          "start_state"   "^CARBON.*"   "cont"
    rule          "cont"          "^(?!CARBON|CREL|AUDIT|HTTP|TRACE|METRIC).*" "cont"
```
### Configuring API Manager

To enable effective log parsing and indexing with Fluent Bit, the WSO2 API Manager's logging configuration has to be updated. This process involves adding a unique prefix to the layout pattern of each log appender. These prefixes act as identifiers, allowing Fluent Bit to correctly differentiate and process various log streams. Update the following values in `<APIM_HOME>/repository/conf/log4j2.properties` file.

1. Add CARBON prefix to the CARBON_LOGFILE appender

```properties
{% raw %}
.... (CARBON_LOGFILE appender configurations)
appender.CARBON_LOGFILE.layout.pattern = CARBON [%d] %5p {%c{1}} %X{Artifact-Container} - %m%ex%n
.... (CARBON_LOGFILE appender configurations continued)
{% endraw %}
```

Next, apply similar prefixes to the other log types that need to be observed in OpenSearch.

```properties
{% raw %}
....
appender.AUDIT_LOGFILE.layout.pattern = AUDIT TID: [%tenantId] [%d] %5p {%c} - %m%ex%n
....

....
appender.HTTP_ACCESS.layout.pattern = HTTP [%X{Correlation-ID}] %mm%n
....
{% endraw %}
```

### View Analytics from OpenSearch Dashboards

1. Start the OpenSearch cluster and dashboards. Once started,Opensearch dashboard can be accessed at http://0.0.0.0:5601.

2. Start Fluent Bit using the following command:

```
fluent-bit -c <path_to_your_fluent-bit.conf>
```

3. Go to the OpenSearch dashboard, select Discover from the left side menu, and create an index to view the logs. To see all logs sent to OpenSearch, use * as a wildcard selection when creating the index.