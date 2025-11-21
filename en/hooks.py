import os
import json
from mkdocs.structure.nav import Section, Page, Link

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
    return config
