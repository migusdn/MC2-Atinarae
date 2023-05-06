//
//  MainView.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/04.
//

import SwiftUI

struct MainView: View {
    @State var tag:Int? = nil
    
    var body: some View {
            ZStack{
            Color.backGroundColor.ignoresSafeArea()
            GeometryReader{ geometry in
                
                VStack{
                    MainViewModelTitle()
                        .frame(width: geometry.size.width, height: geometry.size.height/6)
                    
                    MainViewModelGeometry()
                        .frame(width: geometry.size.width, height: geometry.size.height/2)
                    
                    
                        Button{
                            self.tag = 1
                        } label: {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(
                                    AngularGradient(gradient: Gradient(colors: [.buttonColor, .buttonColor1]), center: .top)
                                        )
                                .frame(width: geometry.size.width/3, height: 50)
                                .overlay{
                                    HStack{
                                        Image(systemName: "paperplane")
                                            .foregroundColor(.black)
                                        Text("메세지보내기")
                                            .foregroundColor(.black)
                                            .font(.subheadline).bold()
                                    }
                                }

                    }
                }
                NavigationLink(destination: DetailView(), tag : 1, selection: self.$tag){}
            }
                
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
        
        }
       
        
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}



//NavigationView{
//ZStack{
//    Color.backGroundColor.ignoresSafeArea()
//        GeometryReader{ geometry in
//
//            VStack{
//                MainViewModelTitle()
//                    .frame(width: geometry.size.width, height: geometry.size.height/6)
//
//                MainViewModelGeometry()
//                    .frame(width: geometry.size.width, height: geometry.size.height/2)
//
//
//                MainViewModelButton()
//            }
//        }
//
//    }
//}
