//
//  MessageListView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/09.
//

import SwiftUI

struct MessageListView: View {
    @EnvironmentObject var appData: AppData
    //    let test: [Int]
    let options = ["Option 1", "Option 2", "Option 3"]
    @State private var selectedMenu = -1
    
    func textTag(text:String, color:Color) -> some View{
        Text(text)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(color)
            )
            .frame(width: 40, height: 35)
            .padding(.leading, 0)
            .padding(.trailing,0)
    }
    var messages:[VideoMessage]
    var isSenderView: Bool
    let targetDate = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1))!
    var filteredData: [VideoMessage] {
        if selectedMenu == -1 {
            return messages
        } else {
            return isSenderView ? messages.filter{ $0.receiverId==selectedMenu } : messages.filter { $0.senderId==selectedMenu }
        }
    }
    var body: some View {
        
        //        Text("hello")
        ZStack{
            //            .padding()
            
            List{
                ForEach(filteredData, id: \.self) { message in
                    HStack{
                        VStack(alignment: .leading, spacing: 8) {
                            Text(message.title)
                                .font(.headline)
                            HStack {
                                if isSenderView{
                                    textTag(
                                        text: message.category,
                                        color: .tagColor
                                    )
                                }else{
                                    Text(appData.getUserNicknameById(userId: message.senderId))
                                        .font(.subheadline)
                                        .fontWeight(.bold)
                                        .padding(.leading, 0)
                                        .padding(.trailing,0)
                                }
                                Text(formatDate(message.unlockedDate))
                                    .font(.subheadline)
                            }
                        }
                        Spacer();
                        if isSenderView == true{
                            Text("D-\(calculateDDay(targetDate: targetDate) ?? 0)")
                        }
                    }
                    .padding()
                    .listRowInsets(EdgeInsets())
                    //                    .background(Color.blue)
                }
                //                .padding()
                
            }
            .padding(.top,0)
            //            .padding(EdgeInsets(top: , leading: 0, bottom: 0, trailing: 0))
            VStack{
                filterByPersonMenu
                    .background(Color.black)
                Spacer()
            }
            
            .padding(.vertical,0)
            .padding(.horizontal)
            
            
        }
        
        
    }
    var filterByPersonMenu: some View{
        HStack{
            Menu {
                Button(action:{
                    selectedMenu = -1
                }){
                    if selectedMenu == -1 {
                        Image(systemName: "chevron.down")
                    }
                    Text("전체보기")
                }
                // Dropdown 항목을 반복하여 추가합니다.
                ForEach(appData.getPeopleFromVideos(videos: messages, isSender: isSenderView), id: \.self) { option in
                    Button(action:{
                        selectedMenu = option
                    }) {
                        HStack{
                            if selectedMenu == option{
                                Image(systemName: "chevron.down")
                            }
                            // 항목을 선택하면 selectedOption 변수를 업데이트합니다.
                            Text(appData.getUserNicknameById(userId: option))
                        }
                    }
                }
            } label: {
                Image(systemName: "chevron.down")
                if selectedMenu == -1{
                    Text("전체보기")
                }else{
                    Text(appData.getUserNicknameById(userId: selectedMenu))
                }
                Spacer()
                Text("디데이순")
            }
            .foregroundColor(Color.primary)
            .menuStyle(BorderlessButtonMenuStyle())
            
            
        }
    }
}


struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        let appData = AppData()
        VStack{
            MessageListView(messages: appData.getUserInboxByUserId(appData.user.userId), isSenderView: false)
                .environmentObject(appData)
            MessageListView(messages: appData.getUserOutboxByUserId(appData.user.userId), isSenderView: true)
                .environmentObject(appData)
        }
    }
}
