//
//  CategorySelectModalView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/05.
//

import SwiftUI

struct CategorySelectModalView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appData: AppData
    @Binding var selectedCategoryIdx: Int?
    @State private var isPresented = false
    @State private var newCategoryName = ""
    var dismissAction: () -> Void
    
    init(selectedCategoryIdx: Binding<Int?>, dismissAction: @escaping () -> Void) {
        self._selectedCategoryIdx = selectedCategoryIdx
        self.dismissAction = dismissAction
    }
    var body: some View {
        
        NavigationView{
            VStack{
                Capsule()
                    .fill(Color.secondary)
                    .frame(width: 30, height: 3)
                    .padding(10)
                
                
                Text("카테고리")
                                    .font(Font.title)
                                    .bold()
                                    .padding(.top, 70)
                                
                                NavigationLink(destination: CategoryAddView(newCategoryName: $newCategoryName)) {
                                    Text("추가하기")
                                        .padding(30)
                                }
                                .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                
                List(selection: $selectedCategoryIdx) {
                    Section {
                        HStack {
                            Text("없음")
                            Spacer()
                            if selectedCategoryIdx == nil {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            selectedCategoryIdx = nil
                            dismissAction()
                        }
                    }
                    Section{
                        ForEach(appData.user.categories.indices, id: \.self) { index in
                            HStack {
                                Text(appData.user.categories[index])
                                Spacer()
                                if selectedCategoryIdx == index {
                                    Image(systemName: "checkmark")
                                }
                            }
                            .onTapGesture {
                                selectedCategoryIdx = index
                                dismissAction()
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    
                }
                Section{
                    
                }
                
                
                .listStyle(InsetGroupedListStyle())
                .toolbar{
                    EditButton()
                }
                
            }
            .navigationBarTitle(
                Text("카테고리")
                , displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        dismissAction()
                    }) {
                        Image(systemName: "chevron.left")
                        Text("뒤로")
                    }
            )
        }
        
        
        
    }
    func delete(at offsets: IndexSet) {
        appData.user.categories.remove(atOffsets: offsets)
    }
}
struct CategorySelectModalView_Previews: PreviewProvider {
    static var previews: some View {
        let appData = AppData()
        CategorySelectModalView(
            selectedCategoryIdx: .constant(nil),
            dismissAction: {}
        ).environmentObject(appData)
    }
}
