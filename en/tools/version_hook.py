#!/usr/bin/env python3
"""
MkDocs hook for version substitution in content.

This hook processes page content during the build process to replace version
placeholders with actual version numbers.
"""

import re
from mkdocs.plugins import BasePlugin
from mkdocs.config import config_options

class VersionSubstitutionHook:
    """Hook for processing version placeholders in page content."""
    
    def __init__(self, config):
        self.config = config
        self.site_version = config.get('extra', {}).get('site_version', 'latest')
        self.version_pattern = re.compile(r'\{\{site_version\}\}')
        
    def on_page_content(self, html, page, config, files):
        """Process page content to replace version placeholders."""
        if '{{site_version}}' in html:
            processed_html = self.version_pattern.sub(self.site_version, html)
            print(f"Processed version placeholders in: {page.file.src_path}")
            return processed_html
        return html

def on_page_content(html, page, config, files, **kwargs):
    """Global hook function for MkDocs."""
    hook = VersionSubstitutionHook(config)
    return hook.on_page_content(html, page, config, files)
