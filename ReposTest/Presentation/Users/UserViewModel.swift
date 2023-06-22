//
//  UserViewModel.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import SwiftUI

final class UserViewModel: ObservableObject {
    @Published var users = [User]()
    var currentPage = 1
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        let lastUserID = users.last?.id
        
        APIService.shared.getUsers(page: currentPage, since: lastUserID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self?.users.append(contentsOf: users)
                    self?.currentPage += 1
                case .failure(let error):
                    print("Failed to fetch users: \(error.localizedDescription)")
                }
            }
        }
    }
}
