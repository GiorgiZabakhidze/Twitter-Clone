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
    
    @State var message: String
    @State var toUserUsername: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    self.showSendMessageView.toggle()
                } label: {
                    Text("Cancel")
                        .background(Color("bg"))
                }
                
                Spacer()
                
                Text("New Message")
                    .fontWeight(.heavy)
                    .background(.white)
                
                Spacer()
                
                Button {
                    guard let authedUser = AuthViewModel.shared.currentUser else {
                        return
                    }
                    
                    let name = UserDefaults.standard.string(forKey: authedUser.id)!
                    
                    self.viewModel.SendMessage(name: name, username: authedUser.username, mesSenderId: authedUser.id, mesReceiverId: <#T##String#>, message: <#T##String#>)
                    self.showSendMessageView.toggle()
                } label: {
                    Text("Send")
                }
                .background(Color("bg"))
                .foregroundColor(.white)
                .clipShape(Capsule())


            }
        }
    }
}


