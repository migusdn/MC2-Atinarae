//
//  plzModal.swift
//  Atinarae
//
//  Created by Cho Chaewon on 2023/05/10.
//

import SwiftUI

struct plzModal: View{
    
    @EnvironmentObject var cameraModel: CameraViewModel
    @Binding var showModal: Bool

    
    var body: some View {
        
        
        Button {
            
            if let _ = cameraModel.previewURL {
                cameraModel.showPreview.toggle()
                showModal.toggle()
            }

        }
    label:{
        Group{
            if cameraModel.previewURL == nil && !cameraModel.recordedURLs.isEmpty{
                ProgressView()
                    .tint(.black)
            } else {
                Label {
                    Image(systemName: "square.fill")
                        .font(.callout)
                } icon: {
                    Text("확인")
                }
                .foregroundColor(.black)
            }
        } //group 닫기
        .padding(.horizontal,20)
        .padding(.vertical,8)
        .background{
            Capsule()
                .fill(.white)
        }
    }
    .sheet(isPresented: $showModal){
        if let url = cameraModel.previewURL, cameraModel.showPreview{
//            FinalPreview(showPreview: $cameraModel.showPreview, url: url)
//                .environmentObject(cameraModel)
//                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
//                .padding(.top,60)
//                .padding(.bottom,10)

        }
    }
    
    }
}
