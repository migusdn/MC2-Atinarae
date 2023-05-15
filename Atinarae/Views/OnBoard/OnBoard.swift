//
//  OnBoard.swift
//  Atinarae
//
//  Created by Kimdohyun on 2023/05/10.
//

import Foundation
import SwiftUI

struct onBoard: View{
    @EnvironmentObject var navModel: NavigationModel
    var body: some View {
        NavigationView{
            VStack{
                
                // TODO: 머식! 여기를 기점으로 시작해서 시작점을 다시 Main으로 돌려주길 바래요.
                NavigationLink ("살려줍메",destination: MessageSettingsView(), isActive: $navModel.MessageAddProcessIsActive)
                    .isDetailLink(false)
                    .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                NavigationLink ("살려줍메",destination: MessageSettingsView(), isActive: $navModel.MessageAddProcessIsActive)
                    .isDetailLink(false)
                    .buttonStyle(ButtonPrimaryStyle(frameWidth: 100, frameHeight: 60))
                
                // TODO: 그 외로 전달사항은 다는 안적은거같지만 TODO 로 검색하면 지금 생각나는 해야 할 일, MARK는 어떤 함수나 진입점의 시작을 의미합니다
                // TODO: 기본적으로 realm은 객체형 DB임을 생각하고 데이터를 다루시면 수월하실 것 같습니다
                // TODO: ORM 에서 Object를 생성해서 CRUD는 가능하지만 저장하지 않은 값은 모두 날아갑니다.
                // TODO: 아직 정확히 realm에 대해서 파악하지는 못했지만 원하는 쿼리 등을 (Entity)ViewModel.swift 에 func로 정의하여 사용하시면 됩니다
                // TODO: 그 부분은 GPT 추천 GPT가 쓴 코드를 이해하면서 수정하는게 빠릅니다.
                // TODO: 그 외로 새로 생긴 파일이나 이름이 바뀐 것 들에 대한 이야기는 여기 아래에 하겠습니다
                // TODO: VideoSettingView -> MessageSettingView
                // TODO: FIX button (완료)
                // TODO: 저기 있는 Utility폴더는 잡다한 func 모아놓은 곳 입니다
                // TODO: 저는 곧 잠들기 직전이라 이제 슬슬 가겠습니다
                // TODO: realm 오류 제어한다고 했는데 안정적으로 잘 될지는 모르겠네요
                // TODO: 모바일 기기의 Appdata는 cmd + shift + 2를 누르고
                // TODO: 모바일 기기 선택이 완료되면 좌측하단 동그라미에 점 세개 있는거 클릭하면 Download Containe, Replace Container 등등 있으니 잘 활용하시기 바랍니다
                // TODO: 추출된 appdata는 일반적인 방법으로 더블클릭해서 여는 파일이 아니므로 "com.atinarae.tvvinkle 2023-05-14 09/48.16.918" 등의 파일을 우클릭하면 패키지 내용 보기 클릭하면 보실 수 있습니다.
                // TODO: 중요! 좌상단의 검색창에서 (MARK, TODO)를 검색해주세요.
                // TODO: 아마 빠진부분 많을거고 다 파악하진 못했습니다.
                
                // TODO: 너무 졸려
                
                // TODO: +++ 폴더 구조에 대한 의견
                // TODO: 폴더이름에 XXXView 이런식으로 하지말고
                // TODO: App - Views - XXX - XXXView.swift
                // TODO:             |     - XXXViewModel.swift
                // TODO:             |     - XXXViewModel.swift
                // TODO:        CommonView
                
            
                
                
                }
            }
        }
    }

