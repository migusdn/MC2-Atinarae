//
//  VideoPreviewView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/15.
//

import SwiftUI

struct VideoPreviewView: View {
    @Environment(\.presentationMode) var presentationMode
    
    //    @EnvironmentObject var navModel: NavigationModel
    //    @EnvironmentObject var navigationModel: NavigationModel
    //    @EnvironmentObject var videoMessageViewModel: VideoMessageViewModel
    
    var videoMessage: VideoMessage
    
    
    var body: some View {
        NavigationView{
            GeometryReader { geo in
                let size = geo.size
                
                VStack(alignment: .center) {
                    
                    Text(videoMessage.title) //user의 title 가져와야함
                        .font(.system(size: 20, weight: .thin))
                        .foregroundColor(.gray)
                        .padding(EdgeInsets(top: 50, leading: 20, bottom: 30, trailing: 0))
                    
                    VideoPlayerViewModel(videoUrl: videoMessage.videoSrc)
                    
                    Spacer()
                    
                    
                    
                }
            }
        }
    }//body view 닫힘
} //Final view 닫힘

struct VideoPreviewView_Previews: PreviewProvider {
    
    static var previews: some View {
        let receiverMessage = VideoMessage()
        receiverMessage.title = "Receiver Message"
        receiverMessage.videoSrc = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
        
        return VideoPreviewView(videoMessage: receiverMessage)
            .environmentObject(NavigationModel())
            .environmentObject(VideoMessageViewModel())
    }
}
