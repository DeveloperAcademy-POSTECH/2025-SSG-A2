>[!question]
>GQ1. ProgressView에는 어떤 기능이 있을까?

## ProgressView
- 작업 완료까지의 진행률을 보여주는 View
- 진행 완료 퍼센트처럼 **확실한 타입**과 진행 중인지 여부만 나타내주는 **불확실한 타입** 모두 가능
- progress를 나타내는 숫자 값과 작업 완료를 나타내는 total 값만 이니셜라이징 하면 됨.
- Default 값은 progress는 0.0이고 total은 1.0이다.

## 주요 기능
### 확실한 타입
```swift
@State private var progress = 0.5

ProgressView(value: progress)
Button("More") { progress += 0.05 }
```
### 불확실한 타입
```swift
ProgressView()
```
### Date 범위 내에서 사용하기
- 현재 날짜가 범위 내에 있는 한, ProgressView는 범위의 끝에 가까워지면 자동으로 업데이트되고 ProgressView가 채워지거나 삭제된다.
- 예제) 5분 타이머
```swift
let workoutDateRange = Date()...Date().addingTimeInterval(5*60)

ProgressView(timerInterval: workoutDateRange) {
	Text("workout")
}
```
## ProgressView 커스텀마이징
- **progressViewStyle** modifier로 설정 가능
- 분홍색 border line을 추가한 버전
```swift
VStack {
	ProgressView(value: 0.25) { Text("25% progress") }
	ProgressView(value: 0.75) { Text("75% progress") }
}
.progressViewStyle(PinkBorderedProgressViewStyle())

struct PinkBorderedProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .padding(4)
            .border(.pink, width: 3)
            .cornerRadius(4)
    }
}
```
- 원형 게이지(**macOS 이외에서는 불확실한 타입으로 나타날 수 있음**)
```swift
@State private var progress = 0.6

ProgressView(value: progress)
	.progressViewStyle(.circular)
```


## Keywords
+ ProgressView

## References
- [Apple 공식 문서](https://developer.apple.com/documentation/swiftui/progressview)