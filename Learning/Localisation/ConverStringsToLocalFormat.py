import json

# List of variables in dictionary format
variables = {
    "BUY THEME": "BuyTheme",
    "GET IT FOR FREE": "GetItForFree",
    "ACTIVE THEME - CONFIGURE": "ConfigureThemeActive",
    "CONFIGURE THEME": "ConfigureTheme",
    "Apply Theme": "ApplyTheme",
    "Search Card": "SearchCard",
    # Continue with all your variables...
}

# JSON template
output = {"strings": {}}

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

# Save to a JSON file
with open("localization.json", "w") as f:
    json.dump(output, f, indent=2)

print("Localization file created successfully!")
