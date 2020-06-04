# Enable or Disable Footer

The footer section is visible by default. You can hide footer by changing themes.light.custom.footer.active to false as follows.

1. Go to  `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` directory, open the `defaultTheme.js` file and set the `themes.light.custom.footer.active` attribute as false to hide the footer.

2. Refresh the Developer Portal to view the changes.

### Following attributes available for footer.

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


