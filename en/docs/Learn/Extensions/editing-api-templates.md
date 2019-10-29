# Editing API Templates

Each API in API manager is represented by an XML file. The elements of this XML file and their attributes are defined in `<APIM_HOME>/repository/resources/api_templates/         velocity_template.xml` file, which is the default API template that comes with the API Manager. By editing the default template definitions, you can change the synapse configuration of all APIs that are created.

If you are using a distributed API Manager setup (i.e., Publisher, Devportal, Gateway and Key Manager components are running on separate JVMs), edit the template in the Publisher node.


