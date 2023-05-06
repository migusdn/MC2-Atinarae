//
//  MainViewModel.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/04.
//

import SwiftUI

struct MainViewModelTitle: View {
    var body: some View {
        ZStack{
            // Color.backGroundColor
            HStack{
                Image("Title")
                    .resizable()
                    .frame(width : 150, height: 25)
                
                Spacer()
                Image(systemName: "bell")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    .padding(.trailing)
                    
                Image(systemName: "person.circle")
                    .resizable()
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
                    
            }
            .padding()
        }
    }
}





struct MainViewModel_Previews: PreviewProvider {
    static var previews: some View {
        MainViewModelTitle()
    }
}
