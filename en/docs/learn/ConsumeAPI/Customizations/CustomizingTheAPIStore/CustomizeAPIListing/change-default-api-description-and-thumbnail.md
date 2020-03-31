# Change Default API Description and Thumbnail

If you want to change the descriptions and the thumbnail images that come by default, do the following:

1.  Sign in to the Management Console and click the **Resources &gt; Browse** menu to open the registry.
2.  Create a collection named `tags` under the registry location `/_system/governance/apimgt/applicationdata` .
3.  Give read permission to the `system/wso2.anonymous.role` role.
4.  Add each tag as collections under the tags collection (e.g., Workflow APIs-group, Integration APIs-group, Quote APIs-group.)
5.  Navigate to each tag collection and upload the following:
    -   **description.txt** with the description of the tag
    -   **thumbnail.png** for the thumbnail image
6.  Back in the API Store, note the changes you did in the registry.

