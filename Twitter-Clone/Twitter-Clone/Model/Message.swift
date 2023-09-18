//
//  Message.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 18/9/23.
//

import SwiftUI

struct Message: Decodable, Identifiable {
    let _id: String
    var id: String {
        return _id
    }
    var name: String
    let username: String
    let mesSenderId: String
    let mesReceiverId: String
    var message: String
}
