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
            
                MainView()
            
//                OnBoardView()
                //                            OnBoard()
                    .environmentObject(userViewModel)
                    .environmentObject(videoMessageViewModel)
                    .environmentObject(navigationModel)
            
        }
    }
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
        
        // TODO: 여기도 반드시 한번 보기를 바랍니다.
        // MARK: - Dev Initialize !! Warn
        /*
         * 만약 이상하면
         *      file:///Users/hyunwoopark/Library/Developer/CoreSimulator/Devices/EF1FE056-8E03-4A96-B773-75E732A692CB/data/Containers/Data/Application/BDE6FC9B-DE2E-43C8-AC64-2DE8A3B3DD80/Documents/default.realm
         *   파일 path가 이거라치면
         *   terminal 에서 rm -rf /Users/hyunwoopark/Library/Developer/CoreSimulator/Devices/EF1FE056-8E03-4A96-B773-75E732A692CB/data/Containers/Data/Application/BDE6FC9B-DE2E-43C8-AC64-2DE8A3B3DD80/Documents
         로 날려버리면 잘됨.
         */
        
        RealmUtility.createNewRealm()
        let isDev = true
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
        
    }
}
