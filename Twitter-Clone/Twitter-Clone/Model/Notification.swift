//
//  NotificationType.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 9/9/23.
//

import SwiftUI

struct Notification: Decodable {
    let _id: String
    let username: String
    let notSenderId: String
    let notReceiverId: String
    var notificationType: String
    var postText: String?
}
