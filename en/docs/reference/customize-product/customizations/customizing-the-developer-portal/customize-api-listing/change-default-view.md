# Change Default View

By default the API Listing view is a grid view. You can follow the steps below to change the default API listing to a table view by configuring `defaultTheme.js`.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file in a text editor.

    You can add the following configuration to the `defaultTheme.js` to change the default API listing to a table view.

    ```js
    const Configurations = {
        custom: {
            defaultApiView: 'list',
        },
    };
    ```

    Changes done in the `defaultTheme.js` will be reflected directly in the developer portal. (It is not required to restart the server or rebuild the source code) 

2. Refresh the Developer Portal to view the changes.

    ![{{base_path}}/assets/img/learn/change-default-view.png]({{base_path}}/assets/img/learn/change-default-view.png)
