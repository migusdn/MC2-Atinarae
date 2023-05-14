////
////  MessageListView.swift
////  Atinarae
////
////  Created by HyunwooPark on 2023/05/09.
////
//
//import SwiftUI
//
//struct MessageListView: View {
//    //    @EnvironmentObject var appData: AppData
//    //    let test: [Int]
//    @EnvironmentObject var videoMessageViewModel: VideoMessageViewModel
//    
//    
//    
//    
//    
//    let options = ["Option 1", "Option 2", "Option 3"]
//    @State private var selectedMenu = 0
//    
//    func textTag(text:String, color:Color) -> some View{
//        Text(text)
//            .padding(5)
//            .background(
//                RoundedRectangle(cornerRadius: 6)
//                    .fill(color)
//            )
//            .frame(width: 40, height: 35)
//            .padding(.leading, 0)
//            .padding(.trailing,0)
//    }
//    var messages:[VideoMessage]
//    var isSenderView: Bool
//    let targetDate = Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1))!
//    
//    var body: some View {
//        
////        ZStack{
////
////            List{
////                ForEach(messages, id: \.self) { message in
////                    HStack{
////                        VStack(alignment: .leading, spacing: 8) {
////                            Text(message.title)
////                                .font(.headline)
////                            HStack {
////                                if isSenderView{
////                                    textTag(
////                                        text: message.category,
////                                        color: .tagColor
////                                    )
////                                }else{
////                                    Text(message.sender!.nickname)
////                                        .font(.subheadline)
////                                        .fontWeight(.bold)
////                                        .padding(.leading, 0)
////                                        .padding(.trailing,0)
////                                }
////                                Text(formatDate(message.unlockedDate))
////                                    .font(.subheadline)
////                            }
////                        }
////                        Spacer();
////                        if isSenderView == true{
////                            Text("D-\(calculateDDay(targetDate: targetDate) ?? 0)")
////                        }
////                    }
////                    .padding()
////                    .listRowInsets(EdgeInsets())
////                    .background(Color.blue)
////                }
////                //                .padding()
////
////            }
////            .padding(.top,10)
//            //            .padding(EdgeInsets(top: , leading: 0, bottom: 0, trailing: 0))
////            VStack{
////                HStack{
////                    Menu {
////                        // Dropdown 항목을 반복하여 추가합니다.
////                        ForEach(appData.getPeopleFromVideos(videos: messages), id: \.self) { option in
////                            Button(appData.getUserNicknameById(userId: option)) {
////                                // 항목을 선택하면 selectedOption 변수를 업데이트합니다.
////                                selectedMenu = option
////                            }
////                        }
////                    } label: {
////                        Text(appData.getUserNicknameById(userId: selectedMenu))
////                            .foregroundColor(Color.primary)
////
////                    }
////                    .menuStyle(BorderlessButtonMenuStyle())
////                    .padding()
////                    Spacer()
////                    Text("디데이순")
////                }
////                Spacer()
////            }
////            .padding(.vertical,0)
////            .padding(.horizontal)
//            
//            
////        }
//        
//        
//    }
////}
//
//struct MessageListView_Previews: PreviewProvider {
////    static var previews: some View {
////        let videoMessageViewModel = VideoMessageViewModel()
//        //        VStack{
////        MessageListView(messages: videoMessageViewModel.videoMessages, isSenderView: true)
////            .environmentObject(videoMessageViewModel)
//        
//        //            MessageListView(messages: appData.user.inbox.videos, isSenderView: true)
//        //                .environmentObject(appData)
//        //        }
////    }
//}
