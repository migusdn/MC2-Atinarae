//
//  Message.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/02.
//
import Foundation
import RealmSwift

class VideoMessage: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var sender: User?
    @Persisted var receiver: User?
    @Persisted var createdDate: Date
    @Persisted var unlockedDate: Date?
    @Persisted var editingCount: Int
    @Persisted var title: String
    @Persisted var category: Category?
    @Persisted var videoSrc: String
    @Persisted var isCompleted: Bool
    @Persisted var hideAtSender: Bool
    @Persisted var hideAtReceiver: Bool
    
    
}
