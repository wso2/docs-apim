# Connecting to MSMQ

This section describes how to configure WSO2 Micro Integrator to connect with Microsoft Message Queuing (MSMQ).

!!! Info
    The setup instruction here are only applicable for Windows environments since we invoke Microsoft C++ API for MSMQ via JNI invocations.

The **msmq:** component is a transport for working with MSMQ. This component natively sends and receives directly allocated ByteBuffer instances allowing access to the JNI layer without memory copying. Using the **ByteBuffer** created with the **allocateDirect** method, the native code can directly access the memory. URI format is [msmq:msmqQueueName](http://msmqmsmqQueueName).

Follow the steps below to set up and configure WSO2 Micro Integrator with MSMQ.

1.	Download the [axis2-transport-msmq-2.0.0-wso2v2.jar](https://github.com/wso2-docs/WSO2_EI/raw/master/Broker-Setup-Artifacts/MSMQ/axis2-transport-msmq-2.0.0-wso2v2.jar) file and add it to the `MI_HOME/dropins` directory. This file provides the JNI invocation required by MSMQ bridging.
2.	Install Visual C++ 2008 (VC9). It works with Microsoft Visual Studio 2008 Express.
3.	Set up MSMQ on a Windows environment. For setup instructions, refer to: [http://msdn.microsoft.com/en-us/library/aa967729.aspx](http://msdn.microsoft.com/en-us/library/aa967729.aspx).
4.	Download and install WSO2 Micro Integrator.

## Setting up the JMS Listener and Sender
5. Add the following configuration to `MI_HOME/conf/depployment.toml` file to enable MSMQ listeners and senders.
   ```toml
   [transport.msmq]
   listener.enable = true
   listener.hostname = "localhost"
   
   sender.enable = true
   ```

!!! Info
    If you get an error message similar to the following when you start the Micro Integrator after configuring the JMS transport with MSMQ, you must check whether the `msvcr100d.dll` file is available in the `C:\Windows\System32` directory. If the file is not available, you need to download the file and copy it to the `C:\Windows\System32` directory.
    ```bash
    ERROR - NativeWorkerPool Uncaught exception
    java.lang.UnsatisfiedLinkError: no msmq_native_support in java.library.path
    ```
You now have instances of MSMQ and WSO2 MI configured, up and running. Next, refer [JMS Consumer]({{base_path}}/integrate/examples/jms_examples/consuming-jms) and [JMS Producer]({{base_path}}/integrate/examples/jms_examples/producing-jms) section for implementation details of JMS consumer and producer.