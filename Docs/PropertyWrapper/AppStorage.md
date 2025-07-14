>[!question]
>GQ1. AppStorage는 무엇일까?
>GQ2. AppStorage는 어디에 쓰일 수 있을까?

## AppStorage란?
- UserDefaults로 부터 값을 반영하고 값 변경에 대한 뷰를 무효화하는 속성 래퍼
- UserDefault의 SwiftUI 버전
- 앱의 전역 범위에 데이터 공유 가능
- Binding으로 서브뷰로 전달하여 데이터를 바로 업데이트 가능
- DynamicProperty라는 프로토콜을 준수하고 있다.
	- DynamicProperty는 뷰의 외부 속성을 업데이트하는 저장 변수에 대한 인터페이스를 제공

## 주요 기능
- 이니셜라이저
```swift
init(
	wrappedValue: Value,
	_ key: String,
	store: UserDefaults? = nil
) where Value == String
```
- 사용법
```swift
@AppStorage("KEY") var Name: Type = Value
// @AppStorage 뒤에 "고유 값"을 적어주면 된다.
```
- 예시
```swift
@AppStorage("age", store: UserDefaults(suiteName: "green")) var age: Int = 3
```
- 전역적으로 데이터 공유 가능
- 하위 뷰들에 바인딩값으로 전달하고 연결할 수 있다.
- **앱이 삭제되기 전에 앱을 종료하고 다시 실행해도 값이 유지**된다.

### 사용 목적
- 설정값 저장
- 상태 유지
- UI 연동
- 앱 재시작 후에도 유지
- 예: 다크 모드 설정 저장, 로그인 상태 유지 등

### 명심할 것
- @AppStroage는 데이터 추출이 쉬워 개인 데이터를 저장하면 안된다.

## Keywords
+ AppStorage
+ [[UserDefaults]]

## References
- [블로그](https://green1229.tistory.com/454)
- 애플 공식 문서
- ChatGPT