>[!question]
>GQ1. ProgressView에는 어떤 기능이 있을까?

## ProgressView
- 작업 완료까지의 진행률을 보여주는 View
- 진행 완료 퍼센트처럼 **확실한 타입**과 진행 중인지 여부만 나타내주는 **불확실한 타입** 모두 가능
- progress를 나타내는 숫자 값과 작업 완료를 나타내는 total 값만 이니설라이징 하면 됨.
- Default 값은 progress는 0.0이고 total은 1.0이다.

## 주요 기능
### 확실한 타입
```swift
@State private var progress = 0.5

ProgressView(value: progress)
Button("More") { progress += 0.05 }
```

## 코드 예시
+ 실제 코드 예시를 작성

## Keywords
+ 파생된 키워드들을 작성

## References
- 참고한 레퍼런스를 작성 (예 : Apple의 공식 문서)