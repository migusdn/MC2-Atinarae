//
//  DetailView.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/04.
//

import SwiftUI
import RealmSwift

struct DetailView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    // scroll 감지
    @State private var scrollOffsetDetect: Double = 0
    // 별 이모션 불값
    @State private var animationFlag = false
    // 행성의 위치
    var planetLotateNumber: Int
    // 행성의 크기
    let planetSize: CGFloat = 300
    // 원활한 뷰 이동을 위해
    @State var tag: Int? = nil
    // 모달 띄우기
    @State private var showModal = false
    // 모달로 바인딩을 위한 변수
    @State private var moveModalPlanetLotateNumber = 0
    @State private var moveModalPlanetNumber = 0
    // 행성 삭제 감지
    @State var deletePlanet = false
    //Dismiss
    @Environment(\.dismiss) var dismiss
    // 바인딩 받아오는 유저 정보
    @Binding var users: [User]?
    @State private var pickSegmetedIsSending = 0
    
    
    
    var body: some View {
        
        GeometryReader { geo in
            ScrollView{
                ZStack {
                    Color.backGroundColor.ignoresSafeArea()
                    
                    VStack{
                        ZStack{
                            makeDetailPlanet(planetNumber:self.users?[planetLotateNumber].profile ?? 0)
                                .resizable()
                                .frame(width: planetSize, height: planetSize)
                                .blendMode(.colorDodge)
                                .opacity(scrollOffsetDetect <= 0 ?  1 - (0.02 * -scrollOffsetDetect) : 1)
                                .overlay{
                                // 궤도
                                self.makeOrbit(diameter: geo.size.width+planetSize)

                                // 궤도
                                self.makeOrbit(diameter: geo.size.width+(planetSize/3))
                                   
                                //안쪽 궤도에만 별 만들기
                                self.makeStar(diameter: geo.size.width+(planetSize/3))
                                    .offset(x:geo.size.width/2)
                            }
                            .offset(x:geo.size.width/2)
                            
                            // User Nickname, Edit Button.
                            HStack{
                                Text(self.users?[planetLotateNumber].nickname ?? "")
                                    .font(.largeTitle).bold()
                                
                                Button{
                                    self.moveModalPlanetLotateNumber = self.planetLotateNumber
                                    self.showModal = true
                                } label: {
                                    Circle()
                                        .frame(width: 34, height: 34)
                                        .foregroundColor(.secondary)
                                        .overlay{
                                            Image(systemName: "pencil")
                                                .resizable()
                                                .frame(width: 15, height: 15)
                                                .foregroundColor(.white)
                                        }
                                    
                                }
                                .sheet(isPresented: self.$showModal) {
                                    EditPlanetModal(planetLotateNumber: $moveModalPlanetLotateNumber, users: $users, deletePlanet: $deletePlanet)
                                        .onDisappear{
                                            if deletePlanet {
                                                dismiss()
                                        }
                                }
                            }
                                
                                Spacer()
                            }   // User, Edit Button HStack.
                            .padding()
                            .offset(y:-geo.size.height/6)
                            
                        }
                       
                        LazyVStack(pinnedViews: .sectionHeaders){

                            Section(header: HeaderView(pickSegmetedIsSending: $pickSegmetedIsSending)){
                                
                                
                                InboxView()
                                    .frame(height: 900)
                                    
                            
                            }   // Section
//                            .offset(y:planetSize/4)
                            
                        }
                        .offset(y:planetSize/4)
                            
                       
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .principal) {
                            HStack{
                                Spacer()
                                Text(String(self.users?[planetLotateNumber].nickname ?? ""))
                                    .opacity(scrollOffsetDetect <= 0 ? 0.008 * -scrollOffsetDetect:0)
//                                    .opacity(scrollOffsetDetect <= 0 ? 0.008 * -scrollOffsetDetect:0)
                                Spacer()

                                Button{     // 편집

                                } label: {
                                    Image(systemName: "paperplane")
                                    //                                        .foregroundColor(.white)
                                }
                            }   //HStack
                           
                        }   // ToolbarItemGroup

                    }
                    GeometryReader { proxy in
                        
                        let offset = proxy.frame(in: .named("scroll")).minY
                        Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                    }
                    
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    scrollOffsetDetect = value
                    // 가운대로 포지션 이동
//                    .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                }
            }
        }
        .onAppear{
            self.animationFlag = true
        }
        .onDisappear{
            dismiss()
            if deletePlanet {
                userViewModel.deleteUser(user: (userViewModel.currentUser?.friends[planetLotateNumber])!)
            }
        }
    }
    
    
    
    // 궤도 만들기
    func makeOrbit(diameter: CGFloat) -> some View {
        return ZStack {
            Circle()    // 궤도
                .strokeBorder(
                    AngularGradient(gradient: Gradient(colors: [.orbitLineColor, .orbitLineColor2, .orbitLineColor, .orbitLineColor2, .orbitLineColor]), center: .center)
                )
                .frame(width: diameter, height: diameter)
        }
    }   // makeOrbit
    
    // 별 만들기
    func makeStar(diameter: CGFloat) -> some View {
        let starSize: CGFloat = 40
        return ZStack {
            Image("star")
                .resizable()
                .frame(width: starSize, height: starSize, alignment: .center)
                .offset(y:14)
                .modifier(self.makeStarEffect(diameter: diameter))
                .animation(Animation.linear(duration: 50)
                    .repeatForever(autoreverses: false))
        }
    }   // makeStar.
    
    // 별에 효과를 주는 함수
    func makeStarEffect(diameter: CGFloat) -> some GeometryEffect {
        return StarEffect(percent: self.animationFlag ? 1.0 : 0.0, radius: diameter / 2)
    }
    
}


struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct HeaderView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var videoMsgViewModel: VideoMessageViewModel
    @Binding var pickSegmetedIsSending: Int
    var body: some View {
        VStack{
            Picker("What is your favorite color?", selection: $pickSegmetedIsSending) {
                Text("발송 전").tag(0)
                Text("발송 완료").tag(1)
            }
            .pickerStyle(.segmented)
            

        }
        
    }
}
















//struct DetailInbox: View {
//    @EnvironmentObject var userViewModel: UserViewModel
//    @EnvironmentObject var videoMessageViewModel: VideoMessageViewModel
//    @State private var pickSegmetedIsSending = 0
//    let planetLotate: Int
//
//
//    let planetSize: CGFloat
//    var body: some View{
//
//    }
//}

// 내리면 점점 사라짐
// .opacity(scrollOffsetDetect <= 0 ?  1 - (0.008 * -scrollOffsetDetect) : 1)

// 내리면 점점 생김
//  .opacity(scrollOffsetDetect <= 0 ? 0.008 * -scrollOffsetDetect:0)



//    HStack{
//        Text(self.users?[planetLotateNumber].nickname ?? "")
//            .font(.largeTitle).bold()
//
//        Button{
//            self.moveModalPlanetLotateNumber = self.planetLotateNumber
//
//            self.showModal = true
//        } label: {
//            Circle()
//                .frame(width: 34, height: 34)
//                .foregroundColor(.secondary)
//                .overlay{
//                    Image(systemName: "pencil")
//                        .resizable()
//                        .frame(width: 15, height: 15)
//                        .foregroundColor(.white)
//                }
//
//        }
//        .sheet(isPresented: self.$showModal) {
//            MakePlanetModalView(planeLotateNumber: $moveModalPlanetLotateNumber, deletePlanet: $deletePlanet)
//                .onDisappear{
//                    if deletePlanet {
//                        dismiss()
//                        appData.user.friends[planetLotateNumber].nickname = nil
//                        appData.user.friends[planetLotateNumber].planetImage = nil
//                        appData.user.friends[planetLotateNumber].eMail = nil
//                        appData.user.friends[planetLotateNumber].phoneNumber = nil
//                    }
//                }
//        }
