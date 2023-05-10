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
    @State private var selectedPlanet: Friend?
    
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
                                    ForEach(0..<5, id: \.self) { planetNumber in
                                        Image(planet[planetNumber])
                                            .resizable()
                                            .frame(width: planetSize, height: planetSize)
                                            .padding(.trailing, 10)
                                            .padding(.leading, 10)
                                    }
                                }
                            }
                            .frame(height: planetSize + 40)
                            
                        }
                        
                        .frame(height: geo.size.height/1.5) // form의 프레임
                  
                }
            }
        }
    }
}



struct MakePlanetModalView_Previews: PreviewProvider {
    static var previews: some View {
        MakePlanetModalView(planetNumber: 1)
    }
}
