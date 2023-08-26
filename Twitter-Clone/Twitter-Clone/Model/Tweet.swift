//
//  Tweet.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 26/8/23.
//

import SwiftUI

struct Tweet: Identifiable, Decodable {
    let _id: String
    var id: String {
        return _id
    }
    let text: String
    let user: String
    let username: String
    let userId: String
    let image: String?
    let likes: [String]?
}
