//
//  AtinaraeApp.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/04/30.
//

//  ----------------------------------------------------------------------
//
//
//
//  ----------------------------------------------------------------------

import SwiftUI

@main
//struct AtinaraeApp: App {
//    let appData = AppData()
//    var body: some Scene {
//        WindowGroup {
//            LunchPage()
////            VideoSettingsView()
//                .environmentObject(appData)
//        }
//    }
//}
struct testConsoleApp{
    static func main(){
        let appData = AppData();
        
        print(appData.getPeopleFromVideos(videos: appData.user.inbox.videos))
    }
}
