>[!question]
>GQ1. NavigationPath란 무엇인가?
>GQ2. NavigationPath는 왜 @State를 통해 관리되는가?

## Description
- NavigationPath의 기능 및 사용 이유에 대해서 알아본다.

## 주요 기능
+ NavigationPath는 NavigationStack에서 화면 전환 경로(state)를 추적하고 조작할 수 있는 타입
+ 여러 화면을 연속적으로 push
+ 특정 조건에 따라 프로그래밍 적으로 이동/뒤로가기

## 추가 설명
- NavigationPath는 SwiftUI에서 제공하는 구조체로 Codable, Hashable, Equatable를 따르고 있음
	- Codable: JSON으로 변환하거나 파싱할 수 있게 해주는 프로토콜
	- Hashable: Set/Dictionary에서 사용 가능하게 하는 프로토콜
	- Equatable: 비교 가능하게 하는 프로토콜
- @State와 함께 사용하는 이유는 SwiftUI 내부적으로 변경 사항을 감지하고 뷰를 다시 그릴 수 있게 하기 위함임

## 코드 예시
```swift
import SwiftUI

struct Fruit: Hashable {
    let name: String
}

struct FruitListView: View {
    @State private var path = NavigationPath()
    
    let fruits = [Fruit(name: "사과"), Fruit(name: "바나나"), Fruit(name: "포도")]
    
    var body: some View {
        NavigationStack(path: $path) {
            List(fruits, id: \.self) { fruit in
                Button {
                    path.append(fruit) // 경로에 push
                } label: {
                    Text(fruit.name)
                }
            }
            .navigationTitle("과일 목록")
            .navigationDestination(for: Fruit.self) { fruit in
                FruitDetailView(fruit: fruit, path: $path)
            }
        }
    }
}

struct FruitDetailView: View {
    let fruit: Fruit
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(spacing: 20) {
            Text(fruit.name)
                .font(.largeTitle)
            
            Button("홈으로 이동") {
                path.removeLast(path.count) // 루트로 이동
            }
        }
        .navigationTitle("상세")
    }
}
```

## Keywords
+ [[NavigationPath]]
+ [@State]

## References
- [Apple 공식문서](https://developer.apple.com/documentation/swiftui/navigationpath/)
- GPT
- 소스 코드