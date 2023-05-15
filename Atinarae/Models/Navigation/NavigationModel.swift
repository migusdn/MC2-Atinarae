//
//  NavigationController.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/13.
//

import Foundation
class NavigationModel: ObservableObject {
//    @Published var mainViewIsActive = false
    @Published var MessageAddProcessIsActive = false
    @Published var recordViewIsActive = false
//
    func MessageAddProcessEnter(){
        MessageAddProcessIsActive = true
    }
    func MessageAddProcessExit(){
        MessageAddProcessIsActive = false
    }
}
