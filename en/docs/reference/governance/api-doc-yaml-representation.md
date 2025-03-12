# API Documentation YAML Representation

For governing each API's documentation, the WSO2 API Manager arranges API documentation metadata in the following structured manner:


```yaml
count: 3 # Total number of documents attached to the API.
docs:
  - type: "document" # The type of document, usually "document" for text-based documents.
    version: "v4.5.0" # The version of the API manager.
    data:
      documentId: "62b16c62-67c8-4716-8144-322c9d64ef2c" # Unique identifier for the document. This is a UUID string.
      name: "How to document" # The name or title of the document.
      type: "HOWTO" # The type of document. Can be one of the following: 
        # - HOWTO
        # - SAMPLES
        # - PUBLIC_FORUM
        # - SUPPORT_FORUM
        # - API_MESSAGE_FORMAT
        # - SWAGGER_DOC
        # - OTHER
      summary: "how to doc" # A brief summary or description of the document's content.
      sourceType: "MARKDOWN" # Specifies the source type of the document. Possible values are:
        # - INLINE: The content is provided directly in the API.
        # - MARKDOWN: Content is provided in Markdown format.
        # - URL: Document is sourced from an external URL.
        # - FILE: Content is sourced from a file (could be a binary or text file).
      content: "This is a how to document" # The actual content of the document if the sourceType is INLINE or MARKDOWN.
      sourceUrl: "https://github.com" # URL to the document if the sourceType is URL.
      fileName: "document.txt" # Name of the file if the sourceType is FILE.
      inlineContent: "This is the content of the document." # The inline content of the document when sourceType is INLINE.
      otherTypeName: ".txt" # The file extension when sourceType is OTHER (e.g., .txt, .pdf, etc.).
      visibility: "API_LEVEL" # The visibility of the document. Possible values are:
        # - OWNER_ONLY: Only the owner can view the document.
        # - PRIVATE: Document is private and may be shared with specific users.
        # - API_LEVEL: Document is visible to the API consumers at a global level.
      createdTime: "2025-03-09T00:00:00Z" # Timestamp of when the document was created.
      createdBy: "admin" # The creator of the document.
      lastUpdatedTime: "2025-03-10T00:00:00Z" # Timestamp of the last update to the document.
      lastUpdatedBy: "admin" # The last person who updated the document.
```