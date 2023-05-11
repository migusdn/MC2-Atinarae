//
//  VideoSettingsView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/03.
//

import SwiftUI

struct VideoSettingsView: View {
    @EnvironmentObject var appData: AppData
    
    @Environment(\.presentationMode) var presentationMode
    @State private var categorySelectSheetIsPresented = false
    @State private var dDaySelectSheetIsPresented = false
    @State private var videoMessage : VideoMessage?
    
    @State private var date = Date()
    @State private var title = ""
    @State private var unlockedDateisNotDefine = false
    @State private var selectedCategoryIdx: Int?
    @State private var selectedFriend:Friend?
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    func setUpData(){
        videoMessage = appData.getTempVideoMessage()
        videoMessage?.senderId = appData.user.userId
    }
    var rows: [GridItem] = Array(repeating: .init(.fixed(50)), count: 1)
    @State var text:String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Form {
                    personSelectView
                    Section {
                        TextField("제목", text: $title)
                    }
                    Section{
                        DatePicker("디데이", selection: $date, displayedComponents: [.hourAndMinute, .date])
                    }
                    .padding(.top,2)
                    .padding(.bottom,2)
                    .padding(.trailing, -9)
                    categorySelectView
                }
                Spacer()
                Button(action:{
                    videoMessage?.title = title
                    videoMessage?.category = appData.user.categories[selectedCategoryIdx!]
                    if unlockedDateisNotDefine{
                        videoMessage?.unlockedDate = nil
                    }else{
                        videoMessage?.unlockedDate = date
                    }
//                    date
                    if let friend = selectedFriend {
                        videoMessage?.receiverId = friend.userId
                        videoMessage?.receiverId = 0
                    }
                    
                    appData.addVideo(videoMessage!)
                }){
                    makeGradientButton("다음")
                        .padding(30)
                }
                
                
                
            }
            .onAppear(){
                setUpData()
            }
            
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(
                Text("영상 보내기")
                , displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    }
            )
            .accentColor(.white)
            
            .sheet(isPresented: $categorySelectSheetIsPresented){
                CategorySelectModalView(
                    selectedCategoryIdx: $selectedCategoryIdx,
                    dismissAction: {
                        categorySelectSheetIsPresented = false
                    }
                )
            }
            .sheet(isPresented: $dDaySelectSheetIsPresented) {
                DateSelectView(
                    date: $date,
                    isOn: $unlockedDateisNotDefine,
                    dismissAction: {
                        dDaySelectSheetIsPresented = false
                    }
                )
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
    var categorySelectView: some View{
        Section{
            HStack{
                Text("카테고리")
                Spacer()
                if selectedCategoryIdx == nil{
                    Text("없음")
                }else{
                    Text(appData.user.categories[selectedCategoryIdx!])
                }
                Image(systemName: "chevron.right")
            }.onTapGesture{
                categorySelectSheetIsPresented.toggle()
            }
            
        }.padding(.vertical)
    }
    var personSelectView: some View{
        Section(header:
                    Text("누구에게 보낼까요")
            .font(.headline)
            .padding(.leading, 0)
            .padding(.bottom,8)
        ){
            ScrollView(.horizontal, showsIndicators: false) {
                HStack{
                    ForEach(appData.user.friends, id: \.self) { friend in
                        Group{
                            friendView(friend: friend, selectedFriend: selectedFriend)
                        }
                        .onTapGesture{
                            selectedFriend = friend
                        }
                        .padding(.trailing, 15)
                    }
                }
                .ignoresSafeArea(.all)
            }
            
            .ignoresSafeArea(.all)
        }
    }
    func friendView(friend: Friend, selectedFriend: Friend?) -> some View {
        VStack(alignment: .center) {
            if selectedFriend == friend {
                ZStack{
                    Image(friend.planetImage!)
                        .resizable()
                        .frame(width: 52, height: 52)
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 63, height:63)
                        .background(Image(systemName: "checkmark").fontWeight(.bold))
                    
                    
                }
                Text(friend.nickname!)
            } else {
                Image(friend.planetImage!)
                    .resizable()
                    .foregroundColor(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
                    .frame(width: 63, height: 63)
                Text(friend.nickname!)
            }
        }
        .padding(.top, 2)
        .padding(.leading,2)
    }
}

struct VideoSettingsView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let appData = AppData()
        VideoSettingsView()
            .environmentObject(appData)
    }
}
