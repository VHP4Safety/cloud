import os
import json

# Paths
service_dir = 'docs/service'
output_dir = 'cap'
output_file = os.path.join(output_dir, 'service_index.json')

# Use a dictionary for services
services = {}

# Process each service JSON
for filename in os.listdir(service_dir):
    if filename.endswith('.json') and filename != 'template.json':
        filepath = os.path.join(service_dir, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            try:
                data = json.load(f)

                # Extract required fields
                service_id = data.get("id")   # unique key
                service_name = data.get("service")
                description = data.get("description")
                base_name = filename.replace('.json', '')

                # Main URL
                main_url = data.get("url") or "no_url"
                
                # Instance URL
                instance = data.get("instance", {})
                inst_url = instance.get("url") or "no_url"
                
                # Screenshot
                screenshot_url = data.get('screenshot') or \
                    'https://github.com/VHP4Safety/ui-design/blob/main/static/images/logo.png'

                # Stage
                service_stage = data.get('stage') or 'Unknown'

                # Regulatory questions (default "false")
                reg_q = data.get("regulatory-question", {})
                service_reg_q1a = reg_q.get("1a", "false")
                service_reg_q1b = reg_q.get("1b", "false")
                service_reg_q2a = reg_q.get("2a", "false")
                service_reg_q2b = reg_q.get("2b", "false")
                service_reg_q3a = reg_q.get("3a", "false")
                service_reg_q3b = reg_q.get("3b", "false")

                # Store entry in dict, keyed by service_id
                services[service_id] = {
                    "id": service_id,
                    "service": service_name,
                    "description": description,
                    "html_name": f"{base_name}.html",
                    "md_file_name": f"{base_name}.md",
                    "png_file_name": screenshot_url,
                    "stage": service_stage,
                    "main_url": main_url,
                    "inst_url": inst_url, 
                    "reg_q_1a": service_reg_q1a,
                    "reg_q_1b": service_reg_q1b,
                    "reg_q_2a": service_reg_q2a,
                    "reg_q_2b": service_reg_q2b,
                    "reg_q_3a": service_reg_q3a,
                    "reg_q_3b": service_reg_q3b,
                }

            except json.JSONDecodeError:
                print(f"Skipping invalid JSON file: {filename}")

# Sort alphabetically by "service" name (not by ID)
services = dict(sorted(services.items(), key=lambda item: item[1]['service'].lower()))

# Write output
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(services, f, indent=2)
