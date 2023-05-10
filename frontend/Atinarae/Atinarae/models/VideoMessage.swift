//
//  Message.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/02.
//
import Foundation

struct VideoMessage: Hashable, Equatable{
   var messageId: Int
   var senderId: Int
   var receiverId: Int
   var createdDate: Date
   var unlockedDate: Date
   var editingCount: Int
   var title: String
   var category: String
   var videoSrc: String
   var isCompleted: Bool
   var hideAtSender: Bool
   var hideAtReceiver: Bool
    
    init(messageId: Int, senderId: Int, receiverId: Int, createdDate: Date, unlockedDate: Date, editingCount: Int, title: String, category: String, videoSrc: String, isCompleted: Bool, hideAtSender: Bool, hideAtReceiver: Bool) {
        self.messageId = messageId
        self.senderId = senderId
        self.receiverId = receiverId
        self.createdDate = createdDate
        self.unlockedDate = unlockedDate
        self.editingCount = editingCount
        self.title = title
        self.category = category
        self.videoSrc = videoSrc
        self.isCompleted = isCompleted
        self.hideAtSender = hideAtSender
        self.hideAtReceiver = hideAtReceiver
    }
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
        hasher.combine(senderId)
        hasher.combine(receiverId)
        hasher.combine(createdDate)
        hasher.combine(unlockedDate)
        hasher.combine(editingCount)
        hasher.combine(title)
        hasher.combine(category)
        hasher.combine(videoSrc)
        hasher.combine(isCompleted)
        hasher.combine(hideAtSender)
        hasher.combine(hideAtReceiver)
    }
    
    static func == (lhs: VideoMessage, rhs: VideoMessage) -> Bool {
        return lhs.messageId == rhs.messageId &&
        lhs.senderId == rhs.senderId &&
        lhs.receiverId == rhs.receiverId &&
        lhs.createdDate == rhs.createdDate &&
        lhs.unlockedDate == rhs.unlockedDate &&
        lhs.editingCount == rhs.editingCount &&
        lhs.title == rhs.title &&
        lhs.category == rhs.category &&
        lhs.videoSrc == rhs.videoSrc &&
        lhs.isCompleted == rhs.isCompleted &&
        lhs.hideAtSender == rhs.hideAtSender &&
        lhs.hideAtReceiver == rhs.hideAtReceiver
    }
}
