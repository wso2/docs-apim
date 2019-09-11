# Changing the RDBMS

The default database of user manager is the H2 database that comes with WSO2 products. You can configure it to point to databases by other vendors.

1.  Add the JDBC driver to the `classpath` by dropping the JAR into `<PRODUCT_HOME>/repository/components/lib` .
2.  Change values of properties given in on the Realm Configuration page appropriately.
3.  Create the database by running the relevant script in `<PRODUCT_HOME>` / dbscripts and restart the server:
    -   **For Linux** : `sh wso2server.sh` or `sh wso2server.sh`
    -   **For Windows** : `wso2server.bat` or `wso2server.batReadOnlyLDAPUserStoreManager">`
`

