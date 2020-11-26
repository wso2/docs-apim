# Add API Documentation

**API documentation** helps API subscribers to understand the functionality of the API and API publishers to market their APIs better and sustain competition. Using the API Publisher, you can add different types of documentation from various sources. All documents created in the API Publisher have unique URLs to help improve SEO support.

The documentation types supported in the API Publisher are as follows:

-   **In-line**: Hosts documentation (How-tos, Samples, SDK, forums etc.) in WSO2 API Publisher itself and allows it to be edited directly via the UI.
-   **URL**: Links of public or support forums or file references (URLs) of an external configuration management system.
-   **File**: Allows to upload the documentation directly to the server.
-   **Markdown**: Allows to add markdown (`.md`) docs via a Markdown editor.

Follow the instructions below to add documentation to an API:

1.  Sign in to the WSO2 API Publisher.
     
     `https://<hostname>:9443/publisher`

2.  Click on the API (e.g., `PizzaShackAPI 1.0.0` ) for which you want to add the documentation.
    [![Select API in API Publisher]({{base_path}}/assets/img/learn/select-api.png)]({{base_path}}/assets/img/learn/select-api.png)

3. Add the specific documentation.
    
     Follow the steps below for each type.

    -   [Add in-line documentation](#add-in-line-documentation)
    -   [Add documentation using a URL](#add-documentation-using-a-url)
    -   [Add documentation using a file](#add-documentation-using-a-file)
    -   [Add Markdown documentation](#add-markdown-documentation)

    ### Add in-line documentation

    1.  Click **Documents** and click **Add New Document**.
        
         [![Add new documents option]({{base_path}}/assets/img/learn/add-docs-documents.png)]({{base_path}}/assets/img/learn/add-docs-documents.png)

    2.  Enter the following details to create an in-line document.

        |         |                                      |
        |---------|--------------------------------------|
        | Name    | PizzaShack                    |
        | Summary | This is the official documentation for the PizzaShack API |
        | Type    | How To                               |
        | Source  | In-line                              |

        [![Create an inline document]({{base_path}}/assets/img/learn/add-docs-create-inline.png)]({{base_path}}/assets/img/learn/add-docs-create-inline.png)

    3.  Click **Add Document**.

    4.  Click **Add Content** to open an embedded editor.

         [![Add content to inline document]({{base_path}}/assets/img/learn/add-docs-add-content.png)]({{base_path}}/assets/img/learn/add-docs-add-content.png)

        !!! note
            You can edit the content later by clicking **Edit Content**. It will open up the embedded editor to proceed.

        [![Edit content in a API document]({{base_path}}/assets/img/learn/add-docs-edit-content.png)]({{base_path}}/assets/img/learn/add-docs-edit-content.png)

        !!! info
            You can use the **Edit Content** option to update/change the document information.

    5.  Edit the document content in-line using the embedded editor and click **Update Content**.
    
         [![Edit inline document]({{base_path}}/assets/img/learn/add-docs-update-content.png)]({{base_path}}/assets/img/learn/add-docs-update-content.png)
         
         The API's **Documents** tab opens.

    ### Add documentation using a URL

    You can use either **Public Forum**, **Support Forum** or **Other** types to add documentation using a URL.

    #### Add a document using a URL based on a Public Forum/Support Forum

    1.  Click **Add New Document** to add another documenation type.

    2.  Enter the following information to create another doc using a URL of a Public or Support forum.

        <table>
        <tbody>
        <tr class="odd">
        <td>Name</td>
        <td>API Forum</td>
        </tr>
        <tr class="even">
        <td>Summary</td>
        <td><div class="company-logo-container">
        <p>Forum to discuss about APIs</p>
        </div></td>
        </tr>
        <tr class="odd">
        <td>Type</td>
        <td>Public Forum/Support Forum</td>
        </tr>
        <tr class="even">
        <td>Source</td>
        <td>URL<br />
        <a href="http://www.dummyforum.com" class="uri">http://www.dummyforum.com</a></td>
        </tr>
        </tbody>
        </table>

        [![Add forum type URL based API documentation]({{base_path}}/assets/img/learn/add-docs-forum-type.png)]({{base_path}}/assets/img/learn/add-docs-forum-type.png)

    #### Add an other type URL based document

     You can use this if you want to add a document using the **Other** type that points to a link that has a file reference of an external source.

    1.  Enter the following information to create another doc using a URL. 

        <table>
        <tbody>
        <tr class="odd">
        <td>Name</td>
        <td>PizzaShack Wiki</td>
        </tr>
        <tr class="even">
        <td>Summary</td>
        <td><div class="company-logo-container">
        <p>Sample PizzaShack API</p>
        </div></td>
        </tr>
        <tr class="odd">
        <td>Type</td>
        <td>Other</td>
        </tr>
        <tr class="even">
        <td>Other Document Type</td>
        <td>Other (Provide a type as required)</td>
        </tr>
        <tr class="even">
        <td>Source</td>
        <td>URL<br />
        <a href="http://www.dummy.com/PizzaShackAPIDoc.pdf" class="uri">http://www.dummy.com/PizzaShackAPIDoc.pdf</a></td>
        </tr>
        </tbody>
        </table>

        [![Add other type URL based API documentation]({{base_path}}/assets/img/learn/add-docs-url-type.png)]({{base_path}}/assets/img/learn/add-docs-url-type.png)

    4.  Click **Add Document**.
         
         The API's **Documents** tab opens.

    ### Add documentation using a file

    1.  Click **Add New Document** to add yet another document using a file.

    2.  Enter the following information.

        |         |                                                                                                                                                                                                                                                                                                                              |
        |---------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | Name    | API Manager Samples                                                                                                                                                                                                                                                                                                          |
        | Summary | API Manager Samples                                                                                                                                                                                                                                                                                                          |
        | Type    | Samples & SDK                                                                                                                                                                                                                                                                                                                |
        | Source  | You can provide only these file formats.(`.pdf` , `.doc` , `.txt` ) of any size. For example, use the sample PDF file [here]({{base_path}}/assets/attachments/learn/api-docs-sample.pdf). |

        [![Add file based API documentation]({{base_path}}/assets/img/learn/add-docs-pdf-file.png)]({{base_path}}/assets/img/learn/add-docs-pdf-file.png)

    3.  Click **Add Document**.
        
    ### Add Markdown documentation

    1.  Click **Documents** and click **Add New Document**.
        
         [![Add new document option]({{base_path}}/assets/img/learn/add-docs-documents.png)]({{base_path}}/assets/img/learn/add-docs-documents.png)

    2.  Enter the following details to create Markdown documentation and click **Add Document**.

        |         |                                      |
        |---------|--------------------------------------|
        | Name    | PizzaShackAPI Documentation                    |
        | Summary | This is the official documentation for the PizzaShack API |
        | Type    | How To                               |
        | Source  | Markdown                              |

        [![Add Markdown based API documentation]({{base_path}}/assets/img/learn/add-docs-markdown.png)]({{base_path}}/assets/img/learn/add-docs-markdown.png)

    3.  Click **Add Content** to open an embedded editor.
        [![Add content for Markdown documentation]({{base_path}}/assets/img/learn/add-docs-markdown-add-content.png)]({{base_path}}/assets/img/learn/add-docs-markdown-add-content.png)

    4.  Edit the document content using the embedded markdown editor and click **Update Content**.
        
         [![Update content for Markdown documentation]({{base_path}}/assets/img/learn/add-docs-markdown-editor.png)]({{base_path}}/assets/img/learn/add-docs-markdown-editor.png)
         
         The API's **Documents** tab opens.
         
         [![APIs documentation tab with added documentation]({{base_path}}/assets/img/learn/add-docs-markdown-view.png)]({{base_path}}/assets/img/learn/add-docs-markdown-view.png)

     You have now added four type of documents to the API: in-line, URL, file, and markdown.
     
     [![APIs documentation tab with a list of the added documentation]({{base_path}}/assets/img/learn/add-docs-all.png)]({{base_path}}/assets/img/learn/add-docs-all.png)

5.  Sign in to the WSO2 Developer Portal and click on the `PizzaShackAPI` version 1.0.0 API.
    
     `https://<hostname>:9443/devportal         `
    
     [![API in Developer Portal]({{base_path}}/assets/img/learn/view-docs-devportal.png)]({{base_path}}/assets/img/learn/view-docs-devportal.png)

6.  Click **Documentation**.
 
     The documents that you added, which are listed by type, appears.

7. Click the links to view the documentation content. 

     As a subscriber, you can read the documentation and learn about the API.

     [![View API related documentation]({{base_path}}/assets/img/learn/view-docs-api.png)]({{base_path}}/assets/img/learn/view-docs-api.png)

You have created documentation using the API Publisher and viewed the documentation as a subscriber in the Developer Portal.

### Control API Document Visibility in Developer Portal

   By default, any document associated with an API has the same visibility level of the API. That is, if the API is
    public, its documentation is also visible to all users (registered and anonymous).
!!! note
    This feature has been disabled in the default setup.
#### Enabling document visibility in Developer Portal
   To enable other visibility levels to the documentation, go to the  
   `<API-M_HOME>/repository/conf/deployment.toml`, 
   add the following configuration.
   ``` toml
   [apim.publisher]
   enable_api_doc_visibility = "true"
   ```
   Document visibility levels can be one of the following options:
   - **Same as API visibility:** visible to the same user roles who can see the API. For example, if the API's visibility is public, its documentation is visible to all users.
   - **Visible to My Domain:** visible to all registered users in the API's tenant domain.
   - **Publishers Only:** visible only to the users who have permission to log in to the API Publisher web interface and
    create and/or publish APIs to the Developer Portal.
#### Control API document visibility using the API Publisher
1.  Sign in to the API Publisher as an API creator using the following URL: 
     `https://<localhost>:9443/publisher`
2.  [Create a new API]({{base_path}}/learn/design-api/create-api/create-a-rest-api/) or edit an existing API.
3.  In the **Documents** tab, Click **Add New Document**, to see a new drop-down list added to select visibility from.
     [ ![API document visibility selector]({{base_path}}/assets/img/learn/api-doc-visibility-selector.png) ](/{{base_path}}/assets/img/learn/api-doc-visibility-selector.png)
4.  Select the desired visibility level for the document. 
     [ ![API document visibility selector dropdown]({{base_path}}/assets/img/learn/api-doc-visibility-dropdown.png) ](/{{base_path}}/assets/img/learn/api-doc-visibility-dropdown.png)
5.  Add the Document.
