//
//  RealmUtility.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/14.
//

import Foundation
import RealmSwift
// MARK: - Realm 관련 function 모음

class RealmUtility {
    static func createNewRealm() {
        let realmConfig = Realm.Configuration(
            schemaVersion: 0, // 스키마 버전
            deleteRealmIfMigrationNeeded: true // 마이그레이션 필요 시 데이터베이스 삭제
        )
        
        do {
            let realm = try Realm(configuration: realmConfig)
            // 생성된 Realm 인스턴스를 사용하여 작업 수행
        } catch let error {
            // Realm 초기화 중 오류가 발생한 경우 처리
            print("Failed to create Realm: \(error)")
        }
    }
    static func initTestData(){
        
        do {
            let realm = try Realm()
            // 생성된 Realm 인스턴스를 사용하여 작업 수행
            let users = realm.objects(User.self)
            print(users.count)
            if users.count != 0{
                return
            }
            print("users.count")
            // 사용자 객체 생성
            let user1 = User()
            user1.nickname = "우디"
            
            let user2 = User()
            user2.nickname = "모아나"
            
            let user3 = User()
            user3.nickname = "돈"
            
            let user4 = User()
            user4.nickname = "잼"
            
            let user5 = User()
            user5.nickname = "제이미"
            
            let user6 = User()
            user6.nickname = "머식이"
            
            let categoryNames = [
                "수능", "결혼", "졸업", "여행", "생일", "휴가", "운동", "영화", "책", "음식",
                "댄스", "음악", "미술", "사진", "공연", "축구", "농구", "야구", "배구", "수영",
                "요가", "등산", "서핑", "자전거", "쇼핑", "요리", "독서", "게임", "피아노"
            ]
            
            var categories: [Category] = []
            
            // 각 유저마다 5개의 카테고리 생성
            for user in [user1, user2, user3, user4, user5, user6] {
                for _ in 0..<5 {
                    let category = Category()
                    category.name = generateRandomCategoryName()
                    category.user = user
                    categories.append(category)
                }
            }
            
            // 랜덤한 카테고리 이름을 생성하는 함수
            func generateRandomCategoryName() -> String {
                let randomIndex = Int.random(in: 0..<categoryNames.count)
                return categoryNames[randomIndex]
            }
            // 메시지 생성
            var messages: [VideoMessage] = []
            let senderUsers: [User] = [user2, user3, user4, user5, user6]
            for senderUser in senderUsers {
                var senderUserId = senderUser._id
                for _ in 1...2 {
                    let receiverMessage = VideoMessage()
                    receiverMessage._id = ObjectId.generate()
                    receiverMessage.senderId = senderUserId
                    receiverMessage.receiverId = user1._id
                    receiverMessage.createdDate = Date()
                    receiverMessage.unlockedDate = nil
                    receiverMessage.editingCount = 0
                    receiverMessage.title = "Receiver Message"
                    receiverMessage.videoSrc = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
                    receiverMessage.isCompleted = false
                    receiverMessage.hideAtSender = false
                    receiverMessage.hideAtReceiver = false
                    messages.append(receiverMessage)
                    let senderMessage = VideoMessage()
                    senderMessage._id = ObjectId.generate()
                    senderMessage.senderId = user1._id
                    senderMessage.receiverId = senderUserId
                    senderMessage.createdDate = Date()
                    senderMessage.unlockedDate = nil
                    senderMessage.editingCount = 0
                    senderMessage.title = "Sender Message"
                    senderMessage.videoSrc = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
                    senderMessage.isCompleted = false
                    senderMessage.hideAtSender = false
                    senderMessage.hideAtReceiver = false
                    messages.append(senderMessage)
                }
            }
            // 각 사용자마다 25개의 메시지 생성
//            for _ in 1...25 {
//                let message1 = VideoMessage()
//                message1.sender = user1
//                message1.receiver = user2
//                message1.createdDate = Date()
//                message1.unlockedDate = nil
//                message1.editingCount = 0
//                message1.title = "메시지 1"
//                message1.videoSrc = "video1.mp4"
//                message1.isCompleted = false
//                message1.hideAtSender = false
//                message1.hideAtReceiver = false
//                messages.append(message1)
//
//                let message2 = VideoMessage()
//                message2.sender = user1
//                message2.receiver = user3
//                message2.createdDate = Date()
//                message2.unlockedDate = nil
//                message2.editingCount = 0
//                message2.title = "메시지 2"
//                message2.videoSrc = "video2.mp4"
//                message2.isCompleted = false
//                message2.hideAtSender = false
//                message2.hideAtReceiver = false
//                messages.append(message2)
//
//                // 나머지 사용자와 메시지 생성
//                for _ in 1...25 {
//                    let message3 = VideoMessage()
//                    message3.sender = user1
//                    message3.receiver = user4
//                    message3.createdDate = Date()
//                    message3.unlockedDate = nil
//                    message3.editingCount = 0
//                    message3.title = "메시지 3"
//                    message3.videoSrc = "video3.mp4"
//                    message3.isCompleted = false
//                    message3.hideAtSender = false
//                    message3.hideAtReceiver = false
//                    messages.append(message3)
//
//                    let message4 = VideoMessage()
//                    message4.sender = user1
//                    message4.receiver = user5
//                    message4.createdDate = Date()
//                    message4.unlockedDate = nil
//                    message4.editingCount = 0
//                    message4.title = "메시지 4"
//                    message4.videoSrc = "video4.mp4"
//                    message4.isCompleted = false
//                    message4.hideAtSender = false
//                    message4.hideAtReceiver = false
//                    messages.append(message4)
//
//                    let message5 = VideoMessage()
//                    message5.sender = user1
//                    message5.receiver = user6
//                    message5.createdDate = Date()
//                    message5.unlockedDate = nil
//                    message5.editingCount = 0
//                    message5.title = "메시지 5"
//                    message5.videoSrc = "video5.mp4"
//                    message5.isCompleted = false
//                    message5.hideAtSender = false
//                    message5.hideAtReceiver = false
//                    messages.append(message5)
//                }
////                guard user1.friends.filter("nickname == %@", user2.nickname).isEmpty else {
////                    print("Nickname already exists")
////                    return
////                }
//
//
//            }
            try realm.write {
                
                user1.friends.append(user2)
                user1.friends.append(user3)
                user1.friends.append(user4)
                user1.friends.append(user5)
                user2.friends.append(user6)
                print("Initial data created successfully.")
                realm.add([user1, user2, user3, user4, user5, user6])
                realm.add(messages)
                realm.add(categories)
                print("왜와이 여기깢")
                
            }
        } catch let error {
            // Realm 초기화 중 오류가 발생한 경우 처리
            print("Failed to create Realm: \(error)")
        }
    }
}




