//
//  ToastView.swift
//  AdminCardApp
//
//  Created by Anand Upadhyay on 02/05/25.
//
import UIKit

import UIKit

class ToastView: UIView {
    
    // MARK: - Properties
    private var messageLabel: UILabel!
    private var iconImageView: UIImageView!
    private var containerView: UIView!
    private var hideAfter: TimeInterval = 3.0 // Default to 3 seconds
    
    // MARK: - Initializer
    init(message: String,
         image: UIImage? = UIImage(systemName: "info.circle"), // Default image
         backgroundColor: UIColor = .darkGray,
         textColor: UIColor = .white,
         hideAfter: TimeInterval? = nil) {
        
        super.init(frame: .zero)
        self.hideAfter = hideAfter ?? self.hideAfter
        setupView(message: message, image: image, backgroundColor: backgroundColor, textColor: textColor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView(message: String, image: UIImage?, backgroundColor: UIColor, textColor: UIColor) {
        // Create and configure the container view
        containerView = UIView()
        containerView.backgroundColor = backgroundColor
        containerView.layer.cornerRadius = 8
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the image view
        iconImageView = UIImageView(image: image)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 4
        iconImageView.layer.masksToBounds = true
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Create and configure the label
        messageLabel = UILabel()
        messageLabel.text = message
        messageLabel.textColor = textColor
        messageLabel.numberOfLines = 0 // Allow multiple lines
        messageLabel.font = UIFont.fontWithStyle(.regular, size: 16)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews to the container view
        containerView.addSubview(iconImageView)
        containerView.addSubview(messageLabel)
        addSubview(containerView)
        
        NSLayoutConstraint.activate([
                    // Container view constraints
                    containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                    containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
                    containerView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 10),
                    containerView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -10),
                    
                    // Icon image view constraints
                    iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
                    iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                    iconImageView.widthAnchor.constraint(equalToConstant: 24),
                    iconImageView.heightAnchor.constraint(equalToConstant: 24),
                    
                    // Message label constraints
                    messageLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
                    messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
                    messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
                    messageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
                ])
    }
    
    // MARK: - Show
    func show(in parentView: UIView) {
        // Add the toast view to the parent view
        parentView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Add constraints for the toast view
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: parentView.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: parentView.bottomAnchor,constant: -40)
        ])
        
        // Animate the toast view appearance
        self.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 1
        }) { _ in
            // Hide the toast after the specified duration
            self.hideAfterDelay()
        }
    }
    
    // MARK: - Hide
    private func hideAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + hideAfter) { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.3, animations: {
                self.alpha = 0
            }) { _ in
                self.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Utility
    static func showToast(message: String,
                          in parentView: UIView,
                          image: UIImage? = UIImage(named: "AppLogo"),
                          backgroundColor: UIColor = .darkGray,
                          textColor: UIColor = .white,
                          hideAfter: TimeInterval? = nil) {
        let toast = ToastView(message: message, image: image, backgroundColor: backgroundColor, textColor: textColor, hideAfter: hideAfter)
        toast.show(in: parentView)
    }
}

//How to Use
//Toast Message
extension AppDelegate{
    func showToast(message: String,
                   in parentView: UIView,
                   backgroundColor: UIColor = .gray,
                   textColor: UIColor = .black,
                   font: UIFont = UIFont.fontWithStyle(.regular, size: 18),
                   hideAfter: TimeInterval? = nil){
        if !message.isEmpty {
            DispatchQueue.main.async {
                ToastView.showToast(message: message, in: parentView)
//                ToastView.showToast(message: message, in: parentView, backgroundColor: backgroundColor, textColor: textColor, font: font, hideAfter: hideAfter)
                
            }
        }
    }
}

