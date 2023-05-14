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
    @EnvironmentObject var categoryViewModel: CategoryViewModel
    @Binding var newCategoryName:String
    @FocusState var isFocused: Bool
    var user: User?
    
    func addCategory() {
        if let user = user {
            // 사용자 정보를 활용하여 카테고리를 추가하는 로직 작성
            // user를 활용하여 새로운 카테고리를 생성하고, 저장 등의 작업 수행
            
            categoryViewModel.createCategory(user: user, name: newCategoryName)
            newCategoryName = ""
            dismiss()
            categoryViewModel.refresh()
        }
    }
    
    var body: some View {
        
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
                        addCategory()
                    }
                    .focused($isFocused)
                    .padding(.vertical)
            }
            Button(action:{
                addCategory()
                
            }){
                Text("저장")
            }
            .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
            .padding(.bottom, 50)
        }
        
    }
    
}

struct CategoryAddView_Previews: PreviewProvider {
    static var previews: some View {
        let newCategoryName = Binding<String>(get: { "" }, set: { _ in })
        return CategoryAddView(newCategoryName: newCategoryName)
        
    }
}
