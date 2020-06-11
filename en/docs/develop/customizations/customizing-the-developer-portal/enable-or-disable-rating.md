# Enable or Disable Rating

The star traing is enable by default. You can disable star rating by changing themes.light.custom.social.showRating to false as follows.

1. Go to  `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` directory, open the `defaultTheme.js` file and set the `themes.light.custom.social.showRating` attribute to false if you want to disable rating.
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