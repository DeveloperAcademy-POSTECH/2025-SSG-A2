>[!question]
>GQ1. FireBase Analytics는 무엇인가?
>GQ2. FireBase Analytics를 사용하는 이유는 무엇인가?
>GQ3. FireBase Analytics 작동 원리는 무엇인가?

## Description
- 앱 분석 도구로, 사용자 행동 데이터를 수집, 분석하여 앱의 성능과 사용자 경험을 개선하는데 도움을 주는 서비스.

## 주요 기능 및 서비스
+ 자동 이벤트 수집(앱 설치, 앱 열기, 앱 업데이트 등 주요 이벤트 추적)
+ 사용자 정의 이벤트(개발자가 원하는 특정 이벤트를 직접 설정 및 추적 가능)
+ 사용자 속성 추적: 사용자 연령, 관심사, 지역 등 사용자 기반 정보 분석

## 사용하는 이유
+ 사용자 행동 분석을 통해 사용자가 앱에서 어떤 행동을 취하는지 추적하여 사용 흐름, 이탈 지점, 전환율 등을 분석
+ 광고(Google Ads)의 효과를 측정하고, 맞춤형 마케팅 전략을 수립.


## 코드 예시
```swift
import SwiftUI
import Firebase

@main
struct AnalyticsDemoApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Firebase Analytics Demo")
                .font(.headline)

            Button("로그인 버튼 클릭") {
                Analytics.logEvent("login_click", parameters: [
                    "method": "email"
                ])
            }

            Button("구매 버튼 클릭") {
                Analytics.logEvent("purchase", parameters: [
                    "item_id": "1001",
                    "item_name": "Gold Pack",
                    "value": 12000,
                    "currency": "KRW"
                ])
            }
        }
        .padding()
        .onAppear {
            Analytics.setUserProperty("male", forName: "gender")
        }
    }
}
```


## Keywords
+ [Server]
+ [[Firebase]]

## References
- [파이어베이스 문서](https://firebase.google.com/docs/projects/learn-more?hl=ko)
- GPT