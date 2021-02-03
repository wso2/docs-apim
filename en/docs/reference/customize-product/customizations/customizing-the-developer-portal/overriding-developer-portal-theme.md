# Overriding Developer Portal Theme

There are mainly 2 ways to customize and override the developer portal theme. 

1. Theming using `defaultTheme.js`
2. Overriding React components

In this section, we will cover the first method which is the easiest way to change the appearance of Developer portal.

For the second method, please refer [Advanced Customization]({{base_path}}/develop/customizations/advanced-ui-customization/) section.
## Global Theming

You can find the default theme in the following location `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/source/src/defaultTheme.js`. 

The `defaultTheme.js` file has all the parameters defining the look and feel of the Developer Portal. 
Using the above file as reference, you can override the parameters defined in the above file by altering `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file. Changes done in this file are reflected directly in the Developer Portal ( It's not required to restart the server or rebuild the source code). 

!!!Note
    API Manager Devportal is themed using React Material Design. The theme configuration is an external JSON file that resides outside the React codebase. While an administrator who has access to the file system can override the default theme configuration, a tenant admin can override both of them via the defaultTheme.json file.
    You can refer to `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/source/src/defaultTheme.js` for available parameters. Note that you need to only put the parameters that you override to your file.
    The parameters you can override via the theme are listed at the bottom. Additionally, the default theme params available with React Material Design library can be overridden via this file.

Example:

Enable landing page. **defaultTheme.js**.

```sh
const Configurations = {
    custom: {
        landingPage: {
            active: true,
        },
    },
};
```

Example:

Enable landing page. **defaultTheme.json** (Tenant theming).

```sh
{
  "custom": {
    "landingPage": {
      "active": true
    }
  }
}
```

The following documents describe some of the most commonly used customizations, that you can do by changing the `defaultTheme.js`

  - [Enabling or Disabling API Detail Tabs](enabling-or-disabling-api-detail-tabs.md)
  - [Override API Overview Page per API](override-api-overview-page-per-api.md)
  - [Enable or Disable Rating](enable-or-disable-rating.md)
  - [Enable or Disable Home Page](enable-or-disable-home-page.md)
  - [Enable or Disable Tag Cloud](enable-or-disable-tag-cloud.md)
  - [Enable or Disable Footer](enable-or-disable-footer.md)
  - [Enable or Disable Banner](enable-or-disable-banner.md)
  - [Styling API Details Left Menu](styling-api-details-left-menu.md)
  - [Styling API Details Info Section](styling-api-details-info-section.md)
  - [Styling the Logo and Header](styling-the-logo-and-header.md)
  - [Customize API Listing Default View](customize-api-listing/change-default-view.md)

## Tenant Theming 

### Uploading Devportal theme via the Admin Portal (Tenants Only)

**If you do not have access to the file system** , you can upload/download the Devportal theme via the Admin Portal as shown below:

1.  Download the sample theme here [sample-theme.zip]({{base_path}}/assets/attachments/learn/sample-theme.zip). 
2.  The `sample-theme.zip` file contains the following folder structure. 

     You can make the changes required to `defaultTheme.json` file and archive it back. The name of the archive does not matter. But make sure that the `defaultTheme.json` file name remains the same.
     Uses of resources in `login` folder will be discussed in [Applying thems for tenant login pages]({{base_path}}/develop/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#applying-themes-for-tenant-login-pages).

      ```
      └──apim
      │    └──css
      │    │    └── custom.css
      │    ├── defaultTheme.json
      │    └── images
      │          └── custom-logo.png
      └──analytics
      │     └── images
      │          └── custom-logo.png
      │          └── favicon.ico
      └──login
           └──css
           │    └── custom.css
           ├── loginTheme.json
           └── images
                 └── custom-logo.png
                 └── favicon.ico
      ```

3.  Sign in to the WSO2 Admin Portal (`https://<server-host>:<server-port>/admin`) with your tenant username (format: `<username>@<domain>.com`) and password.

4.  Click **Tenant Theme** under **Settings** category and click **Browse File to Upload** to upload your ZIP file.
    Alternatively, you can drag and drop your ZIP file to upload.

    [![Upload tenant theme]({{base_path}}/assets/img/learn/upload-tenant-theme.png)]({{base_path}}/assets/img/learn/upload-tenant-theme.png)

5.  Access the API Developer Portal (`https://<server-host>:<server-port>/devportal`) using your tenant username and password.

    Note the new theme is applied.
    
!!!Note
    From API-M 3.1.0 onwards, `defaultTheme.json` can contain only the custom modifications done to the default theme. 
    Therefore the following are valid `defaultTheme.json` files.
    
    ```
        Ex1:
        {
          direction: 'rtl'
        }
        
        Ex2: 
        {
            custom: {
                    defaultApiView: 'list',
            }
        }
    ```
    
    The default theme configuration can be found at `<APIM_HOME>/repository/deployment/server/jaggeryapps/devportal/source/src/defaultTheme.js`. 
    In the shared defaultTheme.json we have overriden the `custom.appBar` configurations only.
    
    ```
    {
    	"custom": {
    		"appBar": {
    			"logo": "/site/public/tenant_themes/<tenant-domain>/apim/images/custom-logo.svg",
    			"logoHeight": 31,
    			"logoWidth": 144,
    			"background": "#1d344f",
              		"activeBackground": "#254061"
    		}
    	}
    }
    ```

### Adding custom logo for the tenant

In your tenant theme, you can refer to an image from the `defaultTheme.json` file as follows. The examples below uses the `custom-logo.png` image from the `sample-theme.zip`. The image can be referred using one of the following URL patterns.

The path format to the `custom-logo.png` image within the tenant domain theme is as follows:

```js
"logo": "/site/public/tenant_themes/<tenant-domain>/apim/images/custom-logo.png",
```
The path to the `custom-logo.png` image within the `kim@testorg.com` tenant domain theme is as follows:

```js
"logo": "/site/public/tenant_themes/kim@testorg.com/apim/images/custom-logo.png",
```

The following defines the logo image from an external URL.

```js
"logo": "https://dummyimage.com/208x19/66aad1/ffffff&text=testlogo",
```

### Applying CSS rules to change the look and feel

If you prefer to change the styling using CSS rules, you can use the `custom.css` file. The above sample theme also has a custom CSS file. In the CSS file, let's change the top header background color to black. 

Note that we have injected IDs into the dom elements. You can use them to apply CSS rules. However, be aware of the dynamically generated CSS class names. These class names have a number suffix that changes from version to version. Therefore, it is recommended not to use them for styling purposes. 

The CSS file is referenced in the `defaultTheme.json` in the following manner. It is not a must to replace the `<tenant-domain> ` in the following line, as at runtime the Developer Portal will automatically replace it with the current tenant domain.

```js
   "tenantCustomCss": "/site/public/tenant_themes/<tenant-domain>/apim/css/custom.css",
```

### Content of defaultTheme.json

The following is the Devportal app theme object merging with the React Material Design default theme object described [here](https://material-ui.com/customization/default-theme/#default-theme).

<div>
<div class="jsonTreeOutput"></div>
<textarea class="jsonTreeInput">
{
  "direction": "ltr",
  "palette": {
    "primary": {
      "main": "#006e9c"
    },
    "secondary": {
      "light": "#347eff",
      "main": "#415a85",
      "contrastText": "#ffcc00"
    },
    "background": {
      "default": "#f9f9f9",
      "paper": "#ffffff",
      "drawer": "#1a1f2f"
    }
  },
  "typography": {
    "fontFamily": "\"Open Sans\", \"Helvetica\", \"Arial\", sans-serif",
    "fontSize": 12,
    "body2": {
      "lineHeight": 2
    },
    "h4": {
      "fontWeight": 200
    }
  },
  "custom": {
    "contentAreaWidth": 1240,
    "backgroundImage": "",
    "defaultApiView": "grid",
    "page": {
      "style": "fluid",
      "width": 1240,
      "emptyAreadBackground": "#1e2129",
      "border": "none"
    },
    "appBar": {
      "logo": "/site/public/images/logo.svg",
      "logoHeight": 19,
      "logoWidth": 208,
      "background": "#0fa2db",
      "backgroundImage": "/site/public/images/appbarBack.png",
      "searchInputBackground": "#fff",
      "searchInputActiveBackground": "#fff",
      "activeBackground": "#1c6584",
      "showSearch": true,
      "drawerWidth": 200
    },
    "leftMenu": {
      "position": "vertical-left",
      "style": "icon left",
      "iconSize": 24,
      "leftMenuTextStyle": "uppercase",
      "width": 180,
      "background": "#012534",
      "backgroundImage": "/site/public/images/leftMenuBack.png",
      "leftMenuActive": "#00597f",
      "leftMenuActiveSubmenu": "#0d1723",
      "activeBackground": "#191e46",
      "rootIconVisible": true,
      "rootIconSize": 42,
      "rootIconTextVisible": false,
      "rootBackground": "#000"
    },
    "infoBar": {
      "height": 70,
      "background": "#ffffff",
      "showThumbnail": true,
      "starColor": "#f6bf21",
      "sliderBackground": "#ffffff",
      "iconOddColor": "#347eff",
      "iconEvenColor": "#89b4ff",
      "listGridSelectedColor": "#347eff",
      "tagChipBackground": "#7dd7f5"
    },
    "listView": {
      "tableHeadBackground": "#fff",
      "tableBodyOddBackgrund": "#efefef",
      "tableBodyEvenBackgrund": "#fff"
    },
    "overview": {
      "titleIconColor": "#89b4ff",
      "titleIconSize": 16,
      "noContentBackground": "rgba(255, 255, 255, 0.2)"
    },
    "adminRole": "admin",
    "commentsLimit": 5,
    "maxCommentLength": 512,
    "overviewPage": {
      "commentsBackground": "/site/public/images/overview/comments.svg",
      "documentsBackground": "/site/public/images/overview/documents.svg",
      "credentialsBackground": "/site/public/images/overview/credentials.svg",
      "keysBackground": "/site/public/images/overview/keys.svg"
    },
    "resourceChipColors": {
      "get": "#02a8f4",
      "post": "#8ac149",
      "put": "#ff9700",
      "delete": "#de3702",
      "options": "#5f7c8a",
      "patch": "#785446",
      "head": "#785446"
    },
    "operationChipColor": {
      "query": "#b3e6fe",
      "mutation": "#c1dea0",
      "subscription": "#ffcc80"
    },
    "thumbnail": {
      "width": 240,
      "contentPictureOverlap": false,
      "iconColor": "rgba(0, 0, 0, 0.38)",
      "listViewIconSize": 20,
      "contentBackgroundColor": "rgba(239, 239, 239, 0.5)",
      "defaultApiImage": false,
      "backgrounds": [
        {
          "prime": 2406206207,
          "sub": 1338177791
        },
        {
          "prime": 4101969663,
          "sub": 3453762047
        },
        {
          "prime": 4097980159,
          "sub": 4274063359
        },
        {
          "prime": 563540991,
          "sub": 2934571263
        },
        {
          "prime": 4288086271,
          "sub": 4293606655
        },
        {
          "prime": 4288086271,
          "sub": 4267123455
        }
      ],
      "document": {
        "icon": "library_books",
        "backgrounds": {
          "prime": 3489136639,
          "sub": 3808425983
        }
      }
    },
    "noApiImage": "/site/public/images/nodata.svg",
    "landingPage": {
      "active": false,
      "activeForAnonymous": true,
      "carousel": {
        "active": true,
        "slides": [
          {
            "src": "/site/public/images/landing/01.jpg",
            "title": "Lorem <span>ipsum</span> dolor sit amet",
            "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer felis lacus, placerat vel condimentum in, porta a urna. Suspendisse dolor diam, vestibulum at molestie dapibus, semper eget ex. Morbi sit amet euismod tortor."
          },
          {
            "src": "/site/public/images/landing/02.jpg",
            "title": "Curabitur <span>malesuada</span> arcu sapien",
            "content": "Curabitur malesuada arcu sapien, suscipit egestas purus efficitur vitae. Etiam vulputate hendrerit venenatis. "
          },
          {
            "src": "/site/public/images/landing/03.jpg",
            "title": "Nam vel ex <span>feugiat</span> nunc laoreet",
            "content": "Nam vel ex feugiat nunc laoreet elementum. Duis sed nibh condimentum, posuere risus a, mollis diam. Vivamus ultricies, augue id pulvinar semper, mauris lorem bibendum urna, eget tincidunt quam ex ut diam."
          }
        ]
      },
      "listByTag": {
        "active": true,
        "content": [
          {
            "tag": "finance",
            "title": "Checkout our Finance APIs",
            "description": "We offers online payment solutions and has more than 123 million customers worldwide. The WSO2 Finane API makes powerful functionality available to developers by exposing various features of our platform. Functionality includes but is not limited to invoice management, transaction processing and account management.",
            "maxCount": 5
          },
          {
            "tag": "weather",
            "title": "Checkout our Weather APIs",
            "description": "We offers online payment solutions and has more than 123 million customers worldwide. The WSO2 Finane API makes powerful functionality available to developers by exposing various features of our platform. Functionality includes but is not limited to invoice management, transaction processing and account management.",
            "maxCount": 5
          }
        ]
      },
      "parallax": {
        "active": true,
        "content": [
          {
            "src": "/site/public/images/landing/parallax1.jpg",
            "title": "Lorem <span>ipsum</span> dolor sit amet",
            "content": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer felis lacus, placerat vel condimentum in, porta a urna. Suspendisse dolor diam, vestibulum at molestie dapibus, semper eget ex. Morbi sit amet euismod tortor."
          },
          {
            "src": "/site/public/images/landing/parallax2.jpg",
            "title": "Nam vel ex <span>feugiat</span> nunc laoreet",
            "content": "Nam vel ex feugiat nunc laoreet elementum. Duis sed nibh condimentum, posuere risus a, mollis diam. Vivamus ultricies, augue id pulvinar semper, mauris lorem bibendum urna, eget tincidunt quam ex ut diam."
          }
        ]
      },
      "contact": {
        "active": true,
        "contactHTML": "<div><strong>Mailing Address</strong><p><div>787 Castro Street</div><div>Mountain View,</div><div>CA 94041</div></p><div>Tel: +1 650 745 4499 </div><div>Fax: +1 650 584 3894</div></div>"
      }
    },
    "tagWise": {
      "active": false,
      "style": "fixed-left",
      "thumbnail": {
        "width": 150,
        "image": "/site/public/images/api/api-default.png"
      },
      "key": "-group",
      "showAllApis": true
    },
    "tagCloud": {
      "active": true,
      "colorOptions": {
        "luminosity": "dark",
        "hue": "blue"
      },
      "leftMenu": {
        "width": 200,
        "height": "calc(100vh - 222px)",
        "background": "#d8e4e9",
        "color": "#000",
        "titleBackground": "#222",
        "sliderBackground": "#222",
        "sliderWidth": 25,
        "hasIcon": false
      }
    },
    "social": {
      "showRating": true,
      "showSharing": {
        "active": false,
        "showFacebook": true,
        "showReddit": true,
        "showTwitter": true,
        "showEmbad": true,
        "showEmail": true
      }
    },
    "apiDetailPages": {
      "showCredentials": true,
      "showComments": true,
      "showTryout": true,
      "showDocuments": true,
      "showSdks": true,
      "onlyShowSdks": [],
      "sdkBackground": "#ffffff",
      "swaggerUIBackground": "#efefef",
      "documentBackground": "#efefef",
      "tokenTextBoxBackground": "#efefef"
    },
    "banner": {
      "active": false,
      "style": "text",
      "image": "/site/public/images/landing/01.jpg",
      "text": "This is a very important announcement",
      "color": "#ffffff",
      "background": "#e08a00",
      "padding": 20,
      "margin": 0,
      "fontSize": 18,
      "textAlign": "center"
    },
    "footer": {
      "active": true,
      "footerHTML": "",
      "text": "",
      "background": "#000",
      "color": "#fff",
      "height": 50
    },
    "title": {
      "prefix": "[Devportal]",
      "sufix": "- WSO2 APIM"
    },
    "languageSwitch": {
      "active": false,
      "languages": [
        {
          "key": "en",
          "image": "/site/public/images/flags/en.png",
          "imageWidth": 24,
          "text": "English",
          "direction": "ltr"
        },
        {
          "key": "es",
          "image": "/site/public/images/flags/sp.png",
          "imageWidth": 24,
          "text": "Spanish",
          "direction": "ltr"
        },
        {
          "key": "ar",
          "image": "/site/public/images/flags/ar.png",
          "imageWidth": 24,
          "text": "Arabic",
          "direction": "rtl"
        },
        {
          "key": "si",
          "image": "/site/public/images/flags/si.png",
          "imageWidth": 24,
          "text": "Sinhala",
          "direction": "ltr"
        }
      ],
      "showFlag": true,
      "showText": true,
      "minWidth": 60
    },
    "info": {
      "color": "#64b5f6"
    },
    "publicTenantStore": {
      "active": true,
      "redirectToIfInactive": "https://wso2.com/api-management/cloud/"
    }
  }
}
</textarea>
</div>


### Applying themes for tenant login pages

1. Configure a custom URL for the tenant.

2. Sign in to tenant's Carbon Console and add the following property to `/_system/config/apimgt/applicationdata/tenant-conf.json` file.

```json
"EnablePerTenantServiceProviderCreation" : "true" 
```
3. `login` folder in the tenant theme contains the config files and resources to define login theme customizations.
```
└──login
└──css
│    └── custom.css
├── loginTheme.json
└── images
     └── custom-logo.png
     └── favicon.ico
```
4. Apply changes to `login/loginTheme.json` file. A sample file would look like below.
```js
{
  "title" : "WSO2 API Manager",
  "header" : {
    "title" : "API Manager" 	
  },
  "footer" : {
    "name" : "WSO2 API Manager"
  },  
  "favicon" : {
    "src" : "favicon.ico"
  },
  //"logo" : {
    //"src" : "custom-logo.png",
    //"alt" : "logo",
    //"height" : "60",
    //"width" : "60"
  //},
  "cookie-policy" : {
    "visible" : true,
    "text" : "<custom cookie policy text>"
  },
  "privacy-policy" : {
    "visible" : true,
    "text" : "<custom privacy policy text>"
  }
}
```

!!!Note
    Please note that it is not allowed to define both a header.title and a logo for the login customizations. You can only define either a header.title or a logo.
    
4. Copy the image files into `login/images` folder and mention the file names against favicon and logo src fileds. In case you need to change the look and feel of login pages you can add a custom css file to `login/css` folder. Make sure to name the file as `custom.css`.
5. Zip this file along with other resources in the tenant theme and upload it via the Admin Portal. Or you can make changes manually if you have access to the server's file system.
