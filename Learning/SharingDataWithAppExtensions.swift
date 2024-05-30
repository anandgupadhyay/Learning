//Add the group to the entitlements/capabilities.


//From Apple's App Extension Guide :

//https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/ExtensionScenarios.html

//In the main app, save person name:

let defaults = UserDefaults(suiteName: "your group ID")
defaults!.set("person name", forKey: "key for person name")
defaults!.synchronize()
//In the extension, you can use saved person name:

let defaults = UserDefaults(suiteName: "your group ID")
let savedPersonName = defaults!.string(forKey: "key for person name")
