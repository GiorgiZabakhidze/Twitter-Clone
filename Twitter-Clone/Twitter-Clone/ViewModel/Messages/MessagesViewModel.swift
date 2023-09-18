//
//  MessagesViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 18/9/23.
//

import Foundation

class MessagesViewModel: ObservableObject {
    @Published var messages = [Message]()
    
    func FetchUserMessages() {
        
    }
}
