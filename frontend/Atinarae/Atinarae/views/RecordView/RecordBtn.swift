//
//  RecordBtn.swift
//  RecordPart
//
//  Created by Cho Chaewon on 2023/05/07.
//

import SwiftUI

struct CircleBtn: View {
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color.gray, lineWidth: 20)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.blue, lineWidth: 20)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 45.0))
                    .onAppear() {
                        progress = 1.0
                    }
                Text("Button")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
        }
    }
}
