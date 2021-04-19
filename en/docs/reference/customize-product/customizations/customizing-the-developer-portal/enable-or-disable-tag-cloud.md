# Enable or Disable Tag Cloud

The tag cloud is enabled by default. You can disable the tag cloud by configuring the `defaultTheme.js` file.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file in a text editor and set the `themes.light.custom.tagCloud.active` attribute as `false`.

2. Refresh the Developer Portal to view the changes.

```js
const Configurations = {
    custom: {
        tagCloud: {
            active: true,
            colorOptions: {
                luminosity: 'dark',
                hue: 'blue',
            },
            leftMenu: {
                width: 200,
                height: 'calc(100vh - 222px)',
                background: '#d8e4e9',
                color: '#000',
                titleBackground: '#222',
                sliderBackground: '#222',
                sliderWidth: 25,
                hasIcon: false,
            },
        },
    },
};
```
`leftMenu` object properties are applied only if the `tagCloud.style='fixed-left'`.

| Option | type | Values | Description |
| ------ | -- | ----------- | ----------- |
| active | boolean | true(default), false | If true(default) tag cloud is enabled. If false, the feature is disabled |
| colorOptions | JSON Object | |  This is the Options object passed to TagCloud component more options can be found from [https://www.npmjs.com/package/react-tagcloud](https://www.npmjs.com/package/react-tagcloud) | 
| leftMenu.width | integer | | Defines the width of the left side panel shown when tag cloud or tag wise grouping is visible |
| leftMenu.height | string | | Set the height for the left side panel shown when the tag cloud or tag wise grouping is visible |
| leftMenu.background | string | | Set the background color for the left side panel shown when thag cloud or tag wise grouping is visible | 
| leftMenu.titleBackground | string | | Set the background for the title text for the left side panel displayed when tag cloud or tag wise grouping is visible |
| leftMenu.sliderBackground | string | | Set the background for the collapse icon with rotated vertical text for the left side panel displayed when tag cloud or tag wise grouping is visible |
| leftMenu.sliderWidth | integer || Set the width for the collapse icon with rotated vertical text for the left side panel displayed when tag cloud or tag wise grouping is visible |
| leftMenu.hasIcon | boolean | | Set the visibility for the collapse icon with rotated vertical text for the left side panel displayed when tag cloud or tag wise grouping is visible |