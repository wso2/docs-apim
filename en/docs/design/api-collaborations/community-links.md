# Community Links

By default the community links are **disabled** (hidden) in the Developer portal and administrator has to enable the social feature from the Developer portal configurations.

API community links allows API consumers to share the developer portal link of the API in social media platforms, WSO2 API manager
generate sharable links for Facebook,Twitter and Reddit out of the box.

To enable the community links:

1. Open the following configuration file in the WSO2 API Manager server.
    <html>
        <div class="admonition note">
            <p class="admonition-title">Note</p>
            <p>For more information on the content of the default configuration, see <a href="{{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#content-of-defaultthemejson">Overriding developer portal theme</a>.</p>
        </div> 
    </html>
```
<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/defaultTheme.js
```

2. The default configuration comes with an empty configuration object declaration. You can just override the required configuration in the above `defaultTheme.js` to override the default configuration. So, To enable the social feature add following configuration elements to the `defaultTheme.js`

    ```javascript
    const Configurations = {
        custom: {
            social: {
                showSharing: {
                    active: true,
                }
            }
        }
    };
    ```

3.  Save the above changes to `defaultTheme.js` and open any published API from the Developer portal. Now you will able to see the Social media sharable links and email composer link along with the iframe code embedding of the API.

    ![]({{base_path}}/assets/img/learn/community_features/devportal-default-community-links.png)
    
    Next, Let's add Github and Slack channel URLs to the API.

4. Login to the Publisher portal again and open a published API

5. Click on the **Basic info** link from the left hand side menu

    ![]({{base_path}}/assets/img/learn/community_features/publisher-community-link-basic-info.png)

6. Provide your Github ans Slack channel URL in the respective input fields and click **Save**

    ![]({{base_path}}/assets/img/learn/community_features/publisher-slack-urls.png)

7. Open the API from the Developer portal and go to the API's overview page

    ![]({{base_path}}/assets/img/learn/community_features/devportal-community-links-with-slack-github.png)

Now, API consumer can use these community links to engage with the community activities, Explore the API source and much more.