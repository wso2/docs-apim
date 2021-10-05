# Enable Social Media Interaction

By default, the community links option is **disabled** (hidden). As a result, the sharable Developer Portal links of the APIs for Facebook, Twitter, and Reddit will not appear in the Developer Portal by default. Instead, the administrators have to enable the social media sharing option if they wish to allow API Consumers to use this feature.

In addition, the GitHub and Slack channel URLs will not appear in the Developer Portal unless the administrators have defined these URLs via the Publisher.

- [Enable sharing API links on social media](#enable-sharing-api-links-on-social-media)
- [Add GitHub and Slack channel URLs to an API](#add-github-and-slack-channel-urls-to-an-api)

## Enable sharing API link on social media

Follow the instructions below to enable API Consumers to be able to share the API link on Facebook, Twitter, and Reddit via the Developer Portal:

### Step 1 - Enable the community links option 

1. Open the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/userTheme.js` configuration file in the WSO2 API Manager server.

    <html>
    <div class="admonition note">
    <p class="admonition-title">Note</p>
    <ul>
    <li>
    The default configuration comes with an empty configuration object declaration. You can override the default configuration in the <code>userTheme.js</code> file.
    </li>
    <li>
    <p>For more information on the content that is in the default configuration, see <a href="{{base_path}}/reference/customize-product/customizations/customizing-the-developer-portal/overriding-developer-portal-theme/#content-of-defaultthemejs">Overriding the Developer Portal theme</a>.</p>
    </li>
    </ul>
    </div> 
    </html>

2.  Enable the community links option.

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

### Step 2 - Verify the changes

1.  Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    For testing purposes, you can use `https://localhost:9443/devportal` and `admin` as the username and password.

2. Click on any published API to view its details. 

     The social media sharable links and the email composer link appear along with the iframe code embedding of the API.

    [![Community link in Developer Portal]({{base_path}}/assets/img/design/community-features/devportal-default-community-links.png)]({{base_path}}/assets/img/design/community-features/devportal-default-community-links.png)
    

## Add GitHub and Slack channel URLs to an API

Follow the instructions below to enable the API related GitHub and Slack channel URLs to appear in the Developer Portal:

### Step 1 - Define your GitHub and Slack channel URLs

1.  Sign in to the Publisher.

    `https://<hostname>:9443/publisher`
     
    `https://localhost:9443/publisher`

2. Click on any published API to view its details.

3. Click **Basic info**.

    [![Basic info link]({{base_path}}/assets/img/design/community-features/publisher-community-link-basic-info.png)]({{base_path}}/assets/img/design/community-features/publisher-community-link-basic-info.png)

4. Provide your GitHub and Slack channel URL in the respective input fields and click **Save**

    [![GitHub and Slack channel URL]({{base_path}}/assets/img/design/community-features/publisher-slack-urls.png)]({{base_path}}/assets/img/design/community-features/publisher-slack-urls.png)

### Step 2 - Verify the changes

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    For testing purposes, you can use `https://localhost:9443/devportal` and `admin` as the username and password.

2. Click on the API.

     The API's overview page appears with the GitHub and Slack channel URLs.

     [![Developer Portal community links with Slack and Github]({{base_path}}/assets/img/design/community-features/devportal-community-links-with-slack-github.png)]({{base_path}}/assets/img/design/community-features/devportal-community-links-with-slack-github.png)

     Now, API Consumers can use the GitHub and Slack channel community links to engage in community activities, explore the API source, and much more.
