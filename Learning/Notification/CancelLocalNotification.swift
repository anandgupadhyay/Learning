//To remove previously displayed Notification 
UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["your_notification_identifier"])

//How to check if Local Notification was Deliverred or not
 UNUserNotificationCenter.current().getDeliveredNotifications { deliveredNotifications in
        // This closure is executed on a background thread.
        // You might want to dispatch back to the main thread if updating UI.
        DispatchQueue.main.async {
            for notification in deliveredNotifications {
                // Check the notification's identifier or content to see if it's the one you're looking for
                print("Delivered Notification Identifier: \(notification.request.identifier)")
                print("Delivered Notification Title: \(notification.request.content.title)")
                print("Delivered Notification Body: \(notification.request.content.body)")

                // Example: Check for a specific notification by its identifier
                if notification.request.identifier == "your_unique_notification_identifier" {
                    print("Your specific notification has been delivered!")
                    // Perform actions based on the delivery
                }
            }

            if deliveredNotifications.isEmpty {
                print("No notifications currently delivered.")
            }
        }
    }

