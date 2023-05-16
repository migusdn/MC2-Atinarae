//
//  VideoMessageViewModel.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/13.
//
import Foundation
import RealmSwift

class VideoMessageViewModel: ObservableObject {
    @Published var videoMessages: [VideoMessage] = []
    
    init() {
        // Initialize the view model with data or fetch the data from a data source
        fetchVideoMessages()
    }
    
    func fetchVideoMessages() {
        // Fetch the video messages from a data source and update the published property
        // For example, using Realm:
        do {
            let realm = try Realm()
            videoMessages = Array(realm.objects(VideoMessage.self))
        } catch {
            print("Failed to fetch video messages: \(error)")
        }
    }
    
    func addVideoMessage(_ videoMessage: VideoMessage) {
        // Add a new video message to the data source and update the published property
        // For example, using Realm:
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(videoMessage)
            }
            videoMessages.append(videoMessage)
        } catch {
            print("Failed to add video message: \(error)")
        }
    }
    
    func deleteVideoMessage(_ videoMessage: VideoMessage) {
        // Delete a video message from the data source and update the published property
        // For example, using Realm:
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(videoMessage)
            }
            if let index = videoMessages.firstIndex(of: videoMessage) {
                videoMessages.remove(at: index)
            }
        } catch {
            print("Failed to delete video message: \(error)")
        }
    }
    func getVideoMessages(forUser user: User, isInbox: Bool) -> [VideoMessage] {
        // Fetch the video messages based on the user and whether they are the sender or receiver
        // For example, using Realm:
        print("뭐가 문제야")
//        print(user)
        do {
            let realm = try Realm()
            let filteredMessages = realm.objects(VideoMessage.self)
//                .filter("sender = %@", user)
//                .filter("sender = %@", user)
                .filter(isInbox ? "receiverId = %@" : "senderId = %@", user._id)
            print(filteredMessages)
            return Array(filteredMessages)
            
        } catch {
            print("Failed to fetch video messages: \(error)")
            return []
        }
    }
    
    func refresh() {
            // Refresh the video messages by fetching the latest data from the data source
            fetchVideoMessages()
        }
    
    // Detail의 User와, 쿼리를 때릴 User를 받아와서 해야함.
    // DetailUser가 reciver 고정으로 되어야 하고, 쿼리를 때릴 User는 sender여야함.
    func getDetailVideoMessages(forUser Detailuser: User) -> [VideoMessage] {
        do {
            let realm = try Realm()
            let filteredMessages = realm.objects(VideoMessage.self)
                .filter("receiverId = %@", Detailuser._id)
            print(filteredMessages)
            return Array(filteredMessages)
            
        } catch {
            print("Failed to fetch video messages: \(error)")
            return []
        }
    }

}

