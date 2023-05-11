//
//  AppData.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/06.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var isLoggedIn = false
    @Published var userList = [
        User(
            userId: 1,
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
                    nickname: "모아나",
                    planetImage: 0,
                    videos: []
                ),
                Friend(
                    nickname: "머슥후",
                    planetImage: 1,
                    videos: []
                ),
                Friend(
                    nickname: "우디",
                    planetImage: 0,
                    videos: []
                ),
                Friend(
                    nickname: "쨈",
                    planetImage: 2,
                    videos: []
                ),
                Friend(
                    nickname: "돈",
                    planetImage: 3,
                    videos: []
                ),
            ],
            inbox: Inbox(videos: [
                VideoMessage(
                    messageId: 1,
                    senderId: 2,
                    receiverId: 1,
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
                    senderId: 3,
                    receiverId: 1,
                    createdDate: Date(),
                    unlockedDate: Date(),
                    editingCount: 3,
                    title: "사랑하는 OdO 에게",
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
                    title: "사랑하는 OffO 에게",
                    category: "생일",
                    videoSrc: "",
                    isCompleted: true,
                    hideAtSender: false,
                    hideAtReceiver: false
                )
            ])
        ),
        User(userId: 2, nickname: "musk", mail: "musk@exmaple.com", phone: "010-0000-0000", profile: "test", categories: [], friends: [], inbox: Inbox()),
        User(userId: 3, nickname: "moana", mail: "moana@exmaple.com", phone: "010-0000-0000", profile: "test", categories: [], friends: [], inbox: Inbox())
    ]
    func getUserNicknameById(userId: Int) -> String{
        return userList[userId].nickname
    }
    func getPeopleFromVideos(videos: [VideoMessage]) -> [Int]{
        let uniqueVideos = videos.reduce(into: [Int: VideoMessage]()) { result, video in
            guard result[video.senderId] == nil else { return } // 이미 저장된 VideoMessage가 있는 경우 skip
            result[video.senderId] = video
        }
        let uniqueSenderIds = Array(uniqueVideos.keys)
        
        return uniqueSenderIds
    }
    
    @Published var user =
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
//                nickname: "모아나",
//                planetImage: 0,
                videos: []
            ),
            Friend(
                nickname: "머슥후",
                planetImage: 1,
                videos: []
            ),
            Friend(
                nickname: "우디",
                planetImage: 4,
                videos: []
            ),
            Friend(
                nickname: "쨈",
                planetImage: 2,
                videos: []
            ),
            Friend(
                nickname: "돈",
                planetImage: 3,
                videos: []
            ),
        ],
        inbox: Inbox(videos: [
            VideoMessage(
                messageId: 1,
                senderId: 0,
                receiverId: 1,
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
                messageId: 2,
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
                messageId: 3,
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
            )
        ])
    )
    
}
