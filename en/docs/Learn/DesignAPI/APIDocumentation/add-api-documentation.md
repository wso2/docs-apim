# Add API Documentation

**API documentation** helps API subscribers understand the functionality of the API, and API publishers to market their APIs better and sustain competition. Using the API Publisher, you can add different types of documentation from different sources. All documents created in the API Publisher have unique URLs to help improve SEO support.

The documentation types supported in the API Publisher are as follows:

-   **In-line** : Hosts documentation (How-tos, Samples, SDK, forums etc.) in WSO2 API Publisher itself and allows it to be edited directly from the UI.
-   **URL** : Links to file references (URLs) of an external configuration management system.
-   **File:** Allows to upload the documentation directly to the server.
-   Using the integrated API Console

!!! tip
Do you want to set different visibility levels to the API documentation than the API? See [API documentation visibility](https://docs.wso2.com/display/AM260/Key+Concepts#KeyConcepts-APIdocumentationvisibility) .


1.  Sign in to the WSO2 API Publisher.
    `          https://<hostname>:9443/publisher         `
2.  Click the API (e.g., `           PhoneVerification 1.0.0          ` ) for which you want to add documentation.
    ![](attachments/103328543/103328553.png)
3.  **Add in-line documentation.**

    1.  Select the **Docs** tab of the API and click **Add New Document** .
        ![](attachments/103328543/103328552.png)
    2.  Enter the following details to create documentation in-line.

        |         |                                      |
        |---------|--------------------------------------|
        | Name    | PhoneVerification                    |
        | Summary | Check the validity of a phone number |
        | Type    | How To                               |
        | Source  | In-line                              |

        ![](attachments/103328543/103328551.png)
    3.  Click **Add Document** .
    4.  Click **Edit Content** to open an embedded editor.

                !!! info
        Update button can be used to update/change the document information.


        ![](attachments/103328543/103328550.png)
    5.  Edit the document content in-line using the embedded editor and click **Save and Close** .
        ![](attachments/103328543/103328549.png)        The API's **Doc** tab opens.

4.  **Add documentation using a URL** .

    1.  Click **Add New Document** to add another doc type.

    2.  Enter the following information to create another doc using a URL.

        <table>
        <tbody>
        <tr class="odd">
        <td>Name</td>
        <td>CDYNE Wiki</td>
        </tr>
        <tr class="even">
        <td>Summary</td>
        <td><div class="company-logo-container">
        <p>CDYNE Phone Notify API</p>
        </div></td>
        </tr>
        <tr class="odd">
        <td>Type</td>
        <td>Other (specify)</td>
        </tr>
        <tr class="even">
        <td>Source</td>
        <td>URL<br />
        <a href="https://cdyne.com/downloads/SPECS_Phone-Notify.pdf" class="uri">https://cdyne.com/downloads/SPECS_Phone-Notify.pdf</a></td>
        </tr>
        </tbody>
        </table>

        ![](attachments/103328543/103328548.png)
    3.  Click **Add Document** .
        The API's **Doc** tab opens.

5.  **Add documentation using a file** .

    1.  Click **Add New Document** to add yet another document using a file.

    2.  Enter the following information.

        |         |                                                                                                                                                                                                                                                                                                                              |
        |---------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
        | Name    | API Manager Samples                                                                                                                                                                                                                                                                                                          |
        | Summary | API Manager Samples                                                                                                                                                                                                                                                                                                          |
        | Type    | Samples & SDK                                                                                                                                                                                                                                                                                                                |
        | Source  | You can provide any file format (common formats are `                 .pdf                ` , `                 .html                ` , `                 .doc                ` , `                 .txt                ` ) of any size. For example, use the sample PDF file [here](attachments/103328543/103328555.pdf) . |

        ![](attachments/103328543/103328547.png)
    3.  Click **Add Document** .
        You have now added three documents to the API: in-line, using a URL, and a file.
        ![](attachments/103328543/103328546.png)
6.  Log in to the WSO2 API Store and click the `          PhoneVerification         ` 1.0.0 API.
    `          https://<hostname>:9443/store         `
    ![](attachments/103328543/103328545.png)7.  Go to the API's **Documentation** tab and see the documents listed by type.
    Click the links to see the documentation content. As a subscriber, you can read the documentation and learn about the API.
    ![](attachments/103328543/103328544.png)
You have created documentation using the API Publisher and viewed them as a subscriber in the API Store.
