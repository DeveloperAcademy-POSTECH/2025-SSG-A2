>[!question]
>GQ1. UserDefaults란 무엇이고 어떻게 사용되는가?
>GQ2. UserDefaults는 SwiftData와 어떻게 다른가?

## UserDefaults란?
- **iOS에서 데이터를 보관하기 위한 방법** 중 하나
- 기본적으로 **메모리** 상에서 모든 데이터를 관리한다. -> **메모리 캐싱**
- 앱이 실행되는 동안 Key-Value 형태로 데이터를 저장하는 사용자의 기본 데이터베이스에 대한 인터페이스
- 대용량 데이터보다 가벼운 단일 데이터 값을 저장하는 것이 좋다.
- ex) 인증 토큰 정보(KeyChain에 저장하는걸 권장), 자동 로그인 여부, 알림 수신 여부, 팝업창 띄우기 여부, 앱 테마 설정 등

## 특징
- (데이터(value), 키(key))로 데이터에 저장
	- 키(key)의 값은 String
	- 데이터(value)는 모든 객체 가능(Bool, Int, Float, Double, String 등)
- 앱이 설치되면 앱이 실행되는 시점에 데이터를 저장할 수 있는 기본 데이터베이스가 생성된다.
- Property List 기반으로 .plist 확장자 파일에 xml 형식으로 Sandbox 내부에 저장된다.
- UserDefaults에 저장된 데이터는 앱이 종료되더라도 사라지지 않고, 영구적으로 저장된다.
- 앱 자체 삭제 시, 데이터도 같이 사라진다.
	-> 앱 Sandbox에 저장되기 때문
- 사용자 기기의 저장공간 중 앱의 **문서 및 데이터** 영역을 차지한다.
### 저장위치
- 홈 디렉토리 > Library > Preferences > .plist

## 주요 기능
+ set
```swift
let userName = "Gyeong"
UserDefaults.standard.set(userName, forKey: "name")
```
- get
```swift
UserDefaults.standard.string(forKey: "name")
```
- remove
```swift
UserDefaults.standard.removeObject(forKey: "name")
```
- 전체 UserDefault 객체 목록 조회
```swift
for (key, value) in UserDefaults.standard.dictionaryRepresentation() { 
	print("\(key) = \(value) \n") 
}
```

## SwiftData와 차이점
| 항목     | UserDefaults                    | SwiftData                 |
| ------ | ------------------------------- | ------------------------- |
| 데이터 규모 | 소규모                             | 중대규모 이상                   |
| 데이터 구조 | 단순 키-값<br>키: String<br>값: 모든 객체 | 구조화된 모델 객체 (`@Model`)<br> |
| 특징     | 직렬화된 기본 타입                      | 영속 저장소 (Core Data 기반)     |
- 간단한 설정/플래그 저장: UserDefaults
- 앱 내 구조화된 사용자 데이터 저장: SwiftData

## AppStorage와의 차이점
| 항목      | UserDefaults         | AppStorage                  |
| ------- | -------------------- | --------------------------- |
| 타입      | 클래스 (`UserDefaults`) | 프로퍼티 래퍼 (`@AppStorage`)     |
| 사용 위치   | 전역, 뷰 외부에서도 사용 가능    | 주로 **SwiftUI View 내부**에서 사용 |
| 데이터 바인딩 | 직접 처리해야 함            | 자동으로 UI에 바인딩됨               |
- **간단한 UI 상태, 사용자 설정**: `AppStorage`
- **복잡한 데이터 처리, 뷰 외부 사용**: `UserDefaults`
#### UserDefaults
```swift
let defaults = UserDefaults.standard
defaults.set("blue", forKey: "favoriteColor")

let color = defaults.string(forKey: "favoriteColor")
```
#### AppStorage
```swift
struct ContentView: View {
    @AppStorage("favoriteColor") private var favoriteColor = "red"

    var body: some View {
        VStack {
            Text("선호 색상: \(favoriteColor)")
            Button("파랑으로 변경") {
                favoriteColor = "blue"
            }
        }
    }
}
```

## 코드 예시
```swift
import SwiftUI

struct ContentView: View {
    @State private var isFirstLaunch = false

    var body: some View {
        VStack(spacing: 20) {
            if isFirstLaunch {
                Text("🎉 앱을 처음 실행하셨네요! 환영합니다.")
                    .font(.headline)
            } else {
                Text("다시 오셨군요! 👋")
                    .font(.headline)
            }

            Button("Reset 상태 (UserDefaults 초기화)") {
                UserDefaults.standard.removeObject(forKey: "hasLaunchedBefore")
                checkFirstLaunch() // 다시 확인
            }
        }
        .onAppear {
            checkFirstLaunch()
        }
    }

    /// UserDefaults를 사용해서 첫 실행 여부 확인
    private func checkFirstLaunch() {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "hasLaunchedBefore") == false {
            // 키가 없거나 false이면 첫 실행
            isFirstLaunch = true
            defaults.set(true, forKey: "hasLaunchedBefore")
        } else {
            isFirstLaunch = false
        }
    }
}
```

## Keywords
+ SwiftData
+ [[AppStorage]]

## References
- [블로그1](https://co-dong.tistory.com/65)
- [블로그2](https://zeddios.tistory.com/107)
- 