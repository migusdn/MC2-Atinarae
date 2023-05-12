//
//  RecordView.swift
//  RecordPart
//
//  Created by Cho Chaewon on 2023/05/04.
//

import SwiftUI
import AVKit



struct RecordView: View {
    @StateObject var cameraModel = CameraViewModel()
    @State private var progress: CGFloat = 0.0
    @State var isBack = true
    @State private var selectedSegment = 0
    
    let timeSelect = ["15초" ,"45초"]
    
    var body: some View{
        
        
        ZStack(alignment: .bottom) {
            
            //카메라 뷰
            CameraRecord()
                .environmentObject(cameraModel)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .padding(.top,10)
                .padding(.bottom,70)
            
        
            Spacer()
            
            Picker(selection: $selectedSegment, label: Text("시간시간")) {
                        ForEach(0..<timeSelect.count) { index in
                            Text(timeSelect[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 150)
            
            
            Spacer()
            
            //컨트롤 버튼들
            HStack{
                //화면전환 버튼
                Button{
                    if cameraModel.isBack { //뒷면
                        cameraModel.setUp()
                        print("뒷면")
                    } else { //앞면
                        cameraModel.setUp()
                        print("앞면")
                    }
                    
                }
            label: {
                Image(systemName: "arrow.triangle.2.circlepath")
                    .resizable()
                //.renderingMode(.template)
                //.aspectRatio(contentMode: .fit)
                    .frame(width:50, height: 50)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
            .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: 0))
                
                
                
                //녹화버튼
                Button{
                    if cameraModel.isRecording {
                        cameraModel.stopRecording()
                    } else {
                        cameraModel.startRecording()
                        
                    }//녹화중!
                }
            label: {
                Image(systemName: "camera")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.black)
                    .opacity(cameraModel.isRecording ? 0 : 1)
                    .padding(12)
                    .frame(width:50, height: 50)
                    .background{
                        Circle()
                            .stroke(cameraModel.isRecording ? .clear : .black)
                    }
                    .padding(6)
                    .background{
                        ZStack{
                            Circle()
                                .fill(cameraModel.isRecording ? .red : .white)
                            if cameraModel.isRecording {
                                Circle()
                                    .trim(from: 0, to: progress)
                                    .stroke(Color.blue, lineWidth: 5)
                                    .rotationEffect(.degrees(-90))
                                    .animation(.easeInOut(duration: 45.0))
                                    .onAppear() {
                                        progress = 1.0
                                    }
                            }
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
                
                //확인 btn
                Button{
                    if let _ = cameraModel.previewURL {
                        cameraModel.showPreview.toggle()
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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            //.padding(.trailing)
            //.opacity(cameraModel.previewURL == nil && !cameraModel.recordedURLs.isEmpty || cameraModel.isRecording ? 0 : 1)
                
                }//HStack 임당
                .padding(EdgeInsets(top: 40, leading: 0, bottom: -80, trailing: 0))
            }//ZStack
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.top,10)
            .padding(.bottom,30)
            
//            Button {
//                cameraModel.recordedDuraion = 0
//                cameraModel.previewURL = nil
//                cameraModel.recordedURLs.removeAll()
//            } label : {
//                Image(systemName: "xmark")
//                    .font(.title)
//                    .foregroundColor(.white)
//            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//            .padding()
//            .padding(.top)
        //}
        .overlay(content: {
            if let url = cameraModel.previewURL, cameraModel.showPreview{
                FinalPreview(showPreview: $cameraModel.showPreview, url: url)
                    .transition(.move(edge: .trailing))
            }
            
        })
        .animation(.easeInOut, value: cameraModel.showPreview)
        .preferredColorScheme(.dark)
        
        
        
    }
}

struct FinalPreview: View {
    @Binding var showPreview: Bool
    @StateObject var cameraModel = CameraViewModel()
    var url: URL
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            
            VideoPlayer(player: AVPlayer(url: url))
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width, height: 600) //600 대신 size.height 였음
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            //뒤로가기
                .overlay(alignment: .topLeading) {
                    Button {
                        showPreview.toggle()
                    } label : {
                        Label {
                            Text("back")
                        } icon: {
                            Image(systemName: "chevron.left")
                        }
                        .foregroundColor(.white)
                        
                    }
                    .padding(.leading)
                    .padding(.top,22)
                }

            Button {
                cameraModel.recordedDuraion = 0
                cameraModel.previewURL = nil
                cameraModel.recordedURLs.removeAll()
            } label : {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            .padding(.top)
        }
    }//body view 닫힘
} //Final view 닫힘

struct RecordView_Previews: PreviewProvider {
    static var previews: some View{
        RecordView()
    }
}
