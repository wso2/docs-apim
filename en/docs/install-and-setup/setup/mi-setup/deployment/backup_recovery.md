# Backup and Recovery

We recommend that you use a proper artifact management system such as [Puppet](https://puppet.com/) to back up and manage your artifacts before deploying them in the Micro Integrator runtime. Also, use the [**WSO2 Update Manager**](https://docs.wso2.com/display/updates/WSO2+Updates) (WUM) tool, which is a command-line utility that allows you to get the latest updates (bug fixes and security fixes) of a particular product release.

![Backup and recovery flow]({{base_path}}/assets/img/integrate/admin-guide-configuration-mgmt.png)

## Recovery recommendations
Be sure to determine the following depending on your business-continuity requirements:

* Recovery Time Objective (RTO): How long does it take to recover to the RPO.
* Backup Frequency: How frequently you should take backups. If your RPO is one day, your backup frequency should be daily.
* Disaster Recovery Site: The place where the latest copy of your backup is. This can be from a different shelf in your data center to a completely different geographical location.

We also recommend the following:

* Align your artifact deployment and recovery processes.
* Schedule disaster recovery drills to test the recoverability of the system.
* Test your artifacts in an environment that is identical to the production environment before deploying them into production.

## Recovery strategy
The following steps include how to recover your setup using the backups:

1. Recover the hot-deployment artifacts by replacing the MI_HOME/repository directory with the backed up copy.
2. To recover the databases, follow the recovery strategy recommended by the databases you are using. For information on supported and tested databases, see [Tested Database Management Systems](https://docs.wso2.com/display/compatibility/Tested+DBMSs).
