//
//  PlanetList.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/10.
//

import Foundation
import SwiftUI

// TODO: 우리 이런 공통되는 스타일 관련한건 저기 Style 폴더에 옮깁시다.
let mainPlanet = ["planet_bp", "planet_by", "planet_py", "planet_yb", "planet_pb", "planet_Empty"]
let selectPlanet = ["SelectPlanetBp", "SelectPlanetBy", "SelectPlanetPy", "SelectPlanetYb", "SelectPlanetPb"]

func makeMainPlanet(planetNumber: Int) -> Image {
    return Image(mainPlanet[planetNumber])
}

func makeSelectPlanet(planetNumber: Int) -> Image {
    return Image(selectPlanet[planetNumber])
}


























// 쨈을 위해 남겨둠
//  사용법
//  MakePlanet(style: .planetBy)

//enum PlanetStyle {
//    case planetBy
//    case planetBp
//    case planetYb
//    case planetPy
//    case planetEmpty
//}

//func MakePlanet(style: PlanetStyle) -> some View {
//    switch style {
//    case .planetBy: return ZStack{ Image("PlanetBY") }
//    case .planetBp: return
//    case .planetYb: return
//    case .planetPy: return
//    case .planetEmpty: return
//
//    }
//}
//
//struct PlanetPreview_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack{
//            HStack{
//                MakePlanet(style: .planetBy)
//                Text("planetBY")
//            }
//            
//            HStack{
//                MakePlanet(style: .planetBp)
//                Text("planetBp")
//            }
//
//            HStack{
//                MakePlanet(style: .planetYb)
//                Text("planetYb")
//            }
//
//            HStack{
//                MakePlanet(style: .planetPy)
//                Text("planetPy")
//            }
//
//            HStack{
//                MakePlanet(style: .planetEmpty)
//                Text("planetEmpty")
//            }
//            
//        }
//    }
//}
//
//
//struct PlanetBy: View{
//    
//    var body: some View {
//        ZStack {
//                Circle()
//                    .foregroundColor(.white)
//                    .cornerRadius(30)
//                
//                Circle()
//                    .foregroundColor(.clear)
//                    .opacity(0.7)
//                    .overlay(
//                        LinearGradient(
//                            gradient: Gradient(colors: [
//                                Color(red: 0.394, green: 0.606, blue: 0.946, opacity: 1),
//                                Color(red: 0.443, green: 0.624, blue: 0.914, opacity: 0)
//                            ]),
//                            startPoint: UnitPoint(x: 0.25, y: 0.5),
//                            endPoint: UnitPoint(x: 0.75, y: 0.5)
//                        )
//                        .rotationEffect(.degrees(-90))
//                        .mask(Circle())
//                    )
//                
//                Circle()
//                    .foregroundColor(.clear)
//                    .overlay(
//                        ZStack {
//                            Circle()
//                                .foregroundColor(.clear)
//                                .shadow(color: Color(red: 0.363, green: 0.605, blue: 1, opacity: 0.5), radius: 30)
//                            Circle()
//                                .foregroundColor(.clear)
//                                .shadow(color: Color(red: 1, green: 1, blue: 1, opacity: 0.6), radius: 10, x: -2, y: 2)
//                        }
//                    )
//            }
//
//
//    }
//}
//
//struct PlanetBp: View{
//    
//    var body: some View {
//        ZStack {
//            Circle()
//                .foregroundColor(.white)
//            
//            Circle()
//                .foregroundColor(.clear)
//                .opacity(0.7)
//                .overlay(
//                    LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color(red: 0.443, green: 0.624, blue: 0.914),
//                            Color(red: 0.443, green: 0.624, blue: 0.914).opacity(0)
//                        ]),
//                        startPoint: UnitPoint(x: 0.25, y: 0.5),
//                        endPoint: UnitPoint(x: 0.75, y: 0.5)
//                    )
//                    .rotationEffect(.degrees(-90))
//                    .mask(Circle())
//                )
//            
//            Circle()
//                .foregroundColor(.clear)
//                .overlay(
//                    ZStack {
//                        Circle()
//                            .foregroundColor(.clear)
//                            .shadow(color: Color(red: 0.363, green: 0.605, blue: 1).opacity(0.5), radius: 30) 
//                        Circle()
//                            .foregroundColor(.clear)
//                            .shadow(color: Color(red: 1, green: 1, blue: 1).opacity(0.6), radius: 10, x: -2, y: 2)
//                    }
//                )
//        }
//
//    }
//}



//        return ZStack {
//            Circle()
//              //  .frame(width: 46, height: 46)
//                .foregroundColor(.white)
//                .cornerRadius(30)
//
//            Circle()
//               // .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .opacity(0.7)
//                .overlay(
//                    LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 1),
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0)
//                        ]),
//                        startPoint: UnitPoint(x: 0.25, y: 0.5),
//                        endPoint: UnitPoint(x: 0.75, y: 0.5)
//                    )
//                    .rotationEffect(.degrees(-90))
//               //     .frame(width: 46, height: 46)
//                    .mask(Circle())
//                )
//
//            Circle()
//             //   .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .shadow(color: Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0.4), radius: 30)
//                .overlay(
//                    Circle()
//                        .foregroundColor(.clear)
//                        .shadow(color: Color(red: 1, green: 1, blue: 1, opacity: 0.6), radius: 10, x: -2, y: 2)
//                )
        
   // }
//    case .planetYb:
//        return ZStack {
//            Circle()
//              //  .frame(width: 46, height: 46)
//                .foregroundColor(.white)
//                .cornerRadius(30)
//
//            Circle()
//               // .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .opacity(0.7)
//                .overlay(
//                    LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 1),
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0)
//                        ]),
//                        startPoint: UnitPoint(x: 0.25, y: 0.5),
//                        endPoint: UnitPoint(x: 0.75, y: 0.5)
//                    )
//                    .rotationEffect(.degrees(-90))
//               //     .frame(width: 46, height: 46)
//                    .mask(Circle())
//                )
//
//            Circle()
//             //   .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .shadow(color: Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0.4), radius: 30)
//                .overlay(
//                    Circle()
//                        .foregroundColor(.clear)
//                        .shadow(color: Color(red: 1, green: 1, blue: 1, opacity: 0.6), radius: 10, x: -2, y: 2)
//                )
//
//    }
//    case .planetPy:
//        return ZStack {
//            Circle()
//              //  .frame(width: 46, height: 46)
//                .foregroundColor(.white)
//                .cornerRadius(30)
//
//            Circle()
//               // .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .opacity(0.7)
//                .overlay(
//                    LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 1),
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0)
//                        ]),
//                        startPoint: UnitPoint(x: 0.25, y: 0.5),
//                        endPoint: UnitPoint(x: 0.75, y: 0.5)
//                    )
//                    .rotationEffect(.degrees(-90))
//               //     .frame(width: 46, height: 46)
//                    .mask(Circle())
//                )
//
//            Circle()
//             //   .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .shadow(color: Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0.4), radius: 30)
//                .overlay(
//                    Circle()
//                        .foregroundColor(.clear)
//                        .shadow(color: Color(red: 1, green: 1, blue: 1, opacity: 0.6), radius: 10, x: -2, y: 2)
//                )
//
//    }
//    case .planetEmpty:
//        return ZStack {
//            Circle()
//              //  .frame(width: 46, height: 46)
//                .foregroundColor(.white)
//                .cornerRadius(30)
//
//            Circle()
//               // .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .opacity(0.7)
//                .overlay(
//                    LinearGradient(
//                        gradient: Gradient(colors: [
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 1),
//                            Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0)
//                        ]),
//                        startPoint: UnitPoint(x: 0.25, y: 0.5),
//                        endPoint: UnitPoint(x: 0.75, y: 0.5)
//                    )
//                    .rotationEffect(.degrees(-90))
//               //     .frame(width: 46, height: 46)
//                    .mask(Circle())
//                )
//
//            Circle()
//             //   .frame(width: 46, height: 46)
//                .foregroundColor(.clear)
//                .shadow(color: Color(red: 0.506, green: 0.49, blue: 0.922, opacity: 0.4), radius: 30)
//                .overlay(
//                    Circle()
//                        .foregroundColor(.clear)
//                        .shadow(color: Color(red: 1, green: 1, blue: 1, opacity: 0.6), radius: 10, x: -2, y: 2)
//                )
//
//    }
