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
    @State private var selectedSegment = 0
    @State private var showModal = false
    @State var Flag: Bool = true
    var url : URL?
    //var videoURL: URL
    //@State var checkBack: Bool = true
    
    var body: some View{
        
        GeometryReader { geo in
            ZStack {
                VStack{
                    
                    Text("0:15") //타이머 나오도록 바꿔야함
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text("작성자가 쓴 제목") //작성자가 적은 제목 user.title로 이동할 수 있도록 만들기
                        .font(.system(size: 20, weight: .thin))
                        .foregroundColor(.gray)
                    //카메라 뷰
                    CameraRecord()
                        .frame(width: geo.size.width, height: 500)
                        .environmentObject(cameraModel)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(.top,10)
                        .padding(.bottom,10)
                    
                    
                    //컨트롤 버튼들
                    HStack{
                        //화면전환 버튼
                        Button{
                            cameraModel.setUp()
                        }
                    label: {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width:30, height: 30)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                    .padding(EdgeInsets(top: 0, leading: 60, bottom: 0, trailing: -30))
                        
                        
                        
                        
                        Button{
                            if cameraModel.isRecording {
                                cameraModel.stopRecording()
                                showModal.toggle()
                            } else {
                                cameraModel.startRecording()
                            }//녹화중!
                        }
                    label:{
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
                                }//zstack
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        
                    }
                        
                        
                        
                        
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
//                        if let url = cameraModel.previewURL, cameraModel.showPreview{
                        FinalPreview(url: cameraModel.recordedURL!)
//                                .environmentObject(cameraModel)
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                .padding(.top,60)
                                .padding(.bottom,10)
                            
//                        }
                    }
                    }
                    
                    
                }//vstack
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.top,10)
                .padding(.bottom,30)
                .animation(.easeInOut, value: cameraModel.showPreview)
                .preferredColorScheme(.dark)
                
            }
        }
    }//zstack
}//geometry


struct FinalPreview: View {
//    @Binding var showPreview: Bool
//    @StateObject var cameraModel = CameraViewModel()
    var url: URL
    
    var body: some View {
        GeometryReader { geo in
            let size = geo.size
            
            VStack(alignment: .center) {
                
                Text("수능을 마친 딸에게") //user의 title 가져와야함
                    .font(.system(size: 20, weight: .thin))
                    .foregroundColor(.gray)
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 30, trailing: 0))
                
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(width: size.width, height: size.height / 5 * 3, alignment: .center) //600 대신 size.height 였음
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                
                
                //----------------------------------------------------------------------------------------------------------------------------------------
                //overlay로 영상 재생 시간 만들어주기
                
                //----------------------------------------------------------------------------------------------------------------------------------------
                //뒤로가기  {
                
                //뒤로가기
                //                .overlay(alignment: .topLeading) {
                //                    Button {
                //                        showPreview.toggle()
                //                    } label : {
                //                        Label {
                //                            Text("back")
                //                        } icon: {
                //                            Image(systemName: "chevron.left")
                //                        }
                //                        .foregroundColor(.white)
                //
                //                    }
                //                    .padding(.leading)
                //                    .padding(.top,22)
                //                }
                
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
                
            }
            Spacer()
            Button{
                //영상 저장 버튼으로 이동하기
            } label: {
                RoundedRectangle(cornerRadius: 30)
                    .fill(
                        AngularGradient(gradient: Gradient(colors: [.buttonColor, .buttonColor1]), center: .top)
                    )
                    .frame(width: 100, height: 50, alignment: .bottom)
                    .overlay{
                        Text("다음")
                            .foregroundColor(.black)
                            .font(.subheadline).bold()
                    }
            }
            
        }
        .padding(EdgeInsets(top: -50, leading: 0, bottom: 30, trailing: 0))
        
    }//body view 닫힘
} //Final view 닫힘

