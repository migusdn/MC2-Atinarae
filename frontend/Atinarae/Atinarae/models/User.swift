//
//  User.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/02.
//

import Foundation

class User {
    let userId:Int
    let userNickname:String
    let userMail: String
    let userPhone: String
    
    init(userId: Int, userNickname: String, userMail: String, userPhone: String, userCategories: [String], receiverList: [VideoMessage]) {
        self.userId = userId
        self.userNickname = userNickname
        self.userMail = userMail
        self.userPhone = userPhone
    }
    
}
