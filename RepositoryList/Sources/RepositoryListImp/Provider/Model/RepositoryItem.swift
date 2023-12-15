import Foundation

struct RepositoryOwner: Codable {
    let ownerName: String
    let ownerProfileAvatarPath: String

    enum CodingKeys: String, CodingKey {
        case ownerName = "login"
        case ownerProfileAvatarPath = "avatar_url"
    }
}

struct RepositoryItem: Codable {
    let name: String
    let owner: RepositoryOwner
    let description: String
    let stargazersCount: Int
    let forksCount: Int

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case owner = "owner"
        case description = "description"
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
    }
}
