//
//  RepoModel.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import Foundation
import SQLite

struct Repo: Codable, Identifiable {
    let id: Int
    let full_name: String
    let htmlUrl: String
    let description: String?
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case id, owner
        case htmlUrl = "html_url"
        case description, full_name
    }
    
    static let repoTable = Table("repos")
    static let id = Expression<Int>("id")
    static let name = Expression<String>("name")
    static let description = Expression<String?>("description")
    static let owner = Expression<Data>("owner")
}
