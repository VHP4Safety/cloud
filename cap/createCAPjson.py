# This script creates the json cache file of the central access point (https://github.com/VHP4Safety/ui-design)
# It is used by Github Action: 
import requests
import os
import json
import fnmatch
import datetime


# Github API link to receive the list of the services on the cloud repo:
url = f'https://api.github.com/repos/VHP4Safety/cloud/contents/docs/service'
response = requests.get(url)

# Checking if the request was successful (status code 200).
if response.status_code == 200:
    #print(response.json())
    # Extracting the list of files.
    service_content = response.json()

    # Separating .json and .md files.
    json_files = {file['name']: file for file in service_content if file['type'] == 'file' and file['name'].endswith('.json')}
    md_files = {file['name']: file for file in service_content if file['type'] == 'file' and file['name'].endswith('.md')}
    png_files = {file['name']: file for file in service_content if file['type'] == 'file' and file['name'].endswith('.png')}

    # Creating an empty list to store the results. 
    writejson = {} 
    writejson["metadata"] = {}
    writejson["data"] = {}
    writejson["metadata"]["datetime"] =  str(datetime.datetime.now())
    print("writejson:")
    print(writejson)
    with open('json_files.json', 'w') as f:
        json.dump(json_files, f)
    #print("json_files:")
    #print(json_files)


    # Fetching the .json files.
    for json_file_name, json_file in json_files.items():
        # Skipping the template.json file. 
        if json_file_name == 'template.json':
            continue
        if json_file_name == 'aop-builder.json':
            continue

        json_url = json_file['download_url']  # Using the download URL from the API response.
        json_content= requests.get(json_url)
        print("json_content:")
        print(json_content)
        if json_content.status_code == 200:
            json_data = json_content.json()
            
            # Extracting the 'service' field from the json file.
            service_name = json_data.get('service')
            description_string = json_data.get('description') 

            if service_name:
                # Replacing the .json extension with the .md to get the corresponding .md file.
                md_file_name = json_file_name.replace('.json', '.md')
                html_name = json_file_name.replace('.json', '.html')
                url = "https://cloud.vhp4safety.nl/service/"+ html_name 

                if md_file_name in md_files:
                    md_file_url = f'https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/{md_file_name}'
                else:
                    md_file_url = "md file not found"
                png_file_name = md_file_name.replace('.md', '.png')

                if png_file_name in png_files:
                    png_file_url = f'https://raw.githubusercontent.com/VHP4Safety/cloud/main/docs/service/{png_file_name}'
                    writejson["data"][service_name] = {
                        'service':service_name,
                        'url':url,
                        'meta_data':md_file_url,
                        'description':description_string,
                        'png':png_file_url
                        }
                else:
                    writejson["data"][service_name] = {
                        'service':service_name,
                        'url':url,
                        'meta_data':md_file_url,
                        'description':description_string,
                        'png':"../../static/images/logo.png"
                        }
    print("Final writejson:")
    print(writejson)
    # Find current .json file and increase int by one, then write a new file
    full_list = os.listdir("service/CAP")
    CAPjson_list = []
    for item in full_list:
        if fnmatch.fnmatch(item, '*.json'):
            item = item.strip("CAPjson.")
            CAPjson_list.append(item)

    print("CAPjson_list:")
    print(CAPjson_list)

    new_version = "CAPjson" + str((int(max(CAPjson_list))+1)) + ".json"
    print("new_version:")
    print(new_version)
    with open("service/CAP/"+ new_version, 'w') as f:
        json.dump(writejson, f)



