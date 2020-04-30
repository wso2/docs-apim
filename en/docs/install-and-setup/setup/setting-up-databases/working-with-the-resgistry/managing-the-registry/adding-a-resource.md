# Adding a Resource

You can add a resource to a certain collection for more convenient usage of the Registry.

Follow the instructions below to add a new child entry to a collection.

1. To add a new resource, click on the *Add Resource* link.

![]({{base_path}}/assets/attachments/126562631/126562638.png)

2. In the *Add Resource* panel, select *Method* from the drop-down menu.

The following methods are available:

-   **[Upload content from file](#AddingaResource-1)**
-   **[Import content from URL](#AddingaResource-2)**
-   **[Create Text content](#AddingaResource-3)**
-   **[Create custom content](#AddingaResource-4)**

![]({{base_path}}/assets/attachments/126562631/126562637.png)

### Uploading Content from File

1. If this method was selected, specify the following options:

-   File - The path of a file to fetch content (XML, WSDL, JAR etc.) Use the *Browse* button to upload a file.
-   Name - The unique name of a resource.
-   Media type **-** Can add a configured media type or leave this unspecified to enforce the default media type.
-   Description - The description of a resource.

2. Click *Add* once the information is added as shown in the example below.

![]({{base_path}}/assets/attachments/126562631/126562635.png)

### Importing Content from URL

1. If this method was selected, specify the following options:

-   URL - The full URL of the resource to fetch content from URL.
-   Name - The unique name of a resource.
-   Media type **-** Can add a configured media type or leave this unspecified to enforce the default media type.
-   Description - The description of a resource.

2. Click *Add* once the information is added.

![]({{base_path}}/assets/attachments/126562631/126562633.png)

### Text Content Creation

1. If this method was selected, specify the following options:

-   Name - The unique name of a resource.
-   Media type **-** Can add a configured media type or leave this unspecified to enforce the default media type.
-   Description - The description of a resource.
-   Content **-** The resource content. You can use either *Rich Text Editor* or *Plain Text Editor* to enter.

2. Click *Add* once the information is added.

![]({{base_path}}/assets/attachments/126562631/126562632.png)

### Custom Content Creation

1. If this method was selected, choose the *Media Type* from the drop-down menu and click *Create Content* .

![]({{base_path}}/assets/attachments/126562631/126562636.png)

**Media Types**

Each collection and resource created and stored on the repository has an associated media type. However, you also have the option to leave this unspecified enforcing the default media type. There are two main ways to configure media types for resources.

-   The first method is by means of a one-time configuration, which can be done by modifying the "mime.types" file found in &lt;CARBON\_HOME &gt;\\repository\\conf \\etc directory. This can be done just once before the initial start-up of the server
-   The second method is to configure the media types via the server administration console. The first method does not apply for collections, and the only available mechanism is to configure the media types via the server administration console.

Initially the system contains the media types defined in the mime.types file will be available for resources and a set of default media types will be available for collections.

Managing media types for resources can be done via the server administration console, by editing the properties of the /system/mime.types/index collection. This collection contains two resources, collection and custom.ui. To manage media types of collections and custom user interfaces, edit the properties of these two resources.
