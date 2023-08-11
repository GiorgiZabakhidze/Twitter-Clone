//
//  CretaeTweetView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct CreateTweetView: View {
    @State var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    
                } label: {
                    Text("Cancel")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("Tweet").padding()
                }
                .background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())

            }
            MultilineTextField(text: $text)
        }.padding()
    }
}

struct CretaeTweetView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTweetView()
    }
}
