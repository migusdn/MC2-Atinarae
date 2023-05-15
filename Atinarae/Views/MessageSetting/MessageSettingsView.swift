//
//  VideoSettingsView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/03.
//

import SwiftUI

struct MessageSettingsView: View {
// MARK: - EnvObject Var Define
    //For Navigation View Control
    @EnvironmentObject var navModel: NavigationModel
    //Access User Data
    @EnvironmentObject var userViewModel: UserViewModel
    //For Modal View Close
    @Environment(\.presentationMode) var presentationMode
// MARK: - Local State Var Define
    //New Message Recevier
    @State private var selectedFriend: User?
    //New Message Category
    @State var selectedCategory: Category?
    //D-Day, Category Sheet State
    @State private var categorySelectSheetIsPresented = false
    @State private var dDaySelectSheetIsPresented = false
    
    @State private var unlockedDateisNotDefine = true
    
    @State private var unlokcedDate: Date?
    @State private var title = ""
    
    private var videoMessage: VideoMessage = VideoMessage()
    
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    
    @State var text:String = ""
    
    var body: some View {
            VStack{
                Form {
                    personSelectView
                    Section {
                        TextField("제목", text: $title)
                    }
                    .padding(.vertical)
                    Section{
                        Button(action:{
                            dDaySelectSheetIsPresented.toggle()
                        }){
                            HStack{
                                Text("디데이")
                                Spacer()
                                if unlockedDateisNotDefine{
                                    Text("선택해주세요")
                                    
                                }else{
                                    Text(formatDate(unlokcedDate))
                                }
                                Image(systemName: "chevron.forward")
                            }
                        }
                    }
                    .padding(.vertical)
// MARK: - CategorySelectView Load
                    categorySelectView
                }
                Spacer()
                // TODO: videoMessage 객체 완성해서 저장해야함
                Button(action:{
                    
                    videoMessage.title = title
                    print(videoMessage.title)
                    videoMessage.category = selectedCategory
                    if !unlockedDateisNotDefine {
                        videoMessage.unlockedDate = nil
                    }
                    //                    date
                    if let friend = selectedFriend {
                        videoMessage.receiverId = friend._id
                    }
                    videoMessage.senderId = userViewModel.currentUser?._id
                
                    print("다음 버튼 클릭")
                    print("나와라 제발")
                    print(videoMessage)
                }){
                    
                    NavigationLink(
                        destination: RecordView(videoMessage: videoMessage),
//                        isActive: $navModel.MessageAddProcessIsActive,
                        label: {
                            Text("다음")
                        }
                    )
                    .isDetailLink(false)
                    
                    
                }.buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                
                
                
            }
            .onAppear(){
                //                setUpData()
            }
            
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
                    selectedCategory: $selectedCategory,
                    dismissAction: {
                        categorySelectSheetIsPresented = false
                    }
                )
            }
            .sheet(isPresented: $dDaySelectSheetIsPresented) {
                DateSelectView(
                    date: Binding<Date>(
                        get: { unlokcedDate ?? Date() },
                        set: { unlokcedDate = $0 }
                    ),
                    isOn: $unlockedDateisNotDefine,
                    dismissAction: {
                        dDaySelectSheetIsPresented = false
                    }
                )
            }
            
        
        .navigationBarBackButtonHidden(true)
    }
    var categorySelectView: some View{
        Section{
            HStack{
                Text("카테고리")
                Spacer()
                if let categoryName = selectedCategory?.name {
                    Text(categoryName)
                } else {
                    Text("없음")
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
                    ForEach(userViewModel.getFriendsList(), id: \.self) { friend in
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
    func friendView(friend: User, selectedFriend: User?) -> some View {
        VStack(alignment: .center) {
            if selectedFriend == friend {
                ZStack{
                    makeSelectPlanet(planetNumber: 1)
                    
                        .resizable()
                        .frame(width: 52, height: 52)
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 63, height:63)
                        .background(Image(systemName: "checkmark").fontWeight(.bold))
                    
                    
                }
                Text(friend.nickname)
            } else {
                makeSelectPlanet(planetNumber: 1)
                    .resizable()
                    .frame(width: 63, height: 63)
                Text(friend.nickname)
            }
        }
        .padding(.top, 2)
        .padding(.leading,2)
    }
}

struct VideoSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let navgationModel = NavigationModel()
        let userViewModel = UserViewModel()
        MessageSettingsView()
            .environmentObject(navgationModel)
            .environmentObject(userViewModel)
    }
}
