//
//  CategoryAddView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/06.
//

import SwiftUI

struct CategoryAddView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var categories: [String]
    @State var newCategoryName:String

    var body: some View {
        
            VStack {
                Form {
                    TextField("제목", text: $newCategoryName)
                }
            }
            .navigationBarTitle(Text("카테고리 추가"), displayMode: .inline)
//            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("취소")
                    },
                trailing:
                    Button(action: {
                        categories.append(newCategoryName)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("저장")
                    }
            )
        
    }
}

struct CategoryAddView_Previews: PreviewProvider {
    
    static var previews: some View {
        let categories = Binding<[String]>(get: { ["1","2"] }, set: { _ in })
        
        let view = CategoryAddView(categories: categories, newCategoryName: "")
        return view
    }
}
