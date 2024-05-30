//Add the group to the entitlements/capabilities.

1. Go to the capabilities tab of the app's target
2. Enable App Groups
3. Create a new app group, entitled something appropriate. It must start with group..
4. Let Xcode go through the process of creating this group for you.
5. Save data to NSUserDefaults with group ID and use it in your extension.

//From Apple's App Extension Guide :

//https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html

//In the main app, save person name:

let defaults = UserDefaults(suiteName: "your group ID")
defaults!.set("person name", forKey: "key for person name")
defaults!.synchronize()
//In the extension, you can use saved person name:

let defaults = UserDefaults(suiteName: "your group ID")
let savedPersonName = defaults!.string(forKey: "key for person name")
