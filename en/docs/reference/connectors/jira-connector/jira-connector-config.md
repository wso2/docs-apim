# Jira Connector Reference

The following operations allow you to work with the Jira Connector. Click an operation name to see parameter details and samples on how to use it.

??? note "init"
    The init operation configures the connection parameters used to establish a connection to the Jira server.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>username</td>
            <td>The username of the user.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>password</td>
            <td>The password of the user.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>uri</td>
            <td>The instance URI of Jira account.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>blocking</td>
            <td>This property helps the connector perform blocking invocations to Jira.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <jira.init>
        <username>{$ctx:username}</username>
        <password>{$ctx:password}</password>
        <uri>{$ctx:uri}</uri>
        <blocking>{$ctx:blocking}</blocking>
    </jira.init>
    ```

    **Sample request**

    The following sample REST request can be handled by the init operation.

    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "blocking":"false"
    }
    ```
    
    
??? note "getDashboards"
    This operation returns a JSON representation of the list of dashboards, including their names, IDs, and more.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of dashboards to return, up to 1000 (default is 50).</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>startAt</td>
            <td>The index of the first dashboard to return (0-based). Must be 0 or a multiple of maxResults.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>filter</td>
            <td>An optional filter that is applied to the list of dashboards.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getDashboards>
        <maxResults>{$ctx:maxResults}</maxResults>
        <filter>{$ctx:filter}</filter>
        <startAt>{$ctx:startAt}</startAt>
    </jira.getDashboards>
    ```
    
    **Sample request**
    
    The following is a sample REST/JSON request that can be handled by the getDashboards operation.

    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "maxResults":"50",
        "filter":"favourite"
    }
    ```
    
    **Sample response**
    
    Given below is a sample response for the getDashboards operation.
    
    ```json
    {
        "startAt": 0,
        "maxResults": 50,
        "total": 1,
        "dashboards": [
            {
                "id": "10100",
                "name": "test",
                "self": "http://localhost:8080/rest/api/2/dashboard/10100",
                "view": "http://localhost:8080/secure/Dashboard.jspa?selectPageId=10100"
            }
        ]
    }
    ```
    
??? note "getDashboardById"

    This operation returns a JSON representation of the dashboard details, including its name, ID, and more.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>id</td>
            <td>Identifies the dashboard that you want to get.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getDashboardById>
        <id>{$ctx:id}</id>
    </jira.getDashboardById>
    ```

    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getDashboardById` operation.
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "id":"10100"
    }
    ```
    
    **Sample response**
    
    Given below is a sample response for the `getDashboardById` operation.
    
    ```json
    {
        "id": "10100",
        "name": "test",
        "self": "http://localhost:8080/rest/api/2/dashboard/10100",
        "view": "http://localhost:8080/secure/Dashboard.jspa?selectPageId=10100"
    }
    ```

??? note "getFilterById"

    To get information about a specific filter, use `getFilterById` and specify the filter ID. This operation returns a JSON representation of the filter information, including the name, ID, search URL, and more.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>filterId</td>
            <td>Identifies the filter that you want to get.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getFilterById>
        <filterId>{$ctx:filterId}</filterId>
        <expand>{$ctx:expand}</expand>
    </jira.getFilterById>
    ```

    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getFilterById` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "filterId":"10100"
    }
    ``` 
    
    **Sample response**

    Given below is a sample response for the `getFilterById` operation.
    
    ```json
    {
        "self": "http://localhost:8080/rest/api/2/filter/10100",
        "id": "10100",
        "name": "All Open Bugs",
        "description": "Lists all open bugs",
        "owner": {
            "self": "http://localhost:8080/rest/api/2/user?username=admin",
            "key": "admin",
            "name": "admin",
            "avatarUrls": {
                "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
            },
            "displayName": "admin@gmail.com",
            "active": true
        },
        "jql": "type = Bug AND resolution is EMPTY",
        "viewUrl": "http://localhost:8080/issues/?filter=10100",
        "searchUrl": "http://localhost:8080/rest/api/2/search?jql=type+%3D+Bug+AND+resolution+is+EMPTY",
        "favourite": true,
        "sharePermissions": [],
        "editable": true,
        "sharedUsers": {
            "size": 0,
            "items": [],
            "max-results": 1000,
            "start-index": 0,
            "end-index": 0
        },
        "subscriptions": {
            "size": 0,
            "items": [],
            "max-results": 1000,
            "start-index": 0,
            "end-index": 0
        }
    }
    ```

??? note "getFavouriteFilters"
    To get the favorite filters of the current user, use `getFavouriteFilter`. This operation returns a JSON representation of the filters, including their names, IDs, search URLs, and more.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <jira.getFavouriteFilters>
        <expand>{$ctx:expand}</expand>
    </jira.getFavouriteFilters>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getFavouriteFilters` operation.

    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080"
    }
    ```

    **Sample response**
    Given below is a sample response for the `getFavouriteFilters` operation.

    ```json
    [
        {
            "self": "http://localhost:8080/rest/api/2/filter/10100",
            "id": "10100",
            "name": "All Open Bugs",
            "description": "Lists all open bugs",
            "owner": {
                "self": "http://localhost:8080/rest/api/2/user?username=admin",
                "key": "admin",
                "name": "admin",
                "avatarUrls": {
                    "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                    "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                    "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                    "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
                },
                "displayName": "admin@gmail.com",
                "active": true
            },
            "jql": "type = Bug AND resolution is EMPTY",
            "viewUrl": "http://localhost:8080/issues/?filter=10100",
            "searchUrl": "http://localhost:8080/rest/api/2/search?jql=type+%3D+Bug+AND+resolution+is+EMPTY",
            "favourite": true,
            "sharePermissions": [],
            "editable": true,
            "sharedUsers": {
                "size": 0,
                "items": [],
                "max-results": 1000,
                "start-index": 0,
                "end-index": 0
            },
            "subscriptions": {
                "size": 0,
                "items": [],
                "max-results": 1000,
                "start-index": 0,
                "end-index": 0
            }
        }
    ]
    ```

??? note "createFilter"
    To create a new filter, use `createFilter` and attach the JSON representation of the filter as the payload of the request.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>filterName</td>
            <td>The name of the filter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>description</td>
            <td>The description of the filter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>jqlType</td>
            <td>The jql type of the filter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>favourite</td>
            <td>Specify whether the filter is a favourite.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <jira.createFilter>
        <filterName>{$ctx:filterName}</filterName>
        <description>{$ctx:description}</description>
        <jqlType>{$ctx:jqlType}</jqlType>
        <favourite>{$ctx:favourite}</favourite>
    </jira.createFilter>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `createFilter` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "filterName":"All Open Bugs",
        "description":"Lists all open bugs",
        "jqlType":"Bug and resolution is empty",
        "favourite":"true"
    }
    ```

    **Sample response**

    Given below is a sample response for the `createFilter` operation.
    
    ```json
    {
        "self": "http://localhost:8080/rest/api/2/filter/10100",
        "id": "10100",
        "name": "All Open Bugs",
        "description": "Lists all open bugs",
        "owner": {
            "self": "http://localhost:8080/rest/api/2/user?username=admin",
            "key": "admin",
            "name": "admin",
            "avatarUrls": {
                "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
            },
            "displayName": "admin@gmail.com",
            "active": true
        },
        "jql": "type = Bug AND resolution is EMPTY",
        "viewUrl": "http://localhost:8080/issues/?filter=10100",
        "searchUrl": "http://localhost:8080/rest/api/2/search?jql=type+%3D+Bug+AND+resolution+is+EMPTY",
        "favourite": true,
        "sharePermissions": [],
        "editable": true,
        "sharedUsers": {
            "size": 0,
            "items": [],
            "max-results": 1000,
            "start-index": 0,
            "end-index": 0
        },
        "subscriptions": {
            "size": 0,
            "items": [],
            "max-results": 1000,
            "start-index": 0,
            "end-index": 0
        }
    }
    ```

??? note "updateFilterById"
    To update an existing filter, use `updateFilterById` with the filter ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>filterId</td>
            <td>The id of the filter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>filterName</td>
            <td>The name of the filter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>description</td>
            <td>The description of the filter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>jqlType</td>
            <td>The jql type of the filter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>favourite</td>
            <td>Specify whether the filter is a favourite.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.updateFilterById>
        <filterId>{$ctx:filterId}</filterId>
        <filterName>{$ctx:filterName}</filterName>
        <description>{$ctx:description}</description>
        <jqlType>{$ctx:jqlType}</jqlType>
        <favourite>{$ctx:favourite}</favourite>
    </jira.updateFilterById>
    ```
    
    **Sample request**
    The following is a sample REST/JSON request that can be handled by the `updateFilterById` operation.
    
    ```json
    {
    "username":"admin",
    "password":"jira@jaffna",
    "uri":"http://localhost:8080",
    "filterName":"All  Bugs",
    "description":"Lists all bugs",
    "jqlType":"Bug and resolution is empty",
    "favourite":"true",
    "filterId":"10101"
    }
    ```

    **Sample response**

    Given below is a sample response for the `updateFilterById` operation.
    
    ```json
    {
        "self": "http://localhost:8080/rest/api/2/filter/10101",
        "id": "10101",
        "name": "All  Bugs",
        "description": "Lists all bugs",
        "owner": {
            "self": "http://localhost:8080/rest/api/2/user?username=admin",
            "key": "admin",
            "name": "admin",
            "avatarUrls": {
                "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
            },
            "displayName": "admin@gmail.com",
            "active": true
        },
        "jql": "type = Bug AND resolution is EMPTY",
        "viewUrl": "http://localhost:8080/issues/?filter=10101",
        "searchUrl": "http://localhost:8080/rest/api/2/search?jql=type+%3D+Bug+AND+resolution+is+EMPTY",
        "favourite": true,
        "sharePermissions": [],
        "editable": true,
        "sharedUsers": {
            "size": 0,
            "items": [],
            "max-results": 1000,
            "start-index": 0,
            "end-index": 0
        },
        "subscriptions": {
            "size": 0,
            "items": [],
            "max-results": 1000,
            "start-index": 0,
            "end-index": 0
        }
    }
    ```

??? note "deleteFilter"
    To delete a filter, use `deleteFilter` and specify the filter ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>filterId</td>
            <td>Identifies the filter that you want to delete.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.deleteFilter>
        <filterId>{$ctx:filterId}</filterId>
    </jira.deleteFilter>
    ```

    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `deleteFilter` operation.
    
    ```json
    {
    "username":"admin",
    "password":"jira@jaffna",
    "uri":"https://testcon.atlassian.net",
    "filterId":"10101"
    }
    ```

    **Sample response**

    For the successful response, you will get 204 No Content status code without any body.


??? note "getGroup"
    This operation returns a JSON representation of the list of groups, including their names, IDs, and more.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>groupName</td>
            <td>The name of the group that you want to get.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getGroup>
        <groupName>{$ctx:groupName}</groupName>
        <expand>{$ctx:expand}</expand>
    </jira.getGroup>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getGroup` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "groupName":"jira-administrators",
        "expand":"users"
    }
    ```

    **Sample response**
    Given below is a sample response for the `getGroup` operation.
    
    ```json
    {
        "name": "jira-administrators",
        "self": "http://localhost:8080/rest/api/2/group?groupname=jira-administrators",
        "users": {
            "size": 1,
            "items": [],
            "max-results": 50,
            "start-index": 0,
            "end-index": 0
        },
        "expand": "users"
    }
    ```

??? note "listGroupPicker"
    This operation retrieves groups with substrings matching a given query.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>query</td>
            <td>The query to match groups against.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>exclude</td>
            <td>Exclude from the result.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The max results to return.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.listGroupPicker>
        <query>{$ctx:query}</query>
        <exclude>{$ctx:exclude}</exclude>
        <maxResults>{$ctx:maxResults}</maxResults>
    </jira.listGroupPicker>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `listGroupPicker` operation.
    
    ```json
    {
    "uri": "http://localhost:8080",
    "username": "admin",
    "password": "1qaz2wsx@",
    "query": "administrators",
    "exclude": "system-administrators",
    "maxResults": "2"
    }
    ```

    **Sample response**

    Given below is a sample response for the `listGroupPicker` operation.
    
    ```json
    {
        "header": "Showing 1 of 1 matching groups",
        "total": 1,
        "groups": [
            {
                "name": "jira-administrators",
                "html": "<b>jira-administrators</b>",
                "labels": [
                    {
                        "text": "Admin",
                        "title": "Users added to this group will be given administrative access",
                        "type": "ADMIN"
                    },
                    {
                        "text": "Jira Software",
                        "title": "Users added to this group will be given access to <strong>Jira Software</strong>",
                        "type": "SINGLE"
                    }
                ]
            }
        ]
    }
    ```

??? note "listGroupUserPicker"
    This operation retrieves a list of users and groups matching a query.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>query</td>
            <td>A string used to search. This can be username, name, or email address.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of users to return.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isShowAvatar</td>
            <td>The boolean value to show avatar.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.listGroupUserPicker>
        <query>{$ctx:query}</query>
        <maxResults>{$ctx:maxResults}</maxResults>
        <isShowAvatar>{$ctx:isShowAvatar}</isShowAvatar>
    </jira.listGroupUserPicker>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `listGroupUserPicker` operation.
    
    ```json
    {
    "uri": "http://localhost:8080",
    "username": "admin",
    "password": "1qaz2wsx@",
    "query": "admin",
    "maxResults": "1",
    "isShowAvatar": "true"
    }
    ```

    **Sample response**

    Given below is a sample response for the `listGroupUserPicker` operation.
    
    ```json
    {
        "users": {
            "users": [],
            "total": 0,
            "header": "Showing 0 of 0 matching users"
        },
        "groups": {
            "header": "Showing 1 of 1 matching groups",
            "total": 1,
            "groups": [
                {
                    "name": "jira-administrators",
                    "html": "jira-<b>admin</b>istrators",
                    "labels": [
                        {
                            "text": "Admin",
                            "title": "Users added to this group will be given administrative access.",
                            "type": "ADMIN"
                        },
                        {
                            "text": "Jira Software",
                            "title": "Users added to this group will be given access to <strong>Jira Software</strong>.",
                            "type": "SINGLE"
                        }
                    ]
                }
            ]
        }
    }
    ```

??? note "getIssue"
    To get an existing issue, use `getIssue` and specify the issue ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue to retrieve. This can be an issue ID, or an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>The list of fields to return for the issue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getIssue>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <fields>{$ctx:fields}</fields>
        <expand>{$ctx:expand}</expand>
    </jira.getIssue>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getIssue` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"EX-1"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getIssue` operation.
    
    ```json
    {
        "id": "10002",
        "self": "http://localhost:8080/jira/rest/api/2/issue/10002",
        "key": "EX-1",
        "fields": {
            "sub-tasks": [],
            "timetracking": {
                "originalEstimate": "10m",
                "remainingEstimate": "3m",
                "timeSpent": "6m",
                "originalEstimateSeconds": 600,
                "remainingEstimateSeconds": 200,
                "timeSpentSeconds": 400
            },
            "project": {
                "self": "http://localhost:8080/jira/rest/api/2/project/EX",
                "id": "10000",
                "key": "EX",
                "name": "Example",
                "avatarUrls": {
                    "24x24": "http://localhost:8080/jira/secure/projectavatar?size=small&pid=10000",
                    "16x16": "http://localhost:8080/jira/secure/projectavatar?size=xsmall&pid=10000",
                    "32x32": "http://localhost:8080/jira/secure/projectavatar?size=medium&pid=10000",
                    "48x48": "http://localhost:8080/jira/secure/projectavatar?size=large&pid=10000"
                }
            },
            "updated": 1,
            "description": "example bug report",
            "issuelinks": [
                {
                    "id": "10001",
                    "type": {
                        "id": "10000",
                        "name": "Dependent",
                        "inward": "depends on",
                        "outward": "is depended by"
                    },
                    "outwardIssue": {
                        "id": "10004L",
                        "key": "PRJ-2",
                        "self": "http://localhost:8080/jira/rest/api/2/issue/PRJ-2",
                        "fields": {
                            "status": {
                                "iconUrl": "http://localhost:8080/jira//images/icons/statuses/open.png",
                                "name": "Open"
                            }
                        }
                    }
                }
            ],
            "attachment": [],
            "watcher": {
                "self": "http://localhost:8080/jira/rest/api/2/issue/EX-1/watchers",
                "isWatching": false,
                "watchCount": 1,
                "watchers": []
            },
            "comment": [],
            "worklog": []
        }
    }
    ```

??? note "createIssue"
    To create a new issue (or task), use `createIssue` and set the following properties.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectKey</td>
            <td>The key (unique identifier) of the project in which you are creating the issue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueFields</td>
            <td>Fields of the issue.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.createIssue>
        <projectKey>{$ctx:projectKey}</projectKey>
        <issueFields>{$ctx:issueFields}</issueFields>
    </jira.createIssue>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `createIssue` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueFields":{
            "fields": {
                "project":{
                    "key": "TEST1"
                },
                "summary": "Hello",
                "description": "test issue",
                "issuetype": {
                    "id": "10000"
                }
            }
        }
    }
    ```

    **Sample response**

    Given below is a sample response for the `createIssue` operation.
    
    ```json
    {
        "id": "10000",
        "key": "TEST1",
        "self": "http://localhost:8080/jira/rest/api/2/issue/10000"
    }
    ```

??? note "updateIssue"
    To update an issue, use `updateIssue` and specify the issue ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>The key (unique identifier) of the issue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueFields</td>
            <td>Fields of the issue.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.updateIssue>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <issueFields>{$ctx:issueFields}</issueFields>
    </jira.updateIssue>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `updateIssue` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-6",
        "issueFields":{
            "update":{
                "summary":[
                {
                    "set":"Bug in business logic"
                }
                ],
                "labels":[
                {
                    "add":"triaged"
                },
                {
                    "remove":"blocker"
                }
                ]
            }
        }
    }
    ```

    **Sample response**

    200 will be returned if it updated the issue succesfully.
    
??? note "updateIssueAssignee"
    To assign an issue to another user, use `updateIssueAssignee` and specify the issue ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue to update. This can be an issue ID or an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>name</td>
            <td>The username of the user.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.updateIssueAssignee>
        <name>{$ctx:name}</name>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
    </jira.updateIssueAssignee>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `updateIssueAssignee` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "name":"admin",
        "issueIdOrKey":"TEST-2"
    }
    ```

    **Sample response**

    Returned 204 if the issue is successfully assigned.

??? note "getTransitions"
    To get a list of the possible transitions the current user can perform for an issue, use `getTransitions` and specify the issue ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue to update. This can be an issue ID or an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getTransitions>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <expand>{$ctx:expand}</expand>
    </jira.getTransitions>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getTransitions` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-2"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getTransitions` operation.

    ```json
    {
        "transitions": [
            {
                "id": "2",
                "name": "Close Issue",
                "to": {
                    "self": "http://localhost:8080/jira/rest/api/2.0/status/10000",
                    "description": "The issue is currently being worked on.",
                    "iconUrl": "http://localhost:8080/jira/images/icons/progress.gif",
                    "name": "In Progress",
                    "id": "10000",
                    "statusCategory": {
                        "self": "http://localhost:8080/jira/rest/api/2.0/statuscategory/1",
                        "id": 1,
                        "key": "in-flight",
                        "colorName": "yellow"
                    }
                },
                "fields": {...},
            {
                "id": "711",
                "name": "QA Review",
                "to": {
                    "self": "http://localhost:8080/jira/rest/api/2.0/status/5",
                    "description": "The issue is closed.",
                    "iconUrl": "http://localhost:8080/jira/images/icons/closed.gif",
                    "name": "Closed",
                    "id": "5",
                    "statusCategory": {
                        "self": "http://localhost:8080/jira/rest/api/2.0/statuscategory/9",
                        "id": 9,
                        "key": "completed",
                        "colorName": "green"
                    }
                },
                "fields": {
                    ...
                }
            }
        ]
    }
    ```

??? note "doTransition"
    To perform a transition on an issue, use `doTransition`. Specify the issue ID and include the transition ID along with any other updates you want to make. Use the following properties:
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue to update. This can be an issue ID, or an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueFields</td>
            <td>Fields of the issue.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.doTransition>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <issueFields>{$ctx:issueFields}</issueFields>
    </jira.doTransition>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `doTransitions` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-2"
        "issueFields":{
        "update": {
        "comment": [
                {
                    "add": {
                        "body": "Bug has been fixed."
                        }
                }
            ]
        },
        "transition": {
            "id": "11"
        }
    }
    }
    ```

    **Sample response**

    Returned 204 if the transition was successful.

??? note "getComments"
    To get the comments for an issue, use `getComments` with the issue ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue that has the comments. This can be an issue ID, or an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getComments>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <expand>{$ctx:expand}</expand>
    </jira.getComments>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getComments` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-2"
    }
    ```

    **Sample response**

    Given below is a sample response for the getComments operation.

    ```json
    {
        "startAt": 0,
        "maxResults": 1,
        "total": 1,
        "comments": [
            {
                "self": "http://localhost:8080/jira/rest/api/2/issue/10010/comment/10000",
                "id": "10000",
                "author": {
                    "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                    "name": "fred",
                    "displayName": "Fred F. User",
                    "active": false
                },
                "body": "Testing.",
                "updateAuthor": {
                    "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                    "name": "fred",
                    "displayName": "Fred F. User",
                    "active": false
                },
                "created": "2013-08-23T16:57:35.982+0200",
                "updated": "2013-08-23T16:57:35.983+0200",
                "visibility": {
                    "type": "role",
                    "value": "Administrators"
                }
            }
        ]
    }
    ```

??? note "postComment"
    To post a comment to an issue, use `postComment` with the following properties.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue to which you are adding this comment. This can be an issue ID or an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>Comment</td>
            <td>The text to post as the comment.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>visibleRole</td>
            <td>User role that can view the comment.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.postComment>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <comment>{$ctx:comment}</comment>
        <visibleRole>{$ctx:visibleRole}</visibleRole>
        <expand>{$ctx:expand}</expand>
    </jira.postComment>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `postComment` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-1",
        "comment":"Waiting to hear back from the legal department.",
        "visibleRole":"Administrators"
    }
    ```

    **Sample response**

    Given below is a sample response for the `postComment` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/issue/10010/comment/10000",
        "id": "10000",
        "author": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "displayName": "Fred F. User",
            "active": false
        },
        "body": "Testing issue",
        "updateAuthor": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "displayName": "Fred F. User",
            "active": false
        },
        "created": "2013-08-23T16:57:35.982+0200",
        "updated": "2013-08-23T16:57:35.983+0200",
        "visibility": {
            "type": "role",
            "value": "Administrators"
        }
    }
    ```

??? note "updateComment"
    To update an existing comment, use the `updateComment` operation.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue with the comments you want to update. This can be an issue ID, or an issue key. If the issue cannot be found via an exact match, Jira will also look for the issue in a case-insensitive way, or by looking to see if the issue was moved.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>commentId</td>
            <td>Identifies the comment you are updating.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>comment</td>
            <td>A string containing the comment to be posted.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>visibleRole</td>
            <td>A String containing the visible role.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand. The 'renderedBody' optional parameter provides the body rendered in HTML.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.updateComment>
        <commentId>{$ctx:commentId}</commentId>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <comment>{$ctx:comment}</comment>
        <visibleRole>{$ctx:visibleRole}</visibleRole>
    </jira.updateComment>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `updateComment` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-1",
        "commentId":"10000",
        "comment":"is this a bug?",
        "visibleRole":"Administrators"
    }
    ```

    **Sample response**

    Given below is a sample response for the updateComment operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/issue/10010/comment/10000",
        "id": "10000",
        "author": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "displayName": "Fred F. User",
            "active": false
        },
        "body": "Testing.",
        "updateAuthor": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "displayName": "Fred F. User",
            "active": false
        },
        "created": "2013-08-23T16:57:35.982+0200",
        "updated": "2013-08-23T16:57:35.983+0200",
        "visibility": {
            "type": "role",
            "value": "Administrators"
        }
    }
    ```

??? note "deleteComment"
    To delete an existing comment, use `deleteComment`.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue with the comments that you want to delete. This can be an issue ID or an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>commentId</td>
            <td>Identifies the comment you are deleting.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.deleteComment>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <commentId>{$ctx:commentId}</commentId>
    </jira.deleteComment>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `deleteComment` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-2",
        "commentId":"10000"
    }
    ```

    **Sample response**

    Returned 204 if delete is successful.

??? note "addAttachmentToIssueId"
    To add one or more attachments to an issue, use `addAttachmentToIssueId` with the issue ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue to which you are adding attachments. This can be an issue ID or an issue key.</td>
            <td>Yes</td>
        </tr>
    </table>

    !!! Info
        Multipart/form-data cannot be processed inside the server. Therefore, the Micro Integrator/ESB should be in a content-unaware status. To achieve this, configure a pass-through proxy, build the message from the client end, and then send it to the proxy.

    **Sample configuration**
    
    ```xml
    <jira.addAttachmentToIssueId>
        <issueIdOrKey>{$url:issueIdOrKey}</issueIdOrKey>
    </jira.addAttachmentToIssueId>
    ```
    
    **Sample response**

    Given below is a sample response to the `addAttachmentToIssueId` operation.
    
    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2.0/attachments/10000",
            "filename": "picture.jpg",
            "author": {
                "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                "name": "fred",
                "avatarUrls": {
                    "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                    "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                    "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                    "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                },
                "displayName": "Fred F. User",
                "active": false
            },
            "created": "2013-08-23T16:57:35.977+0200",
            "size": 23123,
            "mimeType": "image/jpeg",
            "content": "http://localhost:8080/jira/attachments/10000",
            "thumbnail": "http://localhost:8080/jira/secure/thumbnail/10000"
        }
    ]
    ```

??? note "getIssuePriorities"
    To get the priorities available for issues, use `getIssuePriorities`. This operation returns detailed information about each priority, including its name, ID, and more.

    **Sample configuration**
    
    ```xml
    <jira.getIssuePriorities/>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getIssuePriorities` operation.
    
    ```json
    {
    "username":"admin",
    "password":"jira@jaffna",
    "uri":"http://localhost:8080"
    }
    ```

    **Sample response**

    Given below is a sample response for the getIssuePriorities operation.
    
    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2/priority/3",
            "statusColor": "#009900",
            "description": "Major loss of function.",
            "iconUrl": "http://localhost:8080/jira/images/icons/priorities/major.png",
            "name": "Major"
        }
    ]
    ```

??? note "getIssuePriorityById"
    To get information on a specific priority, use `getIssuePriorityById` and specify the priority ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issuePriorityId</td>
            <td>Identifies the priority for retrieving information.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getIssuePriorityById>
        <issuePriorityId>{$ctx:issuePriorityId}</issuePriorityId>
    </jira.getIssuePriorityById>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getIssuePriorityById` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issuePriorityId":"3"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getIssuePriorityById` operation.
    
    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/priority/3",
        "statusColor": "#009900",
        "description": "Major loss of function.",
        "iconUrl": "http://localhost:8080/jira/images/icons/priorities/major.png",
        "name": "Major"
    }
    ```

??? note "getIssueTypes"
    To get the types of issues available in this Jira instance, use `getIssueTypes`. This operation returns detailed information about each issue type, including its name, ID, and more.

    **Sample configuration**
    
    ```xml
    <jira.getIssueTypes/>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getIssueTypes` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getIssueTypes` operation.
    
    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2.0/issueType/3",
            "id": "3",
            "description": "A task that needs to be done.",
            "iconUrl": "http://localhost:8080/jira/images/icons/issuetypes/task.png",
            "name": "Task",
            "subtask": false
        }
    ]
    ```

??? note "getIssueTypeById"
    To get information on a specific issue type, use `getIssueTypeById` with the type ID.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueTypeId</td>
            <td>Identifies the issue type to filter the issues that you want to get.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getIssueTypeById>
        <issueTypeId>{$ctx:issueTypeId}</issueTypeId>
    </jira.getIssueTypeById>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getIssueTypeById` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueTypeId":"3"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getIssueTypeById` operation.
    
    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2.0/issueType/3",
        "id": "3",
        "description": "A task that needs to be done.",
        "iconUrl": "http://localhost:8080/jira/images/icons/issuetypes/task.png",
        "name": "Task",
        "subtask": false
    }
    ```

??? note "getVotesForIssue"
    To get the votes for a specific issue, use `getVotesForIssue` with the issue ID. This operation returns a JSON representation of the vote information including the number of votes and more.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>Identifies the issue with the votes that you want to get. This can be an issue ID or an issue key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getVotesForIssue>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
    </jira.getVotesForIssue>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getVotesForIssue` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "issueIdOrKey":"TEST-1"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getVotesForIssue` operation.
    
    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/issue/TEST-1/votes",
        "votes": 24,
        "hasVoted": true,
        "voters": [
            {
                "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                "name": "fred",
                "avatarUrls": {
                    "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                    "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                    "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                    "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                },
                "displayName": "Fred F. User",
                "active": false
            }
        ]
    }
    ```

??? note "createBulkIssue"
    This operation creates many issues in one bulk operation.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueUpdates</td>
            <td>The array of objects containing the issue details.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.createBulkIssue>
        <issueUpdates>{$ctx:issueUpdates}</issueUpdates>
    </jira.createBulkIssue>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `createBulkIssue` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "issueUpdates": [
            {
                "update": {},
                "fields": {
                    "project": {
                        "id": "10000"
                    },
                    "summary": "something's very wrong",
                    "issuetype": {
                        "id": "10000"
                    }
                }
            }
        ]
    }
    ```

    **Sample response**

    Given below is a sample response for the createBulkIssue operation.
    
    ```json
    {
        "issues": [
            {
                "id": "10000",
                "key": "TST-24",
                "self": "http://localhost:8080/jira/rest/api/2/issue/10000"
            },
            {..}
        ],
        "errors": []
    }
    ```

??? note "assignIssueToUser"
    This operation assigns an issue to a user.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>A string containing an issue key.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>name</td>
            <td>The name of the assignee.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.assignIssueToUser>
        <name>{$ctx:name}</name>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
    </jira.assignIssueToUser>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `assignIssueToUser` operation.
    
    ```json
    {
        "uri": "https://connector.atlassian.net",
        "username": "admin",
        "password": "1qaz2wsx@",
        "name": "vrajenthiran",
        "issueIdOrKey": "WSO2CON-4"
    }
    ```

    **Sample response**

    Returned 204 if the issue is successfully assigned.

??? note "getCommentById"
    This operation retrieves all comments for an issue.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>commentId</td>
            <td>The unique identifier of the comment.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand. The optional 'renderedBody' flag provides the body rendered in HTML.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>A string containing the issue ID or key to which the comment belongs.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getCommentById>
        <commentId>{$ctx:commentId}</commentId>
        <expand>{$ctx:expand}</expand>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
    </jira.getCommentById>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getCommentById` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "commentId" : "10000",
        "issueIdOrKey":"TESTPM1-3"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getCommentById` operation.

    ```json
    {
        "startAt": 0,
        "maxResults": 1,
        "total": 1,
        "comments": [
            {
                "self": "http://localhost:8080/jira/rest/api/2/issue/10010/comment/10000",
                "id": "10000",
                "author": {
                    "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                    "name": "fred",
                    "displayName": "Fred F. User",
                    "active": false
                },
                "body": "Testing.",
                "updateAuthor": {
                    "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                    "name": "fred",
                    "displayName": "Fred F. User",
                    "active": false
                },
                "created": "2013-08-23T16:57:35.982+0200",
                "updated": "2013-08-23T16:57:35.983+0200",
                "visibility": {
                    "type": "role",
                    "value": "Administrators"
                }
            }
        ]
    }
    ```

??? note "sendNotification"

    This operation sends a notification (email) to the list or recipients defined in the request.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>subject</td>
            <td>The subject of the notification.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueIdOrKey</td>
            <td>A string containing the issue ID or key to which the comment will be added.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>textBody</td>
            <td>The text body of the notification.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>htmlBody</td>
            <td>The HTML body of the notification.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>toReporter</td>
            <td>The boolean flag to indicate whether to notify the reporter.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>toAssignee</td>
            <td>The boolean flag to indicate whether to notify the assignee.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>toWatchers</td>
            <td>The boolean flag to indicate whether to notify the watchers.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>toVoters</td>
            <td>The boolean flag to indicate whether to notify the voters.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>toUsers</td>
            <td>The boolean flag to indicate whether to notify the users.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>toGroups</td>
            <td>The array of notification groups to be notified.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>restrictGroups</td>
            <td>The Array of notification groups to be restricted.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>restrictPermissions</td>
            <td>The array of restricted permissions for the notification.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.sendNotification>
        <subject>{$ctx:subject}</subject>
        <issueIdOrKey>{$ctx:issueIdOrKey}</issueIdOrKey>
        <textBody>{$ctx:textBody}</textBody>
        <htmlBody>{$ctx:htmlBody}</htmlBody>
        <toReporter>{$ctx:toReporter}</toReporter>
        <toAssignee>{$ctx:toAssignee}</toAssignee>
        <toWatchers>{$ctx:toWatchers}</toWatchers>
        <toVoters>{$ctx:toVoters}</toVoters>
        <toUsers>{$ctx:toUsers}</toUsers>
        <toGroups>{$ctx:toGroups}</toGroups>
        <restrictGroups>{$ctx:restrictGroups}</restrictGroups>
        <restrictPermissions>{$ctx:restrictPermissions}</restrictPermissions>
    </jira.sendNotification>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `sendNotification` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "issueIdOrKey" : "TESTPM1-3",
        "subject" : "notification subject",
        "textBody":"The text body",
        "htmlBody":"Lorem ipsum <strong>dolor</strong> sit amet, consectetur adipiscing elit. Pellentesque eget",
        "toReporter":"false",
        "toAssignee":"false",
        "toWatchers":"true",
        "toVoters":"true",
        "toUsers":[
                {
                    "name": "vrajenthiran",
                    "active": false
                }
            ],
        "toGroups":[
                {
                    "name": "notification-group",
                    "self": "http://localhost:8080/jira/rest/api/2/group?groupname=notification-group"
                }
            ],
        "restrictPermissions":[
                {
                    "id": "10",
                    "key": "BROWSE"
                }
            ], "restrictGroups": [
                {
                    "name": "notification-group",
                    "self": "http://localhost:8080/jira/rest/api/2/group?groupname=notification-group"
                }
            ]
    }
    ```

    **Sample response**

    Returned 204 if adding to the mail queue was successful.

??? note "addVotesForIssue"

    This operation casts your vote in favour of an issue.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueId</td>
            <td>The ID of the issues to which you are casting the votes.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.addVotesForIssue>
        <issueId>{$ctx:issueId}</issueId>
    </jira.addVotesForIssue>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `addVotesForIssue` operation.
    
    ```json
    {
    "uri": "https://testappmahesh.atlassian.net",
    "username": "testapp.mahesh2",
    "password": "1qaz2wsx@",
    "issueId":"TP-1"
    }
    ```

    **Sample response**

    Returned 204 if adding to the mail queue was successful.


??? note "getWatchersForIssue"

    This operation retrieves the list of watchers for the issue with the given key.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>issueId</td>
            <td>The string containing an issue key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getWatchersForIssue>
        <issueId>{$ctx:issueId}</issueId>
    </jira.getWatchersForIssue>
    ```
    
    **Sample request**

    Following is a sample request that can be handled by the `getWatchersForIssue` operation.
    
    ```json
    {
        "uri":"http://localhost:8080",
        "username":"admin",
        "password":"1qaz2wsx@",
        "issueId":"EX-1"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getWatchersForIssue` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/issue/EX-1/watchers",
        "isWatching": false,
        "watchCount": 1,
        "watchers": [
            {
                "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                "name": "fred",
                "avatarUrls": {
                    "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                    "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                    "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                    "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                },
                "displayName": "Fred F. User",
                "active": false
            }
        ]
    }
    ```

??? note "removeUserFromWatcherList"

    This operation removes a user from an issue's watcher list.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>name</td>
            <td>String containing the name of the user to remove.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueId</td>
            <td>String containing an issue key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.removeUserFromWatcherList>
        <name>{$ctx:name}</name>
        <issueId>{$ctx:issueId}</issueId>
    </jira.removeUserFromWatcherList>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `removeUserFromWatcherList` operation.
    
    ```json
    {
        "uri":"https://connector.atlassian.net",
        "username":"admin",
        "password":"1qaz2wsx@",
        "issueId":"TESTPM1-3",
        "name" : "rasika"
    }
    ```

    **Sample response**

    Returned 204 if the watcher was removed successfully.

??? note "getProject"

    To get information about a specific project, use `getProject` with the project key. This operation returns a JSON representation of the entire project, including name, ID, components, and more.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The Identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>The parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
        <expand>{$ctx:expand}</expand>
    </jira.getProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"EX"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getProject` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/project/EX",
        "id": "10000",
        "key": "EX",
        "description": "This project was created as an example for REST.",
        "lead": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        },
        "components": [
            {
                "self": "http://localhost:8080/jira/rest/api/2/component/10000",
                "id": "10000",
                "name": "Component 1",
                "description": "This is a JIRA component",
                "lead": {
                    "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                    "name": "fred",
                    "avatarUrls": {
                        "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                        "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                        "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                        "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                    },
                    "displayName": "Fred F. User",
                    "active": false
                },
                "assigneeType": "PROJECT_LEAD",
                "assignee": {
                    "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                    "name": "fred",
                    "avatarUrls": {
                        "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                        "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                        "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                        "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                    },
                    "displayName": "Fred F. User",
                    "active": false
                },
                "realAssigneeType": "PROJECT_LEAD",
                "realAssignee": {
                    "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                    "name": "fred",
                    "avatarUrls": {
                        "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                        "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                        "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                        "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                    },
                    "displayName": "Fred F. User",
                    "active": false
                },
                "isAssigneeTypeValid": false
            }
        ],
    ..
    }
    ```

??? note "getAvatarsForProject"

    To get the avatars available for a specific project, use `getAvatarsForProject` with the project key. This operation returns a JSON representation of the avatars, including their name, ID, and whether the avatar is currently selected for the project.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getAvatarsForProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
    </jira.getAvatarsForProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getAvatarsForProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getAvatarsForProject` operation.

    ```json
    {
        "system": [
            {
                "id": "1000",
                "owner": "fred",
                "isSystemAvatar": true,
                "isSelected": true,
                "selected": true
            }
        ],
        "custom": [
            {
                "id": "1010",
                "owner": "andrew",
                "isSystemAvatar": false,
                "isSelected": false,
                "selected": false
            }
        ]
    }
    ```

??? note "deleteAvatarForProject"

    To delete an avatar from a project, use `deleteAvatarForProject` with the project key and avatar ID.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>avatarId</td>
            <td>Identifies the avatar to delete.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.deleteAvatarForProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
        <avatarId>{$ctx:avatarId}</avatarId>
    </jira.deleteAvatarForProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `deleteAvatarForProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST",
        "avatarId":"10412"
    }
    ```

    **Sample response**

    204 will returned if the avatar is successfully deleted.

??? note "getComponentsOfProject"

    To get the components of a specific project, use `getComponentsOfProject` with the project key. This operation returns a JSON representation of the components, including their name, ID, and avatars.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getComponentsOfProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
    </jira.getComponentsOfProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getComponentsOfProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getComponentsOfProject` operation.

    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2/component/10000",
            "id": "10000",
            "name": "Component 1",
            "description": "This is a JIRA component",
            "lead": {
                "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                "name": "fred",
                "avatarUrls": {
                    "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                    "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                    "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                    "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                },
                "displayName": "Fred F. User",
                "active": false
            },
            "assigneeType": "PROJECT_LEAD",
            "assignee": {
                "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                "name": "fred",
                "avatarUrls": {
                    "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                    "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                    "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                    "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                },
                "displayName": "Fred F. User",
                "active": false
            },
            "realAssigneeType": "PROJECT_LEAD",
            "realAssignee": {
                "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
                "name": "fred",
                "avatarUrls": {
                    "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                    "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                    "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                    "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
                },
                "displayName": "Fred F. User",
                "active": false
            },
            "isAssigneeTypeValid": false
        },
    ...
    ]
    ```

??? note "getStatusesOfProject"

    To get the statuses of a specific project, use `getStatusesOfProject` with the project key. This operation returns a JSON representation of each issue type in the project along with the status values.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getStatusesOfProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
    </jira.getStatusesOfProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getStatusesOfProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getStatusesOfProject` operation.

    ```json
    [
        {
            "self": "http://localhost:8090/jira/rest/api/2.0/issueType/3",
            "id": "3",
            "name": "Task",
            "subtask": false,
            "statuses": [
                {
                    "self": "http://localhost:8090/jira/rest/api/2.0/status/10000",
                    "description": "The issue is currently being worked on.",
                    "iconUrl": "http://localhost:8090/jira/images/icons/progress.gif",
                    "name": "In Progress",
                    "id": "10000"
                },
                {
                    "self": "http://localhost:8090/jira/rest/api/2.0/status/5",
                    "description": "The issue is closed.",
                    "iconUrl": "http://localhost:8090/jira/images/icons/closed.gif",
                    "name": "Closed",
                    "id": "5"
                }
            ]
        }
    ]
    ```

??? note "getVersionsOfProject"

    To get the versions of a specific project, use `getVersionsOfProject` with the project key. This operation returns a JSON representation of the list of versions in the project.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getVersionsOfProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
    </jira.getVersionsOfProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getVersionsOfProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getVersionsOfProject` operation.

    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2/version/10000",
            "id": "10000",
            "description": "An excellent version",
            "name": "New Version 1",
            "archived": false,
            "released": true,
            "releaseDate": "2010-07-06",
            "overdue": true,
            "userReleaseDate": "6/Jul/2010",
            "projectId": 10000
        },
        {
            "self": "http://localhost:8080/jira/rest/api/2/version/10010",
            "id": "10010",
            "description": "Minor Bugfix version",
            "name": "Next Version",
            "archived": false,
            "released": false,
            "overdue": false,
            "projectId": 10000
        }
    ]
    ```

??? note "getRolesOfProject"

    To get the roles of a specific project, use `getRolesOfProject` with the project key. This operation returns a JSON representation of the list of roles in the project, including each role's name and a link to more details.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The Identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getRolesOfProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
    </jira.getRolesOfProject>
    ```
    
    **Sample request**

    Following is a sample request that can be handled by the `getRolesOfProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getRolesOfProject` operation.

    ```json
    {
        "Users": "http://localhost:8080/jira/rest/api/2/project/MKY/role/10001",
        "Administrators": "http://localhost:8080/jira/rest/api/2/project/MKY/role/10002",
        "Developers": "http://localhost:8080/jira/rest/api/2/project/MKY/role/10000"
    }
    ```

??? note "getRolesByIdOfProject"

    To get information about a specific role, use `getRolesByIdOfProject` with the project key and role ID. This operation returns a JSON representation of the role, including its name, ID, actors, and more.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The identifier of the project that you want to get.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>roleId</td>
            <td>Identifies the role for which you want to get information.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getRolesByIdOfProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
        <roleId>{$ctx:roleId}</roleId>
    </jira.getRolesByIdOfProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getRolesByIdOfProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST",
        "roleId":"10360"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getRolesByIdOfProject` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/project/MKY/role/10360",
        "name": "Developers",
        "id": 10360,
        "description": "A project role that represents developers in a project",
        "actors": [
            {
                "id": 10240,
                "displayName": "jira-developers",
                "type": "atlassian-group-role-actor",
                "name": "jira-developers"
            }
        ]
    }
    ```

??? note "getUserAssignableProjects"

    To get a list of users (that match the search string) that can be assigned to all projects, use `getUserAssignableProjects`.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectKeys</td>
            <td>The comma-separated list of projects for which you are searching for assinees.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>usernameForSearch</td>
            <td>The username for search.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of users to return.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>startAt</td>
            <td>The index of the first user to return.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getUserAssignableProjects>
        <projectKeys>{$ctx:projectKeys}</projectKeys>
        <usernameForSearch>{$ctx:usernameForSearch}</usernameForSearch>
        <maxResults>{$ctx:maxResults}</maxResults>
        <startAt>{$ctx:startAt}</startAt>
    </jira.getUserAssignableProjects>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `getUserAssignableProjects` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectKeys":"TEST",
        "usernameForSearch":"fred"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getUserAssignableProjects` operation.

    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        }
        ..
    ]
    ```

??? note "setActorsToRoleOfProject"

    To assign one or more users to a specific role in a project, use `setActorsToRoleOfProject` with the project key and role ID. You need to specify the users in the payload. You can specify individual users or groups.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectIdOrKey</td>
            <td>The identifier of the project to which users should be asssigned.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>roleId</td>
            <td>Identifies the user role to which users should be assigned.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>roles</td>
            <td>The users who you want to assign.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.setActorsToRoleOfProject>
        <projectIdOrKey>{$ctx:projectIdOrKey}</projectIdOrKey>
        <roleId>{$ctx:roleId}</roleId>
        <roles>{$ctx:roles}</roles>
    </jira.setActorsToRoleOfProject>
    ```
    
    **Sample request**

    The following is a sample request that can be handled by the `setActorsToRoleOfProject` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectIdOrKey":"TEST",
        "projectKey":"JAF",
        "roleId":"10360",
        "roles":{"user" :["James"]}
    }
    ```

    **Sample response**

    Given below is a sample response for the `setActorsToRoleOfProject` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/project/MKY/role/10360",
        "name": "Developers",
        "id": 10360,
        "description": "A project role that represents developers in a project",
        "actors": [
            ...
        ]
    }
    ```

??? note "searchJira"

    To get an existing issue, use `searchJira` with the JQL query.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>query</td>
            <td>The JQL expression to use for finding issues. The query must include an ORDER BY clause. For more information, see the Jira documentation.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of issues to return, up to 1000 (default is 50).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>startAt</td>
            <td>The 0-based index of the first issue to return (default is 0).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>fields</td>
            <td>Specifies a comma-separated list of fields to be included in the response.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>validateQuery</td>
            <td>Specify whether to validate the JQL query.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>expand</td>
            <td>A comma-separated list of parameters to expand.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.C>
        <query>{$ctx:query}</query>
        <maxResults>{$ctx:maxResults}</maxResults>
        <startAt>{$ctx:startAt}</startAt>
        <fields>{$ctx:fields}</fields>
        <validateQuery>{$ctx:validateQuery}</validateQuery>
        <expand>{$ctx:expand}</expand>
    </jira.searchJira>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `searchJira` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "query":"text~\"issue2\""
    }
    ```

    **Sample response**

    Given below is a sample response for the `searchJira` operation.

    ```json
    {
        "expand": "names,schema",
        "startAt": 0,
        "maxResults": 50,
        "total": 1,
        "issues": [
            {
                "expand": "",
                "id": "10001",
                "self": "http://localhost:8080/jira/rest/api/2/issue/10001",
                "key": "HSP-1"
            }
        ]
    }
    ```

??? note "getUser"

    To get information about a specified user, use `getUser` and specify the username.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>usernameFilter</td>
            <td>Identifies the user whose information you want to get.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>key</td>
            <td>The user key.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getUser>
        <usernameFilter>{$ctx:usernameFilter}</usernameFilter>
        <key>{$ctx:key}</key>
    </jira.getUser>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getUser` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "usernameFilter":"fred"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getUser` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
        "name": "fred",
        "emailAddress": "fred@example.com",
        "avatarUrls": {
            "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
            "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
            "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
            "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
        },
        "displayName": "Fred F. User",
        "active": true,
        "timeZone": "Australia/Sydney",
        "groups": {
            "size": 3,
            "items": []
        }
    }
    ```

??? note "getUserPermissions"

    To get information on the current user's permissions, use `getUserPermissions`. You can optionally provide a specific context for which you want to get permissions (projectKey, projectId, issueKey, or issueId).

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>projectKey/projectId</td>
            <td>Identifies the project for which you want to determine the current user's permissions.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueKey/issueId</td>
            <td>Identifies the issue for which you want to determine the current user's permissions.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getUserPermissions>
        <projectKey>{$ctx:projectKey}</projectKey>
        <projectId>{$ctx:projectId}</projectId>
        <issueKey>{$ctx:issueKey}</issueKey>
        <issueId>{$ctx:issueId}</issueId>
    </jira.getUserPermissions>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getUserPermissions` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getUserPermissions` operation.

    ```json
    {
        "permissions": {
            "EDIT_ISSUE": {
                "id": "12",
                "key": "EDIT_ISSUE",
                "name": "Edit Issues",
                "description": "Ability to edit issues.",
                "havePermission": true
            }
        }
    }
    ```

??? note "searchUser"

    To search for users whose username, name, or email address match a search string, use `searchUser` with a search string.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>usernameForSearch</td>
            <td>The search string used to search the username, name, or email address.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>startAt</td>
            <td>The 0-based index of the first user to return (default is 0).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of users to return, up to 1000 (default is 50).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>includeActive</td>
            <td>Whether to return active users (default is true).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>includeInactive</td>
            <td>Whether to return inactive users (default is false).</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.searchUser>
        <usernameForSearch>{$ctx:usernameForSearch}</usernameForSearch>
        <startAt>{$ctx:startAt}</startAt>
        <maxResults>{$ctx:maxResults}</maxResults>
        <includeActive>{$ctx:includeActive}</includeActive>
        <includeInactive>{$ctx:includeInactive}</includeInactive>
    </jira.searchUser>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `searchUser` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "usernameForSearch":"fred"
    }
    ```

    **Sample response**

    Given below is a sample response for the `searchUser` operation.

    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        }
    ]
    ```

??? note "searchIssueViewableUsers"

    To search for users whose username, name, or email address match a search string and have permission to view the specified issue or project, use `searchIssueViewableUsers`. You need to specify the search string and issue key or project key.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>username</td>
            <td>The search string used to search the username, name, or email address.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueKey</td>
            <td>Identifies the issue that users must have permission to view. This issue will be included in the results.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>projectKey</td>
            <td>If you want to search for users who can browse a project instead of a specific issue, specify projectKey instead of issueKey.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>startAt</td>
            <td>The 0-based index of the first user to return (default is 0).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of users to return, up to 1000 (default is 50).</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.searchIssueViewableUsers>
        <usernameForSearch>{$ctx:usernameForSearch}</usernameForSearch>
        <issueKey>{$ctx:issueKey}</issueKey>
        <projectKey>{$ctx:projectKey}</projectKey>
        <startAt>{$ctx:startAt}</startAt>
        <maxResults>{$ctx:maxResults}</maxResults>
    </jira.searchIssueViewableUsers>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the searchIssueViewableUsers operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "usernameForSearch":"fred",
        "projectKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `searchIssueViewableUsers` operation.

    ```json
    [
        {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
                "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        }
    ]
    ```

??? note "searchAssignableUser"

    To search for users whose username, name, or email address match a search string and can be assigned to a specific issue, use `searchAssignableUser`. You specify the search string and either the project key (if you are getting users for a new issue you are creating) or the issue key (if you are getting users for an existing issue you are editing).

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>usernameForSearch</td>
            <td>The search string used to search the username, name, or email address.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueKey</td>
            <td>Identifies the issue that users must have permission to view. This issue will be included in the results.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>project</td>
            <td>Identifies the project in which you are creating a new issue and want to get a list of users who can be assigned to it.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>issueKey</td>
            <td>Identifies the issue you are editing so that you can get a list of users who can be assigned to it.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>startAt</td>
            <td>The 0-based index of the first user to return (default is 0).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>maxResults</td>
            <td>The maximum number of users to return, up to 1000 (default is 50).</td>
            <td>Optional</td>
        </tr>
        <tr>
            <td>actionDescriptorId</td>
            <td>The id of the workflow action.</td>
            <td>Optional</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.searchAssignableUser>
        <usernameForSearch>{$ctx:usernameForSearch}</usernameForSearch>
        <project>{$ctx:project}</project>
        <issueKey>{$ctx:issueKey}</issueKey>
        <startAt>{$ctx:startAt}</startAt>
        <maxResults>{$ctx:maxResults}</maxResults>
        <actionDescriptorId>{$ctx:actionDescriptorId}</actionDescriptorId>
    </jira.searchAssignableUser>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `searchAssignableUser` operation.
    
    ```json
    {
        "username":"admin",
        "password":"jira@jaffna",
        "uri":"http://localhost:8080",
        "projectKey":"TEST"
    }
    ```

    **Sample response**

    Given below is a sample response for the `searchAssignableUser` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
        "name": "fred",
        "emailAddress": "fred@example.com",
        "avatarUrls": {
            "24x24": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
            "16x16": "http://localhost:8080/jira/secure/useravatar?size=xsmall&ownerId=fred",
            "32x32": "http://localhost:8080/jira/secure/useravatar?size=medium&ownerId=fred",
            "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
        },
        "displayName": "Fred F. User",
        "active": true,
        "timeZone": "Australia/Sydney",
        "groups": {
            "size": 3,
            "items": []
        }
    }
    ```

??? note "getAttachmentById"

    This operation retrieves the metadata for an attachment, including the URL of the actual attached file.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>attachmentId</td>
            <td>The ID to view the meta data of the attachment.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getAttachmentById>
        <attachmentId>{$ctx:attachmentId}</attachmentId>
    </jira.getAttachmentById>
    ```
    
    **Sample request**

    Following is a sample REST/JSON request that can be handled by the `getAttachmentById` operation.
    
    ```json
    {
    "uri": "http://localhost:8080",
    "username": "admin",
    "password": "1qaz2wsx@",
    "attachmentId": "10000"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getAttachmentById` operation.

    ```json
    {
        "self": "http://localhost:8080/rest/api/2/attachment/10000",
        "filename": "31714367_1982813478396639_3541297709187072000_n.jpg",
        "author": {
            "self": "http://localhost:8080/rest/api/2/user?username=admin",
            "key": "admin",
            "name": "admin",
            "avatarUrls": {
                "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
            },
            "displayName": "admin@gmail.com",
            "active": true
        },
        "created": "2018-12-09T22:59:08.690+0530",
        "size": 45364,
        "mimeType": "image/jpeg",
        "properties": {},
        "content": "http://localhost:8080/secure/attachment/10000/31714367_1982813478396639_3541297709187072000_n.jpg",
        "thumbnail": "http://localhost:8080/secure/thumbnail/10000/_thumb_10000.png"
    }
    ```

??? note "getAttachmentContent"

    This operation retrieves the content of an attachment.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>attachmentUrl</td>
            <td>The URI of the attached file.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>fileType</td>
            <td>Type of the attachment.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getAttachmentContent>
        <attachmentUrl>{$ctx:attachmentUrl}</attachmentUrl>
        <fileType>{$ctx:fileType}</fileType>
    </jira.getAttachmentContent>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the getAttachmentContent operation.
    
    ```json
    {
    "uri": "http://localhost:8080",
    "username": "admin",
    "password": "1qaz2wsx@",
    "attachmentUrl": "http://localhost:8080/secure/attachment/10000/31714367_1982813478396639_3541297709187072000_n.jpg",
    "fileType":"image/jpg"
    }
    ```

    **Sample response**

    You will get 200 response code with the attached image as a response.


??? note "createComponent"

    The `createComponent` operation creates a component.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>name</td>
            <td>The name of the component.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>project</td>
            <td>The key of the project to which the component should be belong.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>description</td>
            <td>The description for the component.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>leadUserName</td>
            <td>The key of the lead user name.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>assigneeType</td>
            <td>The type of the assignee.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isAssigneeTypeValid</td>
            <td>A boolean, which specifies whether or not the assignee type is valid.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.createComponent>
        <name>{$ctx:name}</name>
        <project>{$ctx:project}</project>
        <description>{$ctx:description}</description>
        <leadUserName>{$ctx:leadUserName}</leadUserName>
        <assigneeType>{$ctx:assigneeType}</assigneeType>
        <isAssigneeTypeValid>{$ctx:isAssigneeTypeValid}</isAssigneeTypeValid>
    </jira.createComponent>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `createComponent` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "name": "testing component1",
        "project": "TESTPM1",
        "description": "test description",
        "leadUserName": "admin",
        "assigneeType": "PROJECT_LEAD",
        "isAssigneeTypeValid": "false"
    }
    ```

    **Sample response**

    Given below is a sample response for the `createComponent` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/component/10000",
        "id": "10000",
        "name": "Component 1",
        "description": "This is a JIRA component",
        "lead": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        },
        "assigneeType": "PROJECT_LEAD",
        "assignee": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        },
        "realAssigneeType": "PROJECT_LEAD",
        "realAssignee": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        },
        "isAssigneeTypeValid": false
    }
    ```

??? note "getComponent"

    The `getComponent` operation retrieves a project component.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>componentId</td>
            <td>The unique identifier for a particular component.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getComponent>
        <componentId>{$ctx:componentId}</componentId>
    </jira.getComponent>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getComponent` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "componentId": "10000"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getComponent` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/component/10000",
        "id": "10000",
        "name": "Component 1",
        "description": "This is a JIRA component",
        "lead": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        },
        "assigneeType": "PROJECT_LEAD",
        "assignee": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        },
        "realAssigneeType": "PROJECT_LEAD",
        "realAssignee": {
            "self": "http://localhost:8080/jira/rest/api/2/user?username=fred",
            "name": "fred",
            "avatarUrls": {
                "16x16": "http://localhost:8080/jira/secure/useravatar?size=small&ownerId=fred",
                "48x48": "http://localhost:8080/jira/secure/useravatar?size=large&ownerId=fred"
            },
            "displayName": "Fred F. User",
            "active": false
        },
        "isAssigneeTypeValid": false
    }
    ```

??? note "updateComponent"

    The `updateComponent` operation modifies a component.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>componentId</td>
            <td>The unique identifier for a particular component.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>name</td>
            <td>The name of the component.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>description</td>
            <td>The description for the component.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>leadUserName</td>
            <td>The key of the lead username.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>assigneeType</td>
            <td>The type of the assignee.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>isAssigneeTypeValid</td>
            <td>A boolean, which specifies whether or not the assignee type is valid.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.updateComponent>
        <componentId>{$ctx:componentId}</componentId>
        <name>{$ctx:name}</name>
        <description>{$ctx:description}</description>
        <leadUserName>{$ctx:leadUserName}</leadUserName>
        <assigneeType>{$ctx:assigneeType}</assigneeType>
        <isAssigneeTypeValid>{$ctx:isAssigneeTypeValid}</isAssigneeTypeValid>
    </jira.updateComponent>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `updateComponent` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "componentId": "10000",
        "name": "testing component1",
        "description": "test description",
        "leadUserName": "admin",
        "assigneeType": "PROJECT_LEAD",
        "isAssigneeTypeValid": "false"
    }
    ```

    **Sample response**

    Given below is a sample response for the `updateComponent` operation.

    ```json
    {
        "self": "http://localhost:8080/rest/api/2/component/10000",
        "id": "10000",
        "name": "testing component1",
        "description": "test description",
        "lead": {
            "self": "http://localhost:8080/rest/api/2/user?username=admin",
            "key": "admin",
            "name": "admin",
            "avatarUrls": {
                "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
            },
            "displayName": "admin@gmail.com",
            "active": true
        },
        "assigneeType": "PROJECT_LEAD",
        "assignee": {
            "self": "http://localhost:8080/rest/api/2/user?username=admin",
            "key": "admin",
            "name": "admin",
            "avatarUrls": {
                "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
            },
            "displayName": "admin@gmail.com",
            "active": true
        },
        "realAssigneeType": "PROJECT_LEAD",
        "realAssignee": {
            "self": "http://localhost:8080/rest/api/2/user?username=admin",
            "key": "admin",
            "name": "admin",
            "avatarUrls": {
                "48x48": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=48",
                "24x24": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=24",
                "16x16": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=16",
                "32x32": "https://www.gravatar.com/avatar/9f2ee74106e4d9afc58bb796a0895908?d=mm&s=32"
            },
            "displayName": "admin@gmail.com",
            "active": true
        },
        "isAssigneeTypeValid": true,
        "project": "KANA",
        "projectId": 10000
    }
    ```

??? note "countComponentRelatedIssues"

    The `countComponentRelatedIssues` operation retrieves counts of issues related to this component.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>componentId</td>
            <td>The unique identifier for a particular component.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.countComponentRelatedIssues>
        <componentId>{$ctx:componentId}</componentId>
    </jira.countComponentRelatedIssues>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `countComponentRelatedIssues` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "componentId": "10000"
    }
    ```

    **Sample response**

    Given below is a sample response for the `searchIssueViewableUsers` operation.

    ```json
    {
        "self": "http://localhost:8080/jira/rest/api/2/component/10000",
        "issueCount": 23
    }      
    ```

??? note "createIssueLink"

    The `createIssueLink` operation creates an issue link between two issues.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>typeName</td>
            <td>Name of the issue type.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>inwardIssueKey</td>
            <td>Key of the inward issue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>outwardIssueKey</td>
            <td>Key of the outward issue.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>commentBody</td>
            <td>Body of the comment.</td>
            <td>Yes</td>
        </tr>
        <tr>
            <td>commentVisibility</td>
            <td>Visibility of the comment.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.createIssueLink>
        <typeName>{$ctx:typeName}</typeName>
        <inwardIssueKey>{$ctx:inwardIssueKey}</inwardIssueKey>
        <outwardIssueKey>{$ctx:outwardIssueKey}</outwardIssueKey>
        <commentBody>{$ctx:commentBody}</commentBody>
        <commentVisibility>{$ctx:commentVisibility}</commentVisibility>
    </jira.createIssueLink>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `createIssueLink` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "typeName": "Duplicate",
        "inwardIssueKey": "TESTPM1-1",
        "outwardIssueKey": "TESTPM1-2",
        "commentBody": "Linked related issue!",
        "commentVisibility": {
            "type": "group",
            "value": "jira-users"
        }
    }
    ```

    **Sample response**

    As a successful response, you will get 201 status code without any response body.

??? note "getIssueLinkById"

    The `getIssueLinkById` operation retrieves an issue link with the specified ID.

    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Description</th>
            <th>Required</th>
        </tr>
        <tr>
            <td>linkId</td>
            <td>The issue link ID.</td>
            <td>Yes</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <jira.getIssueLinkById>
        <linkId>{$ctx:linkId}</linkId>
    </jira.getIssueLinkById>
    ```
    
    **Sample request**

    The following is a sample REST/JSON request that can be handled by the `getIssueLinkById` operation.
    
    ```json
    {
        "uri": "http://localhost:8080",
        "username": "admin",
        "password": "1qaz2wsx@",
        "linkId": "10000"
    }
    ```

    **Sample response**

    Given below is a sample response for the `getIssueLinkById` operation.

    ```json
    {
        "id": "10000",
        "self": "http://localhost:8080/rest/api/2/issueLink/10000",
        "type": {
            "id": "10002",
            "name": "Duplicate",
            "inward": "is duplicated by",
            "outward": "duplicates",
            "self": "http://localhost:8080/rest/api/2/issueLinkType/10002"
        },
        "inwardIssue": {
            "id": "10002",
            "key": "KANA-3",
            "self": "http://localhost:8080/rest/api/2/issue/10002",
            "fields": {
                "summary": "New task",
                "status": {
                    "self": "http://localhost:8080/rest/api/2/status/10000",
                    "description": "",
                    "iconUrl": "http://localhost:8080/",
                    "name": "To Do",
                    "id": "10000",
                    "statusCategory": {
                        "self": "http://localhost:8080/rest/api/2/statuscategory/2",
                        "id": 2,
                        "key": "new",
                        "colorName": "blue-gray",
                        "name": "To Do"
                    }
                },
                "priority": {
                    "self": "http://localhost:8080/rest/api/2/priority/3",
                    "iconUrl": "http://localhost:8080/images/icons/priorities/medium.svg",
                    "name": "Medium",
                    "id": "3"
                },
                "issuetype": {
                    "self": "http://localhost:8080/rest/api/2/issuetype/10003",
                    "id": "10003",
                    "description": "A task that needs to be done.",
                    "iconUrl": "http://localhost:8080/secure/viewavatar?size=xsmall&avatarId=10318&avatarType=issuetype",
                    "name": "Task",
                    "subtask": false,
                    "avatarId": 10318
                }
            }
        },
        "outwardIssue": {
            "id": "10001",
            "key": "KANA-2",
            "self": "http://localhost:8080/rest/api/2/issue/10001",
            "fields": {
                "summary": "Framework IMplementation",
                "status": {
                    "self": "http://localhost:8080/rest/api/2/status/10000",
                    "description": "",
                    "iconUrl": "http://localhost:8080/",
                    "name": "To Do",
                    "id": "10000",
                    "statusCategory": {
                        "self": "http://localhost:8080/rest/api/2/statuscategory/2",
                        "id": 2,
                        "key": "new",
                        "colorName": "blue-gray",
                        "name": "To Do"
                    }
                },
                "priority": {
                    "self": "http://localhost:8080/rest/api/2/priority/3",
                    "iconUrl": "http://localhost:8080/images/icons/priorities/medium.svg",
                    "name": "Medium",
                    "id": "3"
                },
                "issuetype": {
                    "self": "http://localhost:8080/rest/api/2/issuetype/10003",
                    "id": "10003",
                    "description": "A task that needs to be done.",
                    "iconUrl": "http://localhost:8080/secure/viewavatar?size=xsmall&avatarId=10318&avatarType=issuetype",
                    "name": "Task",
                    "subtask": false,
                    "avatarId": 10318
                }
            }
        }
    }
    ```

### Sample configuration in a scenario

The following is a sample proxy service that illustrates how to connect to the Jira connector and use the getDashboardById operation to get dashboard details. You can use this sample as a template for using other operations in this category.

**Sample Proxy**
```xml
<proxy xmlns="http://ws.apache.org/ns/synapse"
       name="getDashboardById"
       transports="https http"
       startOnLoad="true"
       trace="disable">
   <description/>
   <target>
      <inSequence>
         <property name="username" expression="json-eval($.username)"/>
         <property name="password" expression="json-eval($.password)"/>
         <property name="uri" expression="json-eval($.uri)"/>
         <property name="id" expression="json-eval($.id)"/>
         <jira.init>
            <username>{$ctx:username}</username>
            <password>{$ctx:password}</password>
            <uri>{$ctx:uri}</uri>
         </jira.init>
         <jira.getDashboardById>
            <id>{$ctx:id}</id>
         </jira.getDashboardById>
         <log level="full"/>
         <respond/>
      </inSequence>
      <outSequence/>
      <faultSequence/>
   </target>
</proxy>        
```

**Note**: For more information on how this works in an actual scenario, see [Jira Connector Example](jira-connector-example.md).
