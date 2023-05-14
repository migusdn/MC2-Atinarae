//
//  Buttons.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/14.
//

import SwiftUI
import Foundation

// MARK: -Common Button Style
/*
 아래 내용을 변경하면 모든 버튼 스타일이 변경됩니다.
 버튼은 width, height를 모두 지정하여 생성이 가능하고
 고정 비율 계산을 통한 생성도 가능합니다
 var commonGradient: Primary Button 그라데이션을 설정하는 부분.
 var commonButtonWidthRatio: 지정된 ratio에 따라 width로 프레임을 계산하여 Height를 지정하는 비율
 */
//그라데이션 정의 부분
var commonGradient: LinearGradient = LinearGradient(
    gradient: Gradient(colors: [
        Color(red: 0.569, green: 0.541, blue: 0.961),
        Color(red: 0.685, green: 0.74, blue: 0.981),
        Color(red: 0.792, green: 0.922, blue: 1)
    ]),
    startPoint: UnitPoint(x: 1, y: 0.5),
    endPoint: UnitPoint(x: 0, y: 0.5)
)

var commonButtonWidthRatio: CGFloat = 0.6

// MARK: - PrimaryStyle For Button
/*
 Usage: Button(action: {}) { some View }.buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
 사용법은 primary, secondary 모두 같으며 상황에 맞게 사용하면 됩니다.
 
 Button 생성 방법에는 두 종류가 있으며, 이 두 종류는 아래와 같습니다
 
 1. Frame Width, Frame Height를 파라미터로 받아 처리하는 방식
 -> 이는 사용자가 직접 너비와 높이를 지정하는 방식으로 디테일을 조절해야 할 때 사용하세요.
 
 2. Frame Widht 만으로 높이를 자동으로 지정하는 방식
 -> 이는 앱 전반적으로 모두 같은 비율의 버튼을 가질때 사용하세요.
    비율은 상단의 commonButtonWidthRatio를 변경하면 됩니다.
    계산의 공식은 이와 같습니다.
    ex) 주어진 width가 100이고 commonRatio가 0.6이라면 height는 60 입니다
        width : 100         commonRatio : 0.6
        height: 100 * 0.6
*/
struct ButtonPrimaryStyle: ButtonStyle{
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: frameWidth, height: frameHeight)
            .foregroundColor(Color.black)
            .background(
                commonGradient.cornerRadius(100)
            )
            .fontWeight(.heavy)
        
    }
}
struct ButtonSecondaryStyle: ButtonStyle{
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: frameWidth, height: frameHeight)
            .foregroundColor(Color.white)
            .background(
                Color.buttonSecondary
                .cornerRadius(100)
            )
            .fontWeight(.heavy)
        
        
    }
}
struct ButtonPrimaryStyleByRatio: ButtonStyle{
    let frameWidth: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: frameWidth, height: frameWidth*commonButtonWidthRatio)
            .foregroundColor(Color.black)
            .background(
                commonGradient.cornerRadius(100)
            )
            .fontWeight(.heavy)
        
    }
}
struct ButtonSecondaryStyleByRatio: ButtonStyle{
    let frameWidth: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: frameWidth, height: frameWidth*commonButtonWidthRatio)
            .foregroundColor(Color.white)
            .background(
                Color.buttonSecondary
                .cornerRadius(100)
            )
            .fontWeight(.heavy)
        
        
    }
}
