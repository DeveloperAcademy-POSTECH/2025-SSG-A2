>[!question]
>GQ1. NavigationStack은 무엇인가?

## Description
- root View를 표기하고 그 위에 추가 View를 제공하는 View

## 주요 기능
+ 화면을 ***Stack구조*** 로 관리하며 탐색 경로를 명확히 관리.
+ ***NavigationLink(value:)*** 로 목적지를 설정
+ ***navigationDestinantion(for:)*** 을 통해 화면을 push(바인딩)
+ ***NavigationPath()*** 를 통해서 동적으로 스택 탐색

## 코드 예시
```swift
import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
}

struct FruitListView: View {
    let fruits = [
        Fruit(name: "🍎 사과", description: "달콤하고 아삭아삭한 과일"),
        Fruit(name: "🍌 바나나", description: "부드럽고 달콤한 과일"),
        Fruit(name: "🍊 오렌지", description: "상큼하고 시원한 과일")
    ]
    
    var body: some View {
        NavigationStack {
            List(fruits) { fruit in
                NavigationLink(value: fruit) {
                    Text(fruit.name)
                }
            }
            .navigationTitle("과일 목록")
            .navigationDestination(for: Fruit.self) { fruit in
                FruitDetailView(fruit: fruit)
            }
        }
    }
}

struct FruitDetailView: View {
    let fruit: Fruit
    
    var body: some View {
        VStack(spacing: 20) {
            Text(fruit.name)
                .font(.largeTitle)
            Text(fruit.description)
                .font(.body)
        }
        .padding()
        .navigationTitle("상세 정보")
    }
}

struct ContentView: View {
    var body: some View {
        FruitListView()
    }
}
```

## Keywords
+ [[View]]
+ [[Navigation]]


## References
- [Apple 공식문서](https://developer.apple.com/documentation/swiftui/navigationstack/)