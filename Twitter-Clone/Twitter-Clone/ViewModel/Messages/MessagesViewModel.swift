//
//  MessagesViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 18/9/23.
//

import Foundation

class MessagesViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    init(messages: [Message] = [Message]()) {
        self.messages = messages
        FetchUserMessages()
    }
    
    func SendMessage(name: String, username: String, mesSenderId: String, mesReceiverId: String, message: String) {
        RequestServices.requestDomain = "\(Constants.baseURL)/messages"
        
        RequestServices.SendMessages(name: name, username: username, mesSenderId: mesSenderId, mesReceiverId: mesReceiverId, message: message) { result in
                
            print(result)
        }
    }
    
    func FetchUserMessages() {
        
        RequestServices.FetchUserMessages(userId: AuthViewModel.shared.currentUser!.id) { result in
            switch result {
                case .success(let data):
                    if let json = String(data: data!, encoding: .utf8) {
                        print(json)
                    }
                    
                    guard let messages = try? JSONDecoder().decode([Message].self, from: data as! Data) else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.messages = messages
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}
