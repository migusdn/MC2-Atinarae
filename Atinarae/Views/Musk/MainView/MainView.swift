//
//  MainView.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/04.
//

//  -------------------------------------------------------------------------------------
//          메인 뷰 gk tlksdflkajsdfljasdlfkajsdlf;kjatlqkf wlsWk whrlksjdf;lkasjdf
//          MainViewModel폴더에 있는 여러 ViewModel들을 가져와 만들었습니다
//          지오메트리리더를 사용해서 화면 크기가 달라져도 일정 비율을 유지할 수 있게 만들었고요.
//          행성을 눌러 디테일뷰로 들어갈때 여기서 DetailView로 넘겨주는 값으로 사람을 판별하면 될듯합니다.
//          따라가지 않을거야 난 똑똑하니까 난 절대 끌리지 않는것에 끌려가지 않아 데츠 마이 스타일 키치 키치키치키치키치키치
//------------------------------------------------------------------------------------

import SwiftUI
import RealmSwift


struct MainView: View {
    @EnvironmentObject var navModel: NavigationModel
    //Access User Data
    @EnvironmentObject var userViewModel: UserViewModel
    //    @State var realm = try! Realm() // Realm 인스턴스
    @State var users: [User]?
    
    func setup(){
        do{
//            users = userViewModel.readUsers()
            
//            userViewModel.addFriend(friend: users![0])
        }
        self.users = userViewModel.getFriendsList()
//        
//        userViewModel.addFriend(friend: User(nickname: "Hard", mail: "", phone: "", profile: 1, friends: [])
//        print(users)
    }
    
    var body: some View{
        GeometryReader { geo in
            ZStack{
                Color.backGroundColor.ignoresSafeArea()     // BackGround
                
                VStack{
                    MainViewModelTitle()
                        .frame(height: geo.size.height/6)
                    
                    MainViewModelPlanet(users : $users)
                        .frame(height: geo.size.height/2)
                    
                    MainViewModelSendVideo()
                        .frame(height: geo.size.height/3)
                    
                }   // VStack
            }   // ZStack
        }   // GeometryReader
        .onAppear{
         setup()
        }
        .navigationBarBackButtonHidden(true)
        
    }    // View.
    
}


//  self.users?[1].nickname ?? ""


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let realm = try! Realm() // Realm 인스턴스 생성
        let userViewModel = UserViewModel() // UserViewModel에 Realm 인스턴스 전달
        let videoMessageViewModel = VideoMessageViewModel() // VideoMessageViewModel에 Realm 인스턴스 전달
        let navigationModel = NavigationModel() // NavigationModel에 Realm 인스턴스 전달
        
        return NavigationView {
            MainView()
                .environmentObject(userViewModel)
                .environmentObject(videoMessageViewModel)
                .environmentObject(navigationModel)
        }
    }
}



















//
//struct MainView: View {
//
//    @State var tag: Int? = nil   // 화면 이동을 위한 tag.
//   // @EnvironmentObject var appData: AppData
//    var body: some View {
//
//
//            ZStack{
//
//            Color.backGroundColor.ignoresSafeArea()
//            GeometryReader{ geometry in
//
//                VStack{
//                    MainViewModelTitle()
//                        .frame(width: geometry.size.width, height: geometry.size.height/6)
//
//                    MainViewModelGeometry()
//                      // .environmentObject(appData)
//                        .frame(width: geometry.size.width, height: geometry.size.height/2)
//
//
//                        Button{
//                            self.tag = 1
//                        } label: {
//                            RoundedRectangle(cornerRadius: 30)
//                                .fill(
//                                    AngularGradient(gradient: Gradient(colors: [.buttonColor, .buttonColor1]), center: .center)
//
//                                )
//                                .frame(width: geometry.size.width/3, height: 50)
//                                .overlay{
//                                    HStack{
//                                        Image(systemName: "paperplane")
//                                            .foregroundColor(.black)
//                                        Text("메세지보내기")
//                                            .foregroundColor(.black)
//                                            .font(.subheadline).bold()
//                                    }
//
//
//                        }
//                    }
//                    .frame(width: geometry.size.width, height: geometry.size.height/3)
//                }
//                NavigationLink(destination: VideoSettingsView(), tag : 1, selection: self.$tag){}
//            }
//
//        }
//        // navigatinBar를 지우겠다는 신념
//        .navigationBarTitle("")
//        .navigationBarHidden(true)
//
//
//        }
//
//
//}
//
//struct MainView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        let appData = AppData()
//        NavigationView{
//            MainView()
//                .environmentObject(appData)
//        }
//    }
//}
//


//Text("하 시발...")
