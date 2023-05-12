import SwiftUI
import AVFoundation


class CameraViewModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate {
    
    
    
    // @StateObject var checkBack = RecordView()
    
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCaptureMovieFileOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    //비디오 녹화관련 프로퍼티들...
    @Published var isRecording: Bool = false
    @Published var recordedURLs: [URL] = []
    @Published var previewURL: URL?
    @Published var showPreview: Bool = false
    
    //화면 앞 뒤 전환
    //@objc dynamic var videoDeviceInput: AVCaptureDeviceInput!
    @Published var isBack: Bool = true
    @Published var currentPosition: AVCaptureDevice!
    //@Published var currentCameraPosition
    //@Binding var isUsingFrontCamera: Bool
    
    @Published var cnt: Int = 0
    
    //top바 -> 시간 타이머
    @Published var recordedDuraion: CGFloat = 0
    @Published var maxDuration: CGFloat = 45
    
    
    
    func checkPermission() {
        
        //설정권한 가지고 있는지 확인
        switch AVCaptureDevice.authorizationStatus(for: .video){
        case .authorized:
            setUp()
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status{
                    self.setUp()
                }
            }
        case .denied:
            self.alert.toggle()
            return
            
        default:
            return
            
        }
    }
    
    func setUp() {
        
        isBack.toggle()
        
        do{
            if cnt < 1 {
                let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
                let CameraInput = try AVCaptureDeviceInput(device: camera!)
                
                if self.session.canAddInput(CameraInput) {
                    self.session.addInput(CameraInput)
                }
                
                self.session.beginConfiguration()
                
                
                //let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition)
                
                //let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
                // let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
                
                //let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isBack ? .back : .front)
                // let videoInput = try AVCaptureDeviceInput(device: cameraDevice!)
                // let frontCameraInput = try AVCaptureDeviceInput(device: frontCamera!)
                //소리도 녹음
                let audioDevice = AVCaptureDevice.default(for: .audio)
                let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
                
                
                if self.session.canAddInput(audioInput){
                    self.session.addInput(audioInput)
                }
                
                if self.session.canAddOutput(self.output){
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
                
                
                
            } else {
                //let cameraPosition: AVCaptureDevice.Position = isBack ? .back : .front
                var currentCameraPosition: AVCaptureDevice.Position =  isBack ? .back : .front
                var currentCameraInput: AVCaptureDeviceInput?
                print("ㅇㅇㅇㅇㅇ")
               // func switchCamera() {
                    // 현재 입력 장치 제거
                    if let input = currentCameraInput {
                        session.removeInput(input)
                        currentCameraInput = nil
                    }
                    
                    // 새로운 입력 장치 추가
                    if currentCameraPosition == .back {
                        // 전면 카메라 추가
                        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
                        do {
                            let input = try AVCaptureDeviceInput(device: videoDevice!)
                            if session.canAddInput(input) {
                                session.addInput(input)
                                currentCameraPosition = .front
                                currentCameraInput = input
                            }
                        } catch {
                            print("Error switching to front camera: \(error)")
                        }
                    } else {
                        // 후면 카메라 추가
                        let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
                        do {
                            let input = try AVCaptureDeviceInput(device: videoDevice!)
                            if session.canAddInput(input) {
                                session.addInput(input)
                                currentCameraPosition = .back
                                currentCameraInput = input
                            }
                        } catch {
                            print("Error switching to back camera: \(error)")
                        }
                    }
               // }

                
                
                
                
                
//                self.session.stopRunning()
//                self.session.beginConfiguration()
//                let cameraPosition: AVCaptureDevice.Position = isBack ? .back : .front
//                let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition)
//
//                //let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentPosition)
//                let CameraInput = try AVCaptureDeviceInput(device: camera!)
//
//                if self.session.canAddInput(CameraInput) {
//                    self.session.addInput(CameraInput)
//                }
//
//                //let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition)
//
//                //let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
//                // let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
//
//                //let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isBack ? .back : .front)
//                // let videoInput = try AVCaptureDeviceInput(device: cameraDevice!)
//                // let frontCameraInput = try AVCaptureDeviceInput(device: frontCamera!)
//                //소리도 녹음
//
//                if self.session.canAddOutput(self.output){
//                    self.session.addOutput(self.output)
//                }
//
//                self.session.commitConfiguration()
//                //self.session.startRunning()
                
                
                
                
                
            }
           
            cnt+=1
            print("--------------\(cnt)--------------")
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    //------
    //        do {
    //                //let cameraPosition: AVCaptureDevice.Position = .back
    //            let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: currentPosition)
    //            let CameraInput = try AVCaptureDeviceInput(device: camera!)
    //
    //            if self.session.canAddInput(CameraInput) {
    //                self.session.addInput(CameraInput)
    //            }
    //
    //            self.session.beginConfiguration()
    //
    //
    //            //let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition)
    //
    //            //let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front)
    //           // let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    //
    //            //let cameraDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isBack ? .back : .front)
    //            // let videoInput = try AVCaptureDeviceInput(device: cameraDevice!)
    //           // let frontCameraInput = try AVCaptureDeviceInput(device: frontCamera!)
    //            //소리도 녹음
    //            let audioDevice = AVCaptureDevice.default(for: .audio)
    //            let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
    //
    //
    //            if self.session.canAddInput(audioInput){
    //                self.session.addInput(audioInput)
    //            }
    //
    //            if self.session.canAddOutput(self.output){
    //                self.session.addOutput(self.output)
    //            }
    //
    //            self.session.commitConfiguration()
    //        }
    //
    //        catch{
    //            print(error.localizedDescription)
    //        }
    //    }
    //
    //
    //    //--------
    //
    func switchCamera() {
        
        self.session.beginConfiguration()
        let currentInput = session.inputs.first as! AVCaptureDeviceInput
        self.session.removeInput(currentInput)
        
        let cameraPosition: AVCaptureDevice.Position = isBack ? .back : .front
        let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition)
        let cameraInput = try! AVCaptureDeviceInput(device: camera!)
        
        self.session.addInput(cameraInput)
        isBack.toggle()
        self.session.commitConfiguration()
    }

    
    
//           do{
//                let cameraPosition: AVCaptureDevice.Position = isBack ? .back : .front
//                print("swifthcu \(cameraPosition)")
    
//                // 세션 재설정
//                session.stopRunning()
//                self.session.commitConfiguration()
//
//                let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: cameraPosition)
//                let CameraInput = try AVCaptureDeviceInput(device: camera!)
//
//                if self.session.canAddInput(CameraInput) {
//                    self.session.addInput(CameraInput)
//                }
//
//
//
//                if self.session.canAddOutput(self.output) {
//                    self.session.addOutput(self.output)
//                }
//
//
//                self.session.commitConfiguration()
//
//                session.startRunning()
//            }
//    catch {
//                print(error.localizedDescription)
//            }
        
    
    
    //    func toggleCamera() {
    //        session.beginConfiguration()
    //
    //        guard let currentInput = session.inputs.first else {
    //            return
    //        }
    //
    //        session.removeInput(currentInput)
    //
    //        if currentInput == rearCameraInput {
    //            guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
    //                return
    //            }
    //
    //            do {
    //                let input = try AVCaptureDeviceInput(device: frontCamera)
    //                if session.canAddInput(input) {
    //                    session.addInput(input)
    //                    currentCameraPosition = .front
    //                } else {
    //                    session.addInput(currentInput)
    //                }
    //            } catch {
    //                print("Error: \(error.localizedDescription)")
    //            }
    //        } else {
    //            guard let rearCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
    //                return
    //            }
    //
    //            do {
    //                let input = try AVCaptureDeviceInput(device: rearCamera)
    //                if session.canAddInput(input) {
    //                    session.addInput(input)
    //                    currentCameraPosition = .rear
    //                } else {
    //                    session.addInput(currentInput)
    //                }
    //            } catch {
    //                print("Error: \(error.localizedDescription)")
    //            }
    //        }
    //
    //        session.commitConfiguration()
    //    }
    
    
    func startRecording() {
        //임시저장 URL
        let tempURL = NSTemporaryDirectory() + "\(Date()).mov"
        output.startRecording(to: URL(fileURLWithPath: tempURL), recordingDelegate: self)
        isRecording = true
        
        
    }
    
    
    func stopRecording() {
        output.stopRecording()
        isRecording = false
        
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        //성공!
        print(outputFileURL)
        self.recordedURLs.append(outputFileURL)
        if self.recordedURLs.count == 1{
            self.previewURL = outputFileURL
            return
        }
        
        let assets = recordedURLs.compactMap { url -> AVURLAsset in
            return AVURLAsset(url: url)
        }
        
        
        self.previewURL = nil
        //비디오 합칠 수 있게?
        mergeVideos(assets: assets) { exporter in
            exporter.exportAsynchronously {
                if exporter.status == .failed {
                    print(exporter.error!)
                } else {
                    if let finalURL = exporter.outputURL {
                        print(finalURL)
                        DispatchQueue.main.async {
                            self.previewURL = finalURL
                        }
                    }
                }
            }
        }
    }
    
    func mergeVideos(assets: [AVURLAsset], completion: @escaping (_ exporter: AVAssetExportSession)->()) {
        let composition = AVMutableComposition()
        var lastTime: CMTime = .zero
        
        guard let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else {return}
        guard let audioTrack = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: Int32(kCMPersistentTrackID_Invalid)) else {return}
        
        for asset in assets {
            
            do{
                try videoTrack.insertTimeRange(CMTimeRange(start: .zero, duration: asset.duration), of: asset.tracks(withMediaType: .video)[0], at: lastTime)
                
                if !asset.tracks(withMediaType: .audio).isEmpty{
                    try audioTrack.insertTimeRange(CMTimeRange(start: .zero, duration:  asset.duration), of: asset.tracks(withMediaType: .audio)[0], at: lastTime)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            lastTime = CMTimeAdd(lastTime, asset.duration)
            
        }
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory() + "record-\(Date()).mp4")
        
        
        let layerInstructions = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack)
        
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: 90 * (.pi / 180))
        transform = transform.translatedBy(x:0, y: -videoTrack.naturalSize.height)
        layerInstructions.setTransform(transform, at: .zero)
        
        let instructions = AVMutableVideoCompositionInstruction()
        instructions.timeRange = CMTimeRange(start: .zero, duration: lastTime)
        instructions.layerInstructions = [layerInstructions]
        
        let videoComposition = AVMutableVideoComposition()
        videoComposition.renderSize = CGSize(width: videoTrack.naturalSize.height, height: videoTrack.naturalSize.width)
        videoComposition.instructions = [instructions]
        videoComposition.frameDuration = CMTimeMake(value: 1, timescale:30)
        
        
        
        guard let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality) else {return}
        
        exporter.outputFileType = .mp4
        exporter.outputURL = tempURL
        exporter.videoComposition = videoComposition
        completion(exporter)
    }
    
    
}
