# Adding Internationalization and Localization

The API Manager comes with two Web interfaces as API Publisher and API Store. The following steps show an example of how to localize the API Publisher UI. Same instructions apply to localize the API Store.

#### Changing the browser settings

1.  Follow the instructions in your Web browser's user guide and set the browser's language to a preferred one. For example, in Google Chrome, you set the language using the **Settings -&gt; Show advanced settings -&gt; Languages** menu.
2.  Set the browser's encoding type to UTF-8.

#### Introduction to resource files

1.  Go to `          <APIM_HOME>          /repository/deployment/server/jaggeryapps/publisher         ` directory where `          <APIM_HOME>         ` is the API Manager distribution's home.
2.  There are two types of resource files used to define localization strings in the API Manager.

    -   The resource file used to store the strings defined in .jag files according to browser locale (For example, `            locale_en.json           ` ) is located in `            .../publisher/site/conf/locales/jaggery           ` folder.
    -   The resource file i18nResources.json, which is used to store strings defined in client-side javascript files such as pop-up messages when a UI event is triggered, is located in .../publisher/site/conf/locales/js folder.

    For example,

    ![](attachments/103333409/103333411.png)

    To implement localization support for jaggery, we use its in-built script module 'i18n'. For more information, refer to <http://jaggeryjs.org/documentation.jag?api=i18n> .

    #### Localizing strings in Jaggery files

3.  To localize the API publisher to Spanish, first localize the strings defined in jaggery files. Create a new file by the name **locale\_{lolcaleCode}.json** inside **...publisher/site/conf/locales/jaggery** folder. For example, if the language set in the browser is Spanish, the locale code is **es** and the file name should be **locale\_es.json** .

        !!! note
    The file name which includes the locale code will differ according to the language selected in your browser. Create a new file for the language you select, if the selected language is not available. The file Name should be **`            locale_{localeCode}.json           `** where the `           localeCode          ` refers to the sub tag of the particular language. Please refer the **[IANA Language Subtag Registry page](http://www.iana.org/assignments/language-subtag-registry)** for a list of sub tags.

    By matching the accept Language header, the particular file will be selected from the resource file directory of each web application for the localization by the server. If there is no locale file found with the matching sub tag, locale\_default.json file will be served for the localization.


Add the key-value pairs to locale\_es.json file. For an example on adding key value pairs, refer to **locale\_en.json** file in **...publisher/site/conf/locales/jaggery** folder. It is the default resource file for jaggery.

In addition, a section of a sample `         locale_es.json        ` file is shown below for your reference.

![](attachments/16847625/17225875.png)

#### Localizing strings in client-side Javascript files

1.  To localize the javascript UI messages, navigate to publisher/site/conf/locales/js folder and update **i18nResources.json** file with relevant values for the key strings.
2.  Once done, open the API Publisher web application in your browser ( `          https:         ` `          //<YourHostName>:9443/publisher).         `
3.  Note that the UI is now changed to Spanish.

