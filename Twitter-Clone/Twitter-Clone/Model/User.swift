//
//  User.swift
//  Twitter-Clone
//
//  Created by Macbook Pro on 23/8/23.
//

import Foundation



struct APIResponse: Decodable {
    var user: User
    var token: Token?
}

struct TokenDetails: Decodable {
    let token: String
    let _id: String
}

struct Token: Decodable {
    let _id: String
    let name: String
    let username: String
    let email: String
    let followers: [String]?
    let following: [String]?
    let tokens: [TokenDetails]?
    let __v: Int
    let avatar: String?
    let avatarExists: Bool?
}


struct User: Decodable, Identifiable {
    var _id: String
    var id: String {
         return _id
    }
    let name: String
    let username: String
    let email: String
    var followers: [String]?
    var following: [String]?
    var tokens: [TokenDetails]?
    var __v: Int
    var avatar: String?
    var avatarExists: Bool?
    var location: String?
    var bio: String?
    var website: String?
    
}
