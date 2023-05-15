//
//  InboxView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/08.
//

import SwiftUI

struct InboxView: View {
    @EnvironmentObject var appData: AppData
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            VStack{
                MessageListView(messages: appData.getUserInboxByUserId(appData.user.userId), isSenderView: false)
                    .padding(.top, 40)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle(
                        Text("MY")
                        , displayMode: .inline)
                    .navigationBarItems(
                        leading:
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                            }
                        //                trailing:
                        //                    Button(action: {
                        //                        // 오른쪽 아이템을 클릭했을 때의 동작
                        //                    }) {
                        //                        Image(systemName: "plus")
                        //                    }
                    )
                    .accentColor(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        var appData = AppData()
        InboxView()
            .environmentObject(appData)
    }
}
