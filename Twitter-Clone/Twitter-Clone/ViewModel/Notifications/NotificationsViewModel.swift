//
//  NotificationsViewModel.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 9/9/23.
//

import Foundation

class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    init() {
        fetchUserNotifications()
    }
    
    func fetchUserNotifications() {
        
        RequestServices.FetchUserNotifications(userId: AuthViewModel.shared.currentUser!.id) { result in
            switch result {
                case .success(let data):
                
                    if let json = String(data: data!, encoding: .utf8) {
                        print(json)
                    }
                    
                    guard let notifications = try? JSONDecoder().decode([Notification].self, from: data as! Data) else { return
                    }
                    
                
                    DispatchQueue.main.async {
                        self.notifications = notifications
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
            
        }
    }
}
