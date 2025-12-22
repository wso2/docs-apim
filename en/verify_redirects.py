import yaml
import requests
import sys
from urllib.parse import urljoin

# --- CONFIGURATION ---
REDIRECTS_FILE = 'redirects.yml'
# Ensure this matches your running local server base URL
# The script will replace {{SITE_URL}} with this value.
LOCAL_HOST_URL = 'http://localhost:8000/en/4.6.0/' 
# ---------------------

def normalize_target_to_url(base_url, target_path):
    """
    Constructs the full URL.
    - Replaces {{SITE_URL}} placeholder with the actual base URL.
    - Handles absolute external URLs (http/https).
    - Ensures directory-style URLs (ending in /).
    """
    target_path = target_path.strip()
    
    # 1. Handle Placeholder Replacement
    if '{{SITE_URL}}' in target_path:
        # Remove the placeholder and any leading slash from the remaining path
        # to prevent double slashes when joining.
        clean_target = target_path.replace('{{SITE_URL}}', '').lstrip('/')
        
        # Ensure base_url ends with a slash for clean joining
        if not base_url.endswith('/'):
            base_url += '/'
            
        full_url = base_url + clean_target

    # 2. External URLs without placeholder: Return as-is
    elif target_path.startswith(('http://', 'https://')):
        return target_path

    # 3. Relative paths (fallback, though your file seems to use placeholders)
    else:
        clean_base = base_url.rstrip('/')
        clean_target = target_path.lstrip('/')
        full_url = f"{clean_base}/{clean_target}"

    # 4. Ensure trailing slash for directory paths 
    # (unless it's a file like .png or has query parameters/fragments)
    if not full_url.endswith('/') and '.' not in full_url.split('/')[-1] and '?' not in full_url and '#' not in full_url:
        full_url += '/'
    elif full_url.endswith('.md'):
        full_url = full_url.replace('.md', '/')
        
    return full_url

def check_target_url(source_key, target_value):
    full_url = normalize_target_to_url(LOCAL_HOST_URL, target_value)

    try:
        # Request the Destination Page
        response = requests.get(full_url, timeout=10)

        # Verify Status Code (200 OK)
        if response.status_code == 200:
            # Check for Soft 404 (MkDocs specific "Page not found" content)
            if "page not found" in response.text.lower():
                print(f"[FAIL] Soft 404: {full_url}")
                print(f"       (Source: {source_key})")
                return False
            else:
                print(f"[OK] {full_url}")
                return True
                
        elif response.status_code == 404:
            print(f"[FAIL] 404 Not Found: {full_url}")
            print(f"       (Source: {source_key})")
            return False
            
        else:
            print(f"[FAIL] Status {response.status_code}: {full_url}")
            return False

    except requests.exceptions.RequestException as e:
        print(f"[ERROR] Connection Error for {full_url}: {e}")
        return False

def main():
    print(f"--- Verifying Redirect Targets against {LOCAL_HOST_URL} ---")
    
    try:
        with open(REDIRECTS_FILE, 'r') as f:
            # Load the flat dictionary structure
            redirects_map = yaml.safe_load(f)
    except FileNotFoundError:
        print(f"Error: Could not find {REDIRECTS_FILE}")
        sys.exit(1)
    except Exception as e:
        print(f"Error parsing YAML: {e}")
        sys.exit(1)

    if not redirects_map:
        print(f"No redirects found in {REDIRECTS_FILE}.")
        sys.exit(0)

    print(f"Found {len(redirects_map)} targets to verify.\n")

    failed_count = 0
    for source, target in redirects_map.items():
        if not check_target_url(source, target):
            failed_count += 1

    print("-" * 40)
    print(f"Summary: Total {len(redirects_map)} | Failed {failed_count}")
    
    if failed_count > 0:
        sys.exit(1)

if __name__ == "__main__":
    main()