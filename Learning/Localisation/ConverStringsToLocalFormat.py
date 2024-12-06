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


Steps to Use on a Mac
1. Install Python (if not already installed):
    * Open the Terminal.
    * Type python3 --version to check if Python 3 is installed.
    * If not installed, download and install Python 3 from python.org.
2. Create the Python Script:
    * Open the TextEdit app.
    * Copy and paste the Python script above.
    * Save the file with a .py extension, for example, generate_localization.py.
3. Prepare the Variables:
    * Add all your variables into the variables dictionary in the script. Ensure all keys and values are included.
4. Run the Script:
    * Open the Terminal.
    * Navigate to the folder where your .py file is saved. For example:bash Copy code cd /path/to/your/script
    * Run the script using:bas python3 generate_localization.py 
5. Check the Output:
    * The script will generate a localization.json file in the same directory as the script.
    * Open the localization.json file with any text editor or Xcode to review the content.


