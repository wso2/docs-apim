# Enable or Disable Home Page

It is a common requirement to have a Landing Page if the developer portal is required to present corporate branding. The default Landing Page is the API listing page. But when we enable the Home Page, there will be an additional Landing Page. It can be customized based on the design requirements by configuring the `defaultTheme.js` file.

The `defaultTheme.js` file has all the parameters defining the look and feel of the developer portal. To learn more about `defaultTheme.js` refer [here]({{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#global-theming).

### The Home Page has Four Sections
1. Carousel
2. First Description and the listing of APIs filtered by a given tag (provided via the theme file)
3. Second description and the listing of APIs filtered by a given tag (provided via the theme file)
4. "Contact Us" section

 ![enable or disable home page]({{base_path}}/assets/img/learn/enable-or-disable-home-page.png) 

## Steps to Configure the Landing Page

1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js` file in a text editor and set the attributes accordingly.

    Following JSON is an example for a `defaultTheme.js` to define the look and feel, and the behavior of the landing page. You can set the attributes (components) such as `carousel`, `listByTag`, `parallax` and `contact` as shown in the below example. (Refer to the above screenshot to identify the components refered by the attribute names)

    <div>
    <div class="jsonTreeOutput"></div>
    <textarea class="jsonTreeInput" data-level="2">
    {
    "landingPage": {
          "active": true,
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
            "active": true
          }
        }}
    </textarea>
    </div>

    ``` js
    const Configurations = {
        custom: {
            landingPage: {
                active: true,
                carousel: {
                    active: true,
                    slides: [
                        {
                            src: '/site/public/images/landing/01.jpg',
                            title: 'Lorem <span>ipsum</span> dolor sit amet',
                            content:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer felis lacus, placerat vel condimentum in, porta a urna. Suspendisse dolor diam, vestibulum at molestie dapibus, semper eget ex. Morbi sit amet euismod tortor.',
                        },
                        {
                            src: '/site/public/images/landing/02.jpg',
                            title: 'Curabitur <span>malesuada</span> arcu sapien',
                            content:
                                'Curabitur malesuada arcu sapien, suscipit egestas purus efficitur vitae. Etiam vulputate hendrerit venenatis. ',
                        },
                        {
                            src: '/site/public/images/landing/03.jpg',
                            title: 'Nam vel ex <span>feugiat</span> nunc laoreet',
                            content:
                                'Nam vel ex feugiat nunc laoreet elementum. Duis sed nibh condimentum, posuere risus a, mollis diam. Vivamus ultricies, augue id pulvinar semper, mauris lorem bibendum urna, eget tincidunt quam ex ut diam.',
                        },
                    ],
                },
                listByTag: {
                    active: true,
                    content: [
                        {
                            tag: 'finance',
                            title: 'Checkout our Finance APIs',
                            description:
                                'We offers online payment solutions and has more than 123 million customers worldwide. The WSO2 Finane API makes powerful functionality available to developers by exposing various features of our platform. Functionality includes but is not limited to invoice management, transaction processing and account management.',
                            maxCount: 5,
                        },
                        {
                            tag: 'weather',
                            title: 'Checkout our Weather APIs',
                            description:
                                'We offers online payment solutions and has more than 123 million customers worldwide. The WSO2 Finane API makes powerful functionality available to developers by exposing various features of our platform. Functionality includes but is not limited to invoice management, transaction processing and account management.',
                            maxCount: 5,
                        },
                    ],
                },
                parallax: {
                    active: true,
                    content: [
                        {
                            src: '/site/public/images/landing/parallax1.jpg',
                            title: 'Lorem <span>ipsum</span> dolor sit amet',
                            content:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer felis lacus, placerat vel condimentum in, porta a urna. Suspendisse dolor diam, vestibulum at molestie dapibus, semper eget ex. Morbi sit amet euismod tortor.',
                        },
                        {
                            src: '/site/public/images/landing/parallax2.jpg',
                            title: 'Nam vel ex <span>feugiat</span> nunc laoreet',
                            content:
                                'Nam vel ex feugiat nunc laoreet elementum. Duis sed nibh condimentum, posuere risus a, mollis diam. Vivamus ultricies, augue id pulvinar semper, mauris lorem bibendum urna, eget tincidunt quam ex ut diam.',
                        },
                    ],
                },
                contact: {
                    active: true,
                },
            },
        },
    };

    ```

    | Option | type | Values | Description |
    | ------ | -- | ----------- | ----------- |
    | active | boolean | true, false | If true the feature is enabled. If false(default), the feature is disabled  |
    | carousel.active | boolean | true, false | If true( default ) the carousel section is visible. If false carousel section is hidden. |
    | carousel.slides | array | |  Provide the content for the carousel animation at the page top. Slide is a json of following format. {src: 'path-to-slide-image/image.png', title: 'Title text with <span>special text</span>',content:'Slide description' }  |
    | listByTag.active | boolean | true, false | If true( default ) the listByTag section is visible. If false listByTag section is hidden. |
    listByTag.content | array | | Provide the content for the API grouping. It's an array of JSON where the JSON of following format. { tag: 'tag-name', title: 'Title for tag-name', description: '', maxCount: 5 } .|
    | parallax.active | boolean | true, false | If true( default ) the parallax scrolling section is visible. If false parallax scrolling section is hidden. |
    | contact.active | boolean | true, false | If true( default ) the contact us section is visible. If false contact us section is hidden. |  

2. Refresh the Developer Portal to view the changes.  

The Landing Page provides a headstart for developers who try to rebrand the developer portal for their needs. If the requirements are much complicated, then you need to override the relevant components. The steps to override only specific react components can be found [here]({{base_path}}/reference/customize-product/customizations/advanced-ui-customization/).

