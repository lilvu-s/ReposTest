//
//  AvatarView.swift
//  ReposTest
//
//  Created by Ангеліна Семенченко on 23.06.2023.
//

import SwiftUI

struct AvatarView: View {
    var user: User
    
    var body: some View {
        if let urlString = DBManager.shared.getAvatarUrl(for: user.id),  // Try to get avatar url from the database
           let url = URL(string: urlString),
           let data = try? Data(contentsOf: url),
           let uiImage = UIImage(data: data) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .background(
                    Color.gray
                        .brightness(0.4)
                        .opacity(0.6)
                )
                .clipShape(Circle())
        } else {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in // Try to get a network image if the local image isn't available
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
        }
    }
}
