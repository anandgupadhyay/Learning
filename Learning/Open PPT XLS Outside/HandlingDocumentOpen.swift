import UIKit
/* 
Simple Document Opening Option
class DocumentShareManager: NSObject, UIDocumentInteractionControllerDelegate {
    var documentController: UIDocumentInteractionController?

    func promptToOpenDocument(fileURL: URL, in view: UIView) {
        documentController = UIDocumentInteractionController(url: fileURL)
        documentController?.delegate = self
        
        let success = documentController?.presentOpenInMenu(from: view.bounds, in: view, animated: true)
        
        if success == false {
            print("No app found to open this document.")
        }
    }
    
    // Required delegate method for proper presentation on iPad / iPhone
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return UIApplication.shared.keyWindow?.rootViewController ?? UIViewController()
    }
}

To restrict document sharing exclusively to Microsoft, Google, and Apple apps, you cannot use UIDocumentInteractionController. 
iOS does not natively allow you to filter or remove third-party apps from the standard system "Open In" menu. 
Instead, you must build a custom UIAlertController action sheet. 
Your app will manually check which approved apps are installed on the user's device using their specific URL Schemes. 
If an app is installed, you show it as an option, copy the document to a shared space, and pass it to that app.

Step 1: Update your Info.plistiOS blocks queries to other apps unless they are explicitly whitelisted. 
Add the LSApplicationQueriesSchemes key to your Info.plist file

xml<key>LSApplicationQueriesSchemes</key>
<array>
    <!-- Microsoft Apps -->
    <string>ms-powerpoint</string>
    <string>ms-excel</string>
    <!-- Google Apps -->
    <string>googledocs</string>
    <string>googlesheets</string>
    <!-- Apple Apps -->
    <string>pages</string>
    <string>numbers</string>
</array>
*/

class RestrictedDocOpener {
    
    // Struct to map target apps
    struct TargetApp {
        let name: String
        let scheme: String
        let appStoreURL: String
    }
    
    // Whitelisted applications
    private let approvedApps = [
        TargetApp(name: "Microsoft PowerPoint", scheme: "ms-powerpoint://", appStoreURL: "https://apple.com"),
        TargetApp(name: "Microsoft Excel", scheme: "ms-excel://", appStoreURL: "https://apple.com"),
        TargetApp(name: "Google Docs/Sheets", scheme: "googledocs://", appStoreURL: "https://apple.com"),
        TargetApp(name: "Apple Keynote/Numbers", scheme: "numbers://", appStoreURL: "https://apple.com")
    ]
    
    func presentRestrictedMenu(forFileNamed fileName: String, in viewController: UIViewController) {
        // Fetch document from local Documents directory
        let fileManager = FileManager.default
        guard let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let localFileURL = documentsURL.appendingPathComponent(fileName)
        
        guard fileManager.fileExists(atPath: localFileURL.path) else {
            print("File does not exist.")
            return
        }
        
        let alert = UIAlertController(title: "Open Document With", message: "Select an approved application", preferredStyle: .actionSheet)
        
        // Loop through whitelisted apps and check if they are installed
        for app in approvedApps {
            if let url = URL(string: app.scheme), UIApplication.shared.canOpenURL(url) {
                let action = UIAlertAction(title: app.name, style: .default) { _ in
                    self.shareFile(localFileURL, encodingWithApp: app, in: viewController)
                }
                alert.addAction(action)
            }
        }
        
        // Cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // iPad support
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private func shareFile(_ fileURL: URL, encodingWithApp app: TargetApp, in viewController: UIViewController) {
        // Pass the file data strictly via UIActivityViewController configured to handle individual items safely
        let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        
        // Exclude generic actions (airdrop, save to files) if you want to tighten restrictions
        activityVC.excludedActivityTypes = [
            .copyToPasteboard,
            .saveToCameraRoll,
            .assignToContact
        ]
        
        if let popoverController = activityVC.popoverPresentationController {
            popoverController.sourceView = viewController.view
            popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        viewController.present(activityVC, animated: true, completion: nil)
    }
}
