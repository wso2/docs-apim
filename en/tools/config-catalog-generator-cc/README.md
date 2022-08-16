# API Manager Config Catalog Generator Tool

This is a tool to generate the markdown file of the Choreo Connect's configuration catalog by using a JSON file as the source.

## Instructions

1. Clone the `apim-docs` repo.
2. Navigate to the `docs-apim/en/tools/config-catalog-generator-cc` folder.
3. Run the following command:

    ```
    npm install
    ```

4. Open the `data\` add your content.
5. Come back to root folder (`docs-apim/en/tools/config-catalog-generator-cc`) and run the following command:

    ```
    npm run build
    ```

6. Go to the `dist/` folder: markdown files are created.
7. Copy the these files to the `en/docs/deploy-and-publish/deploy-on-gateway/choreo-connect/configurations` folder.
