import SwiftUI
import AVFoundation


class CameraViewModel: NSObject, ObservableObject, AVCaptureFileOutputRecordingDelegate  {
    //    @EnvironmentObject var appData: AppData
    
    
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
    
    @Published var isBack: Bool = false
    @Published var cnt: Int = 0
    
    
    //top바 -> 시간 타이머
    @Published var recordedDuraion: CGFloat = 0
    @Published var maxDuration: CGFloat = 45
    @Published var minDuration: CGFloat = 15
    
    
    
    
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
            self.session.beginConfiguration()
            print(session.inputs.count)
            
            while session.inputs.count != 0 {
                guard let currentInput = session.inputs.first else { return }
                self.session.removeInput(currentInput)
            }
            
            isBack.toggle()
            
            let Camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: isBack ? .back : .front)
            let cameraInput = try AVCaptureDeviceInput(device: Camera!)
            
            let audioDevice = AVCaptureDevice.default(for: .audio)
            let audioInput = try AVCaptureDeviceInput(device: audioDevice!)
            
            
            if self.session.canAddInput(audioInput) && self.session.canAddInput(cameraInput){
                self.session.addInput(audioInput)
                self.session.addInput(cameraInput)
            }
            
            if self.session.canAddOutput(self.output){
                self.session.addOutput(self.output)
            }
            
            
            
            self.session.commitConfiguration()
            
        }
        catch {
            print("Error switching to back camera: \(error)")
        }
        
    }
    
    func startRecording() {
        //임시저장 URL
        recordedURL = URL(fileURLWithPath: NSTemporaryDirectory() + "\(Date()).mov")
        output.startRecording(to: recordedURL!, recordingDelegate: self)
        isRecording = true
    }
    
    
    func stopRecording() {
        output.stopRecording()
        isRecording = false
        
    }
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
        let groupIdentifier = "group.atinarae.tvvinkle"
        //        appData.groupIdentifier
        
        guard let containerURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier) else {
            return
        }
        
        let dstURL = containerURL.appendingPathComponent("\(formatDateTime(Date())) + .mp4")
        
        do {
            try FileManager.default.moveItem(at: recordedURL!, to: dstURL)
            print("video cp success")
            print("appContainerPath: \(dstURL)")
            recordedURL = dstURL
            
        } catch {
            print("video cp fail")
        }
    }
    
    
}
