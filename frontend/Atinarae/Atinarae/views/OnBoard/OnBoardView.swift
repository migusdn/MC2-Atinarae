//
//  OnBoardView.swift
//  Atinarae
//
//  Created by Kimdohyun on 2023/05/10.
//

import Foundation
import SwiftUI


struct OnBoardView: View
{
    @State var pageNum = 0
    @State var isHidden: Bool = true
    @State var isPresent: Bool = false
    
    var body: some View
    {
        VStack
        {
            TabView(selection: $pageNum)
            {
                OnBfirst()
                    .tag(0)
                
                OnBSecond()
                    .tag(1)
                
                OnBLast()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .frame(width: 400, height: 600)
            
            HStack
            {
                ForEach(0..<3)
                {
                    idx in
                    
                    if idx == self.pageNum
                    {
                        Circle().foregroundColor(.red)
                    }
                    else
                    {
                        Circle().foregroundColor(.gray)
                    }
                }
                .frame(width: 10, height: 6)
            }
            
            if isPresent
            {
                Button {}
                label:
                {
                    Text("시작하기")
                        .frame(width: 250, height: 30)
                }
                .ignoresSafeArea()
                .background(Color(.white))
                .foregroundColor(.black)
                .padding()
            }
            else
            {
                Button {}
                label:
                {
                    Text("시작하기")
                        .frame(width: 250, height: 30)
                }
                .ignoresSafeArea()
                .padding()
                .opacity(0)
            }
        }

        .onChange(of: pageNum)
        {
            newPageIdx in
            
            if newPageIdx == 2
            {
                isPresent = true
            }
            else
            {
                isPresent = false
            }
        }
    }
}

struct OnBfirst: View
{
    let minStars = 20
    let maxStars = 50
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                ForEach(0..<Int.random(in:minStars...maxStars), id: \.self)
                {
                    _ in
                    
                    Star(LRChoice: LRValue())
                        .frame(width: 400, height: 350)
                    
                }
            }
            Text("작은 마음이 모여")
                .frame(width: 400, height: 200)
                .background(Color(.gray))
        }
    }
}

struct OnBSecond: View
{
    var body: some View
    {
        VStack
        {
            Text("11")
                .frame(width: 400, height: 350)
                    
            Text("작은 마음이 모여")
                .frame(width: 400, height: 200)
                .background(Color(.gray))
        }
    }
}

struct OnBLast: View
{
    var body: some View
    {
        VStack
        {
            Text("11")
                .frame(width: 400, height: 350)
                    
            Text("작은 마음이 모여")
                .frame(width: 400, height: 200)
                .background(Color(.gray))
        }
    }
}


struct Star: View
{
    @State private var angle = CGFloat.random(in: -100...100)
    @State private var radius = CGFloat.random(in: 50...250)
    
    var size = CGFloat.random(in: 10...100)
    //var speed = Double
    
    var LRChoice: CGFloat = LRValue()

    var body: some View
    {
        Image("star")
            .resizable()
            .frame(width: size, height: size)
            .offset(x: radius * CGFloat(cos(angle)), y: radius * CGFloat(sin(angle * LRChoice)))
            .onAppear
            {
                Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true)
                {
                    timer in
                    withAnimation(Animation.linear(duration: 8.0))
                    {
                        self.angle += 0.1
                        self.radius -= 0.5
                        if radius <= 50
                        {
                            
                        }
                        if radius <= 0
                        {
                            timer.invalidate()
                        }
                    }
                }
            }
    }
}

func LRValue() -> CGFloat
{
    var LRChoice: CGFloat

    let LValue: CGFloat  = -1
    let RValue: CGFloat  = 1
    
    let boolCheck: Bool = Bool.random()
    
    if boolCheck
    {
        LRChoice = LValue
    }
    else
    {
        LRChoice = RValue
    }
    
    return LRChoice
}



/*
{
    @State private var stars: [StarView] = []
        
        private let minStarCount = 10
        private let maxStarCount = 15
        
        private let spiralRadius: CGFloat = 150
        private let spiralRotation: Double = 5 // 회전 속도
        
        private let gatheringDuration: Double = 2 // 모이는 애니메이션 지속 시간
        
        var body: some View {
            ZStack {
                ForEach(stars) { star in
                    star
                }
            }
            .onAppear {
                generateStars()
                animateStars()
            }
        }
        
        private func generateStars() {
            let starCount = Int.random(in: minStarCount...maxStarCount)
            
            for _ in 0..<starCount {
                let angle = Double.random(in: 0..<360)
                let distance = CGFloat.random(in: 0..<spiralRadius)
                
                let x = distance * cos(CGFloat(angle))
                let y = distance * sin(CGFloat(angle))
                
                let star = StarView(position: CGPoint(x: x, y: y), rotation: angle)
                stars.append(star)
            }
        }
        
        private func animateStars() {
            withAnimation(Animation.linear(duration: gatheringDuration)) {
                for i in 0..<stars.count {
                    stars[i].position = .zero
                    stars[i].rotation += spiralRotation
                }
            }
        }
}


struct StarView: View, Identifiable {
    let id = UUID()
    var position: CGPoint
    var rotation: Double
    
    var body: some View {
        Image("star") // 별 이미지 이름을 적절히 변경하세요.
            .resizable()
            .frame(width: 20, height: 20)
            .position(position)
            .rotationEffect(Angle.degrees(rotation))
    }
}


*/
/*
struct Star: View, Hashable, Identifiable {
    var id = UUID()
    var position: CGPoint
    var size: CGSize
    
    @State private var angle = 0.0
    @State private var radius: CGFloat = 200.0
    
    func position(at angle: Double, radius: CGFloat) -> CGPoint {
        CGPoint(x: radius * CGFloat(cos(angle)), y: radius * CGFloat(sin(angle)))
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var body: some View {
        let currentAngle = angle
        let currentRadius = radius
        
        return Image("star")
            .resizable()
            .frame(width: size.width, height: size.height)
            .offset(x: position.x + position(at: currentAngle, radius: currentRadius).x, y: position.y + position(at: currentAngle, radius: currentRadius).y)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true) { timer in
                    withAnimation(Animation.linear(duration: 8.0)) {
                        self.angle += 0.1
                        self.radius -= 0.5
                        if self.radius <= 0 {
                            timer.invalidate()
                        }
                    }
                }
            }
    }
}
*/
/*
struct Star: View, Hashable, Identifiable
{
    var id = UUID()
    var position: CGPoint
    var Ssize: CGSize
    
    var angleOffset: Double
    {
        Double.random(in: -200...200)
    }
    
    var radiusOffset: CGFloat
    {
        CGFloat.random(in: 10...50)
    }
    
    static func == (lhs: Star, rhs: Star) -> Bool
    {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher)
    {
        hasher.combine(id)
    }
    
    var body: some View
    {
        let randomX = CGFloat.random(in: -200...200)
        let randomS = CGFloat.random(in: 10...50)
        
        Image("star")
            .resizable()
            .frame(width: randomS, height: randomS)
            .offset(x: radius * CGFloat(cos(angle - randomX)), y: radius * CGFloat(sin(angle)))
            .onAppear
            {
                let randomCount = Int.random(in: 10...20)
                
                for _ in 0..<randomCount
                {
                    
                }
                Timer.scheduledTimer(withTimeInterval: 0.015, repeats: true)
                {
                    timer in
                    // .repeatForever(autoreverses: false) 넣으면 무한 반복
                    withAnimation(Animation.linear(duration: 8.0))
                    {
                        self.angle += 0.1
                        self.radius -= 0.5
                        if self.radius == 0
                        {
                            timer.invalidate()
                        }
                    }
                }
            }
    }
}

 */
 
struct Siri: View
{
    @State var isRotating = false
    
    var body: some View
    {
        ZStack
        {
            ZStack
            {
                Image("shadow")
                Image("icon-bg")
                Image("pink-top")
                    .rotationEffect(.degrees(isRotating ? 320 : -360))
                    .hueRotation(.degrees(isRotating ? -270 : 60))
                    
                Image("pink-left")
                    .rotationEffect(.degrees(isRotating ? -360 : 180))
                    .hueRotation(.degrees(isRotating ? -220 : 300))
                    
                Image("blue-middle")
                    .rotationEffect(.degrees(isRotating ? -360 : 420))
                    .hueRotation(.degrees(isRotating ? -150 : 0))
                    .rotation3DEffect(.degrees(75), axis: (x: isRotating ? 1 : 5, y: 0, z: 0))
                
                Image("blue-right")
                    .rotationEffect(.degrees(isRotating ? -360 : 420))
                    .hueRotation(.degrees(isRotating ? 720 : -50))
                    .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: isRotating ? -5 : 15))
                
                Image("intersect")
                    .rotationEffect(.degrees(isRotating ? 30 : -420))
                    .hueRotation(.degrees(isRotating ? 0 : 720))
                    .rotation3DEffect(.degrees(15), axis: (x: 1, y: 1, z: 1), perspective: isRotating ? 5 : -5)
                    
                Image("green-right")
                    .rotationEffect(.degrees(isRotating ? -300 : 360))
                    .hueRotation(.degrees(isRotating ? 300 : -15))
                    .rotation3DEffect(.degrees(15), axis: (x: 1, y: isRotating ? -1 : 1, z: 0), perspective: isRotating ? -1 : 1)
                
                Image("green-left")
                    .rotationEffect(.degrees(isRotating ? 360 : -360))
                    .hueRotation(.degrees(isRotating ? 180 :50))
                    .rotation3DEffect(.degrees(75), axis: (x: 1, y:isRotating ? -5 : 15, z: 0))
                
                
                Image("bottom-pink")
                    .rotationEffect(.degrees(isRotating ? 400 : -360))
                    .hueRotation(.degrees(isRotating ? 0 : 230))
                    .opacity(0.25)
                    .blendMode(.multiply)
                    .rotation3DEffect(.degrees(75), axis: (x: 5, y:isRotating ? 1 : -45, z: 0))
            }
            .blendMode(isRotating ? .hardLight : .difference )
            
            Image("highlight")
                .rotationEffect(.degrees(isRotating ? 360 : 250))
                .hueRotation(.degrees(isRotating ? 0 : 230))
                .padding()
                .onAppear
                {
                    // .repeatForever(autoreverses: false) 넣으면 무한반복
                    withAnimation(.easeInOut(duration: 12))
                    {
                        isRotating.toggle()
                    }
                }
        }
        .scaleEffect(0.6)
    }
}

struct OnBoard_Previews: PreviewProvider
{
    static var previews: some View
    {
        OnBoardView()
    }
}
