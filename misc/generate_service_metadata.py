### Loading the necessary modules.
import os
import json

# Setting the paths to the service json files and the output file where the 
# meta-data will be stored. 
service_dir = 'docs/service'
output_dir  = 'cap'

output_file = os.path.join(output_dir, 'service_index.json')

# Creating an empty list to store the meta-data.
services = []

# Getting the meta-data for each service. 
for filename in os.listdir(service_dir):
    if filename.endswith('.json') and filename != 'template.json':
        filepath = os.path.join(service_dir, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            try:
                data = json.load(f)
                service_name = data.get('service')
                description = data.get('description')

                base_name = filename.replace('.json', '')
                
                # Check if 'screenshot' exists and is not empty
                screenshot_url = data.get('screenshot')
                if not screenshot_url:
                    screenshot_url = 'https://github.com/VHP4Safety/ui-design/blob/main/static/images/logo.png'
                    
                # Check if 'stage' exists and is not empty
                service_stage = data.get('stage')
                if not service_stage:
                    service_stage = 'Unknown'  # Default to 'Unknown' if no stage is found

                services.append({
                    "service": service_name,
                    "description": description,
                    "html_name": f"{base_name}.html",
                    "md_file_name": f"{base_name}.md",
                    "png_file_name": screenshot_url,
                    "stage": service_stage
                })
            except json.JSONDecodeError as e:
                print(f"Skipping invalid JSON file: {filename}")

# Sorting services in the alphabetical order.
services.sort(key=lambda x: x['service'].lower())

# Writing the output.
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(services, f, indent=2)

        