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
    var text: String
    var user: String
    let username: String
    let userId: String
    var image: String?
    var likes: [String]
    var isLiked: Bool? = false
}
