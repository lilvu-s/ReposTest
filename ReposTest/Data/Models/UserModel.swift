//
//  UserModel.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import Foundation
import SQLite

struct User: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarUrl: String
    let reposUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id, login
        case avatarUrl = "avatar_url"
        case reposUrl = "repos_url"
    }
    
    static let userTable = Table("users")
    static let id = Expression<Int>("id")
    static let login = Expression<String>("login")
    static let repos_url = Expression<String>("repos_url")
    static let avatarUrl = Expression<String>("avatar_url")
}
