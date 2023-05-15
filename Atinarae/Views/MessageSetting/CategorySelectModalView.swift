//
//  CategorySelectModalView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/05.
//

import SwiftUI

struct CategorySelectModalView: View {
    // MARK: - Init Data
    @EnvironmentObject var userViewModel: UserViewModel
    @StateObject var categoryViewModel = CategoryViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var selectedCategory: Category?
    @State private var isPresented = false
    @State private var newCategoryName = ""
    
    var dismissAction: () -> Void
    
    // MARK: - Constructor
    init(selectedCategory: Binding<Category?>, dismissAction: @escaping () -> Void) {
        self._selectedCategory = selectedCategory
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
// MARK: - CategoryAdd NavLink
                
                
                NavigationLink(
                    destination: CategoryAddView(newCategoryName: $newCategoryName, user: userViewModel.currentUser!)
                        .environmentObject(categoryViewModel)
                ) {
                    Text("추가하기")

                }
                .buttonStyle(ButtonSecondaryStyle(frameWidth: 120, frameHeight: 50))
                
                List(selection: $selectedCategory) {
                    Section {
                        HStack {
                            Text("없음")
                            Spacer()
                            if selectedCategory == nil {
                                Image(systemName: "checkmark")
                            }
                        }
                        .onTapGesture {
                            selectedCategory = nil
                            dismissAction()
                        }
                    }
                    Section{
                        ForEach(
                            Array(
                                categoryViewModel.getUserCategories(for: userViewModel.currentUser!).enumerated()),
                            id: \.element._id) { index, category in
                                
                                Button(action:{
                                    selectedCategory = category
                                    dismissAction()
                                }){
                                    HStack{
                                        Text(category.name)
                                        Spacer()
                                        if selectedCategory == category {
                                            Image(systemName: "checkmark")
                                        }
                                    }
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
            
            
        }
        
        
        
    }
    func delete(at offsets: IndexSet) {
        //        appData.user.categories.remove(atOffsets: offsets)
    }
}
struct CategorySelectModalView_Previews: PreviewProvider {
    static var previews: some View {
        let userViewModel = UserViewModel()
        
        
        CategorySelectModalView(selectedCategory: .constant(nil), dismissAction: {})
            .environmentObject(userViewModel)
//            .environmentObject(categoryViewModel)
    }
}
