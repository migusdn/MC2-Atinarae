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
//    // MARK: - Define App Variable
//    private var userViewModel = UserViewModel()
//    private var videoMessageViewModel = VideoMessageViewModel()
//    private var navigationModel = NavigationModel()
    @State var pageNum = 0
    @State var isPresent: Bool = false
    
    var lastFlag: Bool
    {
        pageNum == 2
    }
    
    var body: some View
    {
        NavigationView{
            VStack
            {
                TabView(selection: $pageNum)
                {
                    OnBfirst()
                        .tag(0)
                    
                    OnBSecond()
                        .tag(1)
                    
                    OnBLast(lastFlag: lastFlag)
                        .tag(2)
                }
                //            .onChange(of: pageNum, perform: { newValue in
                //                print(newValue)
                //            })
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(width: 400, height: 600)
                
                
                HStack
                {
                    ForEach(0..<3)
                    {
                        idx in
                        
                        if idx == self.pageNum
                        {
                            Circle().foregroundColor(.white)
                        }
                        else
                        {
                            Circle().foregroundColor(.gray)
                        }
                    }
                    .frame(width: 10, height: 6)
                    .padding(.bottom, 20)
                }
                
                if isPresent
                {
                    Button(action:{})
                    {
                        NavigationLink(destination: MainView())
                        {
                            Text("시작하기")
                        }
                    }
                    .buttonStyle(ButtonPrimaryStyle(frameWidth: 200, frameHeight: 60))
                }
                else
                {
                    Button(action:{})
                    {
                        NavigationLink(
                            destination: MainView()
                            //                            .environmentObject(userViewModel)
                            //                            .environmentObject(videoMessageViewModel)
                            //                            .environmentObject(navigationModel)
                        )
                        {
                            Text("시작하기")
                        }
                    }
                    .buttonStyle(ButtonPrimaryStyle(frameWidth: 200, frameHeight: 60))
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
            .background(
                Group
                {
                    if pageNum == 1
                    {
                        Image("OnB2B")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                    }
                    else if pageNum == 2
                    {
                        Image("OnB3B")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                    }
                    else
                    {
                        Image("OnB1BC")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .edgesIgnoringSafeArea(.all)
                    }
                }
            )
            .navigationBarBackButtonHidden(true)
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
                Text("작은 마음이 모여")
                    .font(.system(size: 30).bold())
                    .offset(x: -60, y: -220)
                Text("Tvvinkle의 영상메세지 기능을\n통해 전하고 싶은 마음을 기록하세요")
                    .offset(x: -35, y: -160)
                ForEach(0..<Int.random(in:minStars...maxStars), id: \.self)
                {
                    _ in
                    
                    Star(LRChoice: LRValue())
                        .frame(width: 400, height: 350)
                        .offset(y: 80)
                }
                OnBFPlanet()
                    .offset(y: 80)
            }
        }
    }
}

struct OnBSecond: View
{
    @State private var offsetX: CGFloat = -250
    
    var body: some View
    {
        ZStack
        {
            Text("어두운 우주를 건너")
                .font(.system(size: 30).bold())
                .offset(x: -55, y: -220)
            Text("특별한 날 깜짝 선물이 되도록 \nD-day를 정해 메세지를 보내 보세요")
                .offset(x: -45, y: -160)
            Image("meteor1")
                .blendMode(.colorDodge)
                .offset(x: offsetX, y: 0)
                .animation(Animation.linear(duration: 6.5).repeatCount(1))
                .onAppear
            {
                startMove()
            }
        }
    }
    
    
    private func startMove()
    {
        withAnimation
        {
            offsetX += 350
        }
    }
}

struct OnBLast: View
{
    var lastFlag: Bool
    var body: some View
    {
        
        ZStack
        {
            Text("하늘에 빛을 비추어요")
                .font(.system(size: 30).bold())
                .offset(x: -40, y: -220)
            
            Text("오랜시간 당신을 위해 날아온 메세지가\n소중한 마음을 전달해 드려요")
                .offset(x: -35, y: -160)
            
            StarLight(lastFlag: lastFlag, imgName: "star33", delay: 0.5)
                .frame(width: 150)
                .offset(x: 140, y: 115)
            StarLight(lastFlag: lastFlag, imgName: "star33", delay: 1.7)
                .frame(width: 100)
                .blur(radius: 1.5)
                .offset(x: -100, y: -30)
            StarLight(lastFlag: lastFlag,imgName: "star33", delay: 2.3)
                .frame(width: 80)
                .blur(radius: 3.5)
                .offset(x: 140, y: -125)
            StarLight(lastFlag: lastFlag, imgName: "OnB3Phalo", delay: 0.5)
                .offset(y: 442.5)
            Image("OnB3Planet")
                .offset(x: -2.5, y: 468)
        }
        
    }
    
}


struct Star: View
{
    @State private var angle = CGFloat.random(in: -100...100)
    @State private var radius = CGFloat.random(in: 50...250)
    
    var size = CGFloat.random(in: 10...30)
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
                        if radius <= 0
                        {
                            timer.invalidate()
                        }
                    }
                }
            }
    }
}


struct StarLight: View
{
    var lastFlag: Bool
    
    let imgName: String
    let delay: Double
    
    @State private var isShowing = false
    
    var body: some View
    {
        Group
        {
            if lastFlag
            {
                Image(imgName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(1.0)
                    .onAppear
                    {
                        print("Planet")
                        DispatchQueue.main.asyncAfter(deadline: .now() + delay)
                        {
                            withAnimation(.easeIn(duration: 1.5))
                            {
                                print("Now\(delay)")
                                self.isShowing = true
                            }
                        }
                    }
                    .opacity(isShowing ? 1.0 : 0.0)
            }
        }
    }
}


struct OnBFPlanet: View
{
    @State private var scale: CGFloat = 0.0
//    @State private var rotationAngle: Double = 0
    
    var body: some View
    {
        ZStack
        {
            Image("OnB1Planet")
                .scaledToFit()
                .scaleEffect(scale)
                .onAppear
            {
                withAnimation( .linear(duration: 6.0))
                {
                    scale = 0.65
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
 
struct OnBoard_Previews: PreviewProvider
{
    static var previews: some View
    {
        OnBoardView()
    }
}
