# Twitter Connector Reference

The following operations allow you to work with the Twitter Connector. Click an operation name to see parameter details and samples on how to use it.

---

## Initialize the connector

To use the Twitter connector, add the `<twitter.init>` element in your configuration before carrying out any other Twitter operations. 

??? note "twitter.init"
    The twitter.init operation initializes the connector to interact with the Twitter API. See the [related API documentation]( https://developer.twitter.com/en/docs/authentication/oauth-2-0/authorization-code) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>accessToken</td>
            <td>String</td>
            <td>Yes if the refresh token is not present</td>
            <td>The access token of the OAuth 2.0 Twitter app. Not to be mistaken with the OAuth 1.0 access token.</td>
        </tr>
        <tr>
            <td>refreshToken</td>
            <td>String</td>
            <td>Yes if the access token is not present</td>
            <td>The refresh token of the OAuth 2.0 Twitter app. Not to be mistaken with the OAuth 1.0 refresh token.</td>
        </tr>
        <tr>
            <td>clientId</td>
            <td>String</td>
            <td>Yes</td>
            <td>User Id that allows you to use OAuth 2.0 as an authentication method.</td>
        </tr>
        <tr>
            <td>apiUrl</td>
            <td>String</td>
            <td>No, the default value is https://api.twitter.com</td>
            <td>The URL of the Twitter REST API.</td>
        </tr>
        <tr>
            <td>timeout</td>
            <td>Integer</td>
            <td>No, the default value is 5000</td>
            <td>Timeout duration of the API request.</td>
        </tr>
    </table>

    **Sample configuration**

    ```xml
    <twitter.init>
        <clientId>{$ctx:clientId}</clientId>
        <accessToken>{$ctx:accessToken}</accessToken>
        <refreshToken>{$ctx:refreshToken}</refreshToken>
        <apiUrl>{$ctx:apiUrl}</apiUrl>
        <timeout>{$ctx:timeout}</timeout>
    </twitter.init>
    ```

    **Sample request**

    ```xml
    <twitter.init>
        <clientId>"rG9n6402A3dbUJKzXTNX4oWHJ"</clientId>
        <accessToken>"MFpJRmFlbGJTZHVDdkNIbDN4WURTYTFiUmZtRV9HckdsUmlmd1ZxVjRvWHVUOjE2ODY1NDIwMjM5MTk6MTowOmF0OjE"</accessToken>
        <refreshToken>"bWRWa3gzdnk3WHRGU1o0bmRRcTJ5VUxWX1lZTDdJSUtmaWcxbTVxdEFXcW5tOjE2MjIxNDc3NDM5MTQ6MToxOnJ0OjE"</refreshToken>
    </twitter.init>
    ```
---

## Working with Tweets

The following operations allow you to work with tweets. To be authorized for the following endpoints, you will need an access token with the correct scopes. Please refer the [Twitter authentication map](https://developer.twitter.com/en/docs/authentication/guides/v2-authentication-mapping) to get the required scopes for the access token.

??? note "createTweet"
    The twitter.createTweet method creates a Tweet. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/post-tweets) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>text</td>
            <td>String</td>
            <td>Yes if media field is not present</td>
            <td>The text of your Tweet. Up to 280 characters are permitted.</td>
        </tr>
        <tr>
            <td>direct_message_deep_link</td>
            <td>String</td>
            <td>No</td>
            <td>Tweets a link directly to a Direct Message conversation with an account.</td>
        </tr>
        <tr>
            <td>for_super_followers_only</td>
            <td>Boolean</td>
            <td>No</td>
            <td>Allows you to Tweet exclusively for Super Followers.</td>
        </tr>
        <tr>
            <td>geo</td>
            <td>JSON Object</td>
            <td>No</td>
            <td>A JSON object that contains location information for a Tweet. You can only add a location to Tweets if you have geo enabled in your profile settings. If you don't have geo enabled, you can still add a location parameter in your request body, but it won't get attached to your Tweet.</td>
        </tr>
        <tr>
            <td>media</td>
            <td>JSON Object</td>
            <td>No</td>
            <td>A JSON object that contains media information being attached to created Tweet. This is mutually exclusive from Quote Tweet ID and Poll.</td>
        </tr>
        <tr>
            <td>poll</td>
            <td>JSON Object</td>
            <td>No</td>
            <td>A JSON object that contains options for a Tweet with a poll. This is mutually exclusive from Media and Quote Tweet ID.</td>
        </tr>
        <tr>
            <td>quote_tweet_id</td>
            <td>String</td>
            <td>No</td>
            <td>Link to the Tweet being quoted.</td>
        </tr>
        <tr>
            <td>reply</td>
            <td>JSON Object</td>
            <td>No</td>
            <td>A JSON object that contains information of the Tweet being replied to.</td>
        </tr>
        <tr>
            <td>reply_settings</td>
            <td>String</td>
            <td>No</td>
            <td>Settings to indicate who can reply to the Tweet. Valid values are: `mentionedUsers, following`. If the field isn’t specified, it will default to everyone.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.createTweet>
        <text>{$ctx:text}</text>
        <direct_message_deep_link>{$ctx:direct_message_deep_link}</direct_message_deep_link>
        <for_super_followers_only>{$ctx:for_super_followers_only}</for_super_followers_only>
        <geo>{$ctx:geo}</geo>
        <media>{$ctx:media}</media>
        <poll>{$ctx:poll}</poll>
        <quote_tweet_id>{$ctx:quote_tweet_id}</quote_tweet_id>
        <reply>{$ctx:reply}</reply>
        <reply_settings>{$ctx:reply_settings}</reply_settings>
    </twitter.createTweet>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the createTweet operation.
    
    ```xml
    <twitter.createTweet>
        <text>"Hello World!"</text>
        <for_super_followers_only>true</for_super_followers_only>
        <poll>{"options": ["yes", "maybe", "no"], "duration_minutes": 120}</poll>
        <reply>{"in_reply_to_tweet_id": "1455953449422516226", "exclude_reply_user_ids": ["6253282"]}</reply>
        <reply_settings>"mentionedUsers"</reply_settings>
    </twitter.createTweet>
    ```
    **Sample response**
        
    Given below is a sample response for the createTweet operation.

    ```json
    {
       "data": {
          "edit_history_tweet_ids": [
             "1667035675894640640"
          ],
          "id": "1667035675894640640",
          "text": "Hello World!"
       }
    }
    ``` 
        
??? note "deleteTweet"
    The twitter.deleteTweet method deletes a Tweet when given the Tweet ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/manage-tweets/api-reference/delete-tweets-id) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The Tweet ID you are deleting.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.deleteTweet>
        <id>{$ctx:id}</id>
    </twitter.deleteTweet>

    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the deleteTweet operation.
        
    ```xml
    <twitter.deleteTweet>
        <id>"1667035675894640640"</id>
    </twitter.deleteTweet>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the deleteTweet operation.
    
    ```json
    {
        "data": {
            "deleted": true
        }
    }
    ```    

??? note "getTweetById"
    The twitter.getTweetById method retrieves information about a single Tweet specified by the requested ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets-id) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>Unique identifier of the Tweet to request.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td>Expansions enable you to request additional data objects that relate to the originally returned Tweets. Submit a list of desired expansions in a comma-separated list without spaces. The ID that represents the expanded data object will be included directly in the Tweet data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `attachments.poll_ids, attachments.media_keys, author_id, edit_history_tweet_ids, entities.mentions.username, geo.place_id, in_reply_to_user_id, referenced_tweets.id, referenced_tweets.id.author_id`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return media fields if the Tweet contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. While the media ID will be located in the Tweet object, you will find this ID and all additional media fields in the includes data object. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, non_public_metrics, organic_metrics, promoted_metrics, alt_text, variants`</td>
        </tr>
        <tr>
            <td>place_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific place fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The response will contain the selected fields only if you've also included the expansions=geo.place_id query parameter in your request. Valid values for this parameter are: `contained_within, country, country_code, full_name, geo, id, name, place_type`.</td>
        </tr>
        <tr>
            <td>poll_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific poll fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return poll fields if the Tweet contains a poll and if you've also included the expansions=attachments.poll_ids query parameter in your request. While the poll ID will be located in the Tweet object, you will find this ID and all additional poll fields in the includes data object. Valid values for this parameter are: `duration_minutes, end_datetime, id, options, voting_status`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned Tweet object. Specify the desired fields in a comma-separated list without spaces between commas and fields. You can also pass the expansions=referenced_tweets.id expansion to return the specified fields for both the original Tweet and any included referenced Tweets. The requested Tweet fields will display in both the original Tweet data object, as well as in the referenced Tweet expanded data object that will be located in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the original Tweet object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getTweetById>
        <id>{$ctx:id}</id>
        <expansions>{$ctx:expansions}</expansions>
        <media_fields>{$ctx:media_fields}</media_fields>
        <place_fields>{$ctx:place_fields}</place_fields>
        <poll_fields>{$ctx:poll_fields}</poll_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getTweetById>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getTweetById operation.
        
    ```xml
    <twitter.getTweetById>
        <id>"1460323737035677698"</id>
        <expansions>"attachments.media_keys,author_id"</expansions>
        <media_fields>"duration_ms,media_key"</media_fields>
        <tweet_fields>"lang"</tweet_fields>
    </twitter.getTweetById>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getTweetById operation.
    
    ```json
    {
        "data": {
            "lang": "en",
            "author_id": "2244994945",
            "text": "Introducing a new era for the Twitter Developer Platform! \n\n The Twitter API v2 is now the primary API and full of new features\n⏱Immediate access for most use cases, or apply to get more access for free",
            "attachments": {
                "media_keys": [
                    "7_1460322142680072196"
                ]
            },
            "id": "1460323737035677698",
            "edit_history_tweet_ids": [
                "1460323737035677698"
            ]
        }
    }

    ``` 

??? note "getTweetsLookup"
    The twitter.getTweetsLookup method retrieves information about one or more Tweets specified by the requested IDs. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/lookup/api-reference/get-tweets) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>ids</td>
            <td>String</td>
            <td>Yes</td>
            <td>A comma separated list of Tweet IDs. Up to 100 are allowed in a single request. Make sure to not include a space between commas and fields.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td>Expansions enable you to request additional data objects that relate to the originally returned Tweets. Submit a list of desired expansions in a comma-separated list without spaces. The ID that represents the expanded data object will be included directly in the Tweet data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `attachments.poll_ids, attachments.media_keys, author_id, edit_history_tweet_ids, entities.mentions.username, geo.place_id, in_reply_to_user_id, referenced_tweets.id, referenced_tweets.id.author_id`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return media fields if the Tweet contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. While the media ID will be located in the Tweet object, you will find this ID and all additional media fields in the includes data object. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, non_public_metrics, organic_metrics, promoted_metrics, alt_text, variants`</td>
        </tr>
        <tr>
            <td>place_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific place fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The response will contain the selected fields only if you've also included the expansions=geo.place_id query parameter in your request. Valid values for this parameter are: `contained_within, country, country_code, full_name, geo, id, name, place_type`.</td>
        </tr>
        <tr>
            <td>poll_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific poll fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return poll fields if the Tweet contains a poll and if you've also included the expansions=attachments.poll_ids query parameter in your request. While the poll ID will be located in the Tweet object, you will find this ID and all additional poll fields in the includes data object. Valid values for this parameter are: `duration_minutes, end_datetime, id, options, voting_status`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned Tweet object. Specify the desired fields in a comma-separated list without spaces between commas and fields. You can also pass the expansions=referenced_tweets.id expansion to return the specified fields for both the original Tweet and any included referenced Tweets. The requested Tweet fields will display in both the original Tweet data object, as well as in the referenced Tweet expanded data object that will be located in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the original Tweet object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getTweetsLookup>
        <ids>{$ctx:ids}</ids>
        <expansions>{$ctx:expansions}</expansions>
        <media_fields>{$ctx:media_fields}</media_fields>
        <place_fields>{$ctx:place_fields}</place_fields>
        <poll_fields>{$ctx:poll_fields}</poll_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getTweetsLookup>

    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getTweetsLookup operation.
        
    ```xml
    <twitter.getTweetsLookup>
        <ids>"1460323737035677698,1519781379172495360,1519781381693353984"</ids>
        <expansions>"attachments.poll_ids,author_id"</expansions>
        <poll_fields>"duration_minutes"</poll_fields>
    </twitter.getTweetsLookup>

    ```    
      
    **Sample response**
    
    Given below is a sample response for the getTweetsLookup operation.
    
    ```json
    {
        "data": [
            {
                "text": "Introducing a new era for the Twitter Developer Platform! \n\n📣The Twitter API v2 is now the primary API and full of new features\n⏱Immediate access for most use cases, or apply to get more access for free\n📖Removed certain restrictions in the Policy\nhttps://t.co/Hrm15bkBWJ https://t.co/YFfCDErHsg",
                "edit_history_tweet_ids": [
                    "1460323737035677698"
                ],
                "id": "1460323737035677698",
                "lang": "en",
                "author_id": "2244994945"
            },
            {
                "text": "Our mission remains just as important as ever: to deliver an open platform that serves the public conversation. We’re continuing to innovate on the Twitter API v2 and invest in our developer community 🧵\n\nhttps://t.co/Rug1l46sUc",
                "edit_history_tweet_ids": [
                    "1519781379172495360"
                ],
                "id": "1519781379172495360",
                "lang": "en",
                "author_id": "2244994945"
            },
            {
                "text": "Catch up on recent launches and build with the core elements of the Twitter experience:\n🔖 New Bookmarks endpoints\n💬 New Quote Tweets lookup endpoints\n🔼 New sort_order parameter on search endpoints, and improvements to the Likes and Retweets endpoints",
                "edit_history_tweet_ids": [
                    "1519781381693353984"
                ],
                "id": "1519781381693353984",
                "lang": "en",
                "author_id": "2244994945"
            }
        ]
    }
    ``` 

??? note "searchTweets"
    The twitter.searchTweets method retrieves a collection of tweets that meet the specified search criteria. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/search/api-reference/get-tweets-search-recent) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>query</td>
            <td>String</td>
            <td>Yes</td>
            <td>Query for matching Tweets. For more info check [Twitter query guide.](https://developer.twitter.com/en/docs/twitter-api/tweets/search/integrate/build-a-query)</td>
        </tr>
        <tr>
            <td>start_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The oldest UTC timestamp (from most recent seven days) from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (for example, 12:00:01 includes the first second of the minute). If included with the same request as a since_id parameter, only since_id will be used. By default, a request will return Tweets from up to seven days ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>end_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (for example, 12:00:01 excludes the first second of the minute). By default, a request will return Tweets from as recent as 30 seconds ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>since_id</td>
            <td>String</td>
            <td>No</td>
            <td>Returns results with a Tweet ID greater than (that is, more recent than) the specified ID. The ID specified is exclusive and responses will not include it. If included with the same request as a start_time parameter, only since_id will be used.</td>
        </tr>
        <tr>
            <td>sort_order</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to specify the order in which you want the Tweets returned. By default, a request will return the most recent Tweets first (sorted by recency). se object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `recency, relevancy`</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>next_token</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to get the next 'page' of results. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td>Expansions enable you to request additional data objects that relate to the originally returned Tweets. Submit a list of desired expansions in a comma-separated list without spaces. The ID that represents the expanded data object will be included directly in the Tweet data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `attachments.poll_ids, attachments.media_keys, author_id, edit_history_tweet_ids, entities.mentions.username, geo.place_id, in_reply_to_user_id, referenced_tweets.id, referenced_tweets.id.author_id`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return media fields if the Tweet contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. While the media ID will be located in the Tweet object, you will find this ID and all additional media fields in the includes data object. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, non_public_metrics, organic_metrics, promoted_metrics, alt_text, variants`</td>
        </tr>
        <tr>
            <td>place_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific place fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The response will contain the selected fields only if you've also included the expansions=geo.place_id query parameter in your request. Valid values for this parameter are: `contained_within, country, country_code, full_name, geo, id, name, place_type`.</td>
        </tr>
        <tr>
            <td>poll_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific poll fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return poll fields if the Tweet contains a poll and if you've also included the expansions=attachments.poll_ids query parameter in your request. While the poll ID will be located in the Tweet object, you will find this ID and all additional poll fields in the includes data object. Valid values for this parameter are: `duration_minutes, end_datetime, id, options, voting_status`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned Tweet object. Specify the desired fields in a comma-separated list without spaces between commas and fields. You can also pass the expansions=referenced_tweets.id expansion to return the specified fields for both the original Tweet and any included referenced Tweets. The requested Tweet fields will display in both the original Tweet data object, as well as in the referenced Tweet expanded data object that will be located in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the original Tweet object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.searchTweets>
        <query>{$ctx:query}</query>
        <start_time>{$ctx:start_time}</start_time>
        <end_time>{$ctx:end_time}</end_time>
        <since_id>{$ctx:since_id}</since_id>
        <until_id>{$ctx:until_id}</until_id>
        <sort_order>{$ctx:sort_order}</sort_order>
        <max_results>{$ctx:max_results}</max_results>
        <next_token>{$ctx:next_token}</next_token>
        <expansions>{$ctx:expansions}</expansions>
        <media_fields>{$ctx:media_fields}</media_fields>
        <place_fields>{$ctx:place_fields}</place_fields>
        <poll_fields>{$ctx:poll_fields}</poll_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.searchTweets>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the searchTweets operation.
        
    ```xml
    <twitter.searchTweets>
        <query>"(from:TwitterDev) new -is:retweet"</query>
        <start_time>"2020-01-01T00:00:00Z"</start_time>
        <sort_order>"recency"</sort_order>
        <max_results>10</max_results>
        <tweet_fields>"created_at,lang,conversation_id"</tweet_fields>
    </twitter.searchTweets>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the searchTweets operation.
    
    ```json
    {
        "data": [
            {
                "text": "Looking to get started with the Twitter API but new to APIs in general? @jessicagarson will walk you through everything you need to know in APIs 101 session. She’ll use examples using our v2 endpoints, Tuesday, March 23rd at 1 pm EST.",
                "author_id": "2244994945",
                "id": "1373001119480344583",
                "edit_history_tweet_ids": [
                    "1373001119480344583"
                ],
                "lang": "en",
                "conversation_id": "1373001119480344583",
                "created_at": "2021-03-19T19:59:10.000Z"
            }
        ],
    }
    ``` 

??? note "likeTweet"
    The twitter.likeTweet method likes a tweet. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/post-users-id-likes) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID who you are liking a Tweet on behalf of.</td>
        </tr>
        <tr>
            <td>tweet_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The ID of the Tweet that you would give a Like.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.likeTweet>
        <user_id>{$ctx:user_id}</user_id>
        <tweet_id>{$ctx:tweet_id}</tweet_id>
    </twitter.likeTweet>

    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the likeTweet operation.
        
    ```xml
    <twitter.likeTweet>
        <user_id>"1655515285577936899"</user_id>
        <tweet_id>"1521887626935947265"</tweet_id>
    </twitter.likeTweet>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the likeTweet operation.
    
    ```json
    {
        "data": {
            "liked": true
        }
    }

    ``` 

??? note "unlikeTweet"
    The twitter.unlikeTweet method unlikes a tweet. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/delete-users-id-likes-tweet_id) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID who you are unliking a Tweet on behalf of.</td>
        </tr>
        <tr>
            <td>tweet_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The ID of the Tweet that you would unlike.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.unlikeTweet>
        <user_id>{$ctx:user_id}</user_id>
        <tweet_id>{$ctx:tweet_id}</tweet_id>
    </twitter.unlikeTweet>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the unlikeTweet operation.
        
    ```xml
    <twitter.unlikeTweet>
        <user_id>"1655515285577936899"</user_id>
        <tweet_id>"1521887626935947265"</tweet_id>
    </twitter.unlikeTweet>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the unlikeTweet operation.
    
    ```json
    {
        "data": {
            "liked": false
        }
    }

    ``` 

??? note "getLikedTweetsList"
    The twitter.getLikedTweetsList method retrieves a list of liked Tweets of the specified user ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/likes/api-reference/get-users-id-liked_tweets) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>User ID of the user to request liked Tweets for.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Used to request the next page of results if all results weren't returned with the latest request, or to go back to the previous page of results. To return the next page, pass the next_token returned in your previous response. To go back one page, pass the previous_token returned in your previous response.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td>Expansions enable you to request additional data objects that relate to the originally returned Tweets. Submit a list of desired expansions in a comma-separated list without spaces. The ID that represents the expanded data object will be included directly in the Tweet data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `attachments.poll_ids, attachments.media_keys, author_id, edit_history_tweet_ids, entities.mentions.username, geo.place_id, in_reply_to_user_id, referenced_tweets.id, referenced_tweets.id.author_id`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return media fields if the Tweet contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. While the media ID will be located in the Tweet object, you will find this ID and all additional media fields in the includes data object. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, non_public_metrics, organic_metrics, promoted_metrics, alt_text, variants`</td>
        </tr>
        <tr>
            <td>place_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific place fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The response will contain the selected fields only if you've also included the expansions=geo.place_id query parameter in your request. Valid values for this parameter are: `contained_within, country, country_code, full_name, geo, id, name, place_type`.</td>
        </tr>
        <tr>
            <td>poll_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific poll fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return poll fields if the Tweet contains a poll and if you've also included the expansions=attachments.poll_ids query parameter in your request. While the poll ID will be located in the Tweet object, you will find this ID and all additional poll fields in the includes data object. Valid values for this parameter are: `duration_minutes, end_datetime, id, options, voting_status`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned Tweet object. Specify the desired fields in a comma-separated list without spaces between commas and fields. You can also pass the expansions=referenced_tweets.id expansion to return the specified fields for both the original Tweet and any included referenced Tweets. The requested Tweet fields will display in both the original Tweet data object, as well as in the referenced Tweet expanded data object that will be located in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the original Tweet object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getLikedTweetsList>
        <id>{$ctx:id}</id>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <media_fields>{$ctx:media_fields}</media_fields>
        <place_fields>{$ctx:place_fields}</place_fields>
        <poll_fields>{$ctx:poll_fields}</poll_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getLikedTweetsList>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getLikedTweetsList operation.
        
    ```xml
    <twitter.getLikedTweetsList>
        <id>"1655515285577936899"</id>
        <max_results>10</max_results>
    </twitter.getLikedTweetsList>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getLikedTweetsList operation.
    
    ```json
    {
        "data": [
            {
                "edit_history_tweet_ids": [
                    "1519781381693353984"
                ],
                "id": "1519781381693353984",
                "text": "Catch up on recent launches and build with the core elements of the Twitter experience:\nð New Bookmarks endpoints\nð¬ New Quote Tweets lookup endpoints\nð¼ New sort_order parameter on search endpoints, and improvements to the Likes and Retweets endpoints"
            },
            {
                "edit_history_tweet_ids": [
                    "1519781379172495360"
                ],
                "id": "1519781379172495360",
                "text": "Our mission remains just as important as ever: to deliver an open platform that serves the public conversation. Weâre continuing to innovate on the Twitter API v2 and invest in our developer community ð§µ\n\nhttps://t.co/Rug1l46sUc"
            },
            {
                "edit_history_tweet_ids": [
                    "1460323737035677698"
                ],
                "id": "1460323737035677698",
                "text": "Introducing a new era for the Twitter Developer Platform! \n\nð£The Twitter API v2 is now the primary API and full of new features\nâ±Immediate access for most use cases, or apply to get more access for free\nðRemoved certain restrictions in the Policy\nhttps://t.co/Hrm15bkBWJ https://t.co/YFfCDErHsg"
            }
        ],
        "meta": {
            "result_count": 3,
            "next_token": "7140dibdnow9c7btw482mq8hweo1bqos2tvjtvo5vftx2"
        }
    }
    ``` 

??? note "createRetweet"
    The twitter.createRetweet method retweets a Tweet. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/retweets/api-reference/post-users-id-retweets) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID who you are Retweeting a Tweet on behalf of.</td>
        </tr>
        <tr>
            <td>tweet_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The ID of the Tweet that you would like to Retweet.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.createRetweet>
        <user_id>{$ctx:user_id}</user_id>
        <tweet_id>{$ctx:tweet_id}</tweet_id>
    </twitter.createRetweet>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the createRetweet operation.
        
    ```xml
    <twitter.createRetweet>
        <user_id>"1655515285577936899"</user_id>
        <tweet_id>"1519781381693353984"</tweet_id>
    </twitter.createRetweet>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the createRetweet operation.
    
    ```json
    {
        "data": {
            "retweeted": true
        }
    }
    ``` 

??? note "getUserHomeTimeline"
    The twitter.getUserHomeTimeline method retrieves a collection of the most recent Tweets and Retweets posted by you and users you follow. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-reverse-chronological) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>Unique identifier of the user that is requesting their chronological home timeline.</td>
        </tr>
        <tr>
            <td>start_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The oldest UTC timestamp (from most recent seven days) from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (for example, 12:00:01 includes the first second of the minute). If included with the same request as a since_id parameter, only since_id will be used. By default, a request will return Tweets from up to seven days ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>end_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (for example, 12:00:01 excludes the first second of the minute). By default, a request will return Tweets from as recent as 30 seconds ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>since_id</td>
            <td>String</td>
            <td>No</td>
            <td>Returns results with a Tweet ID greater than (that is, more recent than) the specified ID. The ID specified is exclusive and responses will not include it. If included with the same request as a start_time parameter, only since_id will be used.</td>
        </tr>
        <tr>
            <td>until_id</td>
            <td>String</td>
            <td>No</td>
            <td>Returns results with a Tweet ID less than (that is, older than) the specified 'until' Tweet ID. There are limits to the number of Tweets that can be accessed through the API. If the limit of Tweets has occurred since the until_id, the until_id will be forced to the most recent ID available.</td>
        </tr>
        <tr>
            <td>sort_order</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to specify the order in which you want the Tweets returned. By default, a request will return the most recent Tweets first (sorted by recency). se object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `recency, relevancy`</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to move forwards or backwards through 'pages' of results, based on the value of the next_token or previous_token in the response. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.</td>
        </tr>
        <tr>
            <td>exclude</td>
            <td>String</td>
            <td>No</td>
            <td> Comma-separated list of the types of Tweets to exclude from the response. Valid values for this parameter are: `retweets, replies`</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td>Expansions enable you to request additional data objects that relate to the originally returned Tweets. Submit a list of desired expansions in a comma-separated list without spaces. The ID that represents the expanded data object will be included directly in the Tweet data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `attachments.poll_ids, attachments.media_keys, author_id, edit_history_tweet_ids, entities.mentions.username, geo.place_id, in_reply_to_user_id, referenced_tweets.id, referenced_tweets.id.author_id`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return media fields if the Tweet contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. While the media ID will be located in the Tweet object, you will find this ID and all additional media fields in the includes data object. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, non_public_metrics, organic_metrics, promoted_metrics, alt_text, variants`</td>
        </tr>
        <tr>
            <td>place_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific place fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The response will contain the selected fields only if you've also included the expansions=geo.place_id query parameter in your request. Valid values for this parameter are: `contained_within, country, country_code, full_name, geo, id, name, place_type`.</td>
        </tr>
        <tr>
            <td>poll_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific poll fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return poll fields if the Tweet contains a poll and if you've also included the expansions=attachments.poll_ids query parameter in your request. While the poll ID will be located in the Tweet object, you will find this ID and all additional poll fields in the includes data object. Valid values for this parameter are: `duration_minutes, end_datetime, id, options, voting_status`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned Tweet object. Specify the desired fields in a comma-separated list without spaces between commas and fields. You can also pass the expansions=referenced_tweets.id expansion to return the specified fields for both the original Tweet and any included referenced Tweets. The requested Tweet fields will display in both the original Tweet data object, as well as in the referenced Tweet expanded data object that will be located in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the original Tweet object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getUserHomeTimeline>
        <id>{$ctx:id}</id>
        <start_time>{$ctx:start_time}</start_time>
        <end_time>{$ctx:end_time}</end_time>
        <since_id>{$ctx:since_id}</since_id>
        <until_id>{$ctx:until_id}</until_id>
        <sort_order>{$ctx:sort_order}</sort_order>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <exclude>{$ctx:exclude}</exclude>
        <expansions>{$ctx:expansions}</expansions>
        <media_fields>{$ctx:media_fields}</media_fields>
        <place_fields>{$ctx:place_fields}</place_fields>
        <poll_fields>{$ctx:poll_fields}</poll_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getUserHomeTimeline>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getUserHomeTimeline operation.
        
    ```xml
    <twitter.getUserHomeTimeline>
        <id>"1655515285577936899"</id>
        <start_time>"2020-01-01T00:00:00Z"</start_time>
        <max_results>10</max_results>
        <tweet_fields>"created_at,lang,conversation_id"</tweet_fields>
    </twitter.getUserHomeTimeline>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getUserHomeTimeline operation.
    
    ```json
    {
        "data": [
            {
                "created_at": "2022-05-12T17:00:00.000Z",
                "text": "Today marks the launch of Devs in the Details, a technical video series made for developers by developers building with the Twitter API.  ðnnIn this premiere episode, @jessicagarson walks us through how she built @FactualCat #WelcomeToOurTechTalknâ¬ï¸nnhttps://t.co/nGa8JTQVBJ",
                "author_id": "2244994945",
                "edit_history_tweet_ids": [
                    "1524796546306478083"
                ],
                "id": "1524796546306478083"
            },
            {
                "created_at": "2022-05-11T19:16:40.000Z",
                "text": "ð¢ Join @jessicagarson @alanbenlee and @i_am_daniele tomorrow, May 12  | 5:30 ET / 2:30pm PT as they discuss the future of bots https://t.co/sQ2bIO1fz6",
                "author_id": "2244994945",
                "edit_history_tweet_ids": [
                    "1524468552404668416"
                ],
                "id": "1524468552404668416"
            },
            {
                "created_at": "2022-05-09T20:12:01.000Z",
                "text": "Do you make bots with the Twitter API? ð¤nnJoin @jessicagarson @alanbenlee and @iamdaniele on Thursday, May 12  | 5:30 ET / 2:30pm PT as they discuss the future of bots and answer any questions you might have. ððâ¬ï¸nnhttps://t.co/2uVt7hCcdG",
                "author_id": "2244994945",
                "edit_history_tweet_ids": [
                    "1523757705436958720"
                ],
                "id": "1523757705436958720"
            },
            {
                "created_at": "2022-05-06T18:19:54.000Z",
                "text": "If youâd like to apply, or would like to nominate someone else for the program, please feel free to fill out the following form:nnhttps://t.co/LUuWj24HLu",
                "author_id": "2244994945",
                "edit_history_tweet_ids": [
                    "1522642324781633536"
                ],
                "id": "1522642324781633536"
            },
            {
                "created_at": "2022-05-06T18:19:53.000Z",
                "text": "Weâve gone into more detail on each Insider in our forum post. nnJoin us in congratulating the new additions! ð¥³nnhttps://t.co/0r5maYEjPJ",
                "author_id": "2244994945",
                "edit_history_tweet_ids": [
                    "1522642323535847424"
                ],
                "id": "1522642323535847424"
            }
        ],
        "includes": {
            "users": [
                {
                    "created_at": "2013-12-14T04:35:55.000Z",
                    "name": "Twitter Dev",
                    "username": "TwitterDev",
                    "id": "2244994945"
                }
            ]
        },
        "meta": {
            "result_count": 5,
            "newest_id": "1524796546306478083",
            "oldest_id": "1522642323535847424",
            "next_token": "7140dibdnow9c7btw421dyz6jism75z99gyxd8egarsc4"
        }
    }
    ``` 

??? note "getUserMentionsTimeline"
    The twitter.getUserMentionsTimeline method retrieves Tweets mentioning a single user specified by the requested user ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-mentions) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>Unique identifier of the user for whom to return Tweets mentioning the user.</td>
        </tr>
        <tr>
            <td>start_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The oldest UTC timestamp (from most recent seven days) from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (for example, 12:00:01 includes the first second of the minute). If included with the same request as a since_id parameter, only since_id will be used. By default, a request will return Tweets from up to seven days ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>end_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (for example, 12:00:01 excludes the first second of the minute). By default, a request will return Tweets from as recent as 30 seconds ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>since_id</td>
            <td>String</td>
            <td>No</td>
            <td>Returns results with a Tweet ID greater than (that is, more recent than) the specified ID. The ID specified is exclusive and responses will not include it. If included with the same request as a start_time parameter, only since_id will be used.</td>
        </tr>
        <tr>
            <td>until_id</td>
            <td>String</td>
            <td>No</td>
            <td>Returns results with a Tweet ID less than (that is, older than) the specified 'until' Tweet ID. There are limits to the number of Tweets that can be accessed through the API. If the limit of Tweets has occurred since the until_id, the until_id will be forced to the most recent ID available.</td>
        </tr>
        <tr>
            <td>sort_order</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to specify the order in which you want the Tweets returned. By default, a request will return the most recent Tweets first (sorted by recency). se object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `recency, relevancy`</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to move forwards or backwards through 'pages' of results, based on the value of the next_token or previous_token in the response. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td>Expansions enable you to request additional data objects that relate to the originally returned Tweets. Submit a list of desired expansions in a comma-separated list without spaces. The ID that represents the expanded data object will be included directly in the Tweet data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `attachments.poll_ids, attachments.media_keys, author_id, edit_history_tweet_ids, entities.mentions.username, geo.place_id, in_reply_to_user_id, referenced_tweets.id, referenced_tweets.id.author_id`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return media fields if the Tweet contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. While the media ID will be located in the Tweet object, you will find this ID and all additional media fields in the includes data object. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, non_public_metrics, organic_metrics, promoted_metrics, alt_text, variants`</td>
        </tr>
        <tr>
            <td>place_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific place fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The response will contain the selected fields only if you've also included the expansions=geo.place_id query parameter in your request. Valid values for this parameter are: `contained_within, country, country_code, full_name, geo, id, name, place_type`.</td>
        </tr>
        <tr>
            <td>poll_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific poll fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return poll fields if the Tweet contains a poll and if you've also included the expansions=attachments.poll_ids query parameter in your request. While the poll ID will be located in the Tweet object, you will find this ID and all additional poll fields in the includes data object. Valid values for this parameter are: `duration_minutes, end_datetime, id, options, voting_status`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned Tweet object. Specify the desired fields in a comma-separated list without spaces between commas and fields. You can also pass the expansions=referenced_tweets.id expansion to return the specified fields for both the original Tweet and any included referenced Tweets. The requested Tweet fields will display in both the original Tweet data object, as well as in the referenced Tweet expanded data object that will be located in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the original Tweet object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getUserMentionsTimeline>
        <id>{$ctx:id}</id>
        <start_time>{$ctx:start_time}</start_time>
        <end_time>{$ctx:end_time}</end_time>
        <since_id>{$ctx:since_id}</since_id>
        <until_id>{$ctx:until_id}</until_id>
        <sort_order>{$ctx:sort_order}</sort_order>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <media_fields>{$ctx:media_fields}</media_fields>
        <place_fields>{$ctx:place_fields}</place_fields>
        <poll_fields>{$ctx:poll_fields}</poll_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getUserMentionsTimeline>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getUserMentionsTimeline operation.
        
    ```xml
    <twitter.getUserMentionsTimeline>
        <id>"1655515285577936899"</id>
        <start_time>"2020-01-01T00:00:00Z"</start_time>
        <max_results>10</max_results>
        <tweet_fields>"created_at,lang,conversation_id"</tweet_fields>
    </twitter.getUserMentionsTimeline>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getUserMentionsTimeline operation.
    
    ```json
    {
        "data": [
            {
                "public_metrics": {
                    "retweet_count": 5,
                    "reply_count": 2,
                    "like_count": 22,
                    "quote_count": 0
                },
                "text": "Live now! https://t.co/9BbWekeWq2",
                "author_id": "2244994945",
                "id": "1374405406261268481",
                "edit_history_tweet_ids": [
                    "1374405406261268481"
                ],
                "created_at": "2021-03-23T16:59:18.000Z",
                "context_annotations": [
                    {
                    "domain": {
                        "id": "46",
                        "name": "Brand Category",
                        "description": "Categories within Brand Verticals that narrow down the scope of Brands"
                    },
                    "entity": {
                        "id": "781974596752842752",
                        "name": "Services"
                    }
                    },
                    {
                    "domain": {
                        "id": "47",
                        "name": "Brand",
                        "description": "Brands and Companies"
                    },
                    "entity": {
                        "id": "10045225402",
                        "name": "Twitter"
                    }
                    }
                ],
                "conversation_id": "1374405406261268481"
            },
            {
                "public_metrics": {
                    "retweet_count": 7,
                    "reply_count": 1,
                    "like_count": 21,
                    "quote_count": 2
                },
                "text": "Hope to see you tomorrow at 1 pm EST for APIs 101! nhttps://t.co/GrtBOXyHmB https://t.co/YyQfmgiLlL",
                "author_id": "2244994945",
                "id": "1374104599456534531",
                "edit_history_tweet_ids": [
                    "1374104599456534531"
                ],
                "created_at": "2021-03-22T21:04:00.000Z",
                "context_annotations": [
                    {
                    "domain": {
                        "id": "46",
                        "name": "Brand Category",
                        "description": "Categories within Brand Verticals that narrow down the scope of Brands"
                    },
                    "entity": {
                        "id": "781974596752842752",
                        "name": "Services"
                    }
                    },
                    {
                    "domain": {
                        "id": "47",
                        "name": "Brand",
                        "description": "Brands and Companies"
                    },
                    "entity": {
                        "id": "10045225402",
                        "name": "Twitter"
                    }
                    }
                ],
                "conversation_id": "1374104599456534531"
            }
        ]
    }
    ``` 

??? note "getUserTweetsTimeline"
    The twitter.getUserTweetsTimeline method retrieves Tweets composed by a single user, specified by the requested user ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/tweets/timelines/api-reference/get-users-id-tweets) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>Unique identifier of the user who composed the Tweets.</td>
        </tr>
        <tr>
            <td>start_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The oldest UTC timestamp (from most recent seven days) from which the Tweets will be provided. Timestamp is in second granularity and is inclusive (for example, 12:00:01 includes the first second of the minute). If included with the same request as a since_id parameter, only since_id will be used. By default, a request will return Tweets from up to seven days ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>end_time</td>
            <td>String</td>
            <td>No</td>
            <td>`YYYY-MM-DDTHH:mm:ssZ` (ISO 8601/RFC 3339). The newest, most recent UTC timestamp to which the Tweets will be provided. Timestamp is in second granularity and is exclusive (for example, 12:00:01 excludes the first second of the minute). By default, a request will return Tweets from as recent as 30 seconds ago if you do not include this parameter.</td>
        </tr>
        <tr>
            <td>since_id</td>
            <td>String</td>
            <td>No</td>
            <td>Returns results with a Tweet ID greater than (that is, more recent than) the specified ID. The ID specified is exclusive and responses will not include it. If included with the same request as a start_time parameter, only since_id will be used.</td>
        </tr>
        <tr>
            <td>until_id</td>
            <td>String</td>
            <td>No</td>
            <td>Returns results with a Tweet ID less than (that is, older than) the specified 'until' Tweet ID. There are limits to the number of Tweets that can be accessed through the API. If the limit of Tweets has occurred since the until_id, the until_id will be forced to the most recent ID available.</td>
        </tr>
        <tr>
            <td>sort_order</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to specify the order in which you want the Tweets returned. By default, a request will return the most recent Tweets first (sorted by recency). se object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `recency, relevancy`</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>This parameter is used to move forwards or backwards through 'pages' of results, based on the value of the next_token or previous_token in the response. The value used with the parameter is pulled directly from the response provided by the API, and should not be modified.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td>Expansions enable you to request additional data objects that relate to the originally returned Tweets. Submit a list of desired expansions in a comma-separated list without spaces. The ID that represents the expanded data object will be included directly in the Tweet data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. Valid values for this parameter are: `attachments.poll_ids, attachments.media_keys, author_id, edit_history_tweet_ids, entities.mentions.username, geo.place_id, in_reply_to_user_id, referenced_tweets.id, referenced_tweets.id.author_id`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return media fields if the Tweet contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. While the media ID will be located in the Tweet object, you will find this ID and all additional media fields in the includes data object. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, non_public_metrics, organic_metrics, promoted_metrics, alt_text, variants`</td>
        </tr>
        <tr>
            <td>place_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific place fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The response will contain the selected fields only if you've also included the expansions=geo.place_id query parameter in your request. Valid values for this parameter are: `contained_within, country, country_code, full_name, geo, id, name, place_type`.</td>
        </tr>
        <tr>
            <td>poll_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific poll fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet will only return poll fields if the Tweet contains a poll and if you've also included the expansions=attachments.poll_ids query parameter in your request. While the poll ID will be located in the Tweet object, you will find this ID and all additional poll fields in the includes data object. Valid values for this parameter are: `duration_minutes, end_datetime, id, options, voting_status`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned Tweet object. Specify the desired fields in a comma-separated list without spaces between commas and fields. You can also pass the expansions=referenced_tweets.id expansion to return the specified fields for both the original Tweet and any included referenced Tweets. The requested Tweet fields will display in both the original Tweet data object, as well as in the referenced Tweet expanded data object that will be located in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver in each returned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the original Tweet object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getUserTweetsTimeline>
        <id>{$ctx:id}</id>
        <start_time>{$ctx:start_time}</start_time>
        <end_time>{$ctx:end_time}</end_time>
        <since_id>{$ctx:since_id}</since_id>
        <until_id>{$ctx:until_id}</until_id>
        <sort_order>{$ctx:sort_order}</sort_order>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <media_fields>{$ctx:media_fields}</media_fields>
        <place_fields>{$ctx:place_fields}</place_fields>
        <poll_fields>{$ctx:poll_fields}</poll_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getUserTweetsTimeline>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getUserTweetsTimeline operation.
        
    ```xml
    <twitter.getUserTweetsTimeline>
        <id>"1655515285577936899"</id>
        <start_time>"2020-01-01T00:00:00Z"</start_time>
        <max_results>10</max_results>
        <tweet_fields>"created_at,lang,conversation_id"</tweet_fields>
    </twitter.getUserTweetsTimeline>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getUserTweetsTimeline operation.
    
    ```json
    {
        "data": [
            {
                "public_metrics": {
                    "retweet_count": 5,
                    "reply_count": 2,
                    "like_count": 22,
                    "quote_count": 0
                },
                "text": "Live now! https://t.co/9BbWekeWq2",
                "author_id": "2244994945",
                "id": "1374405406261268481",
                "edit_history_tweet_ids": [
                    "1374405406261268481"
                ],
                "created_at": "2021-03-23T16:59:18.000Z",
                "context_annotations": [
                    {
                    "domain": {
                        "id": "46",
                        "name": "Brand Category",
                        "description": "Categories within Brand Verticals that narrow down the scope of Brands"
                    },
                    "entity": {
                        "id": "781974596752842752",
                        "name": "Services"
                    }
                    },
                    {
                    "domain": {
                        "id": "47",
                        "name": "Brand",
                        "description": "Brands and Companies"
                    },
                    "entity": {
                        "id": "10045225402",
                        "name": "Twitter"
                    }
                    }
                ],
                "conversation_id": "1374405406261268481"
            }
        ]
    }
    ``` 
---

## Working with Users

The following operations allow you to work with users in Twitter. To be authorized for the following endpoints, you will need an access token with the correct scopes. Please refer the [Twitter authentication map](https://developer.twitter.com/en/docs/authentication/guides/v2-authentication-mapping) to get the required scopes for the access token.

??? note "getMe"
    The twitter.getMe method retrieves information about the authorized user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-me) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getMe>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getMe>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getMe operation.
        
    ```xml
    <twitter.getMe>
        <expansions>"pinned_tweet_id"</expansions>
        <user_fields>"created_at,username,id,name"</user_fields>
    </twitter.getMe>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getMe operation.
    
    ```json
    {
        "data": {
            "name": "GrawKraken",
            "username": "GrawKraken",
            "pinned_tweet_id": "1667091290889256961",
            "id": "1655515285577936899",
            "created_at": "2023-05-08T10:09:55.000Z"
        },
        "includes": {
            "tweets": [
                {
                    "public_metrics": {
                    "retweet_count": 0,
                    "reply_count": 0,
                    "like_count": 0,
                    "quote_count": 0,
                    "bookmark_count": 0,
                    "impression_count": 0
                    },
                    "edit_history_tweet_ids": [
                    "1667091290889256961"
                    ],
                    "text": "Hi",
                    "id": "1667091290889256961"
                }
            ]
        }
    }
    ``` 

??? note "getUserById"
    The twitter.getUserById method retrieves information about a single user specified by the requested ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-id) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The ID of the user to lookup.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getUserById>
        <id>{$ctx:id}</id>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getUserById>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getUserById operation.
        
    ```xml
    <twitter.getUserById>
        <id>"1655515285577936899"</id>
        <user_fields>"created_at,username,id,name"</user_fields>
    </twitter.getUserById>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getUserById operation.
    
    ```json
    {
        "data": {
            "pinned_tweet_id": "1667091290889256961",
            "name": "GrawKraken",
            "id": "1655515285577936899",
            "created_at": "2023-05-08T10:09:55.000Z",
            "username": "GrawKraken"
        },
        "includes": {
            "tweets": [
                {
                    "id": "1667091290889256961",
                    "edit_history_tweet_ids": [
                    "1667091290889256961"
                    ],
                    "public_metrics": {
                    "retweet_count": 0,
                    "reply_count": 0,
                    "like_count": 0,
                    "quote_count": 0,
                    "bookmark_count": 0,
                    "impression_count": 0
                    },
                    "text": "Hi"
                }
            ]
        }
    }
    ``` 

??? note "getUserByUsername"
    The twitter.getUserByUsername method retrieves information about a single user specified by the requested username. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users-by-username-username) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>username</td>
            <td>String</td>
            <td>Yes</td>
            <td> The Twitter username (handle) of the user.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getUserByUsername>
        <username>{$ctx:username}</username>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getUserByUsername>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getUserByUsername operation.
        
    ```xml
    <twitter.getUserByUsername>
        <username>"GrawKraken"</username>
        <tweet_fields>"public_metrics"</tweet_fields>
    </twitter.getUserByUsername>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getUserByUsername operation.
    
    ```json
    {
        "data": {
            "name": "GrawKraken",
            "username": "GrawKraken",
            "pinned_tweet_id": "1667091290889256961",
            "id": "1655515285577936899",
            "created_at": "2023-05-08T10:09:55.000Z"
        },
        "includes": {
            "tweets": [
                {
                    "public_metrics": {
                    "retweet_count": 0,
                    "reply_count": 0,
                    "like_count": 0,
                    "quote_count": 0,
                    "bookmark_count": 0,
                    "impression_count": 0
                    },
                    "edit_history_tweet_ids": [
                    "1667091290889256961"
                    ],
                    "text": "Hi",
                    "id": "1667091290889256961"
                }
            ]
        }
    }
    ``` 

??? note "getUsersLookup"
    The twitter.getUsersLookup method retrieves information about one or more users specified by the requested IDs. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/lookup/api-reference/get-users) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>ids</td>
            <td>String</td>
            <td>Yes</td>
            <td> A comma separated list of user IDs. Up to 100 are allowed in a single request. Make sure to not include a space between commas and fields.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getUsersLookup>
        <ids>{$ctx:ids}</ids>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getUsersLookup>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getUsersLookup operation.
        
    ```xml
    <twitter.getUsersLookup>
        <ids>"1655515285577936899,15594932"</ids>
        <expansions>"pinned_tweet_id"</expansions>
        <tweet_fields>"created_at"</tweet_fields>
    </twitter.getUsersLookup>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getUsersLookup operation.
    
    ```json
    {
        "data": [
            {
                "pinned_tweet_id": "1667091290889256961",
                "username": "GrawKraken",
                "name": "GrawKraken",
                "id": "1655515285577936899"
            },
            {
                "username": "wso2",
                "name": "WSO2",
                "id": "15594932"
            }
        ],
        "includes": {
            "tweets": [
                {
                    "edit_history_tweet_ids": [
                    "1667091290889256961"
                    ],
                    "text": "Hi",
                    "created_at": "2023-06-09T08:48:31.000Z",
                    "id": "1667091290889256961"
                }
            ]
        }
    }
    ``` 

??? note "followUser"
    The twitter.followUser method  follows a specified user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/post-users-source_user_id-following) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The authenticated user ID of whom you would like to initiate the following on behalf. You must pass the Access Tokens that relate to this user when authenticating the request.</td>
        </tr>
        <tr>
            <td>target_user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID of the user that you would like to follow.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.followUser>
        <id>{$ctx:id}</id>
        <target_user_id>{$ctx:target_user_id}</target_user_id>
    </twitter.followUser>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the followUser operation.
        
    ```xml
    <twitter.followUser>
        <id>"1655515285577936899"</id>
        <target_user_id>"15594932"</target_user_id>
    </twitter.followUser>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the followUser operation.
    
    ```json
    {
        "data": {
            "following": true,
            "pending_follow": false
        }
    }
    ```

??? note "getFollowingUsers"
    The twitter.getFollowingUsers method retrieves a list of users who are followed by the specified user ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-following) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID whose following you would like to retrieve.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Used to request the next page of results if all results weren't returned with the latest request, or to go back to the previous page of results. To return the next page, pass the next_token returned in your previous response. To go back one page, pass the previous_token returned in your previous response.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getFollowingUsers>
        <id>{$ctx:id}</id>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getFollowingUsers>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getFollowingUsers operation.
        
    ```xml
    <twitter.getFollowingUsers>
        <id>"1655515285577936899"</id>
    </twitter.getFollowingUsers>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getFollowingUsers operation.
    
    ```json
    {
        "data": [
            {
                "pinned_tweet_id": "1293595870563381249",
                "id": "6253282",
                "username": "TwitterAPI",
                "name": "Twitter API"
            },
            {
                "pinned_tweet_id": "1293593516040269825",
                "id": "2244994945",
                "username": "TwitterDev",
                "name": "Twitter Dev"
            },
            {
                "id": "783214",
                "username": "Twitter",
                "name": "Twitter"
            },
            {
                "pinned_tweet_id": "1271186240323432452",
                "id": "95731075",
                "username": "TwitterSafety",
                "name": "Twitter Safety"
            },
            {
                "id": "3260518932",
                "username": "TwitterMoments",
                "name": "Twitter Moments"
            },
            {
                "pinned_tweet_id": "1293216056274759680",
                "id": "373471064",
                "username": "TwitterMusic",
                "name": "Twitter Music"
            },
            {
                "id": "791978718",
                "username": "OfficialPartner",
                "name": "Twitter Official Partner"
            },
            {
                "pinned_tweet_id": "1289000334497439744",
                "id": "17874544",
                "username": "TwitterSupport",
                "name": "Twitter Support"
            },
            {
                "pinned_tweet_id": "1283543147444711424",
                "id": "234489024",
                "username": "TwitterComms",
                "name": "Twitter Comms"
            },
            {
                "id": "1526228120",
                "username": "TwitterData",
                "name": "Twitter Data"
            }
        ]
    }
    ```  

??? note "getFollowers"
    The twitter.getFollowers method retrieves a list of users who are followers of the specified user ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/get-users-id-followers) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID whose followers you would like to retrieve.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Used to request the next page of results if all results weren't returned with the latest request, or to go back to the previous page of results. To return the next page, pass the next_token returned in your previous response. To go back one page, pass the previous_token returned in your previous response.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getFollowers>
        <id>{$ctx:id}</id>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getFollowers>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getFollowers operation.
        
    ```xml
    <twitter.getFollowers>
        <id>"1655515285577936899"</id>
    </twitter.getFollowers>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getFollowers operation.
    
    ```json
    {
        "data": [
            {
                "pinned_tweet_id": "1293595870563381249",
                "id": "6253282",
                "username": "TwitterAPI",
                "name": "Twitter API"
            },
            {
                "pinned_tweet_id": "1293593516040269825",
                "id": "2244994945",
                "username": "TwitterDev",
                "name": "Twitter Dev"
            },
            {
                "id": "783214",
                "username": "Twitter",
                "name": "Twitter"
            },
            {
                "pinned_tweet_id": "1271186240323432452",
                "id": "95731075",
                "username": "TwitterSafety",
                "name": "Twitter Safety"
            },
            {
                "id": "3260518932",
                "username": "TwitterMoments",
                "name": "Twitter Moments"
            },
            {
                "pinned_tweet_id": "1293216056274759680",
                "id": "373471064",
                "username": "TwitterMusic",
                "name": "Twitter Music"
            },
            {
                "id": "791978718",
                "username": "OfficialPartner",
                "name": "Twitter Official Partner"
            },
            {
                "pinned_tweet_id": "1289000334497439744",
                "id": "17874544",
                "username": "TwitterSupport",
                "name": "Twitter Support"
            },
            {
                "pinned_tweet_id": "1283543147444711424",
                "id": "234489024",
                "username": "TwitterComms",
                "name": "Twitter Comms"
            },
            {
                "id": "1526228120",
                "username": "TwitterData",
                "name": "Twitter Data"
            }
        ]
    }
    ``` 
    
??? note "unfollowUser"
    The twitter.unfollowUser method unfollows a specified user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/follows/api-reference/delete-users-source_id-following) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The authenticated user ID of whom you would like to initiate the unfollowing on behalf. You must pass the Access Tokens that relate to this user when authenticating the request.</td>
        </tr>
        <tr>
            <td>target_user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID of the user that you would like to unfollow.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.unfollowUser>
        <id>{$ctx:id}</id>
        <target_user_id>{$ctx:target_user_id}</target_user_id>
    </twitter.unfollowUser>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the unfollowUser operation.
        
    ```xml
    <twitter.unfollowUser>
        <id>"1655515285577936899"</id>
        <target_user_id>"15594932"</target_user_id>
    </twitter.unfollowUser>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the unfollowUser operation.
    
    ```json
    {
        "data": {
            "following": false
        }
    }
    ``` 

??? note "blockUser"
    The twitter.blockUser method blocks a specified user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/post-users-user_id-blocking) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The authenticated user ID of whom you would like to initiate the blocking on behalf. You must pass the Access Tokens that relate to this user when authenticating the request.</td>
        </tr>
        <tr>
            <td>target_user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID of the user that you would like to block.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.blockUser>
        <id>{$ctx:id}</id>
        <target_user_id>{$ctx:target_user_id}</target_user_id>
    </twitter.blockUser>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the blockUser operation.
        
    ```xml
    <twitter.blockUser>
        <id>"1655515285577936899"</id>
        <target_user_id>"15594932"</target_user_id>
    </twitter.blockUser>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the blockUser operation.
    
    ```json
    {
        "data": {
            "blocking": true
        }
    }
    ``` 

??? note "getBlockedUsers"
    The twitter.getBlockedUsers method retrieves a list of users who are blocked by the specified user ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/get-users-blocking) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID whose blocked users you would like to retrieve.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Used to request the next page of results if all results weren't returned with the latest request, or to go back to the previous page of results. To return the next page, pass the next_token returned in your previous response. To go back one page, pass the previous_token returned in your previous response.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getBlockedUsers>
        <id>{$ctx:id}</id>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getBlockedUsers>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getBlockedUsers operation.
        
    ```xml
    <twitter.getBlockedUsers>
        <id>"1655515285577936899"</id>
    </twitter.getBlockedUsers>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getBlockedUsers operation.
    
    ```json
    {
        "data": [
            {
                "pinned_tweet_id": "1293595870563381249",
                "id": "6253282",
                "username": "TwitterAPI",
                "name": "Twitter API"
            },
            {
                "pinned_tweet_id": "1293593516040269825",
                "id": "2244994945",
                "username": "TwitterDev",
                "name": "Twitter Dev"
            },
            {
                "id": "783214",
                "username": "Twitter",
                "name": "Twitter"
            },
            {
                "pinned_tweet_id": "1271186240323432452",
                "id": "95731075",
                "username": "TwitterSafety",
                "name": "Twitter Safety"
            },
            {
                "id": "3260518932",
                "username": "TwitterMoments",
                "name": "Twitter Moments"
            },
            {
                "pinned_tweet_id": "1293216056274759680",
                "id": "373471064",
                "username": "TwitterMusic",
                "name": "Twitter Music"
            },
            {
                "id": "791978718",
                "username": "OfficialPartner",
                "name": "Twitter Official Partner"
            },
            {
                "pinned_tweet_id": "1289000334497439744",
                "id": "17874544",
                "username": "TwitterSupport",
                "name": "Twitter Support"
            },
            {
                "pinned_tweet_id": "1283543147444711424",
                "id": "234489024",
                "username": "TwitterComms",
                "name": "Twitter Comms"
            },
            {
                "id": "1526228120",
                "username": "TwitterData",
                "name": "Twitter Data"
            }
        ]
    }
    ``` 

??? note "unblockUser"
    The twitter.unblockUser method unblocks a specified user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/blocks/api-reference/delete-users-user_id-blocking) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The authenticated user ID of whom you would like to initiate the unblocking on behalf. You must pass the Access Tokens that relate to this user when authenticating the request.</td>
        </tr>
        <tr>
            <td>target_user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID of the user that you would like to unblock.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.unblockUser>
        <id>{$ctx:id}</id>
        <target_user_id>{$ctx:target_user_id}</target_user_id>
    </twitter.unblockUser>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the unblockUser operation.
        
    ```xml
    <twitter.unblockUser>
        <id>"1655515285577936899"</id>
        <target_user_id>"15594932"</target_user_id>
    </twitter.unblockUser>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the unblockUser operation.
    
    ```json
    {
        "data": {
            "blocking": false
        }
    }
    ``` 

??? note "muteUser"
    The twitter.muteUser method mutes a specified user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/post-users-user_id-muting) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The authenticated user ID of whom you would like to initiate the muting on behalf. You must pass the Access Tokens that relate to this user when authenticating the request.</td>
        </tr>
        <tr>
            <td>target_user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID of the user that you would like to mute.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.muteUser>
        <id>{$ctx:id}</id>
        <target_user_id>{$ctx:target_user_id}</target_user_id>
    </twitter.muteUser>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the muteUser operation.
        
    ```xml
    <twitter.muteUser>
        <id>"1655515285577936899"</id>
        <target_user_id>"15594932"</target_user_id>
    </twitter.muteUser>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the muteUser operation.
    
    ```json
    {
        "data": {
            "muting": true
        }
    }
    ``` 

??? note "getMutedUsers"
    The twitter.getMutedUsers method retrieves a list of users who are muted by the specified user ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/get-users-muting) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID whose muted users you would like to retrieve.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and the 1000. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Used to request the next page of results if all results weren't returned with the latest request, or to go back to the previous page of results. To return the next page, pass the next_token returned in your previous response. To go back one page, pass the previous_token returned in your previous response.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned users. The ID that represents the expanded data object will be included directly in the user data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original Tweet object. At this time, the only expansion available to endpoints that primarily return user objects is expansions=`pinned_tweet_id`. You will find the expanded Tweet data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will deliver in each returned pinned Tweet. Specify the desired fields in a comma-separated list without spaces between commas and fields. The Tweet fields will only return if the user has a pinned Tweet and if you've also included the expansions=pinned_tweet_id query parameter in your request. While the referenced Tweet ID will be located in the original Tweet object, you will find this ID and all additional Tweet fields in the includes data object. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, non_public_metrics, public_metrics, organic_metrics, promoted_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with each returned users objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified user fields will display directly in the user data objects. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, verified_type, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getMutedUsers>
        <id>{$ctx:id}</id>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getMutedUsers>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getMutedUsers operation.
        
    ```xml
    <twitter.getMutedUsers>
        <id>"1655515285577936899"</id>
    </twitter.getMutedUsers>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getMutedUsers operation.
    
    ```json
    {
        "data": [
            {
                "pinned_tweet_id": "1293595870563381249",
                "id": "6253282",
                "username": "TwitterAPI",
                "name": "Twitter API"
            },
            {
                "pinned_tweet_id": "1293593516040269825",
                "id": "2244994945",
                "username": "TwitterDev",
                "name": "Twitter Dev"
            },
            {
                "id": "783214",
                "username": "Twitter",
                "name": "Twitter"
            },
            {
                "pinned_tweet_id": "1271186240323432452",
                "id": "95731075",
                "username": "TwitterSafety",
                "name": "Twitter Safety"
            },
            {
                "id": "3260518932",
                "username": "TwitterMoments",
                "name": "Twitter Moments"
            },
            {
                "pinned_tweet_id": "1293216056274759680",
                "id": "373471064",
                "username": "TwitterMusic",
                "name": "Twitter Music"
            },
            {
                "id": "791978718",
                "username": "OfficialPartner",
                "name": "Twitter Official Partner"
            },
            {
                "pinned_tweet_id": "1289000334497439744",
                "id": "17874544",
                "username": "TwitterSupport",
                "name": "Twitter Support"
            },
            {
                "pinned_tweet_id": "1283543147444711424",
                "id": "234489024",
                "username": "TwitterComms",
                "name": "Twitter Comms"
            },
            {
                "id": "1526228120",
                "username": "TwitterData",
                "name": "Twitter Data"
            }
        ]
    }
    ``` 

??? note "unmuteUser"
    The twitter.unmuteUser method unmutes a specified user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/users/mutes/api-reference/delete-users-user_id-muting) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The authenticated user ID of whom you would like to initiate the unmuting on behalf. You must pass the Access Tokens that relate to this user when authenticating the request.</td>
        </tr>
        <tr>
            <td>target_user_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID of the user that you would like to unmute.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.unmuteUser>
        <id>{$ctx:id}</id>
        <target_user_id>{$ctx:target_user_id}</target_user_id>
    </twitter.unmuteUser>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the unmuteUser operation.
        
    ```xml
    <twitter.unmuteUser>
        <id>"1655515285577936899"</id>
        <target_user_id>"15594932"</target_user_id>
    </twitter.unmuteUser>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the unmuteUser operation.
    
    ```json
    {
        "data": {
            "muting": false
        }
    }
    ``` 
---

## Working with Lists

The following operations allow you to work with lists in Twitter. To be authorized for the following endpoints, you will need an access token with the correct scopes. Please refer the [Twitter authentication map](https://developer.twitter.com/en/docs/authentication/guides/v2-authentication-mapping) to get the required scopes for the access token.

??? note "createList"
    The twitter.createList method creates a new list for the authenticated user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/post-lists) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>name</td>
            <td>String</td>
            <td>Yes</td>
            <td>The name of the List you wish to create.</td>
        </tr>
        <tr>
            <td>description</td>
            <td>String</td>
            <td>No</td>
            <td>Description of the List.</td>
        </tr>
        <tr>
            <td>private</td>
            <td>Boolean</td>
            <td>No</td>
            <td>Determine whether the List should be private.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.createList>
        <name>{$ctx:name}</name>
        <description>{$ctx:description}</description>
        <private>{$ctx:private}</private>
    </twitter.createList>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the createList operation.
        
    ```xml
    <twitter.createList>
        <name>"test list"</name>
        <description>"list for testing"</description>
        <private>true</private>
    </twitter.createList>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the createList operation.
    
    ```json
    {
        "data": {
            "id": "1667124005638397955",
            "name": "test list"
        }
    }
    ``` 

??? note "updateList"
    The twitter.updateList method updates an existing list for the authenticated user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/put-lists-id) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The ID of the List to be updated.</td>
        </tr>
        <tr>
            <td>name</td>
            <td>String</td>
            <td>No</td>
            <td>The new name of the List you wish to update.</td>
        </tr>
        <tr>
            <td>description</td>
            <td>String</td>
            <td>No</td>
            <td>Description of the List.</td>
        </tr>
        <tr>
            <td>private</td>
            <td>Boolean</td>
            <td>No</td>
            <td>Determine whether the List should be private.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.updateList>
        <id>{$ctx:id}</id>
        <name>{$ctx:name}</name>
        <description>{$ctx:description}</description>
        <private>{$ctx:private}</private>
    </twitter.updateList>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the updateList operation.
        
    ```xml
    <twitter.updateList>
        <id>"1669209684962865153"</id>
        <description>"list for testing"</description>
        <private>true</private>
    </twitter.updateList>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the updateList operation.
    
    ```json
    {
        "data": {
            "updated": true
        }
    }
    ``` 

??? note "deleteList"
    The twitter.deleteList method deletes a list for the authenticated user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/lists/manage-lists/api-reference/delete-lists-id) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The ID of the List you wish to delete.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.deleteList>
        <id>{$ctx:id}</id>
    </twitter.deleteList>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the deleteList operation.
        
    ```xml
    <twitter.deleteList>
        <id>"1669209684962865153"</id>
    </twitter.deleteList>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the deleteList operation.
    
    ```json
    {
        "data": {
            "deleted": true
        }
    }
    ``` 

??? note "getListById"
    The twitter.getListById method retrieves information about a single list specified by the requested ID. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/lists/list-lookup/api-reference/get-lists-id) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The ID of the list to lookup.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned List. The ID that represents the expanded data object will be included directly in the List data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original user object. At this time, the only expansion available to endpoints that primarily return List objects is expansions=`owner_id`. You will find the expanded user data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>list_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific List fields will deliver with each returned List objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified List fields will display directly in the List data objects. Valid values for this parameter are: `created_at, follower_count, member_count, private, description, owner_id`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with the users object. Specify the desired fields in a comma-separated list without spaces between commas and fields. The user fields will only be returned if you have included expansions=owner_id query parameter in your request. You will find this ID and all additional user fields in the included data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getListById>
        <id>{$ctx:id}</id>
        <expansions>{$ctx:expansions}</expansions>
        <list_fields>{$ctx:list_fields}</list_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getListById>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getListById operation.
        
    ```xml
    <twitter.getListById>
        <id>"1667124005638397955"</id>
        <user_fields>"created_at,username,id,name"</user_fields>
    </twitter.getListById>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getListById operation.
    
    ```json
    {
        "data": {
            "id": "1667124005638397955",
            "name": "test list",
            "owner_id": "1655515285577936899"
        },
        "includes": {
            "users": [
                {
                    "id": "1655515285577936899",
                    "name": "GrawKraken",
                    "username": "GrawKraken"
                }
            ]
        }
    }
    ``` 
??? note "getFollowingLists"
    The twitter.getFollowingLists method retrieves all lists the authenticating or specified user is following, including their own. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/lists/list-follows/api-reference/get-users-id-followed_lists) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID whose followed Lists you would like to retrieve.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and 100. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Used to request the next page of results if all results weren't returned with the latest request, or to go back to the previous page of results. To return the next page, pass the next_token returned in your previous response. To go back one page, pass the previous_token returned in your previous response.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned List. The ID that represents the expanded data object will be included directly in the List data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original user object. At this time, the only expansion available to endpoints that primarily return List objects is expansions=`owner_id`. You will find the expanded user data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>list_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific List fields will deliver with each returned List objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified List fields will display directly in the List data objects. Valid values for this parameter are: `created_at, follower_count, member_count, private, description, owner_id`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with the users object. Specify the desired fields in a comma-separated list without spaces between commas and fields. The user fields will only be returned if you have included expansions=owner_id query parameter in your request. You will find this ID and all additional user fields in the included data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getFollowingLists>
        <id>{$ctx:id}</id>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <list_fields>{$ctx:list_fields}</list_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getFollowingLists>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getFollowingLists operation.
        
    ```xml
    <twitter.getFollowingLists>
        <id>"1655515285577936899"</id>
        <user_fields>"created_at,username,id,name"</user_fields>
    </twitter.getFollowingLists>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getFollowingLists operation.
    
    ```json
    {
        "data": [
            {
                "follower_count": 123,
                "id": "1630685563471",
                "name": "Test List",
                "owner_id": "1324848235714736129"
            }
        ],
        "includes": {
            "users": [
                {
                    "username": "alanbenlee",
                    "id": "1324848235714736129",
                    "created_at": "2009-08-28T18:30:45.000Z",
                    "name": "Alan Lee"
                }
            ]
        },
        "meta": {
            "result_count": 1
        }
    }
    ``` 

??? note "getListsMemberships"
    The twitter.getListsMemberships method retrieves all Lists a specified user is a member of. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/lists/list-members/api-reference/get-users-id-list_memberships) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The user ID whose List memberships you would like to retrieve.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned per page. This can be a number between 1 and 100. By default, each page will return 100 results.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Used to request the next page of results if all results weren't returned with the latest request, or to go back to the previous page of results. To return the next page, pass the next_token returned in your previous response. To go back one page, pass the previous_token returned in your previous response.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the originally returned List. The ID that represents the expanded data object will be included directly in the List data object, but the expanded object metadata will be returned within the includes response object, and will also include the ID so that you can match this data object to the original user object. At this time, the only expansion available to endpoints that primarily return List objects is expansions=`owner_id`. You will find the expanded user data object living in the includes response object.</td>
        </tr>
        <tr>
            <td>list_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific List fields will deliver with each returned List objects. Specify the desired fields in a comma-separated list without spaces between commas and fields. These specified List fields will display directly in the List data objects. Valid values for this parameter are: `created_at, follower_count, member_count, private, description, owner_id`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will deliver with the users object. Specify the desired fields in a comma-separated list without spaces between commas and fields. The user fields will only be returned if you have included expansions=owner_id query parameter in your request. You will find this ID and all additional user fields in the included data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getListsMemberships>
        <id>{$ctx:id}</id>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <list_fields>{$ctx:list_fields}</list_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getListsMemberships>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getListsMemberships operation.
        
    ```xml
    <twitter.getListsMemberships>
        <id>"1655515285577936899"</id>
        <user_fields>"created_at,username,id,name"</user_fields>
    </twitter.getListsMemberships>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getListsMemberships operation.
    
    ```json
    {
        "data": [
            {
                "description": "list for editing and testing",
                "id": "1667130158023860224",
                "name": "test listss",
                "owner_id": "1655515285577936899"
            }
        ],
        "includes": {
            "users": [
                {
                    "id": "1655515285577936899",
                    "name": "GrawKraken",
                    "username": "GrawKraken",
                    "created_at": "2023-05-08T10:09:55.000Z"
                }
            ]
        },
        "meta": {
            "result_count": 1
        }
    }
    ``` 
---

## Working with Direct Messages

The following operations allow you to work with direct messages in Twitter. To be authorized for the following endpoints, you will need an access token with the correct scopes. Please refer the [Twitter authentication map](https://developer.twitter.com/en/docs/authentication/guides/v2-authentication-mapping) to get the required scopes for the access token.

??? note "sendNewDirectMessage"
    The twitter.sendNewDirectMessage method sends a new direct message to the specified user from the authenticating user. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-with-participant_id-messages) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>participant_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The User ID of the account this one-to-one Direct Message is to be sent to.</td>
        </tr>
        <tr>
            <td>attachments</td>
            <td>String</td>
            <td>Yes if text is not present</td>
            <td>A single Media ID being attached to the Direct Message. Currently, Twitter supports only 1 attachment.</td>
        </tr>
        <tr>
            <td>text</td>
            <td>String</td>
            <td>Yes if attachments is not present</td>
            <td>Text of the Direct Message being created. Text messages support up to 10,000 characters.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.sendNewDirectMessage>
        <participant_id>{$ctx:participant_id}</participant_id>
        <attachments>{$ctx:attachments}</attachments>
        <text>{$ctx:text}</text>
    </twitter.sendNewDirectMessage>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the sendNewDirectMessage operation.
        
    ```xml
    <twitter.sendNewDirectMessage>
        <participant_id>"1668111685234708487"</participant_id>
        <text>"Test message!"</text>
    </twitter.sendNewDirectMessage>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the sendNewDirectMessage operation.
    
    ```json
    {
        "data": {
            "dm_conversation_id": "1655515285577936899-1668111685234708487",
            "dm_event_id": "1668112397700067333"
        }
    }
    ``` 

??? note "addDirectMessage"
    The twitter.addDirectMessage method creates a Direct Message on behalf of an authenticated user, and adds it to the specified conversation. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/direct-messages/manage/api-reference/post-dm_conversations-dm_conversation_id-messages) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>dm_conversation_id</td>
            <td>String</td>
            <td>Yes</td>
            <td>The dm_conversation_id of the conversation to add the Direct Message to. Supports both 1-1 and group conversations.</td>
        </tr>
        <tr>
            <td>attachments</td>
            <td>String</td>
            <td>Yes if text is not present</td>
            <td>A single Media ID being attached to the Direct Message. Currently, Twitter supports only 1 attachment.</td>
        </tr>
        <tr>
            <td>text</td>
            <td>String</td>
            <td>Yes if attachments is not present</td>
            <td>Text of the Direct Message being created. Text messages support up to 10,000 characters.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.addDirectMessage>
        <dm_conversation_id>{$ctx:dm_conversation_id}</dm_conversation_id>
        <attachments>{$ctx:attachments}</attachments>
        <text>{$ctx:text}</text>
    </twitter.addDirectMessage>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the addDirectMessage operation.
        
    ```xml
    <twitter.addDirectMessage>
        <dm_conversation_id>"1655515285577936899-1668111685234708487"</dm_conversation_id>
        <text>"Second Test message!"</text>
    </twitter.addDirectMessage>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the addDirectMessage operation.
    
    ```json
    {
        "data": {
            "dm_conversation_id": "1655515285577936899-1668111685234708487",
            "dm_event_id": "1668112397700067333"
        }
    }
    ``` 
    
??? note "getDirectMessages"
    The twitter.getDirectMessages method retrives a list of Direct Messages for the authenticated user, both sent and received. See the [related API documentation](https://developer.twitter.com/en/docs/twitter-api/direct-messages/lookup/api-reference/get-dm_events) for more information.
    <table>
        <tr>
            <th>Parameter Name</th>
            <th>Type</th>
            <th>Required</th>
            <th>Description</th>
        </tr>
        <tr>
            <td>event_types</td>
            <td>String</td>
            <td>No</td>
            <td>The type of Direct Message event to return. If not included, all types are returned. Valid values for this parameter are: `MessageCreate, ParticipantsJoin, ParticipantsLeave`.</td>
        </tr>
        <tr>
            <td>max_results</td>
            <td>Integer</td>
            <td>No</td>
            <td>The maximum number of results to be returned in a page. Must be between 1 and 100. The default is 100.</td>
        </tr>
        <tr>
            <td>pagination_token</td>
            <td>String</td>
            <td>No</td>
            <td>Contains either the next_token or previous_token value.</td>
        </tr>
        <tr>
            <td>expansions</td>
            <td>String</td>
            <td>No</td>
            <td> Expansions enable you to request additional data objects that relate to the returned Direct Message conversation events. Submit a list of desired expansions in a comma-separated list without spaces. The IDs that represents the expanded data objects will be included directly in the event data object, and the expanded object metadata will be returned within the includes response object. Valid values for this parameter are: `attachments.media_keys, referenced_tweets.id, sender_id, participant_ids`.</td>
        </tr>
        <tr>
            <td>dm_event_fields</td>
            <td>String</td>
            <td>No</td>
            <td>Extra fields to include in the event payload. id, and event_type are returned by default. The text value isn't included for ParticipantsJoin and ParticipantsLeave events. Valid values for this parameter are: `id, text, event_type, created_at, dm_conversation_id, sender_id, participant_ids, referenced_tweets, attachments`.</td>
        </tr>
        <tr>
            <td>media_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific media fields will be delivered in Direct Message 'MessageCreate' events. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the media ID will be located in the event object, you will find this ID and all additional media fields in the includes data object. The event object will only include media fields if the Direct Message contains media and if you've also included the expansions=attachments.media_keys query parameter in your request. Valid values for this parameter are: `duration_ms, height, media_key, preview_image_url, type, url, width, public_metrics, alt_text, variants`.</td>
        </tr>
        <tr>
            <td>tweet_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific Tweet fields will be delivered in each returned Direct Message 'MessageCreate' event object that contains a Tweet reference. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the Tweet ID will be in the event object, you will find this ID and all additional Tweet fields in the includes data object. The event object will include Tweet fields only if the Direct Message references a Tweet and the expansions=referenced_tweet.id query parameter is included in the request. Valid values for this parameter are: `attachments, author_id, context_annotations, conversation_id, created_at, edit_controls, entities, geo, id, in_reply_to_user_id, lang, public_metrics, possibly_sensitive, referenced_tweets, reply_settings, source, text, withheld`.</td>
        </tr>
        <tr>
            <td>user_fields</td>
            <td>String</td>
            <td>No</td>
            <td>This fields parameter enables you to select which specific user fields will be delivered for Direct Message conversation events that reference a sender or participant ID. Specify the desired fields in a comma-separated list without spaces between commas and fields. While the user ID will be located in the event object, you will find this ID and all additional user fields in the includes data object. Valid values for this parameter are: `created_at, description, entities, id, location, name, pinned_tweet_id, profile_image_url, protected, public_metrics, url, username, verified, withheld`.</td>
        </tr>
    </table>

    **Sample configuration**
    
    ```xml
    <twitter.getDirectMessages>
        <event_types>{$ctx:event_types}</event_types>
        <max_results>{$ctx:max_results}</max_results>
        <pagination_token>{$ctx:pagination_token}</pagination_token>
        <expansions>{$ctx:expansions}</expansions>
        <dm_event_fields>{$ctx:dm_event_fields}</dm_event_fields>
        <media_fields>{$ctx:media_fields}</media_fields>
        <tweet_fields>{$ctx:tweet_fields}</tweet_fields>
        <user_fields>{$ctx:user_fields}</user_fields>
    </twitter.getDirectMessages>
    ```

    **Sample request**
    
    Given below is a sample request that can be handled by the getDirectMessages operation.
        
    ```xml
    <twitter.getDirectMessages>
        <dm_event_fields>"event_type,sender_id"</dm_event_fields>
        <user_fields>"created_at,username,id,name"</user_fields>
    </twitter.getDirectMessages>
    ```    
      
    **Sample response**
    
    Given below is a sample response for the getDirectMessages operation.
    
    ```json
    {
        "data": [
            {
                "text": "Test message!",
                "id": "1668113164393672708",
                "sender_id": "1655515285577936899",
                "event_type": "MessageCreate"
            },
            {
                "text": "Test DM",
                "id": "1668112842107547653",
                "sender_id": "1655515285577936899",
                "event_type": "MessageCreate"
            }
        ],
        "meta": {
            "result_count": 2
        }
    }
    ``` 