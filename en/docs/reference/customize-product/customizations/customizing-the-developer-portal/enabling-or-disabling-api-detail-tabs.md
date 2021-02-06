# Enable or Disable API Detail Tabs

When you go to the API details page, all the linked tabs (credentials, comments, tryout, sdks, documents) are displayed. You can enable or disable them by configuring the `defaultTheme.js` file.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

1. Open `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file in a text editor and set the `themes.light.custom.apiDetailPages` attributes accordingly as shown in the below example.

    ```js
    const Configurations = {
        custom: {
            apiDetailPages: {
                showCredentials: false,
                showComments: true,
                showTryout: true,
                showDocuments: true,
                showSdks: true,
                onlyShowSdks: [],
            },
        },
    };
    ```

    | Property Name | type | Perpose |
    | ---- | ---- | ---- |
    | showCredentials | boolean | Enables the credentials tab if true or disable the Credentials tab if false. |
    | showComments | boolean | Enables the comments tab if true or disable the Credentials tab if false. |
    | showTryout | boolean | Enables the try out tab if true or disable the Credentials tab if false. |
    | showDocuments | boolean | Enables the documents tab if true or disable the Credentials tab if false. |
    | showSdks | boolean | Enables the sdks tab if true or disable the Credentials tab if false. |
    | showSdks | Array of strings | You can put an array of strings to enable only a given set of sdks. Leave empty to show all. ex: ['java','javascript'] |

2. Refresh the Developer Portal to view the changes.