# Enable or Disable API Detail Tabs

When you go to the API detials page all the links ( credentials, comments, tryout, sdks, documents) tabs are displayed. You can enable or disable them by configuring defaultTheme.js.

Go to  `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` directory, open the `defaultTheme.js` file and set the `themes.light.custom.apiDetailPages` attributes accordingly.

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

Refresh the Developer Portal to view the changes.