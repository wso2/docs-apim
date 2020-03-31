# All Partitions in a Single Server

#### Strategy 1: Local Registry

![]({{base_path}}/assets/attachments/21037149/21331970.png)
Figure 1: All registry partitions in a single server instance.

The entire registry space is local to a single server instance and not shared. This is recommended for a stand-alone deployment of a single product instance, but can also be used if there are two or more instances of a product that do not require sharing data or configuration among them.

This strategy requires no additional configuration.
