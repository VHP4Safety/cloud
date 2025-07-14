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
                
                # Getting the main URL to the tool.
                main_url = data.get("url")
                if not main_url:
                    main_url = "no_url"
                
                # Getting the instance URL to the tool.
                # instance_url = data.get("instance").get("url")
                # if not instance_url: 
                #     instance_url = "no_url"
                
                # Check if 'screenshot' exists and is not empty
                screenshot_url = data.get('screenshot')
                if not screenshot_url:
                    screenshot_url = 'https://github.com/VHP4Safety/ui-design/blob/main/static/images/logo.png'
                    
                # Check if 'stage' exists and is not empty
                service_stage = data.get('stage')
                if not service_stage:
                    service_stage = 'Unknown'  # Default to 'Unknown' if no stage is found
                    
                # Check whether 'regulatory questions' exist and capture it if it exists.
                service_reg_q1a = data.get("regulatory-question").get("1a")
                service_reg_q1b = data.get("regulatory-question").get("1b")
                service_reg_q2a = data.get("regulatory-question").get("2a")
                service_reg_q2b = data.get("regulatory-question").get("2b")
                service_reg_q3a = data.get("regulatory-question").get("3a")
                service_reg_q3b = data.get("regulatory-question").get("3b")
                
#                if not service_reg_q1a:
#                    service_reg_q1a = "false"
#                
#                if not service_reg_q1b:
#                    service_reg_q1b = "false"
#                    
#                if not service_reg_q2a:
#                    service_reg_q2a = "false"
#                        
#                if not service_reg_q2b:
#                    service_reg_q2b = "false"
#
#                if not service_reg_q3a:
#                    service_reg_q3a = "false"
#
#                if not service_reg_q1a:
#                    service_reg_q3b = "false"

                services.append({
                    "service": service_name,
                    "description": description,
                    "html_name": f"{base_name}.html",
                    "md_file_name": f"{base_name}.md",
                    "png_file_name": screenshot_url,
                    "stage": service_stage,
                    "main_url": main_url,
                    "reg_q_1a": service_reg_q1a,
                    "reg_q_1b": service_reg_q1b,
                    "reg_q_2a": service_reg_q2a,
                    "reg_q_2b": service_reg_q2b,
                    "reg_q_3a": service_reg_q3a,
                    "reg_q_3b": service_reg_q3b,
                    # "instance_url": instance_url
                })
            except json.JSONDecodeError as e:
                print(f"Skipping invalid JSON file: {filename}")

# Sorting services in the alphabetical order.
services.sort(key=lambda x: x['service'].lower())

# Writing the output.
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(services, f, indent=2)
