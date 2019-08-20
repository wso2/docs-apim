# Re-indexing Existing Data

This section covers reindexing data that are already stored in databases configured for WSO2 API-M Analytics.

Data indexed and stored in databases may need to be reindexed due to the following reasons:

-   If the index data is corrupted.
-   If you change the database to another database, the data in the new database needs to be re-indexed.

To reindex existing data, follow the steps below:

1.  Shut down API-M Analytics.
2.  Remove all the index data stored in the `          <API-M_ANALYTICS_HOME>/repository/data         ` directory.
3.  In the `          <API-M_ANALYTICS_HOME>/repository/conf/analytics/local-shard-allocation-config.conf         ` file, change the mode for all the shards from `          NORMAL         ` to `          INIT         ` .
4.  Restart API-M Analytics.

