//
//  homeView.swift
//  RecordPart
//
//  Created by Cho Chaewon on 2023/05/08.
//

import SwiftUI

struct homeView: View{
    var body: some View {

//            VStack{
//
//                Text("0:15") //타이머 나오도록 바꿔야함
//                    .font(.title)
//                    .foregroundColor(.white)
//
//                Text("작성자가 쓴 제목") //작성자가 적은 제목 user.title로 이동할 수 있도록 만들기
//                    .font(.system(size: 20, weight: .thin))
//                    .foregroundColor(.gray)
                
                
                
                //여기서 If문으로 녹화중일 떈 RecordView, 확인버튼으로 넘어가면 FinalPreview로 바꾸기
                RecordView()
                    //.frame(width: .infinity, height: 300)
                
           // }
            //.padding(EdgeInsets(top: -30, leading: 0, bottom: 0, trailing: 0))
        
    }
}
