//
//  NotificationsView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        RefreshableScrollView(content:
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(0..<9) { _ in
                        NotificationsCellView()
                    }
                }
                
        }) { control in
            print("x")
            control.endRefreshing()
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
