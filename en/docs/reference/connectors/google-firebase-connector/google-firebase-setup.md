# Setting up Google Firebase Environment 

1. Open up [Firebase Console](https://console.firebase.google.com/) and log in.
2. Add a Firebase project. The **Add project** dialog also gives you the option to add Firebase to an existing Google Cloud Platform project.
    <img src="../../../../assets/img/connectors/add-firebase-project.png" title="Add Firebase project" width="400" alt="Add Firebase project"/>
3. Navigate to the [Service Accounts](https://console.firebase.google.com/project/teststatusapp/settings/serviceaccounts/adminsdk) tab in your project's settings page.
4. Click the **Generate New Private Key** button at the bottom of the **Firebase Admin SDK** section of the **Service Accounts** tab.
    <img src="../../../../assets/img/connectors/get-firebase-credentials.png" title="Get Firebase credentials" width="600" alt="Get Firebase credentials"/>

    After you click the button, a JSON file containing your service account's credentials will be downloaded. You'll need information in this file to initialize the Google Firebase Connector in the [integration scenario](google-firebase-connector-example.md) you are going to build next. 
  
