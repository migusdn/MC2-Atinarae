//
//  File.swift
//  Atinarae
//
//  Created by Kimdohyun on 2023/05/13.
//

import Foundation
import SwiftUI

struct AlarmView: View
{
    @State private var button1Tapped = false
    @State private var button2Tapped = false
    @State private var button3Tapped = false
    @State private var button4Tapped = false
    
    var body: some View
    {
        VStack
        {
            Text("11")
            HStack
            {
                Button(action:{
                    button1Tapped = true
                    button2Tapped = false
                    button3Tapped = false
                    button4Tapped = false
                }) {
                    Text("Button 1")
                        .padding()
                        .background(button1Tapped ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    button1Tapped = false
                    button2Tapped = true
                    button3Tapped = false
                    button4Tapped = false
                }) {
                    Text("Button 2")
                        .padding()
                        .background(button2Tapped ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    button1Tapped = false
                    button2Tapped = false
                    button3Tapped = true
                    button4Tapped = false
                }) {
                    Text("Button 3")
                        .padding()
                        .background(button3Tapped ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                }
                
                Button(action: {
                    button1Tapped = false
                    button2Tapped = false
                    button3Tapped = false
                    button4Tapped = true
                }) {
                    Text("Button 4")
                        .padding()
                        .background(button4Tapped ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                }
            }
        }
    }
}


struct Alarm_Previews: PreviewProvider
{
    static var previews: some View
    {
            AlarmView()
    }
}
