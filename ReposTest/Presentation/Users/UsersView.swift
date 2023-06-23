//
//  ContentView.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import SwiftUI

struct UsersView: View {
    @StateObject var viewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.users.isEmpty {
                    VStack {
                        Text("Loading users...")
                        ProgressView()
                    }
                    .padding(.top, -60)
                    
                } else {
                    List {
                        ForEach(viewModel.users) { user in
                            NavigationLink(destination: ReposView(login: user.login)) {
                                HStack(spacing: 15) {
                                    AvatarView(user: user)
                                    
                                    Text(user.login).bold()
                                        .foregroundColor(.black)
                                }
                                .padding(.vertical, 5)
                            }
                        }
                        Button("Load More", action: viewModel.fetchUsers)
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationTitle("Users")
        }
    }
}
