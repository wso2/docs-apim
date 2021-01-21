# Datasource Parameters

The datasource configuration in a data service specifies how the service connects to the datasource. The datasource connection parameters you can use depends on the type of datasource you are exposing.

## RDBMS Connection parameters

Shown below is the synapse configuration of an RDBMS datasource in a data service. See the complete list of [JDBC connection pool parameters](http://tomcat.apache.org/tomcat-7.0-doc/jdbc-pool.html) and the [DBCP configuration guide](http://commons.apache.org/proper/commons-dbcp/configuration.html) for more details.

!!! Note
      The default values of the following parameters might not be optimal for the specific hardware/server configurations in your environment. We recommend that you carry out load tests in your environment to tune them accordingly. See [Tuning Datasource Configuration Parameters]({{base_path}}/install-and-setup/performance_tuning/jdbc_tuning) for information on how you can select the best values for these parameters.

```toml
<data name="RDBMSDataService" serviceStatus="inactive" transports="http https local">
   <config enableOData="false" id="data">
      <property name="driverClassName">com.mysql.jdbc.Driver</property>
      <property name="url">jdbc:mysql://[machine-name/ip]:[port]/[database-name]</property>
      <property name="defaultTransactionIsolation">TRANSACTION_NONE</property>
      <property name="initialSize"></property>
      <property name="maxActive"></property>
      <property name="minIdle"></property>
      <property name="maxIdle"></property>
      <property name="maxWait"></property>
      <property name="validationQuery"></property>
      <property name="timeBetweenEvictionRunsMillis"></property>
      <property name="numTestsPerEvictionRun"></property>
      <property name="minEvictableIdleTimeMillis"></property>
      <property name="removeAbandonedTimeout"></property>
      <property name="defaultCatalog"></property>
      <property name="validatorClassName"></property>
      <property name="connectionProperties"></property>
      <property name="initSQL"></property>
      <property name="jdbcInterceptors"></property>
      <property name="validationInterval"></property>
      <property name="abandonWhenPercentageFull"></property>
      <property name="maxAge"></property>
      <property name="suspectTimeout"></property>
      <property name="validationQueryTimeout"></property>
   </config>
</data>
```