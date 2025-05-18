>[!question]
>GQ1. NavigationLink는 무엇인가?
>GQ2. GQ를 쓰세요

## Description
- NavigationLink는 사용자가 화면을 터치했을  때 목적지 뷰로 이동하게 해주는 UI컴포넌트.
- Button처럼 클릭 가능한 인터페이스 제공
- NavigationStack, NavigationView 모두에서 사용

## 주요 기능
+ 새로운 View로 이동할 때 사용

## 코드 예시
```Swift
NavigationStack {
    List(items, id: \.self) { item in
        NavigationLink(value: item) {
            Text(item)
        }
    }
    .navigationDestination(for: String.self) { value in
        Text("Detail for \(value)")
    }
}
```

## Keywords
+ [UIComponent]

## References
- GPT
- [Apple 공식문서](https://developer.apple.com/documentation/swiftui/navigationlink/)
- 소스코드