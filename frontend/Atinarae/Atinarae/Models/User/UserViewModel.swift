//
//  UserViewModel.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/13.
//

import SwiftUI
import RealmSwift

class UserViewModel: ObservableObject {

    private var realm: Realm
    private var users: Results<User> {
        realm.objects(User.self)
    }

// MARK: - currentUser Store var (Important) - 자동 생성 박아놓음
/**
 그럴 일은 없겠지만 APP 진입점에 선언해논 함수가 사라지면
 userViewModel.setCurrentUser()
 하면 됨
*/
    @Published var currentUser: User?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
        setCurrentUser()
    }
    
    
// MARK: - 새로운 유저 생성 파라미터 값을 이용.
    func createUser(nickname: String, mail: String, phone: String, profile: Int, friends: [User]) {
        guard users.filter("nickname == %@", nickname).isEmpty else {
                print("Nickname already exists")
                return
            }
        let newUser = User()
        newUser._id = ObjectId.generate()
        newUser.nickname = nickname
        newUser.mail = mail
        newUser.phone = phone
        newUser.profile = profile
        newUser.friends.append(objectsIn: friends)
        
        do {
            try realm.write {
                realm.add(newUser)
            }
        } catch {
            print("Failed to create user: \(error)")
        }
    }
// MARK: - 새로운 유저 생성 User 객체를 이용.
    func createUser(user: User) {
        guard users.filter("nickname == %@", user.nickname).isEmpty else {
            print("Nickname already exists")
            return
        }
        do {
            try realm.write {
                realm.add(user)
            }
        } catch {
            print("Failed to create user: \(error)")
        }
    }
// MARK: - 모든 유저 쿼리 AKA FetchAll || SELECT * FROM USER
    func readUsers() -> [User] {
        Array(users)
    }
// MARK: - 특정 유저 업데이트
    func updateUser(user: User, nickname: String, mail: String, phone: String, profile: Int, friends: [User]) {
        do {
            try realm.write {
                user.nickname = nickname
                user.mail = mail
                user.phone = phone
                user.profile = profile
                user.friends.removeAll()
                user.friends.append(objectsIn: friends)
            }
        } catch {
            print("Failed to update user: \(error)")
        }
    }
// MARK: - 특정 유저 삭제
    func deleteUser(user: User) {
        do {
            try realm.write {
                realm.delete(user)
            }
        } catch {
            print("Failed to delete user: \(error)")
        }
    }
// MARK: - APP INIT시 사용하는 부분으로 건들지 말것
    func setCurrentUser() {
            if users.isEmpty {
                // 사용자가 없을 경우 새로운 사용자 생성
                let newNickname = "J2335ohn"
                let newMail = "john@example.com"
                let newPhone = "123-456-7890"
                let newProfile = 1
                let newFriends: [User] = []
                createUser(nickname: newNickname, mail: newMail, phone: newPhone, profile: newProfile, friends: newFriends)
            }
            
            // 첫 번째 사용자를 현재 사용자로 설정
            currentUser = users.first
        }
// MARK: - ObservableObject를 업데이트 함으로서 해당 변수를 참조하고 있는 모든 뷰에 새로고침이 가능해짐.
    func refresh() {
            do {
                // Fetch the latest users data from the database
                let users = realm.objects(User.self)
                
                // Update the published properties with the latest data
                currentUser = users.first
                
                // You can also update other properties or perform additional logic here
                print("currentUser init success: \(currentUser)")
            } catch {
                print("Failed to refresh data: \(error)")
            }
        }
// MARK: - CurrentUser의 친구 목록을 조회하고 이를 반환.
    func getFriendsList() -> [User] {
            guard let currentUser = currentUser else {
                return []
            }
            return Array(currentUser.friends)
        }
// MARK: - CurrentUser의 친구 목록에 새로운 User를 추가.
    func addFriend(friend: User) {
        guard let currentUser = currentUser else {
            return
        }
        
        do {
            try realm.write {
                //유저가 없다면 새로운 유저를 생성하고 이를 추가하는 코드 지워도 됨 머식머식
                createUser(user: friend)
                currentUser.friends.append(friend)
            }
        } catch {
            print("Failed to add friend: \(error)")
        }
    }
    
    func isExist(_ user: User) -> Bool {
        guard users.filter("nickname == %@", user.nickname).isEmpty else {
            print("Nickname already exists")
            return true
        }
        return false
    }
}

