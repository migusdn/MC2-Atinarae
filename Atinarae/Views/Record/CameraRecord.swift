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
    @State private var showModal = false
    @State private var showalert = false

    
    var body: some View {
        
        GeometryReader {proxy in
            let size = proxy.size
            
            CameraPreview(size: size)
                .environmentObject(cameraModel)
        }
        .onAppear(perform: cameraModel.checkPermission)
        .alert(isPresented: $cameraModel.alert) {
            Alert(title: Text("카메라, 마이크 권한확인!"))
        }
        
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) {_ in
            if cameraModel.recordedDuraion <= cameraModel.maxDuration && cameraModel.isRecording{
                cameraModel.recordedDuraion += 1
            }
            
            if cameraModel.recordedDuraion >= cameraModel.maxDuration && cameraModel.isRecording {
                
                let alert = UIAlertController(title: "알림", message: "45초가 넘어서 저장됩니다", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                UIApplication.shared.windows.last?.rootViewController?.present(alert, animated: true)
                
                
                if let _ = cameraModel.previewURL {
                    cameraModel.showPreview.toggle()
                    
                }
                cameraModel.stopRecording()
                //showModal.toggle()
                //cameraModel.recordedDuraion = 0
            }
                
                
                //
                //            }
            
            
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


