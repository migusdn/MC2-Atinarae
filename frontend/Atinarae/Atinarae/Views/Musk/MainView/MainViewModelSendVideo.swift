//
//  MainViewModelSendVideo.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/13.
//

import SwiftUI

struct MainViewModelSendVideo: View {
    @EnvironmentObject var navModel: NavigationModel
    var body: some View {
        
        NavigationLink ("영상 보내기",destination: MessageSettingsView(), isActive: $navModel.MessageAddProcessIsActive)
            .isDetailLink(false)
            .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
            
        
    }
}

struct MainViewModelSendVideo_Previews: PreviewProvider {
    static var previews: some View {
        MainViewModelSendVideo()
    }
}
