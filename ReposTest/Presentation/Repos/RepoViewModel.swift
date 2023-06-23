//
//  RepoViewModel.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import SwiftUI

final class RepoViewModel: ObservableObject {
    @Published var repos = [Repo]()

    var currentPage = 1
    
    func fetchRepos(for user: String) {
        APIService.shared.getRepos(for: user, page: currentPage) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let repos):
                    repos.forEach { DBManager.shared.saveRepo($0) }
                    self.repos.append(contentsOf: repos)
                    self.currentPage += 1
                case .failure(let error):
                    print("Failed to fetch repos: \(error.localizedDescription)")
                }
            }
        }
    }
}
