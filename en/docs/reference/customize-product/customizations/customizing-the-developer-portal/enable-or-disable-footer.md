# Enable or Disable Footer

The footer section is visible by default. You can hide the footer by configuring the `defaultTheme.js` file.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file in a text editor and set the `themes.light.custom.footer.active` attribute as `false` to hide the footer.

2. Refresh the Developer Portal to view the changes.

### The following attributes are available for the footer

```js
const Configurations = {
    custom: {
        footer: {
            active: true,
            text: '',
            background: '#000',
            color: '#fff',
        },
    },
};
```

| Option | type | Description |
| ------ | -- | ----------- |
| active | boolean | Footer is visible if true (default). Hidden if false. |
| text | string | Leave empty to show the default WSO2 Text. Provide custom text to display your own thing. |
| background | string | Set the background color of the footer |
| color | string | Set the font color for the footer text |


