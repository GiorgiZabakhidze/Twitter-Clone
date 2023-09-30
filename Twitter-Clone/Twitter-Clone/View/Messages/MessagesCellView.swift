//
//  MessagesCellView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI
import Kingfisher

struct MessagesCellView: View {
    @State var width = UIScreen.main.bounds.width
    
    var message: Message
    
    let user = AuthViewModel.shared.currentUser!
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
                .padding(.top, -5)
            
            HStack(alignment: .top, spacing: 10) {
                KFImage(URL(string: "http://localhost:3000/users/\(message.mesSenderId)/avatar"))
                    .placeholder {
                        Image("Profile")
                            .resizable()
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(message.name) ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("@\(message.username)")
                        .foregroundColor(.black)
                    
                    Text("\(user.id == message.mesSenderId ? "You: " : "\(message.name): ") \(message.message)")
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .padding(.trailing, -35)
                        .padding(.top, 1)
                }
                
                Spacer()
                
                Text("12/8/23")
                    .foregroundColor(.gray)
                    .padding(.trailing)
                
            }
            .padding(.leading)
            .padding(.top, -5)
        }
    }
}


