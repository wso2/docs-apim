"""
MkDocs plugin to create .nojekyll file for GitHub Pages
"""
import os
from mkdocs.plugins import BasePlugin

class NoJekyllPlugin(BasePlugin):
    def on_post_build(self, config):
        """Create .nojekyll file in the site directory after build"""
        site_dir = config['site_dir']
        nojekyll_path = os.path.join(site_dir, '.nojekyll')
        
        # Create .nojekyll file
        with open(nojekyll_path, 'w') as f:
            f.write('')
        
        print(f"Created .nojekyll file at: {nojekyll_path}")
        return config

def on_post_build(config):
    """Hook function to create .nojekyll file"""
    site_dir = config['site_dir']
    nojekyll_path = os.path.join(site_dir, '.nojekyll')
    
    # Create .nojekyll file
    with open(nojekyll_path, 'w') as f:
        f.write('')
    
    print(f"Created .nojekyll file at: {nojekyll_path}")