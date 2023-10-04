//
//  NotificationType.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 9/9/23.
//

import SwiftUI

struct Notification: Decodable, Identifiable {
    let _id: String
    var id: String {
        return _id
    }
    let username: String
    let notSenderId: String
    let notReceiverId: String
    var notificationType: String
    var postText: String?
    var postLikes: Array<String>?
}
