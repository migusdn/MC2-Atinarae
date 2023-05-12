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
struct AtinaraeApp: App {
    let appData = AppData()
    var body: some Scene {
        WindowGroup {
                LunchPage()
                .environmentObject(appData)
        }
    }
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
        if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appData.groupIdentifier) {
                appData.appContainerURL = containerURL
                print("App Group Container URL: \(containerURL)")
                // 이제 containerURL을 사용하여 앱 그룹 컨테이너에서 파일을 읽고 쓸 수 있습니다.
            } else {
                print("Failed to get App Group Container URL")
            }
        }
}
