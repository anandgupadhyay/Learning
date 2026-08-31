//The Single Responsibility Principle (SRP) states that a Swift class or struct should have only one job, 
//meaning it should have only one reason to change

//Wrong Way
class UserProfile {
    var username: String
    var email: String
    
    init(username: String, email: String) {
        self.username = username
        self.email = email
    }
    
    // Responsibility 1: Business Logic / Data
    func updateEmail(to newEmail: String) {
        self.email = newEmail
    }
    
    // Responsibility 2: Networking / API call
    func saveToRemoteServer() {
        // Network code to upload user profile...
    }
    
    // Responsibility 3: Formatting / UI presentation
    func renderBadge() -> String {
        return "\(username) (Verified)"
    }
}


//Correct way
struct User {
    var username: String
    var email: String
}

class UserApiRepository {
    func save(_ user: User) {
        // Handle network persistence here
    }
}

class UserBadgePresenter {
    func renderBadge(for user: User) -> String {
        return "\(user.username) (Verified)"
    }
}
