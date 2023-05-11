//
//  MakePlanetModalView.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/09.
//

import SwiftUI

struct MakePlanetModalView: View {
    var planetNumber: Int
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.backGroundColor.ignoresSafeArea()
                    VStack {
                        Text("행성 추가하기")
                            .font(.title2).bold()
                        Text("영상을 받을 소중한 사람의 행성을 만들어주세요")
                            .foregroundColor(.secondary)
                            .padding()
                        
                        EditPlanet(planetNumber: planetNumber, name: "", phoneNumber: "", eMail: "", nickName: "") // form의 프레임
                            .frame(height: geo.size.height/1.4)
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




//func planetView(planetNumber: Int, selectedPlanet: Int) -> some View {
//        makeSelectPlanet(planetNumber: planetNumber)
//}

//func planetView(friend: Friend, selectedFriend: Friend?) -> some View {
//    VStack(alignment: .center) {
//        if selectedFriend == friend {
//            ZStack{
//                makeSelectPlanet(planetNumber: <#T##Int#>)
//                    .resizable()
//                    .frame(width: 52, height: 52)
//                Circle()
//                    .stroke(Color.white, lineWidth: 3)
//                    .frame(width: 63, height:63)
//                    .background(Image(systemName: "checkmark").fontWeight(.bold))
//
//
//            }
//            Text(friend.nickname!)
//        } else {
//            Image(friend.planetImage)
//                .resizable()
//                .foregroundColor(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
//                .frame(width: 63, height: 63)
//            Text(friend.nickname!)
//        }
//    }
//    .padding(.top, 2)
//    .padding(.leading,2)
//}
//}

