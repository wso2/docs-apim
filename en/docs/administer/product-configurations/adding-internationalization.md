# Adding Internationalization and Localization

The API Manager includes two Web interfaces, namely the API Publisher and Developer Portal. The steps below explain how you can localize the API Publisher and the Developer Portal.

## Changing the browser language

!!! note
    - The web applications are shipped with the following default and additional languages for demonstration and testing purposes. 

        <table>
                        <tr>
        <th rowspan="2" align="center">
        <b>Web Application</b>
        </th>
        <th colspan="2" align="center">
        <b>Supported Languages</b>
        </th>
    
        </tr>
                <tr>
        <th>
        <b>Default</br>language</b>
        </th>
        <th>
        <b>Additional</br>languages</b>
        </th>
        </tr>
        <tr>
        <td>
        <b>Developer Portal</b>
        </td>
        <td>
        English
        </td>
        <td>
        N/A
        </td>
        </tr>
                <tr>
        <td>
        API Publisher
        </td>
        <td>
        English
        </td>
        <td>
        Spanish</br>French
        </td>
        </tr>
        </table>
    
     - If the language that you set in the browser settings is not a supported language of the API Publisher and/or the Developer Portal web application, "English" is set as the language by default in the web applications. 
    
    - Therefore, if you need to change the language and the language is not supported, make sure to [add the language](#adding-a-new-language) first before changing the browser language.


Set your browser language to a preferred language by following the user guide that corresponds to your browser. 

For example, let's assume that you are using Google Chrome, and let's change the browser language to "Spanish".

1. Navigate to the `chrome://settings/languages` URL in your browser.

     ![Chrome browser settings]({{base_path}}/assets/img/administer/chrome-set-language.png)

2. Add the highest preference to "Spanish", so that "Spanish" moves to the top of the language list.

3. Refresh the API Publisher web app.
     
     The text in the browser will be translated into Spanish. 
     

## Adding a new language

<div class="admonition info">
<p class="admonition-title">Info</p>
<p>
    All the text in the Developer Portal or the API Publisher are loaded via an external JSON file. These JSON files are asynchronously fetched from the browser based on the browser locale. The locale files are available in the following locations.

    <table>
    <tr>
    <td>
    Publisher 
    </td>
    <td>
    <code>&lt;APIM_HOME&gt;/repository/deployment/server/jaggeryapps/publisher/site/public/locales</code>
    </td>
    </tr>
    <tr>
    <td>
    Developer Portal
    <td> <code>&lt;APIM_HOME&gt;/repository/deployment/server/jaggeryapps/devportal/site/public/locales</code>
    </td>
    </tr>
    </table>
    
</p>
</div>

Follow the instructions below to add a new language to the Developer Portal or the API Publisher.

Let's add support for the French language to the Developer Portal.

1. Identify the two-letter locale code for the language that you want to add to the Developer Portal.
    
    The locale code for the French language is `fr`.

2. Make a copy of the `en.json` file and rename it based on the locale code.
    
     Rename the copy of the `<APIM_HOME>/repository/deployment/server/jaggeryapps/devportal/site/public/locales/en.json` file to `fr.json`.

    !!! info
        If you are setting the browser locale to a specific regional language, for example, French (Switzerland), the language with the regional code is `fr-ch`. In this scenario too the two letter locale code is `fr`, because WSO2 API Manager does not support regional language switching.

3. Change all the values that correspond to the key-value pairs to the language that you want to add to the Developer Portal.
     
     The JSON file (`<locale-code>.json`) has key-value pairs as follows:

    ```js
    "Apis.Details.ApiConsole.ApiConsole.title": "Try Out",
    "Apis.Details.ApiConsole.SelectAppPanel.applications": "Appplications",
    ```

    1. [Find the keys to modify](#finding-the-keys-to-modify).

    2. Convert each of the values into French.

### Finding the keys to modify

Sometimes going through the list of keys and modifying each of the values that correspond to a specific language is not going to be enough. You may need to find a key that is responsible for a particular text in the UI. Let’s consider the following scenario. 

Let's find the key for the main title named **APIs** in the following screen.

![Main title highlighted in the Developer Portal]({{base_path}}/assets/img/administer/find-key-01.png)

<div class="admonition tip">
<p class="admonition-title">Prerequisites</p>
<p>

<li> Chrome web browser.</li>
<li> <a href="https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en">React Developer Tools extension for Google Chrome</a>.</li>
</p>
</div>


1. Right-click over the title named **APIs** and select **Inspect Element**.

     ![Right click menu]({{base_path}}/assets/img/administer/find-key-02.png)

     The Chrome Developer Tools will open.

2. Click on **Components** and copy the ID of the text component.
	
     ![Inspect element window]({{base_path}}/assets/img/administer/find-key-03.png)
