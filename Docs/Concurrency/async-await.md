>[!question]
>GQ1. `async-await`은 무엇인가?
>GQ2. `async-await`은 언제 사용하는가?

## Description

Swift에서 비동기 함수를 동기적으로 보이게 하는 문법

## 주요 기능

#### `async` 함수 정의

함수 선언 시 `async` 키워드를 추가하여 비동기 함수임을 표시한다.

```swift
func fetchData() async throws -> Data {
    let url = URL(string: "https://api.example.com/data")!
    let (data, _) = try await URLSession.shared.data(from: url)
    return data
}
```

#### `await` 키워드 사용

비동기 작업이 완료될 때까지 현재 실행 흐름을 일시 중단한다.

```swift
func processData() async {
    do {
        let data = try await fetchData()
        // 데이터 처리 로직
    } catch {
        // 오류 처리
    }
}
```

#### `Task`로 감싸서 사용

async 함수가 아닌 곳에서 비동기 함수를 호출할 때는 Task로 감싼다.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    Task {
        let data = try await fetchData()
        // UI 업데이트는 메인 스레드에서
        await MainActor.run {
            self.updateUI(with: data)
        }
    }
}
```

## 코드 예시

```Swift
import SwiftUI

struct LemonAsyncAwaitView: View {
    @State private var number = 0

    var body: some View {
        VStack {
            Text("\(number)")

            Button("Generate Number") {
                Task {
                    // 랜덤 숫자 생성 함수를 기다림
                    number = try await generateNumber()
                }
            }
        }
    }

    // 비동기 함수임을 명시
    private func generateNumber() async throws -> Int {
        try await Task.sleep(for: .seconds(1))
        return Int.random(in: 1...100)
    }
}

#Preview {
    LemonAsyncAwaitView()
}
```

## Keywords

- [[try-throws]]

## References

- [Concurrency | Swift Documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)
- [Concurrency | Apple Developer Documentation](https://developer.apple.com/documentation/swift/concurrency)