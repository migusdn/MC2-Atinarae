//
//  User.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/02.
//

import Foundation
import RealmSwift

/*
    MARK: - UserModel Define
    User Entity에 대한 CRUD는 UserViewModel에서 정의하고 이를 이용한다.
    
    _id     : ObjectId  -> PK 자동생성
    nickname: String    -> 유저 닉네임
    mail    : String?   -> 유저 mail nullable
    phone   : String?   -> 유저 phone nullable
    profile : Int       -> 유저 profile Image 순서 지정
    friends : List<User>-> 유저가 추가한 친구 List
    createdDate: Date   -> 현재 날짜로 자동으로 생성됨
*/

class User: Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var nickname: String
    @Persisted var mail: String?
    @Persisted var phone: String?
    @Persisted var profile: Int
    @Persisted var friends: List<User>
    @Persisted var createdDate: Date
    
    convenience init(nickname: String, mail: String? = nil, phone: String? = nil, profile: Int, friends: List<User> = List<User>()) {
            self.init()
                self._id = ObjectId.generate()
                self.nickname = ""
                self.mail = nil
                self.phone = nil
                self.profile = 0
                self.friends = List<User>()
                self.createdDate = Date()
            }
        
    
   
}

