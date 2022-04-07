# SeSACFriends
`SnapKit` `MapKit` `MVVM` `Alamofire` `Codable` `Firebase(Auth, Messaging)` `RxSwift` `Socket`

#### ✨ 위치 기반 취미 친구 찾기 어플

> - 프로젝트 기간: 2022.01 ~ 2022.03  
> - 개인 프로젝트  

## Service
- **회원가입/로그인**: Firebase Auth를 이용한 전화번호 인증을 기반으로 회원가입 및 로그인을 할 수 있습니다. REST API 통신을 통해 회원탈퇴 또한 가능합니다.
- **위치 기반 친구 찾기**: 사용자의 현재 위치 혹은 지도를 이동하여 원하는 위치를 기반으로 주변에 취미를 함께할 친구를 찾을 수 있습니다.
- **취미 친구 요청 및 수락**: 원하는 친구에게 친구 요청을 보내거나 받은 요청을 수락하여 매칭을 진행할 수 있습니다.
- **회원 간 채팅**: 매칭된 회원들 간의 채팅을 진행할 수 있습니다. 취미 약속을 잡거나 관련 대화를 나눌 수 있습니다.
- **회원 정보 수정**: 성별, 자주 하는 취미, 번호 검색 허용, 상대방 연령대 등 설정을 수정하고 저장할 수 있습니다. 다른 회원들로부터 받은 타이틀 혹은 리뷰 또한 확인할 수 있습니다.

## Collaboration
- Product Design: Confluence
- Design: Figma
- Server(API): Confluence, Swagger
- TeamWork
  - 4명의 동료 개발자와 팀을 이루어 협의를 통해 각자 사용할 기술 스택을 설정했습니다.
<img width="683" alt="image" src="https://user-images.githubusercontent.com/22907483/158759160-3a6b586d-d158-41b0-bc36-2cbc04a987e8.png">
  - 프로젝트를 진행하는 동안 매일같이 데일리 스크럼을 진행하여 현재 진행 상황 혹은 개발 과정에서 겪은 문제 및 해결방식에 대해 공유했습니다.  
<img width="683" alt="image" src="https://user-images.githubusercontent.com/22907483/158759632-f512cd05-87fe-4672-8ceb-d8f49bc4a818.png">
- 개인적으로 노션에도 진행상황을 정리해가며 개발했습니다.
<img width="722" alt="image" src="https://user-images.githubusercontent.com/22907483/158760875-82c1f459-a251-4795-83c9-1785af9607bf.png">

## Workflow
<img alt="image" src="https://user-images.githubusercontent.com/22907483/158757136-c29cf508-546e-4b4b-af69-abfec8a8172e.png">

## Skill
- Architecture
```swift
'MVVM'
'RxSwift'
```
- View
```swift
'SnapKit'                         // Code-based UI
'MapKit'
```
- Network
```swift
'Alamofire'                       // 서버 통신
'Codable'
'Sockeet'
```
- Data & User
```swift
'Firebase(Auth, Messaging)'
'RxRealm'
```
## View
### 1. 온보딩
<img src = "https://user-images.githubusercontent.com/22907483/158762345-8c8313a7-8c6c-48b0-be98-7b3a04706f20.png" width= "25%"> <img src = "https://user-images.githubusercontent.com/22907483/158762351-a01cb29b-c251-4612-a10f-df72b50fd4fb.png" width= "25%"> <img src = "https://user-images.githubusercontent.com/22907483/158762353-c91fdce4-3f8b-420f-b462-2a7e8fd8d7fc.png" width= "25%">

- 앱을 처음 실행했거나 회원탈퇴를 하는 경우 노출되는 화면입니다.
- 시작하기를 눌러 회원가입 단계로 진입할 수 있습니다.  

### 2. 전화번호 인증 및 로그인
<img src = "https://user-images.githubusercontent.com/22907483/158762961-d0bab3eb-a7c3-45ca-b39e-fb334486a1c2.png" width= "22%">  <img src = "https://user-images.githubusercontent.com/22907483/158762958-d521f6f0-5dfc-4896-8b41-e9cdf09d8aa9.png" width= "22%"> <img src = "https://user-images.githubusercontent.com/22907483/158762965-7dcc74b2-b83d-4047-805d-176651e148b3.png" width= "22%"> <img src = "https://user-images.githubusercontent.com/22907483/158762968-3e2e4203-f6b0-428a-9069-08d9d824ea6e.png" width= "22%">

- 사용자가 번호를 입력하면 자동으로 '-'를 입력하여 포맷을 수정합니다.
- 입력된 내용이 전화번호 포맷을 만족시키면 인증 문자를 받을 수 있고 만약 포맷을 만족시키지 못한다면 토스트가 뜹니다.
- 인증번호 문자를 수신하면 키보드 상단에 자동완성으로 인증번호가 뜨게 되고 정확한 번호라면 인증을 완료할 수 있습니다.
- 만약에 이 전에 회원가입을 진행한 번호라면 바로 홈 화면으로 이동하게되고 만약 신규회원이라면 회원가입 단게로 이동하게 됩니다.

### 3. 회원가입
<img src = "https://user-images.githubusercontent.com/22907483/158764310-e3178b09-c510-4251-b322-9463d72bb63c.png" width= "22%">  <img src = "https://user-images.githubusercontent.com/22907483/158764316-d8fa03b3-f7ca-4f33-a809-579ed23e54ee.png" width= "22%"> <img src = "https://user-images.githubusercontent.com/22907483/158764319-da9af07c-cbbf-46de-9322-5c04e95297aa.png" width= "22%"> <img src = "https://user-images.githubusercontent.com/22907483/158762968-3e2e4203-f6b0-428a-9069-08d9d824ea6e.png" width= "22%">

- 사용자는 닉네임, 생년월일, 이메일, 성별 정보를 기입 후 회원가입을 진행하게 됩니다.
- 이때 각 항목에 대한 유효성 검증이 모두 진행되고 만족되는 경우에만 가입이 수락됩니다.
  - 닉네임: 비속어 혹은 금지된 단어가 포함된 경우, 마지막 성별 기입 단계에서 다음을 클릭했을 때 다시 닉네임 입력 화면으로 돌아가게 됩니다. 다른 닉네임으로 수정 후 다시 진행해야합니다.
  - 생년월일: 만 14세 이상만 사용할 수 있는 어플리케이션으로 기입된 생년월일을 기준으로 만 나이를 계산 후 만 14세 미만은 사용할 수 없다는 토스트를 띄우게 됩니다.
  - 이메일: 이메일 형식을 만족시켜야합니다.
  - 성별: 성별 정보는 애플 심사규정 상 민감 정보로 분류되기 때문에 필수 입력값으로 받을 수 없습니다. 따라서 성별 정보를 선택하지 않더라도 회원가입을 진행할 수 있습니다. 

### 4. 홈(지도 - 위치 및 다른 사용자들)
<img src = "https://user-images.githubusercontent.com/22907483/158761685-ec8948ab-5060-4844-9244-5e82cb214852.PNG" width= "25%">  <img src = "https://user-images.githubusercontent.com/22907483/158761723-50f60493-afe0-4f09-90f1-c2e446fb76a3.PNG" width= "25%">

- 사용자가 앱을 처음 사용하게 되면 위치 정보 수집 허용을 위한 팝업이 뜹니다.
- 사용자가 허락한다면 현재 사용자의 위치로, 거절했다면 미리 정해진 임의의 위치로 지도가 이동합니다.
- 지도를 드래그하여 취미 친구 찾기 요청을 넣은 사용자들을 새싹 아이콘을 통해 확인할 수 있습니다.
- 좌측 상단의 플로팅 버튼을 통해 사용자를 성별로 필터링하여 확인할 수 있습니다.

### 5. 취미 설정


### 6. 취미 친구 요청, 요청 수락


### 7. 채팅


### 8. 회원 정보
<img src = "https://user-images.githubusercontent.com/22907483/158761031-d5827c92-0a98-4b7b-a7e7-fade67f29e0d.PNG" width= "25%">  <img src = "https://user-images.githubusercontent.com/22907483/158761050-89a86088-24b1-476d-90f9-ccfeca68be7c.PNG" width= "25%"> 

- 유저의 회원 정보를 확인하고 수정할 수 있는 페이지입니다.
- 성별, 취미, 검색 허용, 상대방 연령대를 변경할 수 있고 회원 탈퇴가 가능합니다.
- 프로필 이미지 우측 화살표를 클릭하여 다른 회원들이 남긴 자신의 평판 및 리뷰를 확인할 수 있습니다.

