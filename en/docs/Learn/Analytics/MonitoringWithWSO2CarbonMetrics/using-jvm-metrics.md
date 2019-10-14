# Using JVM Metrics

JVM metrics are Java metrics enabled by default in WSO2 products for the purpose of monitoring general statistics related to the server performance. Follow the procedure below to view the JVM metrics dashboard for a WSO2 product.

!!! info
For detailed instructions to enable/disable JVM metrics and to configure metrics, see [Enabling Metrics and Storage Types](_Enabling_Metrics_and_Storage_Types_) .


1.  Log into the Management Console of the WSO2 product. Click **Monitor -&gt; Metrics -&gt; JVM Metrics** to open the **View Metrics** page.
2.  Specify the source for the JVM metrics by selecting a value from the drop-down list for the **Source** parameter in the top panel.
    ![]({{base_path}}/assets/attachments/103335175/103335185.png)
3.  Specify the time interval for which the statistics should be displayed in the dashboard by selecting a value from the following drop-down list in the top panel.
    ![]({{base_path}}/assets/attachments/103335175/103335184.png)
4.  Click the required buttons opposite **Views** in the top panel to select the types of information you want to view in the dashboard, and refresh the web page.
    ![]({{base_path}}/assets/attachments/103335175/103335183.png) Statistics corresponding to each button can be viewed as follows:
    -   **CPU
        ** Click this button to view statistics relating to the CPU as shown below.
        ![]({{base_path}}/assets/attachments/103335175/103335182.png)
        ![]({{base_path}}/assets/attachments/103335175/103335181.png)
    -   **Memory**
        Click **Memory** to view statistics relating to the memory as shown below.
        ![]({{base_path}}/assets/attachments/103335175/103335180.png) ![]({{base_path}}/assets/attachments/103335175/103335179.png)
    -   **Threading
        ** Click **Threading** to **view statistics relating to** threading as shown below.
        ![]({{base_path}}/assets/attachments/103335175/103335178.png)
    -   **Class Loading
        ** Click **Class Loading** to view statistics relating to class loading as shown below.
        ![]({{base_path}}/assets/attachments/103335175/103335177.png)
    -   **File Descriptor
        ** Click **File Descriptor** to view information relating to the file descriptor count as shown below.
        ![]({{base_path}}/assets/attachments/103335175/103335176.png)

