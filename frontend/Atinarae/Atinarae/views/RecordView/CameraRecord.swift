//
//  cameraModelRecord.swift
//  RecordPart
//
//  Created by Cho Chaewon on 2023/05/04.
//

import SwiftUI
import AVFoundation

struct CameraRecord: View {
    
    @EnvironmentObject var cameraModel: CameraViewModel
    
    var body: some View {
        
        GeometryReader {proxy in
            let size = proxy.size
            
            CameraPreview(size: size)
                .environmentObject(cameraModel)
            
                //recordbar 빨갛게 차는거 아래에 나타나게 해주는 코드 -> 지금은 원형 버튼에 같이 차오름
//            ZStack(alignment: .leading) {
//                Rectangle()
//                    .fill(.black.opacity(0.25))
//
//                Rectangle()
//                    .fill(Color(.red))
//                    .frame(width: size.width * (cameraModel.recordedDuraion / cameraModel.maxDuration))
//            }
//            .frame(height: 5)
//            .frame(maxHeight: .infinity, alignment: .bottom)
//            .padding(10)
            
        }
            .onAppear(perform: cameraModel.checkPermission)
            .alert(isPresented: $cameraModel.alert) {
                Alert(title: Text("카메라, 마이크 권한확인!"))
            }
            .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) {_ in
                if cameraModel.recordedDuraion <= cameraModel.maxDuration && cameraModel.isRecording{
                    cameraModel.recordedDuraion += 0.01
                }
                
                if cameraModel.recordedDuraion >= cameraModel.maxDuration && cameraModel.isRecording {
                    cameraModel.stopRecording()
                    cameraModel.isRecording = false
                }
            }
    }
}


//카메라 모델

struct CameraPreview: UIViewRepresentable{
    
    @EnvironmentObject var cameraModel: CameraViewModel
    var size: CGSize
    
    
    func makeUIView(context: Context) -> UIView {
      
        let view = UIView(frame: UIScreen.main.bounds)
        
        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        cameraModel.preview.frame.size = size
            
        cameraModel.preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(cameraModel.preview)
        
        cameraModel.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        //        uiView.subviews.forEach { $0.removeFromSuperview() } // 이전 미리보기 뷰 삭제
        //        cameraModel.preview = AVCaptureVideoPreviewLayer(session: cameraModel.session)
        //        cameraModel.preview.videoGravity = .resizeAspectFill
        //        cameraModel.preview.connection?.videoOrientation = .portrait
        //        cameraModel.preview.frame = UIScreen.main.bounds
        //       uiView.layer.addSublayer(cameraModel.preview) // 새로운 미리보기 뷰 추가
    }
    }
    

