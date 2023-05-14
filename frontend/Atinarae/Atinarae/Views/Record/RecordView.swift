//
//  RecordView.swift
//  RecordPart
//
//  Created by Cho Chaewon on 2023/05/04.
//

import SwiftUI
import AVKit
import UIKit



struct RecordView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var cameraModel = CameraViewModel()
    var videoMessage: VideoMessage
    @State private var progress: CGFloat = 0.0
    @State private var selectedSegment = 0
    @State private var showModal = false
    @State private var timeOutModal = false
    
    var url : URL?
    
    @State private var sec = 0
    @State private var showAlert: Bool = false
    @State private var value = false
    
    
    var body: some View{
        
        GeometryReader { geo in
            ZStack {
                VStack{
                    if cameraModel.isRecording {
                        var sec = Int(cameraModel.recordedDuraion)
                        
                        Text("0 : \(sec/10)\(sec%10)")
                            .font(.largeTitle)
                        
                    } else {
                        Text("0 : 00")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    
                    
                    Text(videoMessage.title)
                        .font(.system(size: 20, weight: .thin))
                        .foregroundColor(.gray)
                    
                    //카메라 뷰
                    CameraRecord()
                        .frame(width: geo.size.width, height: 450)
                        .environmentObject(cameraModel)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        .padding(.top,10)
                        .padding(.bottom,10)
                    
                    VStack{
                        //컨트롤 버튼들
                        VStack {
                            HStack(){
                                //화면전환 버튼
                                
                                Button(action:{
                                    cameraModel.setUp()
                                }){
                                    Image(systemName: "arrow.triangle.2.circlepath")
                                        .resizable()
                                        .renderingMode(.template)
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width:40, height: 40)
                                        .foregroundColor(.white)
                                }
                                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding(EdgeInsets(top: 0, leading: 30, bottom: 20, trailing: 40))
                                .opacity(cameraModel.recordedDuraion >= cameraModel.maxDuration ? 0 : 1)
                                .opacity(cameraModel.isRecording ? 0 : 1)
                                
                                
                                Button(action:{
                                    
                                    
                                    if cameraModel.isRecording { //녹화중단!
                                        if cameraModel.recordedDuraion <= cameraModel.minDuration { //15초 미만일 때 다시 녹화되도록 만들기
                                            let alert = UIAlertController(title: "알림", message: "15초 이상 녹화해주세요.", preferredStyle: .alert)
                                            alert.addAction(UIAlertAction(title: "확인", style: .default))
                                            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
                                            cameraModel.stopRecording()
                                            cameraModel.recordedDuraion = 0
                                            print("15초 미만입니당 다시 찍어주세요오옹ㅇ오ㅗㅇ")
                                        } //15초 미만일 때 다시 녹화되도록 만들기
                                        else { //정상적으로 녹화중단 버튼 누른 경우
                                            if let _ = cameraModel.previewURL {
                                                cameraModel.showPreview.toggle()
                                                print(videoMessage.description)
                                                
                                            }
                                            cameraModel.stopRecording()
                                            showModal.toggle()
                                            cameraModel.recordedDuraion = 0
                                        }
                                        
                                    } else {
                                        if cameraModel.recordedDuraion >= cameraModel.maxDuration { //45초가 넘었을 때
                                            if let _ = cameraModel.previewURL {
                                                cameraModel.showPreview.toggle()
                                            }
                                            cameraModel.stopRecording()
                                            showModal.toggle()
                                            cameraModel.recordedDuraion = 0
                                        } else {
                                            cameraModel.startRecording()
                                        }
                                    }
                                }){
                                    
                                    //버튼모양
                                    if cameraModel.isRecording { //녹화중일때
                                        ZStack {
                                            Circle()
                                                .stroke(Color.gray, lineWidth: 3)
                                                .frame(width: 63, height:63)
                                                .foregroundColor(.gray)
                                            
                                            
                                            Rectangle()
                                                .fill(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [
                                                            Color(red: 0.569, green: 0.541, blue: 0.961),
                                                            Color(red: 0.685, green: 0.74, blue: 0.981),
                                                            Color(red: 0.792, green: 0.922, blue: 1)
                                                        ]),
                                                        startPoint: UnitPoint(x: 1, y: 0.5),
                                                        endPoint: UnitPoint(x: 0, y: 0.5)
                                                    )
                                                )
                                                .frame(width: 18, height: 18)
                                                .cornerRadius(1)
                                            
                                        }
                                    } else { //녹화 아닐 때
                                        
                                        ZStack {
                                            
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                                .frame(width: 63, height:63)
                                                .opacity(cameraModel.recordedDuraion >= cameraModel.maxDuration ? 0 : 1)
                                            
                                            //.background(Image(systemName: "checkmark").fontWeight(.bold))
                                            
                                            Circle()
                                                .fill(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [
                                                            Color(red: 0.569, green: 0.541, blue: 0.961),
                                                            Color(red: 0.685, green: 0.74, blue: 0.981),
                                                            Color(red: 0.792, green: 0.922, blue: 1)
                                                        ]),
                                                        startPoint: UnitPoint(x: 1, y: 0.5),
                                                        endPoint: UnitPoint(x: 0, y: 0.5)
                                                    )
                                                )
                                                .frame(width: 55, height: 55)                                                    .opacity(cameraModel.recordedDuraion >= cameraModel.maxDuration ? 0 : 1)
                                            
                                            
                                            Text("다음")
                                                .frame(width: 91, height: 58)
                                                .foregroundColor(Color.black)
                                                .background(
                                                    LinearGradient(
                                                        gradient: Gradient(colors: [
                                                            Color(red: 0.569, green: 0.541, blue: 0.961),
                                                            Color(red: 0.685, green: 0.74, blue: 0.981),
                                                            Color(red: 0.792, green: 0.922, blue: 1)
                                                        ]),
                                                        startPoint: UnitPoint(x: 1, y: 0.5),
                                                        endPoint: UnitPoint(x: 0, y: 0.5)
                                                    )
                                                    .cornerRadius(100)
                                                )
                                                .opacity(cameraModel.recordedDuraion >= cameraModel.maxDuration ? 1 : 0)
                                        }
                                        
                                        
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 100))
                                .sheet(isPresented: $showModal){
                                    FinalPreview(url: cameraModel.recordedURL!, videoMessage: videoMessage, onClose: { showModal.toggle() })
                                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                                        .padding(.top,60)
                                        .padding(.bottom,10)
                                }
                                
                            }
                            .offset(x: 50, y: 0)
                            //.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 0, leading: -20, bottom: 20, trailing: 80))
                        }
                        //.fixedSize()
                        
                        
                        
                        Text("15초 이상 녹화해 주셔야해요")
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                            .frame(alignment: .center)
                        
                        
                    }
                    
                    
                }//vstack
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.top,10)
                .padding(.bottom,30)
                .animation(.easeInOut, value: cameraModel.showPreview)
                .preferredColorScheme(.dark)
                
            }
        }
        //zstack
    }//geometry
}

struct FinalPreview: View {
   // @Environment(\.presentationMode) var presentationMode
    
//    @EnvironmentObject var navModel: NavigationModel
//    @EnvironmentObject var navigationModel: NavigationModel
//    @EnvironmentObject var videoMessageViewModel: VideoMessageViewModel
    
    var url: URL
    var videoMessage: VideoMessage
    @State private var isNext = false
    
    let onClose: () -> Void
    
    var body: some View {
        NavigationView{
            GeometryReader { geo in
                let size = geo.size
                
                VStack(alignment: .center) {
                    
                    Text(videoMessage.title) //user의 title 가져와야함
                        .font(.system(size: 20, weight: .thin))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 50, leading: 20, bottom: 30, trailing: 0))
            
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(width: size.width, height: size.height / 5 * 3, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    
                    Spacer()
                    
                    Button(action:{
                        videoMessage.videoSrc = url.absoluteString
                        self.isNext.toggle()
                        onClose()

                        print("다음 버튼 클릭")
                    }){
                        Text("다음 - recordView")
                        
                    }
                    .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                    .background(NavigationLink(destination: SendVideo(videoMessage: videoMessage), isActive: $isNext){
                        Text("dfdf")
                    })
                    .padding(EdgeInsets(top: -50, leading: 0, bottom: 30, trailing: 0))
                    
                    
                    // TODO: 모아나~ 여기 참고해서 NavigationLink 조절하면 됩니다.
                    
                    //                Button(action: {
                    //                    videoMessage.videoSrc = url.absoluteString
                    //                    videoMessageViewModel.addVideoMessage(videoMessage)
                    //                    print("Video Data Log")
                    //                    print(videoMessage)
                    //                    presentationMode.wrappedValue.dismiss()
                    //                    navigationModel.MessageAddProcessExit()
                    //
                    //                    //                    navigationModel.finishVideoAddProcess()
                    //                }){
                    //                    Text("종료 - recordView")
                    //
                    //                }.buttonStyle(ButtonSecondaryStyle(frameWidth: 100, frameHeight: 60))
                    
                    
                }
            }
        }
    }//body view 닫힘
} //Final view 닫힘



struct SendVideo: View {
    @Environment(\.presentationMode) var presentationMode
    
    var videoMessage: VideoMessage
    @EnvironmentObject var navigationModel: NavigationModel
    @EnvironmentObject var videoMessageViewModel: VideoMessageViewModel
    
    @State private var isFinal = false
    
    
    var body: some View {
        NavigationView{
            VStack{
                Text("To. 받는사람입니다아") //누구에게 보낼지
                    .foregroundColor(.gray)
                Text(videoMessage.title)  //제목 받아오기
                
                Image(systemName: "square") //영상 썸네일 와야하는데 session으로 캡쳐해서가 가능한가,,?
                    .resizable()
                    .frame(width: 500, height: 500, alignment: .center)
                    .foregroundColor(.white)
                
                //Text(videoMessage.createdDate) //생성일자
 
                // TODO: 모아나~ 여기 참고해서 NavigationLink 조절하면 됩니다.
                Button(action: {
                    videoMessageViewModel.addVideoMessage(videoMessage)
                    print("Video Data Log")
                    presentationMode.wrappedValue.dismiss()
                    navigationModel.MessageAddProcessExit()
                    //                    navigationModel.finishVideoAddProcess()
                }){
                    Text("종료")
                    
                }.buttonStyle(ButtonSecondaryStyle(frameWidth: 100, frameHeight: 60))
                
                
                
            }//vstack 닫힘
            .padding(EdgeInsets(top: -40, leading: 0, bottom: 0, trailing: 0))
            
            
            
        }//navigation 닫힘
    }
}

