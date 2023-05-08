//
//  ContentView.swift
//  RecordPart
//
//  Created by Cho Chaewon on 2023/05/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {

            homeView()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//struct CameraView: View {
//    
//    @StateObject var camera = CameraModel()
//    var body: some View {
//        ZStack {
//            Color.black
//                .ignoresSafeArea(.all, edges: .all)
//            
//            VStack{
//                if camera.isTaken {
//                    HStack {
//                        Spacer()
//                        Button(action: {}, label: {
//                            
//                            Image(systemName: "arrow.triangle.2.circlepath.camera")
//                                .foregroundColor(.black)
//                                .background(Color.white)
//                                .clipShape(Circle())
//                        })
//                        .padding(.trailing, 10)
//                    }
//                }
//                
//                Spacer()
//                
//                HStack{
//                    if camera.isTaken{
//                        Button(action: {}, label: {
//                            Text("Save")
//                                .foregroundColor(.black)
//                                .fontWeight(.semibold)
//                                .padding(.vertical,10)
//                                .padding(.horizontal, 20)
//                                .background(Color.white)
//                                .clipShape(Capsule())
//                        })
//                        .padding(.leading)
//                        
//                        
//                        Spacer()
//                        
//                        
//                    } else {
//                        Button(action: {camera.isTaken.toggle()}, label : {
//                            ZStack{
//                                Circle()
//                                    .fill(Color.white)
//                                    .frame(width: 70, height: 70)
//                                
//                                Circle()
//                                    .stroke(Color.white, lineWidth: 2)
//                                    .frame(width: 75,height: 75)
//                            }
//                        })
//                    }
//                }
//            }
//            .frame(width: 75, height: 75)
//            
//        }
//    }
//}
//
//
////카메라 모델
//class CameraModel: ObservableObject {
//    @Published var isTaken = false
//}
