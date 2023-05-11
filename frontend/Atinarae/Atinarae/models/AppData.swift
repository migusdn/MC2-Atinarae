//
//  AppData.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/06.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var appContainerURL : URL?
    @Published var isLoggedIn = false
    @Published var userList : [User]
    @Published var videoMessages : [VideoMessage]
    @Published var user: User
    init(isLoggedIn: Bool = false, userList: [User] = [
        User(
            userId: 0,
            nickname: "hypark",
            mail: "hypark@example.com",
            phone: "010-0000-0000",
            profile: "assetsPath",
            categories: [
                "생일",
                "기념일",
                "기타 등등",
                "custom"
            ],
            friends: [
                Friend(
                    userId: 3,
                    nickname: "모아나",
                    planetImage: 0,
                    videos: []
                ),
                Friend(
                    userId: 2,
                    nickname: "쨈",
                    planetImage: 2,
                    videos: []
                ),
                Friend(
                    userId: 2,
                    nickname: "돈",
                    planetImage: 3,
                    videos: []
                ),
                Friend(
                    userId: 1,
                    nickname: "머스크",
                    planetImage:4,
                    videos: []
                ),
                Friend(
                    userId: 4,
                    nickname: "제이미",
                    planetImage:0,
                    videos: []
                ),
                Friend(
                    userId: 2,
                    nickname: "우디",
                    planetImage:0,
                    videos: []
                )
            ]
//            inbox: Inbox(videos: )
        ),
        User(userId: 1, nickname: "musk", mail: "musk@exmaple.com", phone: "010-0000-0000", profile: "test", categories: [], friends: []),
        User(userId: 2, nickname: "zam", mail: "musk@exmaple.com", phone: "010-0000-0000", profile: "test", categories: [], friends: []),
        User(userId: 3, nickname: "moana", mail: "moana@exmaple.com", phone: "010-0000-0000", profile: "test", categories: [], friends: []),
        User(userId: 4, nickname: "jamie", mail: "moana@exmaple.com", phone: "010-0000-0000", profile: "test", categories: [], friends: [])
        
    ], videoMessages: [VideoMessage] = [
        VideoMessage(
            messageId: 0,
            senderId: 0,
            receiverId: 3,
            createdDate: Date(),
            unlockedDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1))!,
            editingCount: 3,
            title: "사랑하는 OO 에게",
            category: "생일",
            videoSrc: "",
            isCompleted: true,
            hideAtSender: false,
            hideAtReceiver: false
        ),
        VideoMessage(
            messageId: 1,
            senderId: 0,
            receiverId: 1,
            createdDate: Date(),
            unlockedDate: Date(),
            editingCount: 3,
            title: "사랑하는 OO 에게",
            category: "생일",
            videoSrc: "",
            isCompleted: true,
            hideAtSender: false,
            hideAtReceiver: false
        ),
        VideoMessage(
            messageId: 2,
            senderId: 0,
            receiverId: 3,
            createdDate: Date(),
            unlockedDate: Date(),
            editingCount: 3,
            title: "사랑하는 OO 에게",
            category: "생일",
            videoSrc: "",
            isCompleted: true,
            hideAtSender: false,
            hideAtReceiver: false
        ),
        VideoMessage(
            messageId: 3,
            senderId: 4,
            receiverId: 0,
            createdDate: Date(),
            unlockedDate: Date(),
            editingCount: 3,
            title: "사랑하는 OOd 에게",
            category: "생일",
            videoSrc: "",
            isCompleted: true,
            hideAtSender: false,
            hideAtReceiver: false
        ),
        VideoMessage(
            messageId: 4,
            senderId: 2,
            receiverId: 0,
            createdDate: Date(),
            unlockedDate: Date(),
            editingCount: 3,
            title: "사랑하는 OOf 에게",
            category: "생일",
            videoSrc: "",
            isCompleted: true,
            hideAtSender: false,
            hideAtReceiver: false
        )
    ]) {
        self.isLoggedIn = isLoggedIn
        self.userList = userList
        self.user = userList[0]
        self.videoMessages = videoMessages
    }
    func getUserNicknameById(userId: Int) -> String{
        return userList[userId].nickname
    }
    func getPeopleFromVideos(videos: [VideoMessage], isSender:Bool) -> [Int]{
        if isSender{
            let uniqueVideos = videos.reduce(into: [Int: VideoMessage]()) { result, video in
                guard result[video.receiverId] == nil else { return } // 이미 저장된 VideoMessage가 있는 경우 skip
                result[video.receiverId] = video
            }
            let uniqueSenderIds = Array(uniqueVideos.keys)
            
            return uniqueSenderIds
            
        } else{
            let uniqueVideos = videos.reduce(into: [Int: VideoMessage]()) { result, video in
                guard result[video.senderId] == nil else { return } // 이미 저장된 VideoMessage가 있는 경우 skip
                result[video.senderId] = video
            }
            let uniqueSenderIds = Array(uniqueVideos.keys)
            return uniqueSenderIds
        }
    }
    func getUserInboxByUserId(_ userId: Int) -> [VideoMessage]{
        return videoMessages.filter{$0.receiverId == userId}
    }
    func getUserOutboxByUserId(_ userId: Int) -> [VideoMessage]{
        return videoMessages.filter{$0.senderId == userId}
    }
    func getTempVideoMessage() -> VideoMessage {
        return VideoMessage(
            messageId: videoMessages.count+1,
            senderId: -1,
            receiverId: -1,
            createdDate: Date(),
            unlockedDate: Date(),
            editingCount: 0,
            title: "",
            category: "",
            videoSrc: "",
            isCompleted: false,
            hideAtSender: false,
            hideAtReceiver: false
        )
    }
    func addVideo(_ video: VideoMessage){
        self.videoMessages.append(video)
    }
    
    
    
    
    
}
