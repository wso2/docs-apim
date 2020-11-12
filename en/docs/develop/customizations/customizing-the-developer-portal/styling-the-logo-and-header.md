# Changing the Logo and Header Styles

The header section can be customized to match different design needs. Following is the default look and the configuration. The default header of the API Manager Developer Portal is shown below.

 ![changing the logo and header]({{base_path}}/assets/img/learn/changing-the-logo-and-header1.png)

Go to  `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` directory, open the `defaultTheme.js` file.

The following is a sample configuration with the corresponding parameters to customize the logo and the header of the Developer Portal.

```js
const Configurations = {
    custom: {
        appBar: {
            logo: '/site/public/images/logo.svg',
            logoHeight: 19,
            logoWidth: 208,
            background: '#0fa2db',
            backgroundImage: '/site/public/images/appbarBack.png',
            searchInputBackground: '#fff',
            searchInputActiveBackground: '#fff',
            activeBackground: '#1c6584',
            showSearch: true,
            drawerWidth: 200,
        },
    },
};
```
| Option | type | Description |
| ------ | -- | ----------- |
| logo | string | Relative path to logo |
| logoHeight | integer | Logo height in pixels |
| logoWidth | integer | Logo width in pixels |
| background | string | Background color of the header |
| backgroundImage | string | Set the background image to the header. Ex: '/site/public/images/appbarBack.png' |
| searchInputBackground | string | Set the background color for the search input |
| searchInputActiveBackground | string | Set the background color for the search input |
| activeBackground | string | Background color of the selected header menu item |
| drawerWidth | integer | Small resolutions will collopse the top menu in to a toggle drawer. This property sets the it's width in pixels |

#### Example

We can change the logo and header background as follows by changing the parameters. An example is shown below

```js
const Configurations = {
    custom: {
        appBar: {
            logo: '/site/public/images/custom-logo.png',
            logoHeight: 66,
            logoWidth: 200,
            background: '#a10207',
            activeBackground: '#ffd500',
        },
    },
};
```
Make sure you restart the server for the changes to take effect. 

  ![changing the logo and header]({{base_path}}/assets/img/learn/changing-the-logo-and-header3.png) 
