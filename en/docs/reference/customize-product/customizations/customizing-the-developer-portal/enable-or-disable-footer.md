# Enable or Disable Footer

The footer section is visible by default. You can hide the footer by configuring the `userTheme.json` file.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

1. Open the `<API-M_HOME>/repository/deployment/server/webapps/devportal/site/public/theme/userTheme.json` file in a text editor and set the `custom.footer.active` attribute as `false` to hide the footer.

2. Refresh the Developer Portal to view the changes.

### The following attributes are available for the footer

```json
{
    "custom": {
        "footer": {
            "dangerMode": false,
            "active": true,
            "footerHTML": "",
            "text": "",
            "background": "#000",
            "color": "#fff",
            "height": 50
        }
    }
}

```

| Option | type | Description |
| ------ | -- | ----------- |
| dangerMode | boolean | When true, injects raw HTML via `dangerouslySetInnerHTML` and sets `contentEditable` (unsafe if HTML isn't sanitized). Default: false. |
| active | boolean | Footer is visible if true (default). Hidden if false. |
| footerHTML | string | HTML to render in the footer; overrides `text`. Normally rendered via `HTMLRender`; with `dangerMode` it is injected raw and editable. Leave empty to use `text` or the default. |
| text | string | Leave empty to show the default WSO2 text. Provide custom text to display your own content. |
| background | string | Set the background color of the footer (CSS color value, e.g., `#000`). |
| color | string | Set the font color for the footer text (CSS color value, e.g., `#fff`). |
| height | integer | Height of the footer in pixels. Default: 50. |


