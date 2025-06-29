>[!question]
>GQ1. Window란 무엇인가?

## Description
- Window란 visionOS에서 사용자에게 2D UI를 보여주는 공간적 창
- 일반적 iOS 앱의 화면처럼 보이지만, 차이점은 공간 안에 '떠 있는' 평면 패널이라는 점
- 다른 디바이스와는 달리 공간성이 존재

## 주요 기능
+ 사용자가 이동, 회전, 고정, 크기 조절이 가능.
+ 개발자가 창의 위치, 각도

## 코드 예시
```swift
// WindowGroup은 하나 이상의 window scene을 생성하는 SwiftUI 컨테이너
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

## Keywords
+ 파생된 키워드들을 작성

## References
- [Apple WindowGroup 공식 문서](https://developer.apple.com/documentation/swiftui/windowgroup?utm_source=chatgpt.com)
- 