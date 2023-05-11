//
//  CustomPickerView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/09.
//

import SwiftUI

struct CustomPicker: View {
    @State private var selectedOptionIndex = 0
    @State private var showPicker = false
    let options = ["Option 1", "Option 2", "Option 3"]
    
    var body: some View {
        VStack {
            Button(action: {
                showPicker.toggle()
            }) {
                Text(options[selectedOptionIndex])
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            .sheet(isPresented: $showPicker) {
                VStack {
                    Picker("", selection: $selectedOptionIndex) {
                        ForEach(0..<options.count) { index in
                            Text(options[index])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    Divider()
                    Button("Done") {
                        showPicker.toggle()
                    }
                    .padding(.top, 8)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(.horizontal, 40)
            }
        }
        .padding()
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        let appData = AppData()
        CustomPicker()
    }
}
