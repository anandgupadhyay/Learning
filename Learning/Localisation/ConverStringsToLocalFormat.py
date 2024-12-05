import json

# List of variable names and their corresponding strings
variables = {
    "BUY THEME": "BuyTheme",
    "GET IT FOR FREE": "GetItForFree",
    "ACTIVE THEME - CONFIGURE": "ConfigureThemeActive",
    "CONFIGURE THEME": "ConfigureTheme",
    "Apply Theme": "ApplyTheme",
    "Search Card": "SearchCard",
    "Sorry no alerts at this time.": "NoAlertMsg",
    "Theme Store": "ThemeStoreTitle",
    "You don't have camera": "NoCameraAccess",
    "Pocket already available": "PocketAlreadyAvailable",
    "Pocket name can not be empty!": "PocketNameCanNotBeEmpty",
    "Add Card From URL": "AddCardFromURL",
    "Bluetooth is turned off; this is needed for local notification. Click to Enable": "bluetoothText",
    "Bluetooth is off in SETTINGS or \nCONTROL CENTER, needed for local notifications. Enable in SETTINGS and check the CONTROL CENTER": "bluetoothHardwaretext",
    "Location is not ALWAYS enabled, this is needed for local Card alerts": "locationText",
    "Bluetooth and GPS are not ALWAYS enabled; these are needed for local and GEO notification. Click to Enable": "locationAndBluetoothText",
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
