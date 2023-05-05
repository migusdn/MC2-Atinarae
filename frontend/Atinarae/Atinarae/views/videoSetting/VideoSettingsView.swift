//
//  VideoSettingsView.swift
//  Atinarae
//
//  Created by HyunwooPark on 2023/05/03.
//

import SwiftUI

struct VideoSettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isPresented = false
    @State private var date = Date()
    @State private var title = ""
    
    let users = [
        User(userId: 1, userNickname: "우리딸", userMail: "example@exam.com", userPhone: "010-0000-0000", userProfile: "abcd"),
        User(userId: 1, userNickname: "우리아들", userMail: "example@exam.com", userPhone: "010-0000-0000", userProfile: "abcd"),
        User(userId: 1, userNickname: "우리막내", userMail: "example@exam.com", userPhone: "010-0000-0000", userProfile: "abcd"),
        User(userId: 1, userNickname: "우리엄마", userMail: "example@exam.com", userPhone: "010-0000-0000", userProfile: "abcd"),
        User(userId: 1, userNickname: "우리아빠", userMail: "example@exam.com", userPhone: "010-0000-0000", userProfile: "abcd")
    ]
    @State private var categories = [
        "생일",
        "기념일",
        "기타 등등"
    ]
    @State private var selectedCategoryIdx: Int?
    
    @State private var birthDate = Date()
    @State private var selectedUser:User?
    init() {
        UITextField.appearance().clearButtonMode = .whileEditing
    }
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(50)), count: 1)
    @State var text:String = ""
    //    UITextField.appearance().clearButtonMode = .whileEditing
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    Form {
                        Section(header:
                                    Text("누구에게 보낼까요")
                            .font(.headline)
                            .padding(.leading, 0)
                            .padding(.bottom,8)
                        ){
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: rows, alignment: .center) {
                                    ForEach(users, id: \.self) { user in
                                        Group{
                                            VStack(alignment: .center){
                                                if selectedUser == user{
                                                    ZStack{
                                                        Circle()
                                                            .foregroundColor(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
                                                            .frame(width: 52, height: 52)
                                                        Circle()
                                                            .stroke(Color.black, lineWidth: 3)
                                                            .frame(width: 63, height:63)
                                                            .background(Image(systemName: "checkmark").fontWeight(.bold))
                                                    }
                                                    Text(user.userNickname)
                                                }else{
                                                    Circle()
                                                        .foregroundColor(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
                                                        .frame(width: 63, height: 63)
                                                    Text(user.userNickname)
                                                }
                                            }
                                            .padding(.leading,2)
                                        }
                                        .onTapGesture{
                                            selectedUser = user
                                        }
                                        .padding(.trailing, 15)
                                    }
                                }.padding(.trailing, 0)
                            }
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
                                    Text(categories[selectedCategoryIdx!])
                                }
                                Image(systemName: "chevron.right")
                            }.onTapGesture{
                                isPresented.toggle()
                            }
                            
                            
                        }
                    }
                }
                VStack{
                    Spacer()
                    Button(action: {
                        print("Share tapped!")
                    }) {
                        Text("다음")
                            .fontWeight(.bold)
                            .font(.system(size:25))
                            .frame(width: 79, height: 54)
                            .padding()
                            .foregroundColor(.black)
                            .background(Color(red:0.69,green:0.88,blue:1))
                            .cornerRadius(40)
                            .padding(.horizontal, 20)
                    }
                }
                
                
            }
            .navigationBarTitle(
                Text("영상 보내기")
                    .bold()
                , displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        // 왼쪽 아이템을 클릭했을 때의 동작
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
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $isPresented){
                CategorySelectModalView(
                    categories: $categories,
                    selectedCategoryIdx: $selectedCategoryIdx
                ){
                    isPresented=false
                }
            }
        }
    }
}

struct VideoSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        VideoSettingsView()
    }
}
