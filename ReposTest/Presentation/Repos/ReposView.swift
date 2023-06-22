//
//  ReposView.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import SwiftUI

struct ReposView: View {
    @ObservedObject var viewModel = RepoViewModel()
    let login: String
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.repos) { repo in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(repo.full_name).bold()
                            .foregroundColor(Color(uiColor: .tintColor))
                        Text(repo.description ?? "Description")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 20)
                }
            }
            Button("Load More", action: { viewModel.fetchRepos(for: login) })
        }
        .navigationTitle("Repositories")
        .onAppear {
            viewModel.fetchRepos(for: login)
        }
    }
}
