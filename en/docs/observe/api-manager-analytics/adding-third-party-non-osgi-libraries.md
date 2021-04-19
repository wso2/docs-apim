# Adding Third Party Non OSGi Libraries

The API Manager Analytics distribution is OSGi-based. Therefore, when you integrate third party products such as MySQL with the API Manager Analytics, you need to check whether the libraries you need to add to the Streaming Integrator are OSGi-based. If they are not, you need to convert them to OSGi bundles before adding them to the `<API-M_ANALYTICS_HOME>/lib` directory.

To convert JAR files to OSGi bundles, follow the procedure given below:

1. Download the non-OSGi JAR for the required third party product, and save it in a preferred directory in your machine.

2. In your CLI, navigate to the `<API-M_ANALYTICS_HOME>/bin` directory. Then issue the following command.
     -   On Windows: `jartobundle.bat <PATH_TO_NON-OSGi_JAR> ../lib --run`
     -   On Linux/Mac OS: `sh jartobundle.sh <PATH_TO_NON-OSGi_JAR> ../lib`
      
    This generates the converted file in the `<API-M_ANALYTICS_HOME>/lib` directory.

3. Restart the API Manager Analytics server.