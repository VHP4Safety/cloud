import os
import json

# Paths
method_dir = "docs/methods"
output_dir = "cap"
output_file = os.path.join(output_dir, "methods_index.json")

# Use a dictionary for methods
methods = {}

# Process each method JSON
for filename in os.listdir(method_dir):
    if filename.endswith(".json") and filename != "template.json":
        filepath = os.path.join(method_dir, filename)
        with open(filepath, "r", encoding="utf-8") as f:
            try:
                data = json.load(f)

                # Extract required fields
                method_id = data.get("id", "")
                methods[method_id] = {
                    "id": data.get("id", ""),
                    "issue_number": data.get("issue_number", ""),
                    "sop": data.get("available_sop_content", ""),
                    "assay_name_content": data.get("assay_name_content", ""),
                    "data_producer_content": data.get("data_producer_content", ""),
                    "method_description_content": data.get(
                        "method_description_content", ""
                    ),
                    "type_content": data.get("type_content", ""),
                    "relevant_vhp4safety_regulatory_question(s)_content": data.get(
                        "relevant_vhp4safety_regulatory_question(s)_content", ""
                    ),
                    "relevant_aop_wiki_key_event(s)_to_the_assay_content": data.get(
                        "relevant_aop_wiki_key_event(s)_to_the_assay_content", ""
                    ),
                    "relevant_aop_wiki_adverse_outcome_pathway(s)_to_the_assay_content": data.get(
                        "relevant_aop_wiki_adverse_outcome_pathway(s)_to_the_assay_content",
                        "",
                    ),
                    "vendor_content": data.get("vendor_content", ""),
                    "catalog_number_content": data.get("catalog_number_content", ""),
                    "catalog_webpage_url": data.get("catalog_webpage_url", ""),
                    "citation_content": data.get("citation_content", ""),
                    "vhp4safety_workflow_stage_content": data.get(
                        "vhp4safety_workflow_stage_content", ""
                    ),
                    "workflow_substage_content": data.get(
                        "workflow_substage_content", ""
                    ),
                    "regulatory_question": data.get("regulatory_question", ""),
                    "case_study": data.get("case_study", ""),
                    "timestamp": data.get("timestamp", ""),
                }

            except json.JSONDecodeError:
                print(f"Skipping invalid JSON file: {filename}")

# Sort alphabetically by "method" name (not by ID)
methods = dict(sorted(methods.items(), key=lambda item: item[1]["id"].lower()))

# Write output
with open(output_file, "w", encoding="utf-8") as f:
    json.dump(methods, f, indent=2)
