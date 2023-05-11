//
//  finalModalView.swift
//  Atinarae
//
//  Created by Cho Chaewon on 2023/05/10.
//

import SwiftUI

struct finalModalView: View {
    
    @StateObject var cameraModel = CameraViewModel()
    @State private var showModal = false

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
                        Image(systemName: "chevron.right")
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
                FinalPreview(url: url)
                    .environmentObject(cameraModel)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .padding(.top,60)
                    .padding(.bottom,10)
                
                }
            }
    }
}


//녹화버튼
//                    Button{
//                        if cameraModel.isRecording {
//                          cameraModel.stopRecording()
//                        } else {
//                            cameraModel.startRecording()
//                        }//녹화중!
//                    }
//                    label:{
//                        Image(systemName: "camera")
//                            .resizable()
//                            .renderingMode(.template)
//                            .aspectRatio(contentMode: .fit)
//                            .foregroundColor(.black)
//                            .opacity(cameraModel.isRecording ? 0 : 1)
//                            .padding(12)
//                            .frame(width:50, height: 50)
//                            .background{
//                                Circle()
//                                    .stroke(cameraModel.isRecording ? .clear : .black)
//                            }
//                            .padding(6)
//                            .background{
//                                ZStack{
//                                    Circle()
//                                        .fill(cameraModel.isRecording ? .red : .white)
//                                    if cameraModel.isRecording {
//                                        Circle()
//                                            .trim(from: 0, to: progress)
//                                            .stroke(Color.blue, lineWidth: 5)
//                                            .rotationEffect(.degrees(-90))
//                                            .animation(.easeInOut(duration: 45.0))
//                                            .onAppear() {
//                                                progress = 1.0
//                                            }
//                                    }
//                                }//zstack
//                            }
//                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
//
//                    }



//--------원 그래프 차오르는 것
//                                    if cameraModel.isRecording {
//                                        Circle()
//                                            .trim(from: 0, to: progress)
//                                            .stroke(Color.blue, lineWidth: 5)
//                                            .rotationEffect(.degrees(-90))
//                                            .animation(.easeInOut(duration: 45.0))
//                                            .onAppear() {
//                                                progress = 1.0
//                                            }
//                                    }
//-----원 그래프 차오르는 것
