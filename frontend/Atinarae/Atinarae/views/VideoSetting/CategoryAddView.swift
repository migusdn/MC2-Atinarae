//
//  CategoryAddView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/06.
//

import SwiftUI

struct CategoryAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appData: AppData
    @Binding var newCategoryName:String
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView{
            VStack {
                Capsule()
                    .fill(Color.secondary)
                    .frame(width: 30, height: 3)
                    .padding(10)
                
                HStack{
                    Text("카테고리 추가")
                        .font(Font.title)
                        .bold()
                }
                .padding(.top, 70)
                .padding(.bottom, 70)
                Form {
                    TextField("카테고리명", text: $newCategoryName)
                        .onAppear(){
                            self.isFocused = true
                        }
                        .onSubmit {
                            appData.user.categories.append(newCategoryName)
                            dismiss()
//                            presentationMode.wrappedValue.dismiss()
                        }
                    
                        .focused($isFocused)
                        .padding(.vertical)
                    
                    
                }
                Button(action:{
                    appData.user.categories.append(newCategoryName)
                    dismiss()
//                    presentationMode.wrappedValue.dismiss()
                }){
                    Text("저장")
                }
                .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                .padding(.bottom, 50)
                //                .frame(width: 100, height: 200)
                //                makeGradientButton("저장")
            }
            //            .navigationBarTitle(Text("카테고리 추가"), displayMode: .inline)
            //            .navigationBarBackButtonHidden(true)
            //            .navigationBarItems(
            //                leading:
            //                    Button(action: {
            //                        presentationMode.wrappedValue.dismiss()
            //                    }) {
            //                        Text("취소")
            //                    },
            //                trailing:
            //                    Button(action: {
            //                        appData.user.categories.append(newCategoryName)
            //                        presentationMode.wrappedValue.dismiss()
            //                    }) {
            //                        Text("저장")
            //                    }
            //            )
            
        }
    }
}

struct CategoryAddView_Previews: PreviewProvider {
    static var previews: some View {
        let appData = AppData()
        let newCategoryName = Binding<String>(get: { "" }, set: { _ in })
        return CategoryAddView(newCategoryName: newCategoryName)
            .environmentObject(appData)
    }
}
