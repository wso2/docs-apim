# Introduction to User Management

User management is a mechanism which involves defining and managing
users, roles and their access levels in a system. A user management
dashboard or console provides system administrators a holistic view of a
system's active user sessions, their log-in statuses, the privileges of
each user and their activity in the system, enabling the system
administrators to make business-critical, real-time security
decisions. A typical user management implementation involves a wide
range of functionality such as adding/deleting users, controlling user
activity through permissions, managing user roles, defining
authentication policies, managing external user stores, manual/automatic
log-out, resetting user passwords etc.

Any user management system has users, roles, user stores and user
permissions as its basic components .

### Users

Users are consumers who interact with your organizational applications,
databases or any other systems. These users can be a person, a device or
another application/program within or outside of the organization's
network. Since these users interact with internal systems and access
data, the need to define which user is allowed to do what is critical to
most security-conscious organizations. This is how the concept of user
management developed.

  

### Permission

A permission is a 'delegation of authority' or a 'right' assigned to a
user or a group of users to perform an action on a system. Permissions
can be granted to or revoked from a user/user group/user role
automatically or by a system administrator. For example, if a user has
the permission to log-in to a system , then the permission to log-out is
automatically implied without the need of granting it specifically.

  

### User Roles

A user role is a consolidation of several permissions. Instead of
associating permissions with a user, administrator can associate
permissions with a user role and assign the role to users. User roles
can be reused throughout the system and prevents the overhead of
granting multiple permissions to each and every user individually.

### User Store

A user store is a persistent storage where information of the users
and/or user roles is stored. User information includes log-in name,
password, fist name, last name, e-mail etc. It can be either file based
or a database maintained within SP or externally to it. User stores used
in SP differs based on the interface(IdP Client) used to interact with
the user store. By default, a file based user store maintained in the
\<SP\_HOME\>/conf/\<PROFILE\>/deployment.yaml file interfaced through
'Local' IdP Client is enabled.

  
