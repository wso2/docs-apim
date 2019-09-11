# Categorizing and grouping APIs

API providers add tags to APIs when designing them using the API Publisher. Tags allow API providers to categorize APIs that have similar attributes. When a tagged API gets published to the API Store, its tags appear as clickable links to the API consumers, who can use them to quickly jump to a category of interest. The font size of the tag in the Store varies based on the number of APIs that are assigned to it. Therefore, for example the font size of a tag which has 10 APIs assigned to it will be bigger than the font size of a tag that has only 2 APIs assigned to it.

If you want to see the APIs grouped according to different topics in the API Store, add an API group:

!!! note
Although the way in which you add a Tag and API group appears to be similar there are differences. Therefore, you need to note the following:

-   The **group name should always have** the **suffix `-group`** and it **can have spaces** in it (e.g., APIs groups-group).
-   The **tag name** should **not have a suffix or prefix** , but it **can have spaces** .


1.  Go to `          <API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf         ` directory, open the `          site.json         ` file and set the `          tagWiseMode         ` attribute as true.
2.  Add an API group to the APIs that you wish to group.
    1.  Go to the API Publisher ( `            https://<HostName>:9443/publisher           ` ).
    2.  Click on the edit link of the respective API as shown below.
    3.  Add a group name to the APIs that you wish to group.

        For example add the "APIs groups-group" tag to the Workflow and Integration APIs.

    4.  Save the API for the tag to appear in the Store.

    5.  Repeat steps 2 (a) to (d) to add another APIs to the newly created group.

    Sign in to the API Store and note the API groups.
    If you wish, you can click on a group to see the APIs that belong to a specific group.

