# Overriding developer portal theme

We provide the developers with an easier approach to customize the UI. It’s not required to have React, CSS or HTML knowledge to do UI customization. We have a single JSON file which holds the parameterized constraints of the look and feel. For an example we can change the font family from the JSON file to change it through out the devportal. It has the capability to update not only the look and feel, but also the behaviors such as making the listing view default instead of grid view, hiding social features etc. 



#### Overriding the default theme

The default theme is located in the `<API-M_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/theme/` folder.

`defaultTheme.js` file has all the parameters defining the look and feel of the developer portal.

Make sure to take a backup of the defaultTheme.js before making any changes.

Changes done in the defaultTheme.js will be reflected directly in the devportal. ( It's not required to restart the server or rebuild the source code)

#### Uploading through the Admin Portal (Tenants Only)

**If you do not have access to the file system** , you can upload the theme through the Admin Portal as shown below:

1.  Download the sample theme here <a href="../../../../assets/attachments/learn/testTheme.zip" target="_blank">testTheme.zip</a> file. This sample theme is changing the default listing from 'grid' to 'list'.
2.  testTheme.zip contains a single json file ( defaultTheme.json ). You can make the changes required to this json file and archive it back. The name of the archive doesn't matter but the name of the json file ( defaultTheme.json ) does.
3.  Sign in to the WSO2 Admin Portal ( `https://<server-host>:9443/admin` ) with your tenant username (format `<username>@<domain>.com kim@testorg.com` ) and password.
4.  Expand the **Settings** menu, click **Upload Tenant Theme** and upload your ZIP file. ![../../../../assets/attachments/103334757/103334761.png](../../../../assets/attachments/103334757/103334761.png)
5.  Access the API Store ( `https://<server-host>:9443/devportal` ) using your tenant username and password.
    Note the new theme that is applied.

