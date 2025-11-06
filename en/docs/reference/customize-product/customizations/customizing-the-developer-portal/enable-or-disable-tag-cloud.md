# Enable or Disable Tag Cloud

The tag cloud is enabled by default. You can disable the tag cloud by configuring the `userTheme.json` file.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

1. Open the `<API-M_HOME>/repository/deployment/server/webapps/devportal/site/public/theme/userTheme.json` file in a text editor and set the `custom.tagCloud.active` attribute as `false`.

2. Refresh the Developer Portal to view the changes.

```json
{
    "custom": {
        "tagCloud": {
            "active": true,
            "leftMenu": {
                "width": 200,
                "height": "calc(100vh - 222px)",
                "background": "#012534",
                "color": "#fff",
                "chipBackground": "#e8e5e5ff",
                "titleBackground": "#001c28ff",
                "sliderBackground": "#001c28ff",
                "sliderWidth": 25,
                "hasIcon": false,
                "leftMenuActive": "#00597f"
            },
            "scrollBar": {
                "thumbBackground": "rgba(255, 255, 255, 0.3)",
                "thumbBackgroundHover": "rgba(255, 255, 255, 0.6)",
                "thumbBorderRadius": "4px"
            }
        }
    }
}

```
`leftMenu` object properties are applied only if the `tagCloud.style='fixed-left'`.

| Option | type | Description |
| ------ | -- | ----------- |
| active | boolean | If true (default) tag cloud is enabled. If false, the feature is disabled |
| leftMenu.width | integer | Defines the width of the left side panel shown when tag cloud or tag wise grouping is visible |
| leftMenu.height | string | Set the height for the left side panel shown when the tag cloud or tag wise grouping is visible |
| leftMenu.background | string | Set the background color for the left side panel shown when tag cloud or tag wise grouping is visible |
| leftMenu.color | string | Set the font/text color for items in the left side panel |
| leftMenu.chipBackground | string | Background color for tag chips shown in the left side panel |
| leftMenu.titleBackground | string | Set the background for the title text for the left side panel displayed when tag cloud or tag wise grouping is visible |
| leftMenu.sliderBackground | string | Set the background for the collapse icon with rotated vertical text for the left side panel displayed when tag cloud or tag wise grouping is visible |
| leftMenu.sliderWidth | integer | Set the width for the collapse icon with rotated vertical text for the left side panel displayed when tag cloud or tag wise grouping is visible |
| leftMenu.hasIcon | boolean | Set the visibility for the collapse icon with rotated vertical text for the left side panel displayed when tag cloud or tag wise grouping is visible |
| leftMenu.leftMenuActive | string | Color used to indicate the active/selected state in the left side panel |
| scrollBar.thumbBackground | string | Scrollbar thumb background color for the tag cloud scroll area |
| scrollBar.thumbBackgroundHover | string | Scrollbar thumb background color when hovered |
| scrollBar.thumbBorderRadius | string | Border radius for the scrollbar thumb |