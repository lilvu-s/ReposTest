//
//  RepoModel.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import Foundation

struct Repo: Codable, Identifiable {
    let id: Int
    let full_name: String
    let htmlUrl: String
    let description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case htmlUrl = "html_url"
        case description, full_name
    }
}
