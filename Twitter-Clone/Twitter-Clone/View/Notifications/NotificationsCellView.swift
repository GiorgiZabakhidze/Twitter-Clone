//
//  NotificationsCellView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct NotificationsCellView: View {
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
                    Image("profile_pic")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                    Text("zabaxa ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("followed you")
                        .foregroundColor(.black)
                }
                Spacer(minLength: 8)
            }.padding(.leading, 30)
        }
    }
}

struct NotificationsCellView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsCellView()
    }
}
