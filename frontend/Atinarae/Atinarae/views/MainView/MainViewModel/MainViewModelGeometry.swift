//
//  MainViewModelGeometry.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/04.
//

//  ----------------------------------------------------------------------
//              삽질을 정말... 많이 했읍니다...
//              여기서도 지오메트리리더를 사용, 메인뷰와 여기서 이중으로 사용해서
//              문제가 많았는데, 어찌 해결을 했습니다?
//              이 파일은 여기보단 밑에 적어놓은 주석을 보는게 코드 이해가 더 빠를수도 있습니다.
//  ----------------------------------------------------------------------


import SwiftUI

struct MainViewModelGeometry: View {
    @EnvironmentObject var appData: AppData
    @State private var animationFlag = false        // 별들이 도는 애니메이션 bool
    @State var tag:Int? = nil                       // 네비게이션뷰 이동을 위한 tag
    private var animation = Animation.linear.repeatForever(autoreverses: false)
    let planetSize: CGFloat = 100   // 행성의 크기 조절
    let starSize: CGFloat = 40      // 별의 크기 조절
    // @Environment(\.presentationMode) var presentationMode
    @State private var showModal = false
    
    var body: some View {
        
        
        GeometryReader{ geo in
            let diameter = [geo.size.height/2.5,geo.size.height/1.5,geo.size.height/1.1] // 3번째 원]
            let planetDiameter = [diameter[2], diameter[2], diameter[1], diameter[1], diameter[2]]
            let planetPoint = [4.4, 5.6, 3.5, 6.7, 1.5]
            
            ZStack{
                
                // 배경화면
                Color.backGroundColor

                // 원 생성
                self.makeCircle(dim: diameter[0] - 50)
                self.makeCircle(dim: diameter[1]  - 50)
                self.makeCircle(dim: diameter[2] - 50)
                
                
                ForEach(0..<5){ number in
                    self.makePlanet(planetDiameter: planetDiameter[number], point: planetPoint[number], planetNumber: number)
                }
            
                // 가운대에 있는 MY생성, Eclipse가 버튼이 되지 않게 따로 빼놓음
                ZStack{
                    NavigationLink(destination: InboxView(), label: {
                        Image("MY")
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                    })
//                    Image("MY Eclipse")
//                    Button{
//
//                    } label: {
//
//                    }
                }
            }
            .onAppear{
                self.animationFlag.toggle() // 실행시 애니메이션 실행
            }
            
            // tag로 뷰 이동을 위한 링크 설정
            ForEach(0..<5) { navigationNum in
                NavigationLink(destination: DetailView(number: navigationNum), tag : navigationNum, selection: self.$tag){}
            }
            
        }
    }
    
    // 이곳에서 움직이는 별과 궤도를 만듭니다.
    func makeCircle(dim: CGFloat) -> some View {
        let diameter = dim + 50
        return ZStack {
            Circle()    // 궤도
                .strokeBorder(  // 그라데이션 디자인 감각이 안좋아서 대충 넣어봤습니다..
                    AngularGradient(gradient: Gradient(colors: [.orbitLineColor, .orbitLineColor2, .orbitLineColor, .orbitLineColor2, .orbitLineColor]), center: .center)
                       )
                .frame(width: diameter, height: diameter)
            
            Image("star")   // 별
                .resizable()
                .frame(width: starSize, height: starSize, alignment: .center)
                .offset(y:14)
                .modifier(self.makeOrbitEffect(diameter: diameter))
                .animation(Animation.linear(duration: 250)
                    .repeatForever(autoreverses: false))
            
            
        }
    }
    
    func makePlanet(planetDiameter: CGFloat, point: Double, planetNumber: Int) -> some View {
        return ZStack {
            
                Button{
                    if appData.user.friends[planetNumber].nickname == nil{
                        self.showModal = true
                    } else {
                        self.tag = planetNumber
                    }
                } label: {
                    VStack{
                        Image(appData.user.friends[planetNumber].planetImage ?? "planet_Empty")
                            .resizable()
                            .frame(width: planetSize, height: planetSize)
                        Text(appData.user.friends[planetNumber].nickname ?? "")
                            .foregroundColor(.white)
                    }
                }
                .modifier(self.makePlanetEffect(diameter: planetDiameter, point: point))
                .sheet(isPresented: self.$showModal) {
                                MakePlanetModalView(planetNumber: planetNumber)
                            }
                
            }
            
    }
    
    func makePlanetEffect(diameter: CGFloat, point: Double) -> some GeometryEffect {
        return PlanetEffect(point: point, percent: 0, radius: diameter / 2)
    }
   
    func makeOrbitEffect(diameter: CGFloat) -> some GeometryEffect {
        return OrbitEffect(percent: self.animationFlag ? 1.0 : 0.0, radius: diameter / 2)
    }

}



struct OrbitEffect: GeometryEffect {
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
}

struct PlanetEffect: GeometryEffect {
    let point: Double
    let percent: CGFloat
    let radius: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let angle = 2 * 3.14 + CGFloat(point)
        
        return ProjectionTransform(CGAffineTransform(translationX: cos(angle) * radius, y: sin(angle) * radius))
    }
}

struct MainViewModelGeometry_Previews: PreviewProvider {
    static var previews: some View {
        let appData = AppData()
            GeometryReader{ geo in
                NavigationView{
                MainViewModelGeometry()
                    .frame(width: geo.size.width, height: geo.size.height/2)
                    .environmentObject(appData)
            }
        }
    }
}



// 행성 생성
//                Button{ // 1번
//
//                } label: {
//                    Image("planet_py")
//                        .resizable()
//                        .frame(width: planetSize, height: planetSize)
//                }
//                .modifier(self.makePlanetEffect(diameter: planetDiameter[0], point: 4.4))
//
//
//                Button{ // 2번
//
//                } label: {
//                    Image("planet_yb")
//                        .resizable()
//                        .frame(width: planetSize, height: planetSize)
//
//                }
//                .modifier(self.makePlanetEffect(diameter: diameter[2], point: 5.6))
//
//                Button{ //3번
//
//                } label: {
//                    Image("planet_by")
//                        .resizable()
//                        .frame(width: planetSize, height: planetSize)
//                }
//                .modifier(self.makePlanetEffect(diameter: diameter[1], point: 3.5))
//
//                Button{ // 4번
//                    // self.tag = 1
//                } label: {
//                    Image("planet_by")
//                        .resizable()
//                        .frame(width: planetSize, height: planetSize)
//                }
//                .modifier(self.makePlanetEffect(diameter: diameter[1], point: 6.7))
//
//                Button{ // 5번
//
//                } label: {
//                    Image("planet_yb")
//                        .resizable()
//                        .frame(width: planetSize, height: planetSize)
//                }
//                .modifier(self.makePlanetEffect(diameter: diameter[2], point: 1.5))
