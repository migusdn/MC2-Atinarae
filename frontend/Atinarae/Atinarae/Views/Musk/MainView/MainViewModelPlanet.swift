//
//  MainViewModelPlanet.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/13.
//

import SwiftUI
import RealmSwift

struct MainViewModelPlanet: View {
    @EnvironmentObject var userViewModel: UserViewModel
    // 별들이 도는 애니메이션 bool
    @State private var animationFlag = false
    // 행성을 생성하는 모달뷰
    @State private var showModal = false
    // Delete의 여부
    @State var deletePlanet = false
    // 메인서 바인딩해옴
    @Binding var users: [User]?
    // 뷰 이동을 위한 태그
    @State var tag:Int? = nil

    var body: some View {
        GeometryReader{ geo in
            // 궤도
            let diameter = [geo.size.height/2.02,geo.size.height/1.42,geo.size.height/1.07, geo.size.height/0.85]
            // 행성의 크기
            let planetSize: CGFloat = 110

            ZStack{
                // 가운대의 나 만들기
                ZStack{
                    Image("MY Eclipse")
                        .resizable()
                        .frame(width: planetSize*2, height: planetSize*2, alignment: .center)
//                    NavigationLink(destination: InboxView(), label: {
                        Image("MY")
                            .resizable()
                            .frame(width: planetSize*1.3, height: planetSize*1.3, alignment: .center)
//                    })
                }   // ZStack MY

                // 궤도 생성
                self.makeOrbit(diameter: diameter[0]).opacity(0.4).rotationEffect(.degrees(-30))
                self.makeOrbit(diameter: diameter[1]).opacity(0.3)
                self.makeOrbit(diameter: diameter[2]).opacity(0.2).rotationEffect(.degrees(30))
                self.makeOrbit(diameter: diameter[3]).opacity(0.1)

                // 별 생성
                self.makeStar(diameter: diameter[0])
                self.makeStar(diameter: diameter[1])
                self.makeStar(diameter: diameter[2])

                // 행성을 만드는 +행성 만들기
                makePlusPlanet(planetSize: planetSize, diameter: diameter)
                
            }   // ZStack
            // 가운대로 포지션 이동
            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
        }   // GeometryReader
        .onAppear{
            self.animationFlag.toggle()
            
        }
        
    }    // Body

    // +행성 만들기
    func makePlusPlanet(planetSize: CGFloat, diameter: [CGFloat]) -> some View {
        // 행성의 위치
        let planetPoint = [4.4, 5.6, 3.5, 6.7, 2.5]
        // 행성의 궤도 라인 정하기
        let planetDiameter = [diameter[2], diameter[1], diameter[1], diameter[1], diameter[1]]


        // 행성의 위치 계산.
        let angle = 2 * 3.14 + 1.57
        return ZStack {

//            Text("\(self.users?.count ?? 0)")
//                .font(Font.largeTitle)
//                .foregroundColor(.red)
            
            ForEach(0..<4){ planetLotateNumber in
                self.makePlanet(planetDiameter: planetDiameter[planetLotateNumber], point: planetPoint[planetLotateNumber], planetLotateNumber: planetLotateNumber, planetSize: planetSize)
//                Text(String(self.users?[0].nickname ?? "11"))
//                    .foregroundColor(.black)
            }
            ForEach(0..<5){ planetLotateNumber in
                NavigationLink(destination: DetailView(planetLotateNumber: planetLotateNumber, users: $users), tag : planetLotateNumber, selection: self.$tag){}
            }
            //버튼 만들기
            Button{
                self.showModal = true
            } label: {
               makeMainPlanet(planetNumber: 5)
                    .resizable()
                    .frame(width: planetSize/1.9, height: planetSize/1.9)
            }   // Button Label.
            .offset(x: cos(angle) * diameter[2]/2, y: sin(angle) * diameter[2]/2)

            }
            .sheet(isPresented: self.$showModal) {
                PlanetPlusModal(planetLotateNumber: .constant(0), users: $users) // 고쳐야함
                    }
    }

    // 행성을 만드는 함수
    func makePlanet(planetDiameter: CGFloat, point: Double, planetLotateNumber: Int, planetSize: CGFloat) -> some View {
        let angle = 2 * 3.14 + CGFloat(point)

        return ZStack {
//             makePlanet(planetDiameter: diameter[1], point: planetPoint[4], planetLotateNumber: 0, planetSize: planetSize)
            //버튼 만들기
            let friendsList = userViewModel.getFriendsList()
            
            if(self.users?[planetLotateNumber].nickname == nil){}
            else{ // planet있을때
                Button{
                    // 디테일뷰
                    self.tag = planetLotateNumber
                } label: {

                    makeMainPlanet(planetNumber: self.users?[planetLotateNumber].profile ?? 0)
                        .resizable()
                        .frame(width: planetSize, height: planetSize)
                }   // Button Label.
                .overlay{
                    Text(self.users?[planetLotateNumber].nickname ?? "")
                        .foregroundColor(.white)
                        .offset(y:planetSize/3)
                }
                .offset(x: cos(angle) * planetDiameter/2, y: sin(angle) * planetDiameter/2)

            }
        }   // else 끝
        
    }


    // 궤도를 만드는 함수.
    func makeOrbit(diameter: CGFloat) -> some View {
        return ZStack {
            Circle()    // 궤도
                .strokeBorder(  // 그라데이션 디자인 감각이 안좋아서 대충 넣어봤습니다..
                    AngularGradient(gradient: Gradient(colors: [.orbitLineColor, .orbitLineColor2, .orbitLineColor, .orbitLineColor2, .orbitLineColor]), center: .center)
                       )
                .frame(width: diameter, height: diameter)
        }
    }   // makeOrbit

    // 별을 만드는 함수
    func makeStar(diameter: CGFloat) -> some View {
        let starSize: CGFloat = 40
        return ZStack {
                Image("star")
                .resizable()
                .frame(width: starSize, height: starSize, alignment: .center)
                .offset(y:14)
                .modifier(self.makeStarEffect(diameter: diameter))
                .animation(Animation.linear(duration: 250)
                    .repeatForever(autoreverses: false))
        }
    }   // makeStar.

    // 별에 이펙트를 주는 함수
    func makeStarEffect(diameter: CGFloat) -> some GeometryEffect {
        return StarEffect(percent: self.animationFlag ? 1.0 : 0.0, radius: diameter / 2)
    }

}

// 움직이는 별에 대한 직접적인 설정을 하는 struct.
struct StarEffect: GeometryEffect {
    let initialAngle = CGFloat.random(in: 0..<2 * .pi)

    var percent: CGFloat = 0
    let radius: CGFloat

    var animatableData: CGFloat {
        get { return percent }
        set { percent = newValue }
    }

    func effectValue(size: CGSize) -> ProjectionTransform {
        let angle = 2 * .pi * percent + initialAngle
        let point = CGPoint(x: cos(angle) * radius, y: sin(angle) * radius)
        return ProjectionTransform(CGAffineTransform(translationX: point.x, y: point.y))
    }
}   //StarEffect




//struct MainViewModelPlanet_Previews: PreviewProvider {
//    static var previews: some View {
//        let appData = AppData()
//        GeometryReader{ geo in
//            NavigationView{
//                MainViewModelPlanet()
//                    .frame(height: geo.size.height/2)
//                    .environmentObject(appData)
//            }
//        }
//
//    }
//}
