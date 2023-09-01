//
//  NotificationsView.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 11/8/23.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(0..<9) { _ in
                    NotificationsCellView()
                }
            }
            
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
