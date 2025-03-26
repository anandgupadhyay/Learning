import Foundation

//Step 1: Define the Protocol

protocol Notification {
    func send(message: String)
}

//Step 2: Create Concrete Implementations

class EmailNotification: Notification {
    func send(message: String) {
        print("Sending Email with message: \(message)")
    }
}

class SMSNotification: Notification {
    func send(message: String) {
        print("Sending SMS with message: \(message)")
    }
}

//Step 3: Create the Notification Service
class NotificationService {
    private let notification: Notification
    
    // Dependency Injection through initializer
    init(notification: Notification) {
        self.notification = notification
    }
    
    func notify(message: String) {
        notification.send(message: message)
    }
}

//Step 4: Using the Notification Service
et emailNotification = EmailNotification()
let smsNotification = SMSNotification()

let emailService = NotificationService(notification: emailNotification)
emailService.notify(message: "Hello via Email!")

let smsService = NotificationService(notification: smsNotification)
smsService.notify(message: "Hello via SMS!")

