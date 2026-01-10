import Foundation

extension String {
    func localized(forLanguageCode lanCode: String) -> String {
        // Find the path to the specific language's .lproj folder
        guard let bundlePath = Bundle.main.path(forResource: lanCode, ofType: "lproj"),
              // Create a Bundle object from that path
              let bundle = Bundle(path: bundlePath) else {
            // Return a default value or handle the error if the bundle is not found
            return self 
        }
        
        // Use NSLocalizedString with the specific bundle
        return NSLocalizedString(self, bundle: bundle, value: "", comment: "")
    }
}
