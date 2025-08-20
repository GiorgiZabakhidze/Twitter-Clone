//
//  NotificationsView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct NotificationsView: View {
    
    @StateObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        RefreshableScrollView(content:
            VStack {
            if(viewModel.notifications.filter({$0.notSenderId != AuthViewModel.shared.currentUser!.id}).count > 0) {
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.notifications) { not in
                            if (not.notSenderId != AuthViewModel.shared.currentUser!.id) {
                                NotificationsCellView(notification: not, notificationType: not.notificationType)
                                
                            }
                            
                        }
                    }
                }else {
                    Spacer();
                    Text("No Notifications yet for you nigger!");
                    Spacer();
                    Spacer();
                }
        }.ignoresSafeArea(.keyboard)) { control in
            print("x")
            print(viewModel.notifications.count)
            control.endRefreshing()
        }
    }
}

