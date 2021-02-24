# API Manager Config Catalog Generator Tool

This is a tool to generate the markdown file of the API Manager server's configuration catalog by using a JSON file as the source.

## Instructions

1. Clone the `apim-docs` repo.
2. Navigate to the `docs-apim/en/tools/config-catalog-generator` folder.
3. Run the following command:

    ```
    npm install
    ```

4. Open the `data\config.json` file add your content.
5. Come back to root folder (`docs-apim/en/tools/config-catalog-generator`) and run the following command:

    ```
    npm run build
    ```

6. Go to the `dist/` folder: A markdown file named `config-catalog.md` is created.
7. Copy the `config-catalog.md` file to the `docs-apim/en/docs/eference` folder.

