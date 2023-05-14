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
    func refresh() {
            // Refresh the video messages by fetching the latest data from the data source
            fetchVideoMessages()
        }

}
