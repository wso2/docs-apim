import os

directory = "/Users/hesandaliyanage/wso2 documentation fix/docs-apim/en/docs"

replacements = {
    # Wso2 casing
    "Wso2": "WSO2",

    # a API -> an API
    "a API document": "an API document",
    "a API associated": "an API associated",
    "a API Policy": "an API Policy",
    "a API Manager environment": "an API Manager environment",
    
    # allows to -> allows you to
    "allows to generate": "allows you to generate",
    "allows to log": "allows you to log",
    "allows to configure": "allows you to configure",
    
    # comprises of -> comprises
    "comprises of client": "comprises the client",
    "comprises of a policy": "comprises a policy",

    # an user, an username -> a
    "an user": "a user",
    "an username": "a username",
}

count = 0
for root, _, files in os.walk(directory):
    for filename in files:
        if filename.endswith(".md") or filename.endswith(".yaml"):
            filepath = os.path.join(root, filename)
            with open(filepath, 'r') as f:
                content = f.read()
            
            new_content = content
            for old_str, new_str in replacements.items():
                new_content = new_content.replace(old_str, new_str)
            
            if new_content != content:
                with open(filepath, 'w') as f:
                    f.write(new_content)
                count += 1
                
print(f"Modified {count} files.")
