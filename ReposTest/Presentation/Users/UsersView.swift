//
//  ContentView.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 21.06.2023.
//

import SwiftUI

struct UsersView: View {
    @StateObject var viewModel = UserViewModel()
    @StateObject var repoViewModel = RepoViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.users) { user in
                        NavigationLink(destination: ReposView(login: user.login)) {
                            HStack(spacing: 15) {
                                AsyncImage(url: URL(string: user.avatarUrl)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .background(
                                    Color.gray
                                        .brightness(0.4)
                                        .opacity(0.6)
                                )
                                .clipShape(Circle())
                                
                                Text(user.login).bold()
                                    .foregroundColor(Color(uiColor: .tintColor))
                                
                            }
                            .padding(.vertical, 5)
                        }
                    }
                }
                Button("Load More", action: viewModel.fetchUsers)
                    .foregroundColor(.black)
            }
            .navigationTitle("Users")
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView()
    }
}
