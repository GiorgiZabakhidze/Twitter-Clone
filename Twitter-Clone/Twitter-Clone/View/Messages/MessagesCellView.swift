//
//  MessagesCellView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 12/8/23.
//

import SwiftUI

struct MessagesCellView: View {
    @State var width = UIScreen.main.bounds.width
    
    @ObservedObject var viewModel = MessagesViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .frame(width: width, height: 1, alignment: .center)
                .foregroundColor(.gray)
                .opacity(0.3)
            
            HStack(alignment: .top, spacing: 10) {
                Image("profile_pic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 55, height: 55)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 4) {
                    Text("zabaxa ")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    +
                    Text("@Giorgi_Zabakhidze")
                        .fontWeight(.light)
                    Text("You: Hey! How Is It Going?")
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                }
                Text("12/8/23")
                    .foregroundColor(.gray)
            }.padding(.leading)
        }
    }
}

struct MessagesCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesCellView()
    }
}
