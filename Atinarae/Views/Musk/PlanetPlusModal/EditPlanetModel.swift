//
//  EditPlanet.swift
//  Atinarae
//
//  Created by A_Mcflurry on 2023/05/15.
//
import SwiftUI
import RealmSwift
// 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓 럽미라잇디스 럽미라잇댓

struct EditPlanetModal: View {
    @Binding var planetLotateNumber: Int
    @EnvironmentObject var userViewModel: UserViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedPlanet: Int = 0
    @State var phoneNumber: String = ""
    @State var eMail: String = ""
    @State var nickName: String = ""
    @State var showingAlert: Bool = false
    @State var showingDeleteAlert = false
    @Binding var users: [User]?
    @Binding var deletePlanet: Bool
    
    var body: some View {
        GeometryReader { geo in
            let seletePlanetSize = geo.size.width/9
            
            ScrollView{
                VStack{
                    HStack{
//                        Spacer()
//                        ModalViewIndicator(indicator: geo.size.width/6)
                        Spacer()

                        Button{     // 저장
                            userViewModel.updateUser(user: (users?[planetLotateNumber])!, nickname: nickName, mail: eMail, phone: phoneNumber, profile: selectedPlanet, friends: [])
                            dismiss()
                        } label: {
                            Text("저장")
                            
                        }
                        .padding()
                    }
                    Spacer()
                        
                    makeMainPlanet(planetNumber: selectedPlanet)
                        .resizable()
                        .frame(width: geo.size.width/2, height: geo.size.width/2)
                        .overlay{
                            VStack{
                                Text(self.users?[planetLotateNumber].nickname ?? "")
                                
                                Button(action: {
                                    self.showingAlert = true
                                }) {
                                    Text("행성 삭제하기")
                                        
                                }.buttonStyle(ButtonSecondaryStyle(frameWidth: 120, frameHeight: 35))

                               
                            }
                            .offset(y:geo.size.width/5)
                            .alert("정말 삭제하시겠어요?", isPresented: $showingAlert) {
                                Button("취소", role: .cancel) {}
                                Button("삭제", role: .destructive) {
                                    showingDeleteAlert = true
                                    deletePlanet = true
                                    
                                }
                            } message: {
                                Text("삭제 후 30일 간 환경설정에서 복원이 가능해요.")
                            }
                            .alert("행성이 삭제되었어요.", isPresented: $showingDeleteAlert) {
                                Button("확인", role: .cancel) {
                                    dismiss()
                                }
                            
                        }
                    }
                    }
                    
                    Form{
                        Section{
                            HStack {
                                ForEach(0..<5, id: \.self) { planet in
                                    if selectedPlanet == planet{
                                        ZStack{
                                            makeSelectPlanet(planetNumber: planet)
                                                .resizable()
                                                .frame(width: seletePlanetSize, height: seletePlanetSize)
                                                .padding(.trailing, 10)
                                                .padding(.leading, 10)
                                            
                                            Circle()
                                                .stroke(Color.white, lineWidth: 3)
                                                .frame(width: seletePlanetSize+10, height:seletePlanetSize+10)
                                                .background(Image(systemName: "checkmark").fontWeight(.bold))
                                            
                                        }
                                    } else{
                                        makeSelectPlanet(planetNumber: planet)
                                            .resizable()
                                            .frame(width: seletePlanetSize, height: seletePlanetSize)
                                            .padding(.trailing, 10)
                                            .padding(.leading, 10)
                                            .onTapGesture {
                                                selectedPlanet = planet
                                            }
                                    }
                                }
                            }
                            .frame(height: seletePlanetSize + 40)
                            TextField("행성이름", text: $nickName)
                                .keyboardType(.default)
                        } header: {
                            Text("행성")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        
                        Section{
                            TextField("전화번호", text: $phoneNumber)
                                .keyboardType(.default)
                            TextField("이메일", text: $eMail)
                                .keyboardType(.default)
                        } header: {
                            Text("받는 사람")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .frame(height: geo.size.height/1.4)
                    .offset(y:10)
                }
                
            
        }
        .onAppear{
            selectedPlanet = self.users?[planetLotateNumber].profile ?? 0
            phoneNumber = self.users?[planetLotateNumber].phone ?? ""
            eMail = users?[planetLotateNumber].mail ?? ""
            nickName = users?[planetLotateNumber].nickname ?? ""
        }
    }
}


//struct PlanetPlusModal_Previews: PreviewProvider {
//    static var previews: some View {
//        let appData = AppData()
//        PlanetPlusModal(planetLotateNumber: .constant(0))
//            .environmentObject(appData)
//    }
//}


