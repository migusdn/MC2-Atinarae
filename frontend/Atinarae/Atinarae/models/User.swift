//
//  User.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/02.
//

import Foundation

struct User: Equatable, Hashable {
    var userId: Int
    var nickname: String
    var mail: String
    var phone: String
    var profile: String
    var categories: [String]
    var friends: [Friend]
    var inbox: Inbox
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.userId == rhs.userId &&
            lhs.nickname == rhs.nickname &&
            lhs.mail == rhs.mail &&
            lhs.phone == rhs.phone &&
            lhs.profile == rhs.profile &&
            lhs.categories == rhs.categories &&
            lhs.friends == rhs.friends &&
            lhs.inbox == rhs.inbox
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(userId)
        hasher.combine(nickname)
        hasher.combine(mail)
        hasher.combine(phone)
        hasher.combine(profile)
        hasher.combine(categories)
        hasher.combine(friends)
        hasher.combine(inbox)
    }
    
    init(userId: Int, nickname: String, mail: String, phone: String, profile: String, categories: [String], friends: [Friend], inbox: Inbox) {
        self.userId = userId
        self.nickname = nickname
        self.mail = mail
        self.phone = phone
        self.profile = profile
        self.categories = categories
        self.friends = friends
        self.inbox = inbox
    }
}
