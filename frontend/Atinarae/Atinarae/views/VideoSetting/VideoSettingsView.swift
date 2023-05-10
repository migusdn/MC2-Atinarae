//
//  VideoSettingsView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/03.
//

import SwiftUI

struct VideoSettingsView: View {
    @EnvironmentObject var appData: AppData
    
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    @State private var date = Date()
    @State private var title = ""
    
    
    @State private var selectedCategoryIdx: Int?
    
    @State private var selectedFriend:Friend?
    
    @State private var birthDate = Date()
    
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(50)), count: 1)
    @State var text:String = ""
    
    
    
    var body: some View {
        NavigationView{
            VStack{
                Form {
                    Section(header:
                                Text("누구에게 보낼까요")
                        .font(.headline)
                        .padding(.leading, 0)
                        .padding(.bottom,8)
                    ){
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                ForEach(appData.user.friends, id: \.self) { friend in
                                    Group{
                                        friendView(friend: friend, selectedFriend: selectedFriend)
                                    }
                                    .onTapGesture{
                                        selectedFriend = friend
                                    }
                                    .padding(.trailing, 15)
                                }
                            }
                            .ignoresSafeArea(.all)
                        }
                        
                        .ignoresSafeArea(.all)
                    }
                    Section {
                        TextField("제목", text: $title)
                        
                    }
                    Section{
                        DatePicker("디데이", selection: $date, displayedComponents: [.hourAndMinute, .date])
                    }
                    .padding(.top,2)
                    .padding(.bottom,2)
                    .padding(.trailing, -9)
                    Section{
                        HStack{
                            Text("카테고리")
                            Spacer()
                            if selectedCategoryIdx == nil{
                                Text("없음")
                            }else{
                                Text(appData.user.categories[selectedCategoryIdx!])
                            }
                            Image(systemName: "chevron.right")
                        }.onTapGesture{
                            isPresented.toggle()
                        }
                        
                    }
                }
                Spacer()
                NavigationLink(destination: RecordView()) {
                    Text("다음")
                        .frame(width: 91, height: 58)
                        .foregroundColor(Color.black)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color(red: 0.569, green: 0.541, blue: 0.961),
                                    Color(red: 0.685, green: 0.74, blue: 0.981),
                                    Color(red: 0.792, green: 0.922, blue: 1)
                                ]),
                                startPoint: UnitPoint(x: 0, y: 0.5),
                                endPoint: UnitPoint(x: 1, y: 0.5)
                            )
                            .cornerRadius(100)
                        )
                }.padding(30)
                
                
                
            }
            
            
            
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(
                Text("영상 보내기")
                , displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                    },
                trailing:
                    Button(action: {
                        // 오른쪽 아이템을 클릭했을 때의 동작
                    }) {
                        Image(systemName: "plus")
                    }
            )
            .accentColor(.white)
            
            .sheet(isPresented: $isPresented){
                CategorySelectModalView(
                    selectedCategoryIdx: $selectedCategoryIdx,
                    dismissAction: {
                        isPresented = false
                    }
                )
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    func friendView(friend: Friend, selectedFriend: Friend?) -> some View {
        VStack(alignment: .center) {
            if selectedFriend == friend {
                ZStack{
                    Image(friend.planetImage)
                        .resizable()
                        .frame(width: 52, height: 52)
                    Circle()
                        .stroke(Color.white, lineWidth: 3)
                        .frame(width: 63, height:63)
                        .background(Image(systemName: "checkmark").fontWeight(.bold))
                    
                    
                }
                Text(friend.nickname)
            } else {
                Image(friend.planetImage)
                    .resizable()
                    .foregroundColor(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
                    .frame(width: 63, height: 63)
                Text(friend.nickname)
            }
        }
        .padding(.top, 2)
        .padding(.leading,2)
    }
}

struct VideoSettingsView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let appData = AppData()
        VideoSettingsView()
            .environmentObject(appData)
    }
}
