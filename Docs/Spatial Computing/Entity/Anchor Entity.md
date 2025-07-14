>[!question]
>GQ1. Anchor Entity란 무엇인가?
>GQ2. Anchor Entity는 언제 사용되는가?

## Description
```swift
@MainActor @preconcurrency
class AnchorEntity
```
- 엔티티를 장면에 연결하는 앵커

## 주요 기능
+ RealityKit에서 가상의 객체를 Scene에 배치
+ 동일한 anchor 내에 있는 entity끼리만 서로 영향을 받음

## 코드 예시
```swift
let anchor = AnchorEntity(.plane(.horizontal, classification: .any, minimumBounds: SIMD2<Float>(0.2, 0.2) ))
```


## References
- [Apple의 공식 문서](https://developer.apple.com/documentation/realitykit/anchorentity)