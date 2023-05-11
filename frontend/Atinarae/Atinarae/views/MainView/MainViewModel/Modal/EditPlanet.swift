//
//  EditPlanet.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/11.
//

import SwiftUI

struct EditPlanet: View {
    @State private var selectedPlanet: Int = 0
    var planetNumber: Int
    @State var name: String
    @State var phoneNumber: String
    @State var eMail: String
    @State var nickName: String
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appData: AppData
    var body: some View {
        GeometryReader { geo in
            let planetSize: CGFloat = geo.size.width / 9
            VStack{
                Form {
                    Section {
                        HStack {
                            ForEach(0..<5, id: \.self) { planet in
                                if selectedPlanet == planet{
                                    ZStack{
                                        makeSelectPlanet(planetNumber: planet)
                                            .resizable()
                                            .frame(width: planetSize, height: planetSize)
                                            .padding(.trailing, 10)
                                            .padding(.leading, 10)
                                        
                                        Circle()
                                            .stroke(Color.white, lineWidth: 3)
                                            .frame(width: planetSize+10, height:planetSize+10)
                                            .background(Image(systemName: "checkmark").fontWeight(.bold))
                                        
                                    }
                                } else{
                                    makeSelectPlanet(planetNumber: planet)
                                        .resizable()
                                        .frame(width: planetSize, height: planetSize)
                                        .padding(.trailing, 10)
                                        .padding(.leading, 10)
                                        .onTapGesture {
                                            selectedPlanet = planet
                                        }
                                }
                            }
                        }
                        .frame(height: planetSize + 40)
                    }  header: {
                        Text("행성을 선택")
                    }
                    
                    
                    Section{
                        TextField("이름", text: $name)
                            .keyboardType(.default)
                    }
                    
                    Section{
                        TextField("휴대폰 번호", text: $phoneNumber)
                            .keyboardType(.default)
                    }
                    
                    Section{
                        TextField("이메일", text: $eMail)
                            .keyboardType(.default)
                    }
                    
                    Section{
                        TextField("닉네임", text: $nickName)
                            .keyboardType(.default)
                    }
                    
                }
                .scrollContentBackground(.hidden)
//                .scrollDisabled(true)
               // .frame(height: geo.size.height/1.3)
                
                Button{
                    appData.user.friends[planetNumber].planetImage = selectedPlanet
                    appData.user.friends[planetNumber].nickname = nickName
                    self.presentationMode.wrappedValue.dismiss()
                    
                }   label: {
                    Text("다음")
                        .frame(width: 91, height: 58)
                        .foregroundColor(Color.black)
                        .background(
                                    Group {
                                        if name == "" || phoneNumber == "" || eMail == "" || nickName == "" {
                                            Color.secondary // 비활성화 상태일 때 배경색을 검은색으로 설정
                                        } else {
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 0.569, green: 0.541, blue: 0.961),
                                                    Color(red: 0.685, green: 0.74, blue: 0.981),
                                                    Color(red: 0.792, green: 0.922, blue: 1)
                                                ]),
                                                startPoint: UnitPoint(x: 0, y: 0.5),
                                                endPoint: UnitPoint(x: 1, y: 0.5)
                                            )
                                        }
                                    }
                                    .cornerRadius(100)
                                )
                }
                .disabled(name == "" || phoneNumber == "" || eMail == "" || nickName == "")
            }
        }
    }
}
