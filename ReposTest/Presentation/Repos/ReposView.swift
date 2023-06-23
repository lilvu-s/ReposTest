//
//  ReposView.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import SwiftUI
import Network

struct ReposView: View {
    @StateObject private var viewModel = RepoViewModel()
    let login: String
    
    var body: some View {
        VStack {
            if viewModel.repos.isEmpty {
                VStack {
                    Text("Loading repositories...")
                    ProgressView()
                }
                .padding(.top, -60)
                
            } else {
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
                    Button("Load More", action: { viewModel.fetchRepos(for: login) })
                        .foregroundColor(.black)
                }
            }
        }
        .navigationTitle("Repositories")
        .onAppear {
            viewModel.fetchRepos(for: login)
        }
    }
}
