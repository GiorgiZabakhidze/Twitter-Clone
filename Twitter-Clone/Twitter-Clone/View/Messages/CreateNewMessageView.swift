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
    @State var toUser = ""
    
    @State var prevMessage = ""
    
    @FocusState private var keyboardFocused: Bool
    
    @State var messageCompleted = true
    
    var body: some View {
        withAnimation {
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
                        if (UserDefaults.standard.string(forKey: toUser) != nil && !message.isEmpty) {
                            messageCompleted = true
                            
                            prevMessage = message
                            
                            guard let authedUser = AuthViewModel.shared.currentUser else {
                                return
                            }
                            
                            let name = UserDefaults.standard.string(forKey: authedUser.id)!
                            let mesReceiverId = UserDefaults.standard.string(forKey: toUser)!
                            
                            self.viewModel.SendMessage(name: name, username: authedUser.username, mesSenderId: authedUser.id, mesReceiverId: mesReceiverId, message: message)
                            self.showSendMessageView.toggle()
                        }else if (message.isEmpty || toUser.isEmpty) {
                            messageCompleted = false
                            prevMessage = message
                        }
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
                    
                    TextField("", text: $toUser)
                        .focused($keyboardFocused)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                                keyboardFocused = true
                            })
                        }
                    
                    Spacer()
                    
                    if (!toUser.isEmpty) {
                        
                        withAnimation {
                            Image(systemName: UserDefaults.standard.string(forKey: toUser) == nil ? "x.circle" : "checkmark.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 15, height: 15)
                                .foregroundColor(UserDefaults.standard.string(forKey: toUser) == nil ? .red : Color("bg"))
                            
                        }.rotation3DEffect(Angle(degrees: 40), axis: (x: 50, y: 60, z: 10))
                    }
                }
                .padding(.horizontal)
                .padding(.trailing)
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width - 10, height: 1, alignment: .center)
                    .foregroundColor(.gray)
                
                MultilineTextField(text: $message, textText: "Write a Message..")
                    .padding(.horizontal, 5)
                
                Spacer()
                
                if(!messageCompleted && prevMessage == message) {
                    Text("Username or Message Can not Be Empty..")
                        .foregroundColor(.red)
                        .padding(.bottom, UIScreen.main.bounds.height / 3)
                }
                
            }.padding(.top)
        }
    }
}


