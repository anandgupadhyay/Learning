import json

# List of variable names and their corresponding strings
variables = {
    "EnterNameMsg": "Enter Name",
    "OkayTitle": "Okay",
    "ThankYou" : "Thank you"
    # Add the rest of your variables here...
}

# Initialize the JSON structure
output = {"strings": {}}

# Populate the JSON structure
for value, key in variables.items():
    output["strings"][value] = {
        "extractionState": "manual",
        "localizations": {
            "en": {
                "stringUnit": {
                    "state": "translated",
                    "value": value
                }
            }
        }
    }

# Save the structure to a file
output_file = "localization.json"
with open(output_file, "w") as file:
    json.dump(output, file, indent=2)

print(f"Localization JSON file '{output_file}' created successfully!")
