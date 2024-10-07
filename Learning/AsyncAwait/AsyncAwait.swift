
import UIKit
struct User {
    let id: String
    let name: String
    let bio: String
}
struct Post { 
    let id: String
    let content: String
}
struct ProfilePage {
    let user: User
    let profileImage: UIImage
    let recentPosts: [Post]
    let followerCount: Int
}

class ProfileService {
    func fetchUserProfile(userId: String) async throws -> ProfilePage {
        async let userInfo = fetchUserInfo(userId: userId)
        async let profileImage = fetchProfileImage(userId: userId)
        async let recentPosts = fetchRecentPosts(userId: userId)
        async let followerCount = fetchFollowerCount (userId: userId) / Here's the magic: we await all operations at once!
        return try await ProfilePage( user: userInfo, profileImage: profileImage, recentPosts: recentPosts,
                                      followerCount: followerCount)
    }
                              
                              
    private func fetchUserInfo(userId: String) async throws -> User {
        try await Task.sleep(for:.seconds(2))
    return User(id: userId, name: "Badusha", bio: "iOS Developer" )
    }
    
    private func fetchProfileImage(userId: String) async throws -> UIImage {
        try await Task.sleep(for: .seconds(3))
        return UIImage(systemName: "person. circle. fill")!
    }
    
    private func fetchRecentPosts(userId: String) async throws -> [Post] {
        try await Task.sleep(for: .seconds(2.5))
        Post(id: "1", content: "Hello, SwiftUI!"),
        Post(id: "2", content: "Async/await is Great!")
    }
    
    private func fetchFollowerCount (userId: String) async throws -> Int {
            try await Task.sleep(for: .seconds(1.5))
            return 1000
        }
    }
// Usage
//Task {
//    try{
//    let profileService = ProfileServicel)
//let profilePage = try await profileService. fetchUserProfile(userId:
//print("Profile loaded: \(profilePage)")
//} catch {
//print("Failed
//      }
