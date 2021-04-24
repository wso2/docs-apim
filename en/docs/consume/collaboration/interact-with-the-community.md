# Interact with the Community

The Developer Portal provides community features that help API Consumers collaborate and communicate with the API Publisher and build up constructive conversations. You can actively use the following community features to build and nurture an active community of users for the APIs available in the Developer Portal.

- [Rate an API](#rate-an-API)
- [Comment and reply to an API](#comment-and-reply-to-an-api)
- [Share API link on social media](#share-api-link-on-social-media)
- [Access GitHub and Slack URLs](#access-github-and-slack-urls)

## Rate an API

The API ratings will provide potential API consumers valuable insights on the quality and usefulness of an API. You can add a rating for each API version.

To rate an API,

1.  Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    `https://localhost:9443/devportal`

2.  Click on a published API.

    [![Select an API]({{base_path}}/assets/img/consume/community-features/apis-select-devportal.png)]({{base_path}}/assets/img/consume/community-features/apis-select-devportal.png)

     The **Overview** page appears.

    [![Rating icon]({{base_path}}/assets/img/consume/community-features/devportal-api-overview-select-rating.png)]({{base_path}}/assets/img/consume/community-features/devportal-api-overview-select-rating.png)

3.  Click on the **Ratings** icon, which is denoted by a star, to add your rating.

    [![API rating]({{base_path}}/assets/img/consume/community-features/devportal-api-already-rated.png)]({{base_path}}/assets/img/consume/community-features/devportal-api-already-rated.png)

## Comment and reply to an API

The API consumers can comment on any API in the Developer Portal and they can build up a conversation with other API Consumers or with the owner of the API. The API Consumers can reply to any comment and start a new conversation thread to discuss a specific topic.

Let's see how to add a comment and how to reply to a comment:

1.  Sign in to the Developer Portal 

    `https://<hostname>:9443/devportal`
     
    `https://localhost:9443/devportal`

2. Click on a published API.

    [![Select an API]({{base_path}}/assets/img/consume/community-features/apis-select-devportal.png)]({{base_path}}/assets/img/consume/community-features/apis-select-devportal.png)

3.  Click **Comments**.

4. Optionally, **Add a comment**.
    
     Type a comment and click **COMMENT**.

     Note that the comments appear sorted by the time they were entered, alongside the author's name.

     [![Add a comments]({{base_path}}/assets/img/consume/community-features/devportal-add-new-comment.png)]({{base_path}}/assets/img/consume/community-features/devportal-add-new-comment.png)

5. Optionally, **Reply to a comment**.

     Click **REPLY**, type your reply, and click **COMMENT**.

     [![Reply to a comment]({{base_path}}/assets/img/consume/community-features/developer-portal-reply-to-comment.png)]({{base_path}}/assets/img/consume/community-features/developer-portal-reply-to-comment.png)

     When you add a reply to a comment, it will appear in a nested format to the original or the root comment.

## Share API link on social media

!!! note
    WSO2 API Manager generates sharable links for Facebook, Twitter, and Reddit out-of-the-box. However, the API sharing options for Facebook, Twitter, and Reddit will appear in the Developer Portal only if the administrator has [enabled this sharing feature.]({{base_path}}/design/api-collaborations/enable-social-media-interaction/#enable-sharing-api-links-on-social-media)

1.  Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    For testing purposes, you can use `https://localhost:9443/devportal` and `admin` as the username and password.

2. Click on the respective published API to view its details. 

     The social media sharable links and the email composer link appear along with the iframe code embedding of the API.

    [![Community link in Developer Portal]({{base_path}}/assets/img/design/community-features/devportal-default-community-links.png)]({{base_path}}/assets/img/design/community-features/devportal-default-community-links.png)

3. Click on a social media sharing option of your choice.

4. Sign in to the social media platform and share the post with the link to the API.
    
     The Developer Portal link of the respective API appears so that you can use it to create a post in order to share and publicize the API with a wider audience.

## Access GitHub and Slack URLs

!!! note
    The GitHub and Slack URLs will appear in the Developer Portal only if the [API Publisher has defined these URLs for the API.]({{base_path}}/design/api-collaborations/enable-social-media-interaction/#add-github-and-slack-channel-urls-to-an-api)

1. Sign in to the Developer Portal.

    `https://<hostname>:9443/devportal`
     
    For testing purposes, you can use `https://localhost:9443/devportal` and `admin` as the username and password.

2. Click on the API.

     The API's overview page appears with the GitHub and Slack channel URLs.

     [![Developer Portal community links with Slack and Github]({{base_path}}/assets/img/design/community-features/devportal-community-links-with-slack-github.png)]({{base_path}}/assets/img/design/community-features/devportal-community-links-with-slack-github.png)


3. Optionally, click on the **GitHub URL**.

     You get redirected to the predefined GitHub URL, which will generally link to the corresponding API source code.

4. Optionally, click on the **Slack URL**.

     You get redirected to the predefined Slack URL, which will allow you to get in touch with the subject matter experts with regard to the API via the corresponding Slack channel.
