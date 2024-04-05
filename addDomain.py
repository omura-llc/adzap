#!/usr/bin/env python3

import json
import re
import sys

def load_json_file(file_path):
    with open(file_path, 'r') as file:
        return json.load(file)

def save_json_file(file_path, data):
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=2)

def domain_to_url_filter(domain):
    return f"^https?://{re.escape(domain)}[:/]"

def add_domain_to_blocker_list(blocker_list, domain):
    new_rule = {
        "trigger": {
            "url-filter": domain_to_url_filter(domain),
            "url-filter-is-case-sensitive": False,
            "load-type": ["third-party"]
        },
        "action": {
            "type": "block"
        }
    }

    for index, rule in enumerate(blocker_list):
        if rule["trigger"]["url-filter"] == new_rule["trigger"]["url-filter"]:
            print(f"Domain already exists in the list: {domain}")
            return blocker_list
        if rule["trigger"]["url-filter"] > new_rule["trigger"]["url-filter"]:
            blocker_list.insert(index, new_rule)
            return blocker_list

    blocker_list.append(new_rule)
    return blocker_list

def update_blocker_list(file_path, domain):
    blocker_list = load_json_file(file_path)
    blocker_list = add_domain_to_blocker_list(blocker_list, domain)
    save_json_file(file_path, blocker_list)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python3 addDomain.py <Extension/blockerList.json> <domain>")
        sys.exit(1)

    file_path = sys.argv[1]
    domain_to_add = sys.argv[2]
    update_blocker_list(file_path, domain_to_add)
