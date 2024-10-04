import Foundation

struct User: Codable {
    let userId: String
    let userName: String
    let userImage: String
    let socialMedia: String
}




// Function to filter out duplicate users based on userId
    func filterDuplicateUsers(from userList: [User]) -> [User] {
        var seenUserIds = Set<String>()  // A set to track unique userIds
        var filteredUsers = [User]()
        
        for user in userList {
            if !seenUserIds.contains(user.userId) {
                filteredUsers.append(user)
                seenUserIds.insert(user.userId)
            }
        }
        
        return filteredUsers
    }

    // Example usage
    let users = [
        User(userId: "user1"),
        User(userId: "user2"),
        User(userId: "user1"), // Duplicate user
        User(userId: "user3"),
        User(userId: "user2")  // Duplicate user
    ]

    let eligibleUsers = filterDuplicateUsers(from: users)

    for user in eligibleUsers {
        print(“\nUser eligible for discount: \(user.userName)")
    }

// func removeDuplicateUser(from users: [User]) -> [User] {
//     var uniqueUserIds: Set<String> = []
//     return users.filter { user in
//         if uniqueUserIds.contains(user.userId) {
//             return false
//         } else {
//             uniqueUserIds.insert(user.userId)
//             return true
//         }
//     }
// }
