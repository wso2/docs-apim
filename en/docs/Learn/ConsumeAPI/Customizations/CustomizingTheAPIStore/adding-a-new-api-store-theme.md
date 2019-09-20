# Adding a New API Store Theme

A **theme** consists of UI elements such as logos, images, copyrights messages, landing page text, background colors etc. WSO2 API Store comes with a default theme. You can extend the existing theme by writing a new one or customising the existing one.

#### Folder structure of the API Store themes

The default theme of the API Store is named `wso2` . You find it inside the `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/themes/wso2` folder. If you do not have access to the file system, download the [default theme from here]/assets/attachments/103334757/103334760.zip) .

The easiest way to create a new theme is to copy the files of an existing theme to a folder that is named after your new theme, and do the modifications you want to the files inside it. All themes have the same folder structure as shown below:

![](/assets/attachments/103334757/103334762.png)

You can add a new theme as a main theme or a sub-theme.

-   **A main theme** is saved inside the `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/themes` directory
-   **A sub theme** is saved inside the `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/themes/<main-theme-directory>/subtheme` directory.

As a sub-theme is saved inside a main theme, it needs to contain only the files that are different from the main theme. Any file that you add inside the sub-theme overrides the corresponding files in the main theme. The rest of the files are inherited from the main theme.

!!! tip
**Tip** : **How to customize a theme**

Themes are located in the `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/themes` folder. There are separate folders for each theme, typically by the name of the theme (e.g., `wso2` ), i nside the `themes` folder . In addition, there are CSS folders, which contain the CSS files of those themes, i nside the individual theme folders . If you need to customize an existing theme, you need to change the corresponding CSS files.


Let's see how to create a new theme and set it to the API Store:

-   [Writing a sub theme of the main theme](#AddingaNewAPIStoreTheme-Writingasubthemeofthemaintheme)
-   [Setting the new theme as the default theme](#AddingaNewAPIStoreTheme-Settingthenewthemeasthedefaulttheme)

### Writing a sub theme of the main theme

As a main theme already has most of the UIs, the syntax, and logic of Jaggery code defined, in a typical scenario, you do not have to implement a theme from scratch. Rather, you just add in your edits as a sub-theme of the existing main theme as given below:

1.  Download the default main theme [from here]/assets/attachments/103334757/103334760.zip) , unzip it, and rename the folder according to the name of your new theme (e.g., ancient). Let's refer to this folder as `<THEME_HOME>                    .         `
2.  Make any changes you want to the theme.
    For example, make the following changes in the CSS styles in the `<THEME_HOME>/css/custom.css` file using a text editor and save.

    -   Add the following code to change the color of the header to red.

        ``` java
                header.header-default{
                    background:red !important;
                }
        ```

    -   Update the color given for the search box to `#0be2e2` .

        ``` java
                    .search-wrap>.form-control, .search-wrap .btn.wrap-input-right  {
                        background-color: #0be2e2;
                        border: 0px;
                        color: #FFF;
                        height: 40px;
                        margin-top:-3px;
                    }
        ```

        !!! note
    The custom.css file related to the sub-theme should always have the entire set of CSS styles. Therefore, do not delete the code related to the CSS styles that you have not changed in the `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/themes/<main-theme-directory>/subtheme/<sub-theme>/css/           custom.css` file.


3.  As you plan to upload the theme as a sub-theme of the default main theme, delete all the files in your `<THEME_HOME>` folder except the ones that you edited. The rest of the files are automatically applied from the main theme.

### Setting the new theme as the default theme

The following are the two methods in which you can set your new theme as the default theme:

-   [Saving directly in the file system](#AddingaNewAPIStoreTheme-Savingdirectlyintothefilesystem)
-   [Uploading through the Admin Portal](#AddingaNewAPIStoreTheme-UploadingthroughtheAdminPortal)

#### Saving directly in the file system

**If you have access to the file system** , do the following:

1.  Save the `<THEME_HOME>` folder that [contains the sub-theme of the main theme](#AddingaNewAPIStoreTheme-Writingasubthemeofthemaintheme) inside the `<APIM_HOME>/repository/deployment/server/jaggeryapps/store/site/themes/wso2/subthemes` folder. This makes your new theme a sub-theme of `wso2` .
2.  Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/store/site/conf/site.json` file, and add the following code to it. It specifies the base theme as `wso2` , which is overridden by the sub-theme `ancient` .

    ``` java
        "theme" : {
                "base" : "wso2",
                "subtheme" : "ancient"
        }
    ```

3.  Open the API Store.
    Note the new theme that is applied to it.
    ![](/assets/attachments/103334757/103334759.png)
#### Uploading through the Admin Portal (Tenants Only)

**If you do not have access to the file system** , you can upload the theme through the Admin Portal as shown below:

1.  Navigate inside the `<THEME_HOME>` folder that [contains the sub-theme of the main theme](#AddingaNewAPIStoreTheme-Writingasubthemeofthemaintheme) , select all the folders inside it, and right-click to compress all the selected files and folders. Then rename the ZIP file based on the name of your sub-theme. For this example use the [ancient.zip]/assets/attachments/103334757/103334758.zip) file.
2.  Sign in to the WSO2 Admin Portal ( `https://<server-host>:9443/admin` ) with your tenant username (format `<username>@<domain>.com kim@testorg.com` ) and password.
3.  Expand the **Settings** menu, click **Upload Tenant Theme** and upload your ZIP file.
    ![](/assets/attachments/103334757/103334761.png){height="250"}
4.  Access the API Store ( `https://<server-host>:9443/store` ) using your tenant username and password.
    Note the new theme that is applied.

