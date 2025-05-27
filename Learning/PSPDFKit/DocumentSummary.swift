import PSPDFKit

// Load the PDF document
let documentURL = URL(fileURLWithPath: "/path/to/your/document.pdf")
let document = PSPDFDocument(fileURL: documentURL)

// Create a PSPDFProcessorConfiguration
let config = PSPDFProcessorConfiguration(document: document)

// Generate the simplified PDF with text
PSPDFProcessor.generatePDFFromConfiguration(config, securityOptions: nil, outputFileURL: URL(fileURLWithPath: "/path/to/simplified/document.pdf"), progressBlock: nil) { (error) in
    if let error = error {
        print("Error: \(error)")
    } else {
        // Access the text from the simplified PDF
        let simplifiedDocument = PSPDFDocument(fileURL: URL(fileURLWithPath: "/path/to/simplified/document.pdf"))
        if let firstPage = simplifiedDocument?.pages.first {
            if let text = firstPage.text {
                print("Text: \(text)")
            }
        }
    }
}
