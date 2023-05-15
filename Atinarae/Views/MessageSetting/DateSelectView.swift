//
//  DateSelectView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/10.
//

import SwiftUI

struct DateSelectView: View {
    
    @Binding var date: Date
    @Binding var isOn: Bool
    var dismissAction: () -> Void
    var body: some View {

            VStack{
                Spacer()
                List{
                    Section{
                        Toggle("나중에 정하기",isOn: $isOn)
                    }
                    
                    Section{
                        DatePicker("디데이", selection: $date, displayedComponents: [.hourAndMinute, .date])
                    }
                    
                }
                Button(action: {

                    dismissAction()
                }, label: {
                    
                    Text("저장")
                        
                })
                .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                .padding(.bottom, 40)
                Spacer()
            }
        
    }
}

struct DateSelectView_Previews: PreviewProvider {
    
    static var previews: some View {
        DateSelectView(date: .constant(Date()),isOn: .constant(true)) {
            
        }
    }
}
