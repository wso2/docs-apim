# Redirects Configuration

## Overview

The redirects for this MkDocs documentation are now maintained in a separate file to keep `mkdocs.yml` clean and manageable.

## Files

- **`redirects.yml`**: Contains all redirect mappings
- **`hooks.py`**: Loads redirects from `redirects.yml` during build
- **`mkdocs.yml`**: References the redirects plugin with empty redirect_maps

## How It Works

1. All redirect mappings are stored in `redirects.yml` in the format:
   ```yaml
   'old/path.md': '{{SITE_URL}}/new/path/'
   ```
   
   **Note**: The `{{SITE_URL}}` placeholder in `redirects.yml` is automatically replaced with the `site_url` from `mkdocs.yml` at build time. This allows the same redirect file to work across different environments (local development, staging, production).

2. The `hooks.py` file contains a `load_redirects()` function that:
   - Reads the `redirects.yml` file
   - Parses the redirect mappings
   - Replaces the `{{SITE_URL}}` placeholder with the `site_url` from `mkdocs.yml`
   - Injects the processed redirects into the MkDocs configuration during build

3. The `on_config` hook in `hooks.py` loads the redirects and updates the `redirects` plugin configuration.

## Adding New Redirects

To add a new redirect, simply add a line to `redirects.yml`:

```yaml
'old-page-path.md': '{{SITE_URL}}/destination/'
```

The format is:
```
'<source-path>': '{{SITE_URL}}/<destination-path>'
```

**Important**: Always use the `{{SITE_URL}}` placeholder instead of hardcoding the base URL. This ensures the redirects work correctly across all environments.

## Testing

Build the documentation to verify redirects work correctly:

```bash
python3 -m mkdocs build --clean
```

Or serve locally:

```bash
python3 -m mkdocs serve
```

## Notes

- The redirects are loaded automatically during MkDocs configuration
- No additional plugins are required beyond `mkdocs-redirects`
- The solution uses the existing `hooks.py` infrastructure
- Commented lines (starting with ##) in redirects.yml are preserved but ignored
