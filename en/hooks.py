import os
import json
import yaml
from mkdocs.structure.nav import Section, Page, Link

def load_redirects():
    """Load redirects from external redirects.yml file"""
    redirects_path = os.path.join(os.getcwd(), 'redirects.yml')
    redirects_dict = {}
    
    if os.path.exists(redirects_path):
        with open(redirects_path, 'r') as f:
            redirects_content = f.read()
            
        # Parse the redirects file
        for line in redirects_content.strip().split('\n'):
            if line.strip() and ':' in line:
                # Parse the line manually since it's single quotes
                parts = line.split("': '", 1)
                if len(parts) == 2:
                    key = parts[0].strip().strip("'")
                    value = parts[1].strip().strip("'")
                    redirects_dict[key] = value
    
    return redirects_dict

def parse_json(file_path):
    features_to_remove = {"feature": {}, "page": []}
    with open(file_path, 'r') as json_file:
         parse_data = json.load(json_file)
         for feature, details in parse_data.items():
            enabled = details['enabled']
            page = details['page']
            features_to_remove['feature'][feature] = enabled
            
            if not enabled:
                features_to_remove['page'].extend(page)
    json_file.close()
    return features_to_remove

    files_to_remove = parse_json(os.path.join(os.getcwd(),'features.json'))

def on_files(files, config):
    if os.getenv("ENABLE_HOOKS") == "true":
        files_to_remove = parse_json(os.path.join(os.getcwd(),'features.json'))
        for file in list(files):
            if file.src_uri in files_to_remove['page']:
                files.remove(file)
        return files

def remove_nav_item(nav_items):
    filtered_items = []
    files_to_remove = parse_json(os.path.join(os.getcwd(),'features.json'))
    for item in nav_items:
        if isinstance(item, dict):
            if any(page in item.values() for page in files_to_remove['page']):
                continue        
            for key, value in item.items():
                if isinstance(value, list):
                    value = remove_nav_item(value)
                item[key] = value
            item = {k: v for k, v in item.items() if not (isinstance(v, list) and not v)}
            if item:
                filtered_items.append(item)
        elif isinstance(item, list):
            if item:
                filtered_items.append(item)
    return filtered_items

def on_config(config):
    enable_hooks = os.getenv("ENABLE_HOOKS")
    files_to_remove = parse_json(os.path.join(os.getcwd(),'features.json'))
    for feature, enabled in files_to_remove['feature'].items():
        config[feature] = enabled if enable_hooks else True
    if enable_hooks:
        config['nav'] = remove_nav_item(config['nav'])
    
    # Load redirects from external file and inject into the plugin
    redirects = load_redirects()
    if redirects:
        print(f"✓ Loading {len(redirects)} redirects from redirects.yml")
        
        # Get site_url from config and replace {{SITE_URL}} placeholder in redirects
        site_url = config.get('site_url', '').rstrip('/')
        
        # Replace {{SITE_URL}} placeholder with actual site_url in all redirect targets
        processed_redirects = {}
        for old_path, new_url in redirects.items():
            # Replace the placeholder with site_url
            processed_redirects[old_path] = new_url.replace('{{SITE_URL}}', site_url)
        
        # Access the redirects plugin instance and update its config
        if 'redirects' in config['plugins']:
            redirects_plugin = config['plugins']['redirects']
            if hasattr(redirects_plugin, 'config'):
                redirects_plugin.config['redirect_maps'].update(processed_redirects)
                print(f"✓ Injected {len(processed_redirects)} redirects into redirects plugin (using site_url: {site_url})")
    
    return config
