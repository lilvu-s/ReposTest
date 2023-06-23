//
//  DBManager.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 22.06.2023.
//

import Foundation
import SQLite

final class DBManager {
    static let shared = DBManager()
    private var db: Connection?
    
    private init() {
        do {
            guard let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first else { return }
            db = try Connection("\(path)/db.sqlite3")
            
            try createTables()
        } catch {
            print("Failed to connect to database: \(error.localizedDescription)")
        }
    }
    
    private func createTables() throws {
        try db?.run(User.userTable.create { t in
            t.column(User.id, primaryKey: true)
            t.column(User.login)
            t.column(User.avatarUrl)
            t.column(User.repos_url)
        })
        
        try db?.run(Repo.repoTable.create { t in
            t.column(Repo.id, primaryKey: true)
            t.column(Repo.name)
            t.column(Repo.description)
            t.column(Repo.owner)
        })
    }
    
    func getUsers() -> [User] {
        do {
            return try db?.prepare(User.userTable).map { row in
                return User(id: row[User.id], login: row[User.login], avatarUrl: row[User.avatarUrl], reposUrl: row[User.repos_url])
            } ?? []
        } catch {
            print("Failed to fetch users from database: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveUser(_ user: User) {
        let insert = User.userTable.insert(User.id <- user.id, User.login <- user.login, User.avatarUrl <- user.avatarUrl, User.repos_url <- user.reposUrl)
        do {
            try db?.run(insert)
        } catch {
            print("Failed to save user to database: \(error.localizedDescription)")
        }
    }
    
    func getRepos(for user: String) -> [Repo] {
        do {
            return try db?.prepare(Repo.repoTable).compactMap { row in
                let userData = row[Repo.owner]
                let owner = try JSONDecoder().decode(User.self, from: userData)
                if owner.login == user {
                    return Repo(id: row[Repo.id], full_name: row[Repo.name], htmlUrl: "", description: row[Repo.description], owner: owner)
                }
                return nil
            } ?? []
        } catch {
            print("Failed to fetch repos from database: \(error.localizedDescription)")
            return []
        }
    }
    
    func saveRepo(_ repo: Repo) {
        let userData: Data
        do {
            userData = try JSONEncoder().encode(repo.owner)
        } catch {
            print("Failed to encode owner data: \(error.localizedDescription)")
            return
        }
        
        let insert = Repo.repoTable.insert(Repo.id <- repo.id, Repo.name <- repo.full_name, Repo.description <- repo.description, Repo.owner <- userData)
        do {
            try db?.run(insert)
        } catch {
            print("Failed to save repo to database: \(error.localizedDescription)")
        }
    }
    
    func getAvatarUrl(for userId: Int) -> String? {
        do {
            let query = User.userTable.filter(User.id == userId)
            let user = try db?.pluck(query)
            return user?[User.avatarUrl]
        } catch {
            print("Failed to fetch avatar URL from database: \(error.localizedDescription)")
            return nil
        }
    }
}
