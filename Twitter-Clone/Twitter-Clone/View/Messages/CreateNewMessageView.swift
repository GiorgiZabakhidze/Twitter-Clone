//
//  CreateNewMessageView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 20/9/23.
//

import SwiftUI

struct CreateNewMessageView: View {
    
    @ObservedObject var viewModel = MessagesViewModel()
    
    @Binding var showSendMessageView: Bool
    
    @State var message = ""
    @State var ToUser = ""
    
    @FocusState private var keyboardFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.showSendMessageView.toggle()
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color("bg"))
                }.padding(.leading)
                
                Spacer()
                
                Text("New Message")
                    .fontWeight(.medium)
                
                Spacer()
                
                Button {
                    guard let authedUser = AuthViewModel.shared.currentUser else {
                        return
                    }
                    
                    let name = UserDefaults.standard.string(forKey: authedUser.id)!
                    let mesSenderId = UserDefaults.standard.string(forKey: authedUser.username)!
                    
                    self.viewModel.SendMessage(name: name, username: authedUser.username, mesSenderId: authedUser.id, mesReceiverId: mesSenderId, message: message)
                    self.showSendMessageView.toggle()
                } label: {
                    Text("Send")
                        .padding(7)
                }
                .background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.trailing)
            }
            
            HStack {
                Text("To:")
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                
                TextField("", text: $ToUser)
                    .focused($keyboardFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                            keyboardFocused = true
                        })
                    }
            }
            .padding(.horizontal)
            .padding(.trailing, 50)
            
            Divider()
                .frame(width: UIScreen.main.bounds.width - 10, height: 1, alignment: .center)
                .foregroundColor(.gray)
            
            MultilineTextField(text: $message, textText: "Write a Message..")
                .padding(.horizontal, 5)
            
            Spacer()
        }.padding(.top)
    }
}


