//
//  SharedViewFactory.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/10.
//

import SwiftUI

func makeGradientButton(_ text: String) -> some View{
    Text(text)
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
