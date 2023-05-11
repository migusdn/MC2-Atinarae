import SwiftUI
import AVFoundation


class CameraViewModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate  {


    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCaptureMovieFileOutput()
    @Published var preview : AVCaptureVideoPreviewLayer!
    
    //비디오 녹화관련 프로퍼티들...
    @Published var isRecording: Bool = false
    @Published var recordedURLs: [URL] = []
    @Published var recordedURL: URL?
    @Published var previewURL: URL?
    @Published var showPreview: Bool = false
    
    //화면 앞 뒤 전환
    @Published var videoDeviceInput: AVCaptureDeviceInput!
    @Published var currentPosition: AVCaptureDevice!

    //@Published var currentCameraPosition
    //@Binding var isUsingFrontCamera: Bool
    @Published var isBack: Bool = false
    @Published var cnt: Int = 0


    //top바 -> 시간 타이머
    @Published var recordedDuraion: CGFloat = 0
    @Published var maxDuration: CGFloat = 45
   // @Published var max15Duration: CGFloat = 15

    
    
    
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
        
        do{
            if cnt == 0 {
                self.session.beginConfiguration()
                
                let videoDevice = AVCaptureDevice.default(for: .video)
                let videoInput = try AVCaptureDeviceInput(device: videoDevice!)
                
                let audioDevice = AVCaptureDevice.default(for: .audio)
                let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
                
                if self.session.canAddInput(audioInput) && self.session.canAddInput(videoInput){
                    self.session.addInput(audioInput)
                    self.session.addInput(videoInput)
                }
                
                if self.session.canAddOutput(self.output){
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
            }
            else {
                self.session.beginConfiguration()
                
                isBack.toggle()
                
                guard let currentInput = session.inputs.first else { return }
        
                
                self.session.removeInput(currentInput)
                
                
                let Camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isBack ? .back : .front)
                let cameraInput = try AVCaptureDeviceInput(device: Camera!)
            
                
                if self.session.canAddInput(cameraInput){
                    self.session.addInput(cameraInput)
                }
                
                
                if self.session.canAddOutput(self.output){
                    self.session.addOutput(self.output)
                }
                
                self.session.commitConfiguration()
                
            }
            cnt+=1
                
            }//do 닫힘
            
            catch {
                print("Error switching to back camera: \(error)")
            }
                    
        }


    //버튼을 3번을 눌러야 바뀌는데 이거 이슈 정리 좀 해야할듯,,,,? -> 근데 영상 촬영도중에는 화면 전환이 안되는데 촬영 시작되고 나면 overlay로 투명도 맞출 수 있도록 해야할 듯
//    func switchCamera() {
//        do {
//            self.session.beginConfiguration()
//            
//            isBack.toggle()
//            
//            guard let currentInput = session.inputs.first else { return }
//    
//            
//            self.session.removeInput(currentInput)
//            
//            
//            let Camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isBack ? .back : .front)
//            let cameraInput = try AVCaptureDeviceInput(device: Camera!)
//        
//            
//            if self.session.canAddInput(cameraInput){
//                self.session.addInput(cameraInput)
//            }
//            
//            
//            if self.session.canAddOutput(self.output){
//                self.session.addOutput(self.output)
//            }
//            
//            self.session.commitConfiguration()
//            
//        } catch {
//            print("Error switching to back camera: \(error)")
//        }
//
//
//    }
    
    func startRecording() {
        //임시저장 URL
        let tempURL = NSTemporaryDirectory() + "\(Date()).mov"
        output.startRecording(to: URL(fileURLWithPath: tempURL), recordingDelegate: self)
        isRecording = true
        recordedURL = URL(fileURLWithPath: tempURL)
        
    }
    
    
    func stopRecording() {
        output.stopRecording()
        
        
    }
    
    
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        //성공!
        
        print(outputFileURL)
        recordedURL = outputFileURL
        isRecording = false
//
//        self.recordedURLs.append(outputFileURL)
//
//        if self.recordedURLs.count == 1{
//            self.previewURL = outputFileURL
//            return
//        }
//
//        let assets = recordedURLs.compactMap { url -> AVURLAsset in
//            return AVURLAsset(url: url)
//        }
//
//        self.previewURL = nil
//
//        //비디오 합칠 수 있게?
//        mergeVideos(assets: assets) { exporter in
//            exporter.exportAsynchronously {
//                if exporter.status == .failed {
//                    print(exporter.error!)
//                } else {
//                    let finalURL = self.recordedURLs[0]
//                        //exporter.outputURL {
////                        print(finalURL)
////                        DispatchQueue.main.async {
////                            self.previewURL = finalURL
////                        }
//                    //}
//                }
//            }
//        }
        
   
        
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


        guard let exporter = AVAssetExportSession(asset: composition,  presetName: AVAssetExportPresetHighestQuality) else {return}

        exporter.outputFileType = .mp4
        exporter.outputURL = tempURL
        exporter.videoComposition = videoComposition
        completion(exporter)
    }
    
    
}
