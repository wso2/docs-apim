# Adding Internationalization and Localization

The API Manager includes two Web interfaces as API Publisher and API Store. The steps below explain how to localize the API Publisher UI. Similarly, the API Store could also be localized by following the steps below.

### Changing the browser settings

Set your browser's language as preferred by following the user guide of your browser. For example, in Google Chrome, you set the language by going to `chrome://settings/languages` URL in your browser.

![Chrome browser settings]({{base_path}}/assets/img/administer/chrome-set-language.png)

If you move up the Spanish language to the top once you refresh the publisher or devportal web apps the text will be translated to the Sinhala language. If the language in the above list is not a supported language of the web application, the English language will be selected as default.

!!! info
    The default developer portal ships with the English language, additionally there are three more languages ( Spanish, Arabic, and Sinhala ) packed with the product for demonstration and testing purposes. The publisher web app also packed with one additional language ( Sinhala ). If you are adding a new language, you need to follow the instructions below.

### Adding a new Language to Devportal or Publisher web applications

Every text in the web apps is loaded from an external JSON file. These JSON files are asynchronously fetched from the browser base on the browser local. These local files can be found from the following location for publisher and devportal.

`<APIM_HOME>/repository/deployment/server/jaggeryapps/publisher/site/public/locales`

`<APIM_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/locales`

For example, If you are adding French language support to the devportal, first you need to find the two-letter locale code for the French language, which is `fr`.

Take a copy of the `en.json` file and rename it to `fr.json`.

!!! info
    If you are setting the browser locale to a specific regional language, for example, French (Switzerland), the language with regional code is `fr-ch`. In this case also, the two letter locale code is `fr` because we do not support regional language switching.

This JSON have key-value pairs as follows.

```js
 "Apis.Details.ApiConsole.ApiConsole.title": "Try Out",
 "Apis.Details.ApiConsole.SelectAppPanel.applications": "Appplications",
```

You have to go through each of these values and convert them into French language accordingly.

### Finding the keys to modify.

Sometimes going through the list of keys and modifying each of them is not going to be enough. You might want to find a key that is responsible for a particular text in the UI. Let’s consider the following scenario. 

In this example, we are going to find the key for the main title APIs in the following screen.


#### Prerequisites.

1. Chrome web browser
2. React Developer Tools extension for Google Chrome
https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en

In this example, we are going to find the key for the main title APIs in the following screen.

![Finding Key1]({{base_path}}/assets/img/administer/find-key-01.png)

Right-click on the APIs link and select “Inspect Element”.

![Finding Key2]({{base_path}}/assets/img/administer/find-key-02.png)

Chrome Developer Tools will be open.
Click the “Components” tab and copy the ID of the text component.
	
![Finding Key3]({{base_path}}/assets/img/administer/find-key-03.png)

### Changing the direction.
From **APIM 3.1.0**, we have enabled direction change for the **Devportal** web application. With this feature, it’s possible to entirely change the default direction of the UI from LTR ( Left To Right )  to RTL ( Right to Left ). This required if you are trying to add support for languages like Arabic. 

Add the following configuration to defaultTheme.js to change the page direction to RTL ( Right To Left ).  If you have already done customizations to the default theme, make sure to merge the following with the existing changes carefully.

```js
const Configurations = {
   direction: 'rtl',
};
```

Reload the Devportal to view the changes. 

!!! info
    If the theme changes are done for the instance via the defaultTheme.js the above configuration is valid. But if it’s the tenant them file ( defaultTheme.json) the variable assignment is not required. And the defaultTheme.json file has to be a valid JSON file. For example, the valid configuration that should go to the defaultTheme.json is as follows.

    ```js
    {
    "direction": "rtl",
    }
    ```

    Learn about [Tenant theming]({{base_path}}/en/latest/learn/consume-api/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#uploading-via-the-admin-portal-tenants-only).



### Enabling language switch.
From **APIM 3.1.0**, we have developed a language switch for the **Devportal** web application. 

Open the defaultTheme.js file.

`<APIM_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js`

Add the following configuration to the file. If you have already done customizations to the default theme, make sure to merge the following with the existing changes carefully.

```js
const Configurations = {
   custom: {
       languageSwitch: {
           active: true,
       }
   }
};
```

Reload the Devportal to view the changes. Now in the top menu, a switch will be displayed to change the language.

![Switch]({{base_path}}/assets/img/administer/find-key-04.png)

There are some additional parameters given to customize the language switch.

| Key | value |
| --- | ----- |
| showFlag  | default set to true. False will hide the flag and display only the text. |
| showText | default set to true. False will hide the text and display only the flag. |
| minWidth | Sets the wish of the whole element. The default set to 60 pixels |

When you switch between languages via the language switcher it will take precedence over the browser local. But if you don’t select a language and if the browser local exists in the list of languages given in the language switcher, the browser locale will be automatically selected from the list of available languages. If the browser locale is not available in the list of languages, then it will fall down to English.

The following are the languages available by default.

```js
languages: [
    {
        key: 'en',
        image: '/site/public/images/flags/en.png',
        imageWidth: 24, // in pixles
        text: 'English',
        direction: 'ltr',
    },
    {
        key: 'es',
        image: '/site/public/images/flags/sp.png',
        imageWidth: 24, // in pixles
        text: 'Spanish',
        direction: 'ltr',
    },
    {
        key: 'ar',
        image: '/site/public/images/flags/ar.png',
        imageWidth: 24, // in pixles
        text: 'Arabic',
        direction: 'rtl',
    },
    {
        key: 'si',
        image: '/site/public/images/flags/si.png',
        imageWidth: 24, // in pixles
        text: 'Sinhala',
        direction: 'ltr',
    }
]
```

When you enable the language switch the direction of each language will take precedence over the root level direction. 

The following is the complete configuration related to localization.

```js
const DefaultConfigurations = {
    direction: 'ltr',
    custom: {
        languageSwitch: {
            active: false,
            languages: [
                {
                    key: 'en',
                    image: '/site/public/images/flags/en.png',
                    imageWidth: 24, // in pixles
                    text: 'English',
                    direction: 'ltr',
                },
                {
                    key: 'es',
                    image: '/site/public/images/flags/sp.png',
                    imageWidth: 24, // in pixles
                    text: 'Spanish',
                    direction: 'ltr',
                },
                {
                    key: 'ar',
                    image: '/site/public/images/flags/ar.png',
                    imageWidth: 24, // in pixles
                    text: 'Arabic',
                    direction: 'rtl',
                },
                {
                    key: 'si',
                    image: '/site/public/images/flags/si.png',
                    imageWidth: 24, // in pixles
                    text: 'Sinhala',
                    direction: 'ltr',
                }
            ],
            showFlag: true,
            showText: true,
            minWidth: 60, // Width of the language switcher in pixles
        }
    }
}
```

### Advanced Concepts.

The following document describes how i18n is implemented in the web applications, how you can auto-generate the language file and how to programmatically convert the local file from one language to any other language.

[How internationalization (i18n) works in API Manager React Apps](https://github.com/wso2/carbon-apimgt/wiki/How-internationalization-(i18n)-works-in-API-Manager-React-Apps)


