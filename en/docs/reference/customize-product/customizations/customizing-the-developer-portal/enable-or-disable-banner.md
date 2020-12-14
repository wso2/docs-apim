# Enable or Disable Banner

The banner section is hidden by default. The banner section can use to show an announcement to developer portal users as follows. 

 ![enable or disable banner]({{base_path}}/assets/img/learn/enable-or-disable-banner.png) 

You can show banner by changing themes.light.custom.banner.active to true as follows.

1. Go to  `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` directory, open the `defaultTheme.js` file and set the `themes.light.custom.banner.active` attribute as true to show the banner.

2. Refresh the Developer Portal to view the changes.

### Following attributes available for banner.

```js
const Configurations = {
    custom: {
        banner: {
            active: true,
            style: 'text',
            image: '/site/public/images/landing/01.jpg',
            text: 'This is a very important announcement',
            color: '#ffffff',
            background: '#e08a00',
            padding: 20,
            margin: 0,
            fontSize: 18,
            textAlign: 'center',
        },
    },
};
```

| Option | type | Description |
| ------ | -- | ----------- |
| active | boolean | Banner is visible if true. Hidden if false (default). |
| style | string | Style value can be 'image' or 'text' (default). If text it will display the 'banner.text' value else it will display the 'banner.image'. |
| image | string | Path to banner image |
| text | string | Text to be shown |
| color | string | Color of the banner text |
| background | string | Background color of the banner |
| padding | integer | CSS padding of the banner |
| margin | integer | CSS margin of the banner |
| fontSize | integer | CSS font-size attribute of the banner text |
| textAlign | string | Text align direction |


