import Foundation

struct User: Codable {
    let userId: String
    let userName: String
    let userImage: String
    let socialMedia: String
}


func removeDuplicateUser(from users: [User]) -> [User] {
    var uniqueUserIds: Set<String> = []
    return users.filter { user in
        if uniqueUserIds.contains(user.userId) {
            return false
        } else {
            uniqueUserIds.insert(user.userId)
            return true
        }
    }
}
