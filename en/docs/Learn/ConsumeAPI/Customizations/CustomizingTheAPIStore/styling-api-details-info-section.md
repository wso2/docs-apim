# Styling API details info section

The API details info section can be customized to match with your design needs.

 ![../../../../../assets/img/Learn/styling-api-details-info-section1.png](../../../../../assets/img/Learn/styling-api-details-info-section1.png) 

You can change themes.light.custom.infoBar attributes to change the api detials info section styling. Note these changes will effect the same way to application details info section.

1. Go to  `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` directory, open the `defaultTheme.js` file and update `themes.light.custom.infoBar` attributes.

2. Refresh the Developer Portal to view the changes.

### Following attributes available for infoBar.

```js
 infoBar: {
    height: 70,
    background: '#ffffff',
    showBackIcon: true,
    showThumbnail: true,
    starColor: '#f6bf21', // By default the opasite color of infoBar.background is derived. From here you can override it.
    sliderBackground: '#ffffff',
    iconOddColor: '#347eff',
    iconEvenColor: '#89b4ff',
    listGridSelectedColor: '#347eff', // Defines color of the selected icon ( grid/ list ) view of the api listing page
    tagChipBackground: '#7dd7f5',
}
```

Above JSON defines the default look and feel.

Following example demostrate a use case of changing the colors of UI elements and hiding 'back to apis' link and api thumbnail icon.

```js
infoBar: {
    height: 50,
    background: '#000',
    showBackIcon: false,
    showThumbnail: false,
    starColor: '#ff1a1a', // By default the opasite color of infoBar.background is derived. From here you can override it.
    sliderBackground: '#000',
    iconOddColor: '#00e600',
    iconEvenColor: '#b3ffb3',
    listGridSelectedColor: '#347eff', // Defines color of the selected icon ( grid/ list ) view of the api listing page
    tagChipBackground: '#7dd7f5',
}
```

 ![../../../../../assets/img/Learn/styling-api-details-info-section2.png](../../../../../assets/img/Learn/styling-api-details-info-section2.png)


| Option | type | Description |
| ------ | -- | ----------- |
| height | integer | Height of the top most row with api name and back to api link given in pixles |
| background | string | Background color of the component |
| showBackIcon | boolean | Show hide the "back to APIs" link. By default it's visible. Setting it to false will hide it. |
| showThumbnail | boolean | Show hide the API thumbnail. By default it's visible. Setting it to false will hide it. | 
| starColor | string | Set the color of the star rating. |
| sliderBackground | string | Set the background color of the "SHOW"/"HIDE" colopsible section at the bottom. |
| iconOddColor | strng | Set the color of the icons displayed on the left side of the  odd rows |
| iconEvenColor | strng | Set the color of the icons displayed on the left side of the  even rows |
| listGridSelectedColor | 


With these configurations, we tried to handle most of the use cases for rebranding. But if someone wants to do a change that is not supported by defaultTheme.js then they need to override the relevant React component. Refer to the [Advanced Customization](advanced-customization.md) for more information.



