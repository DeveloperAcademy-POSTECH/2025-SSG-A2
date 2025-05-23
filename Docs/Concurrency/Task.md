>[!question]
>GQ1. `Task`는 무엇인가?
>GQ2. `Task`는 언제 사용하는가?

## Description

비동기 작업을 생성하는 기본 단위

## 주요 기능

#### 기본 Task 사용

```swift
let task = Task {
    let result = await someAsyncFunction()
    return result
}

// Task 결과 기다리기
let result = await task.value
```

#### Task 취소

Task가 필요하지 않을 때 취소할 수 있다.

```swift
@State private var fetchTask: Task<(), Error>? = nil

.onAppear {
	fetchTask = Task {
		await fetchImage()
	}
}
.onDisappear {
	fetchTask?.cancel()
}
```

#### Task 지연 처리

Task에서 지연을 주고 싶을 때는 `Task.sleep`을 사용한다.

```swift
Task {
    try await Task.sleep(nanoseconds: 1_000_000_000) // 1초 지연
    // 지연 후 실행할 작업
}
```

### TaskGroup

여러 비동기 작업을 병렬로 처리할 때 사용한다.

```swift
await withTaskGroup(of: Data.self) { group in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    
    for name in photoNames {
        group.addTask {
            return await downloadPhoto(named: name)
        }
    }
    
    for await photo in group {
        show(photo)
    }
}
```

## 코드 예시

```Swift
import SwiftUI

struct LemonTaskView: View {
    @State private var generateNumberTask: Task<Int, Error>?
    @State private var number = 0

    var body: some View {
        VStack {
            Text("\(number)")
            Button("Generate Number") {
                // 랜덤 숫자 생성 작업을 생성
                generateNumberTask =
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        return Int.random(in: 1...100)
                    }

                // 생성된 작업으로부터 결과를 기다리는 작업을 생성
                Task {
                    do {
                        number = try await generateNumberTask?.value ?? 0
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
    }
}

#Preview {
    LemonTaskView()
}
```

## Keywords

- [[async-await]]
- [[Task]]
- [[Sendable]]

## References

- [Task | Apple Developer Documentation](https://developer.apple.com/documentation/swift/task)