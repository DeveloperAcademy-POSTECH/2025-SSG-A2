>[!question]
>
>GQ1. `@Environment`는 무엇인가?
>
>GQ2. `@Environment`는 언제 사용하는가?
>
>GQ3. `@Environment()`의 프로퍼티에는 어떤 것이 있는가?

## Description

- @Environment는 **SwiftUI 뷰의 환경(Context)** 으로부터 값을 읽는 **프로퍼티 래퍼**다.
- **상위 뷰에서 설정한 값**을 **하위 뷰 어디서든 읽을 수 있도록** 도와준다.
- 시스템 제공 값 (예: 다크 모드, 폰트 크기, 앱 종료 등)과 **사용자 정의 값** 모두 지원한다.
- **값은 읽기 전용**이며, 주입된 이후에는 뷰 계층 아래로 자동 전달된다.
- 전역 설정이나 앱 전반에 영향을 주는 값 전달에 효과적이다.

## 주요 기능

1. `EnvironmentValues`를 key path로 사용하여 값을 가져올 수 있다.
	- 자주 사용하는 `EnvironmentValues`
		- `\.colorScheme`: 현재 뷰의 다크 모드 여부
		- `\.dismiss`: 현재 화면을 닫는 액션
		- `\.presentationMode`: 현재 화면의 프레젠테이션 상태 (isPresented 등 확인용, iOS 16 이하에서 사용)
		- `\.horizontalSizeClass`: 가로 방향 사이즈 클래스 (.compact, .regular)
		- `\.verticalSizeClass`: 세로 방향 사이즈 클래스
		- `\.locale`: 현재 설정된 언어 및 지역
		- `\.openURL`: 외부 URL을 여는 액션
		- `\.isEnabled`: 현재 뷰 컨트롤이 활성화되어 있는지 여부
		- `\.accessibilityEnabled`: 접근성 기능(VoiceOver 등)이 활성화되어 있는지 여부
		- `\.undoManager`: 현재 뷰에서 사용할 수 있는 Undo/Redo 관리자

```Swift
@Environment(\.colorScheme) var colorScheme: ColorScheme
```

2. `Observable object`를 가져올 수 있다.

```Swift
@Observable
class Library {
    var books: [Book] = [Book(), Book(), Book()]

    var availableBooksCount: Int {
        books.filter(\.isAvailable).count
    }
}

@main
struct BookReaderApp: App {
    @State private var library = Library()

    var body: some Scene {
        WindowGroup {
            LibraryView()
                .environment(library)
        }
    }
}

struct LibraryView: View {
	@Environment(Library.self) private var library // class 이름으로 가져옴
	
	var body: some View {
		// ...
	}
}
```

3. `Observable object`를 key path를 사용하여 가져올 수 있다.

```Swift
@Observable
class Library {
    var books: [Book] = [Book(), Book(), Book()]

    var availableBooksCount: Int {
        books.filter(\.isAvailable).count
    }
}

@main
struct BookReaderApp: App {
    @State private var library = Library()

    var body: some Scene {
        WindowGroup {
            LibraryView()
                .environment(\.library, library)
        }
    }
}

struct LibraryView: View {
    @Environment(\.library) private var library // Key path로 가져옴

    var body: some View {
        // ...
    }
}
```

## 코드 예시

`EnvironmentValues`와 Custom Environment를 사용한 예시 코드

```Swift
import SwiftUI

@Observable
class Library {
    var books: [String] = ["SwiftUI", "Combine", "Swift"]
    
}

struct EnvironmentView: View {
    @State private var library = Library()

	// EnvironmentValues
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if colorScheme == .light {
                Text("Light Mode")
                
            } else {
                Text("Dark Mode")
                
            }
            EnvironmentSubView()
        }
        .environment(library)
    }
}

struct EnvironmentSubView: View {
	// Custom Environment
    @Environment(Library.self) private var library
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Library")
                .font(.headline)
                .padding(.bottom)
            
            ForEach(library.books, id: \.self) { book in
                Text(book)
            }
        }
        .padding()
        .background(.gray.opacity(0.2), in: RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    EnvironmentView()
}
```

## Keywords

+ `EnvironmentValues`
+ Key path
+ Observable object

## References

- [Environment | Apple Developer Document](https://developer.apple.com/documentation/swiftui/environment)
- [SwiftUI : @Environment 프로퍼티 래퍼 - 서근 개발노트](https://seons-dev.tistory.com/entry/SwiftUI-Environment-프로퍼티-래퍼)