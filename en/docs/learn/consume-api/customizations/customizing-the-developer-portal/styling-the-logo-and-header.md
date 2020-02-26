# Changing the logo and header styles

The header section can be customized to match different design needs. Following is the default look and the configuration.

 ![changing the logo and header](../../../../assets/img/learn/changing-the-logo-and-header1.png) 

```js
appBar: {
    logo: '/site/public/images/logo.svg',
    logoHeight: 19,
    logoWidth: 208,
    background: '#1d344f',
    activeBackground: '#254061',
    showSearch: true,
    drawerWidth: 200,
},
```
#### Example

We can change the logo and header background as follows by changing the above parameters.
 ![changing the logo and header](../../../../assets/img/learn/changing-the-logo-and-header2.png) 

```js
 appBar: {
    logo: '/site/public/images/custom-logo.png',
    logoHeight: 66,
    logoWidth: 200,
    background: '#a10207',
    activeBackground: '#ffd500',
    showSearch: true,
    drawerWidth: 200,
},
```

| Option | type | Description |
| ------ | -- | ----------- |
| logo | string | Relative path to logo |
| logoHeight | integer | Logo height in pixels |
| logoWidth | integer | Logo width in pixels |
| background | string | Background color of the header |
| activeBackground | string | Background color of the selected header menu item |
| drawerWidth | integer | Small resolutions will collopse the top menu in to a toggle drawer. This property sets the it's width in pixels |