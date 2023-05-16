//
//  DetailBoxView.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/16.
//

import SwiftUI
// 세상에 사랑 관련된 노래가 너무 많아
// 그럼 그걸 빼고 노래해 볼까
// 세상엔 잘 안보이는 행복이 너무 많아
// 사랑보다 행복한 걸 찾을래
struct DetailBoxView: View {
    @EnvironmentObject var videoMsgViewModel: VideoMessageViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    var planetLotateNumber: Int
    
    var body: some View {
        VStack{
            MessageListView(
                messages: videoMsgViewModel.getDetailVideoMessages(forUser: (userViewModel.currentUser?.friends[planetLotateNumber])!), isInbox: true)
                .padding(.top, 40)
  
        }
    }
}

//struct DetailBoxView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailBoxView()
//    }
//}
