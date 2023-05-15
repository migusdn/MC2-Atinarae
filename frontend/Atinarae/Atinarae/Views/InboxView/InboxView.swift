//
//  InboxView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/08.
//

import SwiftUI

struct InboxView: View {
    @EnvironmentObject var videoMsgViewModel: VideoMessageViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
            VStack{
//                MessageListView(
//                    messages: videoMsgViewModel.videoMessages, isSenderView: false)
                MessageListView(
                    messages: videoMsgViewModel.getVideoMessages(
                        forUser: userViewModel.currentUser!,
                        isInbox: true), isInbox: true)
                    .padding(.top, 40)
                    .toolbar {
                        ToolbarItemGroup(placement: .principal) {
                            HStack{
                                Spacer()
                                Text("MY")
//                                Text(String(self.users?[planetLotateNumber].nickname ?? ""))
//                                    .opacity(scrollOffsetDetect <= 0 ? 0.008 * -scrollOffsetDetect:0)
                                Spacer()


                            }   //HStack

                        }   // ToolbarItemGroup

                    }
//                    .navigationBarBackButtonHidden(true)
//                    .navigationBarTitle(
//                        Text("MY")
//                        , displayMode: .inline)
//                    .navigationBarItems(
//                        leading:
//                            Button(action: {
//                                presentationMode.wrappedValue.dismiss()
//                            }) {
//                                Image(systemName: "chevron.left")
//                            }
//                    )
                    .accentColor(.white)
            }
            .onAppear{
                print("Inbox View video message")
                print(videoMsgViewModel.getVideoMessages(
                    forUser: userViewModel.currentUser!,
                    isInbox: false))
            }
        
//        .navigationBarBackButtonHidden(true)
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
//        var appData = AppData()
        InboxView()
//            .environmentObject(appData)
    }
}
