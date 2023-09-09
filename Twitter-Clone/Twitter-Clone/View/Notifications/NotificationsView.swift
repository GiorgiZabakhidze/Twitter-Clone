//
//  NotificationsView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct NotificationsView: View {
    
    @ObservedObject var viewModel = NotificationsViewModel()
    
    var body: some View {
        RefreshableScrollView(content:
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.notifications) { not in
                        NotificationsCellView(notification: not, notificationType: not.notificationType)
                    }
                }
                
        }) { control in
            print("x")
            control.endRefreshing()
        }
    }
}

