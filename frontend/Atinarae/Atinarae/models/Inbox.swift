//
//  Inbox.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/02.
//

import Foundation
struct Inbox: Equatable, Hashable {
    var videos: [VideoMessage]

    static func == (lhs: Inbox, rhs: Inbox) -> Bool {
        return lhs.videos == rhs.videos
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(videos)
    }

    init(videos: [VideoMessage]) {
        self.videos = videos
    }
}
