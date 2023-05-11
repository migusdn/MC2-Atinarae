//
//  DateSelectView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/10.
//

import SwiftUI

struct DateSelectView: View {
    
    @Binding var date: Date
    @State var tempDate = Date()
    @Binding var isOn: Bool
    var dismissAction: () -> Void
    var body: some View {
//        NavigationView{
            VStack{
                Spacer()
                List{
                    Section(header: EmptyView(), footer: EmptyView()){
                        Toggle("나중에 정하기",isOn: $isOn)
                    }
                    
                    Section{
                        DatePicker("디데이", selection: $tempDate, displayedComponents: [.hourAndMinute, .date])
                    }
                    
                }
                Button(action: {
                    if !isOn{
                        date = tempDate
                    }
                    dismissAction()
                }, label: {
                    makeGradientButton("저장")
                        .bold()
                })
                .padding(.bottom, 40)
                Spacer()
            }
//            .listRowInsets(EdgeInsets())
//        }
//        .navigationBarBackButtonHidden(true)
        
    }
}

struct DateSelectView_Previews: PreviewProvider {
    
    static var previews: some View {
        DateSelectView(date: .constant(Date()),isOn: .constant(false)) {
            
        }
    }
}
