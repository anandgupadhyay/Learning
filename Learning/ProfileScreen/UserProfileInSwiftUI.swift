
//
//  UserProfileInSwiftUI.swift
//  Learning
//
//  Created by Anand Upadhyay on 16/01/24.
// https://gist.github.com/lucaswkuipers/8d63c47ac9ddf6584d9a7fa6e1df0846

import Foundation
import SwiftUI

struct CustomButton {
    let title: String
    let url: URL
}

struct Profile {
    let name: String
    let headline: String
    let backgroundPhoto: Image
    let profilePhoto: Image
    let topVoice: String?
    let isVerified: Bool
    let contentCreatorTopics: [String]?
    let education: String
    let location: String
    let customButton: CustomButton?
    let numberOfFollowers: Int?
    let numberOfConnections: Int
}

extension Profile {
    var talksAbout: String? {
        guard let contentCreatorTopics, !contentCreatorTopics.isEmpty else { return nil }

        var lowerCasedTaggedTopics = contentCreatorTopics.map { "#\($0.lowercased())" }

        guard contentCreatorTopics.count > 1 else {
            return  "Talks about \(lowerCasedTaggedTopics.first!)"
        }

        let lastTaggedTopic = lowerCasedTaggedTopics.popLast()!

        return "Talks about " + lowerCasedTaggedTopics.joined(separator: ", ") + " and " + lastTaggedTopic
    }

    var numberOfConnectionsDescription: String {
        "\(min(numberOfConnections, 500))\(numberOfConnections > 500 ? "+" : "") connection\(numberOfConnections == 1 ? "" : "s")"
    }

    var numberOfFollowersDescription: String? {
        guard let numberOfFollowers else { return nil }
        return "\(numberOfFollowers.formatted(.number)) follower\(numberOfFollowers == 1 ? "" : "s")"
    }
}

struct ProfileView: View {
    let profile: Profile = .standard
    var body: some View {
        ZStack(alignment: .topLeading) {
            profile.backgroundPhoto
                .resizable()
                .frame(height: 150)
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 4) {
                profile.profilePhoto
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .clipShape(.circle)
                    .padding(4)
                    .background {
                        Circle()
                            .foregroundStyle(.background)
                    }

                HStack {
                    Text(profile.name)
                        .font(.title)
                        .bold()

                    if profile.isVerified {
                        Image(systemName: "checkmark.shield")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 24)
                            .foregroundStyle(.secondary)
                    }

                    Image(systemName: "speaker.wave.2.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 24)
                        .foregroundStyle(.secondary)
                        .padding(.leading, 4)
                }

                Text(profile.headline)

                if let topVoice = profile.topVoice {
                    HStack(spacing: 4) {
                        Image(systemName: "lightbulb.max")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14)
                            .fontWeight(.black)
                        Text(topVoice)
                            .fontWeight(.semibold)
                            .font(.caption)
                    }
                    .padding(6)
                    .padding(.horizontal, 3)
                    .background(Color(red: 248/255, green: 228/255, blue: 192/255))
                    .foregroundStyle(Color(red: 137/255, green: 92/255, blue: 31/255))
                    .clipShape(.capsule)

                }

                if let talksAbout = profile.talksAbout {
                    Text(talksAbout)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 6)
                }

                Text(profile.education)
                    .font(.subheadline)
                    .foregroundStyle(.primary.opacity(0.9))
                    .padding(.top, 6)

                Text(profile.location)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                if let customButton = profile.customButton {
                    Link(destination: customButton.url) {
                        HStack(spacing:  4) {
                            Text(customButton.title)
                            Image(systemName: "arrow.up.forward.square")
                        }
                    }
                        .bold()
                        .font(.subheadline)
                        .padding(.top, 8)
                }

                HStack(spacing: 0) {
                    if let numberOfFollowersDescription = profile.numberOfFollowersDescription {
                        Button(numberOfFollowersDescription) {
                            // ...
                        }
                        .buttonStyle(.plain)
                        .foregroundStyle(.secondary)

                        Text("・")
                    }

                    Button(profile.numberOfConnectionsDescription) {
                        // ...
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(.secondary)
                }
                .bold()
                .font(.subheadline)
                .padding(.top, 8)

                HStack {
                    Button {
                        // ...
                    } label: {
                        Label("Add", systemImage: "plus")
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .background(.link)
                            .foregroundStyle(.white)
                            .bold()
                            .clipShape(.capsule)
                    }

                    Button {
                        // ...
                    } label: {
                        Label("Connect", systemImage: "paperplane.fill")
                            .frame(maxWidth: .infinity)
                            .frame(height: 35)
                            .foregroundStyle(.link)
                            .bold()
                            .overlay {
                                Capsule()
                                    .stroke(.link)
                            }
                    }
                }
                .padding(.top, 20)

                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView()
}

extension Profile {
    static var standard: Profile {
        Profile(
            name: "Anand Upadhyay",
            headline: "Senior iOS Developer ",
                        backgroundPhoto: Image("Cover"),
                        profilePhoto: Image("face"),
                        topVoice: "iOS Developer and Product Engineer",
                        isVerified: true,
                        contentCreatorTopics: ["iOS", "Mac", "Swift", "UIKit", "SwiftUI" ,"Flutter"],
                        education: "Software Technologies Ltd.",
                        location: "Nairobi, Kenya",
                        customButton: CustomButton(title: "Github", url: URL(string: "https://github.com/anandgupadhyay")!),
                        numberOfFollowers: 5,
                        numberOfConnections: 7
        )
    }
}
