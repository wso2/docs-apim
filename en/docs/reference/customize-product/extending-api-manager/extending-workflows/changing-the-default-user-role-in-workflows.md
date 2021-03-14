# Changing the Default User Role in Workflows

The default user role in the workflow configuration files is the admin role. If you change this to something else, you need to change the following files:

1.  Change the credentials in the `.epr` files of the `<BPS_HOME>/repository/conf/epr` folder.
2.  Change the credentials in work-flow configurations in API Manager Registry ( `_system/governance/apimgt/applicationdata/workflow-extensions.xml` )
3.  Point the same database that has the permissions used by the API Manager to the BPS.
4.  Share the LDAP, if it exists.
5.  If you change the default user role, change the .ht file of the relevant human task.

