//
//  PDFDownloaderWKWebView.swift
//  Learning
//
//  Created by Anand Upadhyay on 12/03/24.
//

import Foundation
import WebKit
import QuickLook

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, QLPreviewControllerDataSource, WKScriptMessageHandler {

    
    @IBOutlet var webView: WKWebView!
    var documentPreviewController = QLPreviewController()
    var documentUrl = URL(fileURLWithPath: "")
    var documentDownloadTask: URLSessionTask?
    var webViewConfiguratio = WKWebViewConfiguration()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // initial configuration of custom JavaScripts
//        webViewConfiguration.userContentController = self
//        webViewConfiguration.websiteDataStore = WKWebsiteDataStore.default()

        webView = WKWebView(frame: self.view.frame, configuration: webViewConfiguratio)
        // init this view controller to receive JavaScript callbacks
//        self.add(self, name: "openDocument")
//        self.add(self, name: "jsError")
        


        // QuickLook document preview
        documentPreviewController.dataSource  = self
        
//        webView = WKWebView(frame: CGRect.zero, configuration: webViewConfiguration)
    }
    
    func webView(_ webView: WKWebView,
                 decidePolicyFor navigationAction: WKNavigationAction,
                 decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url


  if openInDocumentPreview(url!) {
  decisionHandler(.cancel)
  executeDocumentDownloadScript(forAbsoluteUrl: url!.absoluteString)
  } else {
  decisionHandler(.allow)
  }


    }
    
    /*
     Handler method for JavaScript calls.
     Receive JavaScript message with downloaded document
     */
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        debugPrint("did receive message \(message.name)")


        if (message.name == "openDocument") {
            previewDocument(messageBody: message.body as! String)
        } else if (message.name == "jsError") {
            debugPrint(message.body as! String)
        }
    }
    
    /*
     Open downloaded document in QuickLook preview
     */
    private func previewDocument(messageBody: String) {
        // messageBody is in the format ;data:;base64,
        
        // split on the first ";", to reveal the filename
        let filenameSplits = messageBody.split(separator: ";", maxSplits: 1, omittingEmptySubsequences: false)
        
        let filename = String(filenameSplits[0])
        
        // split the remaining part on the first ",", to reveal the base64 data
        let dataSplits = filenameSplits[1].split(separator: ",", maxSplits: 1, omittingEmptySubsequences: false)
        
        let data = Data(base64Encoded: String(dataSplits[1]))
        
        if (data == nil) {
            debugPrint("Could not construct data from base64")
            return
        }
        
        // store the file on disk (.removingPercentEncoding removes possible URL encoded characters like "%20" for blank)
        let localFileURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename.removingPercentEncoding ?? filename)
        
        do {
            try data!.write(to: localFileURL);
        } catch {
            debugPrint(error)
            return
        }
        
        // and display it in QL
        DispatchQueue.main.async {
            self.documentUrl = localFileURL
            self.documentPreviewController.refreshCurrentPreviewItem()
            self.present(self.documentPreviewController, animated: true, completion: nil)
        }
    }
    
    /*
     Implementation for QLPreviewControllerDataSource
     */
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return documentUrl as QLPreviewItem
    }


    /*
     Implementation for QLPreviewControllerDataSource
     We always have just one preview item
     */
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }


    /*
     Checks if the given url points to a document download url
     */
    private func openInDocumentPreview(_ url : URL) -> Bool {
    // this is specific for our application - can be everything in your application
        return url.absoluteString.contains("/APP/connector")
    }

    /*
     Intercept the download of documents in webView, trigger the download in JavaScript and pass the binary file to JavaScript handler in Swift code
     */
    private func executeDocumentDownloadScript(forAbsoluteUrl absoluteUrl : String) {
        // TODO: Add more supported mime-types for missing content-disposition headers
        webView.evaluateJavaScript("""
            (async function download() {
                const url = '\(absoluteUrl)';
                try {
                    // we use a second try block here to have more detailed error information
                    // because of the nature of JS the outer try-catch doesn't know anything where the error happended
                    let res;
                    try {
                        res = await fetch(url, {
                            credentials: 'include'
                        });
                    } catch (err) {
                        window.webkit.messageHandlers.jsError.postMessage(`fetch threw, error: ${err}, url: ${url}`);
                        return;
                    }
                    if (!res.ok) {
                        window.webkit.messageHandlers.jsError.postMessage(`Response status was not ok, status: ${res.status}, url: ${url}`);
                        return;
                    }
                    const contentDisp = res.headers.get('content-disposition');
                    if (contentDisp) {
                        const match = contentDisp.match(/(^;|)\\s*filename=\\s*(\"([^\"]*)\"|([^;\\s]*))\\s*(;|$)/i);
                        if (match) {
                            filename = match[3] || match[4];
                        } else {
                            // TODO: we could here guess the filename from the mime-type (e.g. unnamed.pdf for pdfs, or unnamed.tiff for tiffs)
                            window.webkit.messageHandlers.jsError.postMessage(`content-disposition header could not be matched against regex, content-disposition: ${contentDisp} url: ${url}`);
                        }
                    } else {
                        window.webkit.messageHandlers.jsError.postMessage(`content-disposition header missing, url: ${url}`);
                        return;
                    }
                    if (!filename) {
                        const contentType = res.headers.get('content-type');
                        if (contentType) {
                            if (contentType.indexOf('application/json') === 0) {
                                filename = 'unnamed.pdf';
                            } else if (contentType.indexOf('image/tiff') === 0) {
                                filename = 'unnamed.tiff';
                            }
                        }
                    }
                    if (!filename) {
                        window.webkit.messageHandlers.jsError.postMessage(`Could not determine filename from content-disposition nor content-type, content-dispositon: ${contentDispositon}, content-type: ${contentType}, url: ${url}`);
                    }
                    let data;
                    try {
                        data = await res.blob();
                    } catch (err) {
                        window.webkit.messageHandlers.jsError.postMessage(`res.blob() threw, error: ${err}, url: ${url}`);
                        return;
                    }
                    const fr = new FileReader();
                    fr.onload = () => {
                        window.webkit.messageHandlers.openDocument.postMessage(`${filename};${fr.result}`)
                    };
                    fr.addEventListener('error', (err) => {
                        window.webkit.messageHandlers.jsError.postMessage(`FileReader threw, error: ${err}`)
                    })
                    fr.readAsDataURL(data);
                } catch (err) {
                    // TODO: better log the error, currently only TypeError: Type error
                    window.webkit.messageHandlers.jsError.postMessage(`JSError while downloading document, url: ${url}, err: ${err}`)
                }
            })();
            // null is needed here as this eval returns the last statement and we can't return a promise
            null;
        """) { (result, err) in
            if (err != nil) {
                debugPrint("JS ERR: \(String(describing: err))")
            }
        }
    }
}
