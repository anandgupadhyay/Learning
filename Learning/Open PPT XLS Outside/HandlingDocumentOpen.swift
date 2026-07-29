import UIKit

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
