//
//  DetailView.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/04.
//

import SwiftUI

struct DetailView: View {
    var planetNumber: Int
//    @State var date = Date()
    var body: some View {
        GeometryReader { geo in
            var planetSize: CGFloat = 500
            
                makeMainPlanet(planetNumber: planetNumber)
                    .resizable()
                    .frame(width: planetSize, height: planetSize)
                    .offset(x:geo.size.width - planetSize/2)
            
        }
       
        
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(planetNumber: 1)
    }
}


//List{
//    ScrollView{
//            VStack{
//                ForEach(1..<3) { _ in
//                    DetailViewModel()
//
//                }
//            }
//
//
//}
//}
