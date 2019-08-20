# Backward Compatibility

The **Default Version** option means that you make this version the default in a group of different versions of the API. A default API can be invoked without specifying the version number in the URL. For example, if you mark http://host:port/youtube/ 2.0 as the default version when the API has 1.0 and 3.0 versions as well, requests made to [http://host:port/youtube/](http://hostport) get automatically routed to version 2.0.

If you mark any version of an API as the default, two API URLs are listed in its **Overview** tab in the API Store. One URL is with the version and the other is without. You can invoke a default version using both URLs.

If you mark an unpublished API as the default, the previous default published API is used as the default until the new default API is published (or prototyped).
