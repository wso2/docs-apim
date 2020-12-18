# Setting up the AS400 PCML Environment  

The AS400 PCML connector allows you to access RPG programs that are available on AS400 (renamed as IBM iSeries) servers using WSO2 EI. This is done using [Program Call Markup Language](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzahh/pcml.htm) (PCML). 

you need to have access to an IBM iSeries server. If you do not have an on-premise IBM iSeries server, go to public IBM iSeries server, and create a [public IBM iSeries server](https://pub400.com/) account.

The connector uses the IBM JTOpen library for all its operations. Copy the **jt400.jar** to `<ESB_HOME>/repository/components/lib` folder. You can download the IBM JTOpen library from (here)[https://sourceforge.net/projects/jt400/].

### Setting up public IBM iSeries server

Follow the steps below to create public IBM iSeries server.

1. Go to [https://pub400.com](https://pub400.com/) and click the **Sign up** button.

    <img src="../../../../assets/img/connectors/as400-signup.png" title="AS400-signup page" width="600" alt="AS400-signup page"/>
    
1. Go to [https://pub400.com](https://pub400.com/) and click the **Sign up** button.

    <img src="../../../../assets/img/connectors/as400-signup-details.png" title="AS400-signup details" width="600" alt="AS400-signup details"/>
    
3. You will receive an email response with the client credentials to your email account (it will take a few hours).

4. Navigate in to the [IBM i Access - Client Soluthetions](https://www.ibm.com/support/pages/ibm-i-access-client-solutions) page. IBM i Access Client Solutions consolidates the most commonly used tasks for managing your IBM i into one simplified location. 

5. Download the **IBM i Access Client Solutions**.

    <img src="../../../../assets/img/connectors/as400-ibm-client-access.png" title="IBM i Access Client Solutions" width="600" alt="IBM i Access Client Solutions"/>

6. Extract the downloaded .zip file and install it.

7. Start the IBM I access client solution.
   
    <img src="../../../../assets/img/connectors/as400-ibm-client-access-homepage.png" title="IBM i Access Client Solutions start" width="600" alt="IBM i Access Client Solutions start"/>

8. Click **System Configurations** section under **Management** section. 

    <img src="../../../../assets/img/connectors/as400-system-configuration.png" title="IBM i Access system-configuration" width="500" alt="IBM i Access system-configuration"/>

9. The following window appears system configuration parameters. Click the **New** button.
  
    <img src="../../../../assets/img/connectors/as400-ibm-add-new-system.png" title="IBM i Access add new system" width="600" alt="IBM i Access add new system"/>

10. Add the required details. Add the **System name** and **Description** under General tab. In this sample we use `pub400.com` as the **System name**.

    <img src="../../../../assets/img/connectors/as400-ibm-add-systemname.png" title="IBM i Access add new system name" width="600" alt="IBM i Access add new system name"/>

11. Add the **Default username** and **port** number under the **Connection** tab. In this sample we need to use `port` number as `23`. Click **OK**.

    <img src="../../../../assets/img/connectors/as400-ibm-port-and-username.png" title="IBM i Access add port number" width="600" alt="IBM i Access add port number"/>

12. After setting up the configuration we can use the **5250 Emulator**. Click the **5250 Emulator** link under the **General** section.

    <img src="../../../../assets/img/connectors/as400-ibm-5250-emulator.png" title="IBM 5250-emulator" width="600" alt="IBM 5250-emulator"/>

13. When you click this emulator you need to add the username and password you got in step 3. Then you will see the following window.   

    <img src="../../../../assets/img/connectors/as400-pub400-server-window.png" title="PUB400 server command line view" width="600" alt="PUB400 server command line view"/>
 
14. You need to add the same user name and password you got in the step 3.

15. Now you can see the following **IBM i Main Menu**.

    <img src="../../../../assets/img/connectors/as400-ibm-i-main-menu.png" title="IBM i Main Menu" width="600" alt="IBM i Main Menu"/>

To configure the AS400 PCML connector, you will be required AS400 public server `username` and `password`.