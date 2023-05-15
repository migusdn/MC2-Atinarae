//
//  PlanetPlusModal.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/13.
//

//  ----------------------------------------------------------------------
//          나도 아이패드 프로 갖고 싶다
//          나도 큰 화면 쓰고 싶다
//          나도 그림은 안그리지만 아이패드 프로로 그림 그리고 싶다
//          나도... 나도..... 나도..... 아이패드.... 프로....
//  ----------------------------------------------------------------------

import SwiftUI
import RealmSwift

struct PlanetPlusModal: View {
    @Binding var planetLotateNumber: Int
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedPlanet: Int = 0
    @State var phoneNumber: String = ""
    @State var eMail: String = ""
    @State var nickName: String = ""
    @State var showingAlert: Bool = false
    @State var showingDeleteAlert = false
    @Binding var users: [User]?
    @Binding var deletePlanet: Bool
    
    var body: some View {
        GeometryReader { geo in
            let seletePlanetSize = geo.size.width/9
            
            ScrollView{
                VStack{
                    HStack{
//                        Spacer()
//                        ModalViewIndicator(indicator: geo.size.width/6)
                        Spacer()
                        
                        Button{     // 저장
                            let newFriend = User()
                            newFriend.nickname = nickName
                            newFriend.profile = selectedPlanet
                            newFriend.mail = eMail
                            newFriend.phone = phoneNumber
                            userViewModel.addFriend(friend: newFriend)
                            dismiss()
                        } label: {
                            Text("저장")
                            
                        }
                        .padding()
                    }
                    Spacer()
                    
                    Text("행성 추가하기")
                        .font(.title2).bold()
                        .padding(.bottom)
                    Text("영상을 받을 소중한 사람의 행성을 만들어주세요")
                        .foregroundColor(.secondary)
                        .padding(.bottom)
                
            }
            
            Form{
                Section{
                    HStack {
                        ForEach(0..<5, id: \.self) { planet in
                            if selectedPlanet == planet{
                                ZStack{
                                    makeSelectPlanet(planetNumber: planet)
                                        .resizable()
                                        .frame(width: seletePlanetSize, height: seletePlanetSize)
                                        .padding(.trailing, 10)
                                        .padding(.leading, 10)
                                    
                                    Circle()
                                        .stroke(Color.white, lineWidth: 3)
                                        .frame(width: seletePlanetSize+10, height:seletePlanetSize+10)
                                        .background(Image(systemName: "checkmark").fontWeight(.bold))
                                    
                                }
                            } else{
                                makeSelectPlanet(planetNumber: planet)
                                    .resizable()
                                    .frame(width: seletePlanetSize, height: seletePlanetSize)
                                    .padding(.trailing, 10)
                                    .padding(.leading, 10)
                                    .onTapGesture {
                                        selectedPlanet = planet
                                    }
                            }
                        }
                    }
                    .frame(height: seletePlanetSize + 40)
                    TextField("행성이름", text: $nickName)
                        .keyboardType(.default)
                } header: {
                    Text("행성")
                        .font(.body)
                        .foregroundColor(.white)
                }
                
                Section{
                    TextField("전화번호", text: $phoneNumber)
                        .keyboardType(.default)
                    TextField("이메일", text: $eMail)
                        .keyboardType(.default)
                } header: {
                    Text("받는 사람")
                        .font(.body)
                        .foregroundColor(.white)
                }
            }
            .listStyle(PlainListStyle())
            .frame(height: geo.size.height/1.4)
        }
        }
        
        
        
    }
}


//struct PlanetPlusModal_Previews: PreviewProvider {
//    static var previews: some View {
//        let appData = AppData()
//        PlanetPlusModal(planetLotateNumber: .constant(0))
//            .environmentObject(appData)
//    }
//}


struct ModalViewIndicator: View {
    var indicator: CGFloat
    var body: some View {
        HStack {
            Spacer()
            RoundedRectangle(cornerRadius: 25)
                .frame(width: indicator, height:6)
                .font(Font.title.weight(.heavy))
                .foregroundColor(Color(UIColor.tertiaryLabel))
            Spacer()
        }.padding(4)
    }
}




