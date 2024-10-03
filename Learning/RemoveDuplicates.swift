import Foundation

struct User: Codable {
    let userId: String
    let userName: String
    let userImage: String
    let socialMedia: String
}


func removeDuplicateUsers(from users: [User]) -> [User] {
    let predicate = Predicate<User> { user in
        // Your filtering logic here
        return user.userId != "duplicateUserId" // Example condition
    }

    return users.filter(predicate)
}
