////
////  MessageListView.swift
////  Atinarae
////
////  Created by HyunwooPark on 2023/05/09.
////
//
import SwiftUI


import SwiftUI

struct MessageListView: View {
    let options = ["Option 1", "Option 2", "Option 3"]
    @State private var selectedPerson: User?
    
    @State private var isPresented = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    func textTag(text: String, color: Color) -> some View {
        Text(text)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 6)
                    .fill(color)
            )
//            .frame(width: 40, height: 35)
            .padding(.leading, 0)
            .padding(.trailing, 0)
    }
    
    var messages: [VideoMessage]
    var isInbox: Bool
    let targetDate = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1))!
    
    var filteredData: [VideoMessage] {
        if let selectedPerson = selectedPerson {
            return isInbox ? messages.filter { $0.senderId == selectedPerson._id } : messages.filter { $0.receiverId == selectedPerson._id }
        } else {
            return messages
        }
    }
    
    var body: some View {
        var selectedMessage: VideoMessage?
        ZStack {
            List {
                ForEach(filteredData, id: \.self) { message in
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(message.title)
                                .font(.headline)
                            
                            
                                if isInbox {
                                    Button(action: {
                                        print("test")
                                        print(message)
                                        selectedMessage = message
                                        isPresented=true
                                    }){
                                        HStack {
                                            Text(userViewModel.getUserNicknameByUserId(userId:  message.senderId!))
                                                .font(.subheadline)
                                                .fontWeight(.bold)
                                                .padding(.leading, 0)
                                                .padding(.trailing, 0)
                                            
                                            Text(formatDate(message.unlockedDate))
                                                .font(.subheadline)
                                        }
                                    }
                                } else {
                                    HStack {
                                        textTag(text: message.category?.name ?? "", color: .tagColor)
                                        
                                        Text(formatDate(message.unlockedDate))
                                            .font(.subheadline)
                                    }
                                }
                                
                            
                        }
                        
                        Spacer()
                        
                        if !isInbox {
                            Text("D-\(calculateDDay(targetDate: targetDate) ?? 0)")
                        }
                    }
                    .padding()
                    .listRowInsets(EdgeInsets())
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.top, 0)
            
            VStack {
                filterByPersonMenu
                
                Spacer()
            }
            .padding(.vertical, 0)
            .padding(.horizontal)
        }
        .sheet(isPresented: $isPresented) {
                    if let selectedMessage = selectedMessage {
                        VideoPreviewView(videoMessage: selectedMessage)
                    }
                }
        
    }
    
    var filterByPersonMenu: some View {
        HStack {
            Menu {
                Button(action: {
                    selectedPerson = nil
                }) {
                    if selectedPerson == nil {
                        Image(systemName: "chevron.down")
                    }
                    Text("전체보기")
                }
                
                ForEach(getPeopleFromVideos(videos: messages, isInbox: isInbox), id: \.self) { option in
                    Button(action: {
                        selectedPerson = option
                    }) {
                        HStack {
                            if selectedPerson?._id == option._id {
                                Image(systemName: "chevron.down")
                            }
                            
                            Text(option.nickname)
                        }
                    }
                }
            } label: {
                Image(systemName: "chevron.down")
                if selectedPerson == nil {
                    Text("전체보기")
                } else {
                    Text(selectedPerson?.nickname ?? "")
                }
                Spacer()
                Text("디데이순")
            }
            .foregroundColor(Color.primary)
            .menuStyle(BorderlessButtonMenuStyle())
        }
    }
    private func getPeopleFromVideos(videos: [VideoMessage], isInbox: Bool) -> [User] {
            var people: [User] = []
            for video in videos {
                if isInbox {
                    if let sender = userViewModel.getUserByID(userID: video.senderId!) {
                        people.append(sender)
                    }
                } else {
                    if let receiver = userViewModel.getUserByID(userID: video.receiverId!) {
                        people.append(receiver)
                    }
                }
            }
            return Array(Set(people))
        }
}


struct MessageListView_Previews: PreviewProvider {
    static var previews: some View {
        let user1 = User()
        user1.nickname = "User 1"
        let user2 = User()
        user2.nickname = "User 2"
        let user3 = User()
        user3.nickname = "User 3"
        
        let category1 = Category()
        category1.name = "Category 1"
        category1.user = user1
        let category2 = Category()
        category2.name = "Category 2"
        category2.user = user2
        let category3 = Category()
        category3.name = "Category 3"
        category3.user = user3
        
        let message1 = VideoMessage()
        message1.title = "Message 1"
        message1.senderId = user1._id
        message1.receiverId = user2._id
        message1.unlockedDate = Date()
        message1.category = category1
        
        let message2 = VideoMessage()
        message2.title = "Message 2"
        message2.senderId = user2._id
        message2.receiverId = user1._id
        message2.unlockedDate = Date()
        message2.category = category2
        
        let message3 = VideoMessage()
        message3.title = "Message 3"
        message3.senderId = user3._id
        message3.receiverId = user1._id
        message3.unlockedDate = Date()
        message3.category = category3
        
        let messages = [message1, message2, message3]
        
        return VStack {
            MessageListView(messages: messages, isInbox: true)
            MessageListView(messages: messages, isInbox: false)
        }
    }
}
