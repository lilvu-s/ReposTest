//
//  UserModel.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let url: String
    let reposUrl: String
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarUrl = "avatar_url"
        case url
        case reposUrl = "repos_url"
        case htmlUrl = "html_url"
    }
}
