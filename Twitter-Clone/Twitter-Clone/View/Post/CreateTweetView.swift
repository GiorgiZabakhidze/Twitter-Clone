//
//  CretaeTweetView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct CreateTweetView: View {
    
    @Binding var show: Bool
    @State var text = ""
    
    @ObservedObject var viewModel = CreateTweetViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.show.toggle()
                } label: {
                    Text("Cancel")
                }
                
                Spacer()
                
                Button {
                    
                    if !text.isEmpty {
                        self.show.toggle()
                        self.viewModel.uploadPost(text: text)
                    }else {
                        print("Cannot Post Empty Tweet")
                    }
            
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

