import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView(
            "No Data Available",
            systemImage: "tray",
            description: Text("There’s nothing here right now. Please try again later.")
        )
    }
}

//Using it inside a list or screen
// struct MyListView: View {
//     @State private var items: [String] = []

//     var body: some View {
//         if items.isEmpty {
//             ContentUnavailableView(
//                 "No Items",
//                 systemImage: "list.bullet",
//                 description: Text("Add new items to see them here.")
//             )
//         } else {
//             List(items, id: \.self) { item in
//                 Text(item)
//             }
//         }
//     }
// }

//Same Implementation in UIKit

import UIKit

class EmptyStateView: UIView {
    
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let imageView = UIImageView()

    init(title: String, message: String, systemImageName: String) {
        super.init(frame: .zero)

        imageView.image = UIImage(systemName: systemImageName)
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit

        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textAlignment = .center

        messageLabel.text = message
        messageLabel.font = .systemFont(ofSize: 16)
        messageLabel.textColor = .secondaryLabel
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0

        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, messageLabel])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .center

        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            imageView.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

//And Here's how to use it
class ViewController: UIViewController {

    let emptyView = EmptyStateView(
        title: "Content Unavailable",
        message: "Try again later.",
        systemImageName: "tray"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(emptyView)
        emptyView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

