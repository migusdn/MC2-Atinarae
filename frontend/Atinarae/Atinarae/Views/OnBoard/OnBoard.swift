//
//  OnBoard.swift
//  Atinarae
//
//  Created by Kimdohyun on 2023/05/10.
//

import Foundation
import SwiftUI

struct onBoard: View{
    @EnvironmentObject var navModel: NavigationModel
    var body: some View {
        NavigationView{
            VStack{
                
                
                NavigationLink ("살려줍메",destination: MessageSettingsView(), isActive: $navModel.MessageAddProcessIsActive)
                    .isDetailLink(false)
                    .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                NavigationLink ("살려줍메",destination: MessageSettingsView(), isActive: $navModel.MessageAddProcessIsActive)
                    .isDetailLink(false)
                    .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                
                    
                }
            }
        }
    }

