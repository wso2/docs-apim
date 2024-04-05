# Enable or Disable Rating

The star rating is enabled by default. You can disable the star rating by configuring the `userTheme.js` file.

The `userTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `userTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

1. Open the `<API-M_HOME>/repository/deployment/server/webapps/devportal/site/public/theme/userTheme.js` file in a text editor and set the `themes.light.custom.social.showRating` attribute to `false` if you want to disable the star rating.

    ```js
    const Configurations = {
        custom: {
            social: {
                showRating: false,
            },
        },
    };
    ```

2. Refresh the Developer Portal to view the changes.