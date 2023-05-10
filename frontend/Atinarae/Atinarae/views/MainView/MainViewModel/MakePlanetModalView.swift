//
//  MakePlanetModalView.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/09.
//

import SwiftUI

struct MakePlanetModalView: View {
    var planetNumber: Int
    @EnvironmentObject var appData: AppData
    @State private var selectedPlanet: String?
    @State private var name: String = ""
    @State private var phoneNumber: String = ""
    @State private var eMail: String = ""
    @State private var nickName: String = ""
    
    let planet = ["SelectPlanetBp", "SelectPlanetBy", "SelectPlanetPy", "SelectPlanetYb", "SelectPlanetPb"]
    
    var body: some View {
        GeometryReader { geo in
            let planetSize: CGFloat = geo.size.width / 9
       
            ZStack {
                Color.backGroundColor.ignoresSafeArea()
               
                VStack {
                    Text("행성 추가하기")
                        .font(.title2).bold()
                    
                    Text("영상을 받을 소중한 사람의 행성을 만들어주세요")
                        .foregroundColor(.secondary)
                    
                    
                    .padding()
                   
                        Form {
                            Section {
                                HStack {
                                    ForEach(planet, id: \.self) { planet in
                                        Image(planet)
                                            .resizable()
                                            .frame(width: planetSize, height: planetSize)
                                            .padding(.trailing, 10)
                                            .padding(.leading, 10)
                                    } .onTapGesture {
                                       // selectedPlanet = planet
                                    }
                                }
                            }
                            .frame(height: planetSize + 40)
                            
                            Section{
                                TextField("이름", text: $name)
                            }
                            
                            Section{
                                TextField("휴대폰 번호", text: $phoneNumber)
                            }
                            
                            Section{
                                TextField("이메일", text: $eMail)
                            }
                            
                            Section{
                                TextField("닉네임", text: $nickName)
                            }
                            
                        }
                      //  .background(Color.backGroundColor)
                        .frame(height: geo.size.height/1.5) // form의 프레임
                    
                    Button{
                        appData.user.friends[planetNumber].planetImage = selectedPlanet
                        appData.user.friends[planetNumber].nickname = nickName
                        
                        
                    }   label: {
                        Text("다음")
                            .frame(width: 91, height: 58)
                            .foregroundColor(Color.black)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.569, green: 0.541, blue: 0.961),
                                        Color(red: 0.685, green: 0.74, blue: 0.981),
                                        Color(red: 0.792, green: 0.922, blue: 1)
                                    ]),
                                    startPoint: UnitPoint(x: 0, y: 0.5),
                                    endPoint: UnitPoint(x: 1, y: 0.5)
                                )
                                .cornerRadius(100)
                                
                            )
                    }
                    .disabled(name == "" && phoneNumber == "" && eMail == "" && nickName == "")
                    
                  
                }
            }
           
        }
        
    }
}



struct MakePlanetModalView_Previews: PreviewProvider {
    static var previews: some View {
        let appData = AppData()
        MakePlanetModalView(planetNumber: 1)
            .environmentObject(appData)
    }
}




