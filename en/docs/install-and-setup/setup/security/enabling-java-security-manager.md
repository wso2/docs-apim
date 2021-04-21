# Enabling Java Security Manager

The Java Security Manager is used to define various security policies that prevent untrusted code from manipulating your system. Enabling the Java Security Manager for WSO2 products activates the Java permissions that are in the `<API-M_HOME>/repository/conf/sec.policy` file. You modify this file to change the Java security permissions as required.

!!! info
    **Before you begin**

    * Ensure that you have Java 1.8 or Java 11 installed.
    * Note that you need to use a keystore for signing JARs using the Java security manager. In this example, you will be using the default keystore in your WSO2 product ( `wso2carbon.jks` ). You can read about the recommendations for using keystores from [here]({{base_path}}/administer/product-security/configuring-keystores/keystore-basics/about-asymetric-cryptography/).


The steps below show how to enable the Java Security Manager for WSO2 products.

1.  Download the WSO2 product to any location (e.g., `<HOME>/user/<product-pack>` folder).

2. Run the startup script in the `<API-M_HOME>/bin` folder. For Linux, it is `api-manager.sh`. Once the product is up and running, shutdown the server.

3.  To sign the JARs in your product, you need a key. You can generate a new keystore (with a new key) by executing the keytool command given below. Note that the new keystore is created in the directory from which you execute the keytool command.

    ```bash
    keytool -genkey -alias signFiles -keyalg RSA -keystore signkeystore.jks -validity 3650 -dname "CN=John,OU=Engineering, O=WSO2, L=Colombo, ST=Western, C=LK"
    Enter keystore password:  
    Re-enter new password:
    Enter key password for
    (RETURN if same as keystore password)
    ```

    Now you have a new keystore (`signkeystore.jks`) with a new public key certificate (`signFiles`).

4.  By default, WSO2 products use the default `wso2carbon.jks` keystore for signing JARs. This keystore is stored in the `<API-M_HOME>/repository/resources/security` directory.      Therefore, you need to add the `signFiles` public key certificate that you created earlier into the `wso2carbon.jks` keystore.

    First, export the `signFiles` public key certificate from the `signkeystore.jks` keystore by executing the following command:

    ```java
    $ keytool -export -keystore signkeystore.jks -alias signFiles -file sign-cert.cer 
    ```

    Then, import the same `signFiles` certificate to the `wso2carbon.jks` keystore by executing the command given below. Be sure to specify the correct directory path to the `wso2carbon.jks` file of your product.

    ```bash
    $ keytool -import -alias signFiles -file sign-cert.cer -keystore <PATH_to_API-M_HOME>/repository/resources/security/wso2carbon.jks
    Enter keystore password:  
    Owner: CN=John, OU=Engineering, O=WSO2, L=Colombo, ST=Western, C=LK
    Issuer: CN=John, OU=Engineering, O=WSO2, L=Colombo, ST=Western, C=LK
    Serial number: 5486f3b0
    Valid from: Tue Dec 09 18:35:52 IST 2014 until: Fri Dec 06 18:35:52 IST 2024
    Certificate fingerprints:
    MD5:  54:13:FD:06:6F:C9:A6:BC:EE:DF:73:A9:88:CC:02:EC
    SHA1: AE:37:2A:9E:66:86:12:68:28:88:12:A0:85:50:B1:D1:21:BD:49:52
    Signature algorithm name: SHA1withRSA
    Version: 3
    Trust this certificate? [no]:  yes
    Certificate was added to keystore
    ```

    !!! note
        Note that WSO2 no longer recommends MD5 for JAR signing due to cryptographic limitations.

5.  Prepare the scripts to sign the JARs and **grant them the required permission**(e.g., `sudo chmod 755 signJar.sh`). For example, the `signJar.sh` script given below can be used to sign each JAR file separately or you can use the `signJars.sh` script, which runs a loop to read all JARs and sign them.

    **signJar.sh script**

    ``` bash
    #!/bin/bash
    set -e
    jarfile=$1
    keystore_file="signkeystore.jks"
    keystore_keyalias='signFiles'
    keystore_storepass='wso2123'
    keystore_keypass='wso2123'
    signjar="$JAVA_HOME/bin/jarsigner -keystore $keystore_file -storepass $keystore_storepass -keypass $keystore_keypass"
    verifyjar="$JAVA_HOME/bin/jarsigner -keystore $keystore_file -verify"
    echo "Signing $jarfile"
    $signjar $jarfile $keystore_keyalias
    echo "Verifying $jarfile"
    $verifyjar $jarfile
    # Check whether the verification is successful.
    if [ $? -eq 1 ]
    then
        echo "Verification failed for $jarfile"
    fi
    ```

    **signJars.sh script**

    ``` bash
    #!/bin/bash
    if [[ ! -d $1 ]]; then
        echo "Please specify a target directory"
        exit 1
    fi
    for jarfile in `find . -type f -iname \*.jar`
    do
        ./signJar.sh $jarfile
    done 
    ```

6.  Execute the following commands to sign the JARs in your product:

    ``` java
    ./signJars.sh /HOME/user/<product-pack>
    ```

    !!! tip
        Every time you add an external JAR to the WSO2 product, sign them manually using the above instructions for the Java Security Manager to be effective. You add external JARs to the server when extending the product, applying patches etc.

7.  Open the startup script in the `<API-M_HOME>/bin` folder. For Linux, it is `api-manager.sh`.
8.  Add the following system properties to the startup script and save the file. Add them before the `org.wso2.carbon.bootstrap.Bootstrap $*` line.

    ``` java
    -Djava.security.manager=org.wso2.carbon.bootstrap.CarbonSecurityManager \
    -Djava.security.policy=$CARBON_HOME/repository/conf/sec.policy \
    -Drestricted.packages=sun.,com.sun.xml.internal.ws.,com.sun.xml.internal.bind.,com.sun.imageio.,org.wso2.carbon. \
    -Ddenied.system.properties=javax.net.ssl.trustStore,javax.net.ssl.trustStorePassword,denied.system.properties \
    ```

9.  Create a `sec.policy` file with the required security policies in the `<API-M_HOME>/repository/conf` folder and start the server. Starting the server makes the Java permissions defined in the `sec.policy` file to take effect.

An example of a `sec.policy` file is given below. It includes mostly WSO2 Carbon-level permissions.

``` text
keystore "file:${user.dir}/repository/resources/security/wso2carbon.jks", "JKS";

grant {
  permission java.net.SocketPermission "*:1-65535", "connect,resolve";
  permission java.lang.RuntimePermission "accessClassInPackage.org.wso2.carbon.context";
  permission java.lang.RuntimePermission "accessClassInPackage.org.wso2.carbon.registry.api";
  permission java.lang.RuntimePermission "accessClassInPackage.org.wso2.carbon.registry.core";
  permission java.lang.RuntimePermission "accessClassInPackage.org.wso2.carbon.user.api";
  permission java.lang.RuntimePermission "accessClassInPackage.org.wso2.carbon.user.core";
  permission java.lang.RuntimePermission "accessClassInPackage.org.wso2.carbon.authenticator.stub";
  permission java.lang.RuntimePermission "accessClassInPackage.org.wso2.carbon.core.common";
  permission java.lang.management.ManagementPermission "control";
  permission java.lang.RuntimePermission "getClassLoader";
  permission java.lang.RuntimePermission "setContextClassLoader";
  permission java.lang.reflect.ReflectPermission "suppressAccessChecks";
  permission java.lang.RuntimePermission "accessDeclaredMembers";
  permission java.util.PropertyPermission "*", "read";
  permission java.lang.RuntimePermission "accessClassInPackage.sun.misc";
  permission java.lang.RuntimePermission "accessClassInPackage.sun.security.util";
  permission java.lang.RuntimePermission "modifyThreadGroup";
  permission java.io.FilePermission "*", "read";
};

grant signedBy "signfiles" {
  permission java.security.AllPermission;
};

grant codeBase "file:${user.dir}/repository/deployment/server/-" {
  permission java.security.AllPermission;
};

grant signedBy "signfiles",  codeBase "file:${user.dir}/bin/" {
  permission java.security.AllPermission;
};

grant codeBase "file:${java.home}/lib/-" {
  permission java.security.AllPermission;
};

grant codeBase "file:${java.home}/jre/lib/ext/-" {
  permission java.security.AllPermission;
};

grant codeBase "file:${java.home}/../lib/-" {
  permission java.security.AllPermission;
};

grant codeBase "file:${java.home}/lib/ext/-" {
  permission java.security.AllPermission;
};
grant codeBase "file:${java.home}/../lib/-" {
  permission java.security.AllPermission;
};

grant codeBase "file:${java.home}/lib/ext/-" {
  permission java.security.AllPermission;
};

```


