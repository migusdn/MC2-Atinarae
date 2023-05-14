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
import RealmSwift
@main
struct AtinaraeApp: SwiftUI.App {
    
    
    
    
    
    /*  MARK: - Define Overall App Color
     *  AccentColor와 BackgroundColor를 지정하는 선언부
     *  위 색을 변경하고 싶으면 Assets.xcassets안의
     *  AccentColor와 BackgorundColor를 우 상단의 inspector에서 변경하면 됨.
     */
    var accentColor = Color("AccentColor")
    var backgroundColor = Color("BackgroundColor")
    
    
    // MARK: - Define App Variable
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var videoMessageViewModel = VideoMessageViewModel()
    @StateObject private var navigationModel = NavigationModel()
    var body: some Scene {
        
        WindowGroup {
            onBoard()
                .environmentObject(userViewModel)
                .environmentObject(videoMessageViewModel)
                .environmentObject(navigationModel)
        }
    }
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
        
        // MARK: - Dev Initialize !! Warn
        /*
         * 만약 이상하면
         *      file:///Users/hyunwoopark/Library/Developer/CoreSimulator/Devices/EF1FE056-8E03-4A96-B773-75E732A692CB/data/Containers/Data/Application/BDE6FC9B-DE2E-43C8-AC64-2DE8A3B3DD80/Documents/default.realm
         *   파일 path가 이거라치면
         *   terminal 에서 rm -rf /Users/hyunwoopark/Library/Developer/CoreSimulator/Devices/EF1FE056-8E03-4A96-B773-75E732A692CB/data/Containers/Data/Application/BDE6FC9B-DE2E-43C8-AC64-2DE8A3B3DD80/Documents
         로 날려버리면 잘됨.
         */
        
        RealmUtility.createNewRealm()
        let isDev = !true
        if isDev {
            
            RealmUtility.initTestData()
            print("currentUser init success: \($userViewModel.currentUser)")
            print("realm_path =  \(Realm.Configuration.defaultConfiguration.fileURL!)")
            
            
            print("한번 실행하고 나면 isDev 꺼주세요 이상한 오류나는데 못잡겠어요 흑")
            print("=============================================================================================")
            print("To view the Realm database, execute the following command in the terminal:")
            print("open \(Realm.Configuration.defaultConfiguration.fileURL!.path)\n\n")
            print("If an error occurs, execute the following command in the terminal:")
            print("rm -rf \(Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().path)\n\n")
            print("=============================================================================================")
        }
        
        
        //        if let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appData.groupIdentifier) {
        //                appData.appContainerURL = containerURL
        //                print("App Group Container URL: \(containerURL)")
        //                // 이제 containerURL을 사용하여 앱 그룹 컨테이너에서 파일을 읽고 쓸 수 있습니다.
        //            } else {
        //                print("Failed to get App Group Container URL")
        //            }
        
        //        let newUserID = ObjectId() // 새로운 사용자의 ID 생성
        //                    let newNickname = "J2335ohn"
        //                    let newMail = "john@example.com"
        //                    let newPhone = "123-456-7890"
        //                    let newProfile = "profile.jpg"
        //                    let newFriends: [User] = [] // 새로운 사용자의 친구 목록
        //        userViewModel.createUser(nickname: newNickname, mail: newMail, phone: newPhone, profile: newProfile, friends: newFriends)
        
        
    }
}
