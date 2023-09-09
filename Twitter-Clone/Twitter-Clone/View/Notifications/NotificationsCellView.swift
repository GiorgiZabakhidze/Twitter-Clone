//
//  NotificationsCellView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI
import Kingfisher

struct NotificationsCellView: View {
    
    let notification: Notification
    var notificationType: String
    
    @State var width = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
            HStack(alignment: .top) {
                Image("twitter-profile-2")
                    .renderingMode(.template)
                    .foregroundColor(Color("bg"))
                    .padding(.top, 4)
                VStack(alignment: .leading, spacing: 2) {
                    KFImage(URL(string: "http://localhost:3000/users/\(self.notification.notReceiverId)/avatar"))
                        .placeholder {
                            Image("Profile")
                                .resizable()
                        }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                    Text("\(self.notification.notSenderId) ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text(notificationType == "follow" ? "followed you" : "Liked Your Post")
                        .foregroundColor(.black)
                }
                Spacer(minLength: 8)
            }.padding(.leading, 30)
        }
    }
}


