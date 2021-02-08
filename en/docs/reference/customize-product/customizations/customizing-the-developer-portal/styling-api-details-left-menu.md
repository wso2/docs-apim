# Styling API Details Left Menu

The API details left menu can be customized to match with your design needs by configuring the `defaultTheme.js` file.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

 ![styling api details left menu]({{base_path}}/assets/img/learn/styling-api-details-left-menu1.png) 

You can change the `themes.light.custom.leftMenu` attributes to change the left menu styling. Note that, these changes will effect the same way to application details left menu as well.

1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file in a text editor and update the `themes.light.custom.leftMenu` attributes.

2. Refresh the Developer Portal to view the changes.

### The following attributes are available for the leftMenu

```js
 const Configurations = {
    custom: {
        leftMenu: {
            position: 'vertical-left',
            style: 'icon left',
            iconSize: 24,
            leftMenuTextStyle: 'uppercase',
            width: 180,
            background: '#012534',
            backgroundImage: '/site/public/images/leftMenuBack.png',
            leftMenuActive: '#00597f',
            leftMenuActiveSubmenu: '#0d1723',
            activeBackground: '#191e46',
            rootIconVisible: true,
            rootIconSize: 42,
            rootIconTextVisible: false,
            rootBackground: '#000',
        },
    },
};
```

The above JSON defines the default look and feel.

We can change the menu to take different positions. For an example, the following configuration sets the menu as a toolbar by just changing the values of the above JSON as follows.
```js
const Configurations = {
    custom: {
        leftMenu: {
            position: 'horizontal',
            rootIconVisible: false,
        },
    },
};
```

 ![styling api details left menu]({{base_path}}/assets/img/learn/styling-api-details-left-menu2.png) 


The following will set the menu to the right hand side and will disable the icons.

```js
const Configurations = {
    custom: {
        leftMenu: {
            position: 'vertical-right',
            style: 'no icon',
        },
    },
};
```

 ![styling api details left menu3.png]({{base_path}}/assets/img/learn/styling-api-details-left-menu3.png) 

| Option | type | Description |
| ------ | -- | ----------- |
| position | string | Sets the possition of the menu. Accepts 'horizontal', 'vertical-left', 'vertical-right' |
| style | string | Sets the menu icon position and visibility. Accepts'icon top', 'icon left', 'no icon', 'no text' |
| iconSize | integer | Icon size in pixles |
| leftMenuTextStyle | string | Set the font style for the menu text |
| width | integer | Defines the menu width |
| background | string | Set the background for the left menu |
| backgroundImage | string | Set a background image to the left menu ex: '/site/public/images/leftMenuBack.png'|
| leftMenuActive | string | Set the background color of the menu when it's selected |
| leftMenuActiveSubmenu | string | Set the background color for submenu elements. Example use can be found at the Application details page |
| rootIconVisible | boolean | Set the top Icons visibility. By default set to true, Set it to false to hide it. |
| rootIconSize | integer | Define the size of root icon. The value is considerd in pixels when rendering. |
| rootIconTextVisible | boolean | Set the visibility of the root icon text. By default it's hidden. |
|rootBackground | string | Set the background color of the root icon containing element |

With these configurations, we tried to handle most of the use cases for rebranding. But if someone wants to do a change that is not supported, for an example change the icons or make the menu collapsible, then they need to override the relevant React component. Refer to the [Advanced Customization]({{base_path}}/reference/customize-product/customizations/advanced-ui-customization/) for more information.