# Changing the Logo and Header Styles

The header section can be customized to match different design needs. Following is the default look and the configuration.
The default header of the API Manager Developer Portal is shown below.

 ![changing the logo and header]({{base_path}}/assets/img/learn/changing-the-logo-and-header1.png) 

!!! note
    -   You can find the default theme in the following location
    `<APIM_HOME>/repository/deployment/server/jaggeryapps/devportal/source/src/defaultTheme.js`
    -   Using the above file as reference you can override the parameters defined in the above file by altering the `defaultTheme.js` file in following location
    `<APIM_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js`

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
#### Example

We can change the logo and header background as follows by changing the above parameters.
 ![changing the logo and header]({{base_path}}/assets/img/learn/changing-the-logo-and-header3.png) 

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