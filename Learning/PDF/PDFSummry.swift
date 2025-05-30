//This is a Sample to Get a  Summary from a PDF File using Native PDF Kit available for free on iOS 
import UIKit
import PDFKit

class PDFSummaryViewController: UIViewController {

    // MARK: - UI Elements
    private let summarizeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Summarize PDF", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
    }

    // MARK: - Setup UI
    private func setupButton() {
        view.addSubview(summarizeButton)
        NSLayoutConstraint.activate([
            summarizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            summarizeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            summarizeButton.heightAnchor.constraint(equalToConstant: 50),
            summarizeButton.widthAnchor.constraint(equalToConstant: 200)
        ])

        summarizeButton.addTarget(self, action: #selector(summarizePDFButtonTapped), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func summarizePDFButtonTapped() {
        guard let pdfURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("yourFileName.pdf") else {
            showAlert(title: "Error", message: "PDF file not found.")
            return
        }

        let fullText = extractText(from: pdfURL)
        guard !fullText.isEmpty else {
            showAlert(title: "Error", message: "Failed to extract text from PDF.")
            return
        }

        let summary = generateSummary(from: fullText)
        showAlert(title: "PDF Summary", message: summary)
    }

    // MARK: - Text Extraction
    private func extractText(from pdfURL: URL) -> String {
        guard let pdfDocument = PDFDocument(url: pdfURL) else { return "" }
        var fullText = ""

        for pageIndex in 0..<pdfDocument.pageCount {
            if let page = pdfDocument.page(at: pageIndex),
               let text = page.string {
                fullText += text + "\n"
            }
        }
        return fullText
    }

    // MARK: - Summary Generation
    private func generateSummary(from text: String, sentenceLimit: Int = 3) -> String {
        let sentences = text.components(separatedBy: ".")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        let sortedSentences = sentences.sorted { $0.count > $1.count }
        let summary = sortedSentences.prefix(sentenceLimit).joined(separator: ". ") + "."
        return summary
    }

    // MARK: - Helper
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}


