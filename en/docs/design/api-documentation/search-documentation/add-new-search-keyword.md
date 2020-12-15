# Add a New Search Keyword

WSO2 API Manager has [Apache Solr](https://lucene.apache.org/solr/) based indexing for API documentation content. It provides both the API Publisher and Developer Portal a full-text search facility to search through the API documentation, and find the documents and related APIs. The search syntax is `doc:keyword`. The search criteria looks for the keyword in any word/phrase in the documentation content and returns both the matching documents and associated APIs.

The following media types have Apache Solr based indexers by default, which are configured using the `<Indexers>` element in the `<APIM_HOME>/repository/conf/registry.xml` file.

-   Text : text/plain
-   PDF : application/pdf
-   MS word : application/msword
-   MS Powerpoint : application/vnd.ms-powerpoint
-   MS Excel : application/vnd.ms-excel
-   XML : application/xml

### Writing a custom index

In addition to the default indexes, you can write your own indexer implementation and register it as follows:

1.  Write a custom indexer.
    
     The following is the sample indexer code.

    ``` java
    package org.wso2.indexing.sample;

    import java.util.HashMap;
    import java.util.List;
    import java.util.Map;
    import java.util.Arrays;
    import org.apache.solr.common.SolrException;
    import org.wso2.carbon.registry.core.exceptions.RegistryException;
    import org.wso2.carbon.registry.core.utils.RegistryUtils;
    import org.wso2.carbon.registry.indexing.IndexingConstants;
    import org.wso2.carbon.registry.indexing.AsyncIndexer.File2Index;
    import org.wso2.carbon.registry.indexing.indexer.Indexer;
    import org.wso2.carbon.registry.indexing.solr.IndexDocument;

    public class PlainTextIndexer implements Indexer {
        public IndexDocument getIndexedDocument(File2Index fileData) throws SolrException,
                RegistryException {
                 
                 /* Create index document with resource path and raw content*/
                 IndexDocument indexDoc = new IndexDocument(fileData.path, RegistryUtils.decodeBytes(fileData.data), null);
                 
                 /* You can specify required field/value pairs for this indexing document.
                  * When searching we can query on these fields  */
                 Map<String, List<String>> fields = new HashMap<String, List<String>>();
                 fields.put("path", Arrays.asList(fileData.path));
                                         
                 if (fileData.mediaType != null) {
                             fields.put(IndexingConstants.FIELD_MEDIA_TYPE, Arrays.asList(fileData.mediaType));
                 } else {
                             fields.put(IndexingConstants.FIELD_MEDIA_TYPE, Arrays.asList("text/plain"));
                 }
                 
                 /* set fields for index document*/
                 indexDoc.setFields(fields);             
                 return indexDoc;
        }    
    }
    ```

2.  Add the custom indexer JAR file to the `<API-M_HOME>/repository/components/lib` directory.

3.  Add the `custom_indexer` element in the `<API-M_HOME>/repository/conf/deployment.toml` file with the new indexer as shown below.
    
     The content is indexed using this media type. 
     
     Example:

    ``` xml
    [[custom_indexers]]
    class = "org.wso2.indexing.sample.PlainTextIndexer"
    media_type_regex = "text/plain"
    ```
    The attributes of the above configuration are described below:

    |                                               |                                                                                                           |
    |-----------------------------------------------|-----------------------------------------------------------------------------------------------------------|
    | `class`| Java class name of the indexer.                                                                           |
    | `mefiaTypeRegEx` | A regular expression (regex) pattern to match the media type.                                             |
    | `profiles`| [API-M profiles]({{base_path}}/install-and-setup/deploying-wso2-api-manager/distributed-deployment/product-profiles/) in which the indexer is available. |

4.  Restart the server. 

     This will automatically update the `Indexers` section in the `<API-M_HOME>/repository/conf/registry.xml` file with the indexer.

    ``` xml
    <indexers>
            <indexer class="org.wso2.indexing.sample.PlainTextIndexer" mediaTypeRegEx="text/plain" profiles="default,api-devportal,api-publisher"/>
    </indexers>
    ```

5.  Add the API documentation using the new media type and thereafter search for some term in the documentation using the syntax (`doc:keyword`).

     You can now see how the documentation has got indexed according to the media type.
