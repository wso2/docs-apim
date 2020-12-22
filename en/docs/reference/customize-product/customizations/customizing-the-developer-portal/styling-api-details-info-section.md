# Styling API and Application Details Info Section

The "API Details Info" section shown below, can be customized according to your design needs.

 [![styling api details info section]({{base_path}}/assets/img/learn/styling-api-details-info-section1.png)]({{base_path}}/assets/img/learn/styling-api-details-info-section1.png)

Edit the attributes in `themes.light.custom.infoBar` to change the styling "API Details Info" section and the "Application Details Info" section.

1. Go to the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` directory.

2. Open the `defaultTheme.js` file and update the `themes.light.custom.infoBar` attributes.

3. Refresh the Developer Portal to view the changes.

### Attributes available for infoBar

The JSON sample code given below defines the default look and feel.

```js
const Configurations = {
    custom: {
        infoBar: {
            height: 70,
            background: '#ffffff',
            showThumbnail: true,
            starColor: '#f6bf21',
            sliderBackground: '#ffffff',
            iconOddColor: '#347eff',
            iconEvenColor: '#89b4ff',
            listGridSelectedColor: '#347eff',
            tagChipBackground: '#7dd7f5',
        },
    },
};
```

#### Example: Change the colors of UI elements

```js
const Configurations = {
    custom: {
        infoBar: {
            height: 70,
            background: '#000',
            showThumbnail: false,
            starColor: '#ff1a1a',
            sliderBackground: '#000',
            iconOddColor: '#00e600',
            iconEvenColor: '#b3ffb3',
        },
    },
};

```

 [![styling api details info section]({{base_path}}/assets/img/learn/styling-api-details-info-section2.png)]({{base_path}}/assets/img/learn/styling-api-details-info-section2.png)
 
### Attribute options

| Option | type | Description |
| ------ | -- | ----------- |
| height | integer | Height of the top most row with the API name up to the API link, given in pixels. |
| background | string | Background color of the component |
| showThumbnail | boolean | Show/hide the API thumbnail. Set to visible, by default.|
| starColor | string | Set the color of the star rating. |
| sliderBackground | string | Set the background color of the 'SHOW'/'HIDE' collapsible section at the bottom. |
| iconOddColor | string | Change the color of the icons displayed on the left of the odd-numbered rows. |
| iconEvenColor | string | Change the color of the icons displayed on the left of the even-numbered rows. |
| listGridSelectedColor | string | Define the color of a selected icon (Grid/List) view of the API listing page. |
| tagChipBackground | string | Change the background color of the tags. |

You can handle most of the use cases with regard to rebranding using these configurations. However, if you need to make a change that is not supported by the defaultTheme.js file, then you need to override the relevant React component. For more information, see [Advanced Customization]({{base_path}}/reference/customize-product/customizations/advanced-ui-customization/) for more information.

### Known issues and workarounds

The API details page tags are not visible- [https://github.com/wso2/product-apim/issues/7849](https://github.com/wso2/product-apim/issues/7849).

As a workaround, add the following to the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file.

```js
const Configurations = {
    custom: {
        tagWise: {
            active: true,
        },
    },
};
```
