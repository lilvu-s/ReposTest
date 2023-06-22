//
//  RepoViewModel.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import SwiftUI

final class RepoViewModel: ObservableObject {
    @Published var repos = [Repo]()
    var page = 1
    
    func fetchRepos(for user: String) {
        APIService.shared.getRepos(for: user, page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    self?.repos.append(contentsOf: repos)
                    self?.page += 1
                case .failure(let error):
                    print("Failed to fetch repos: \(error.localizedDescription)")
                }
            }
        }
    }
}
