>[!question]
>GQ1. Model Entity는 무엇인가?
>GQ2. Model Entity는 언제 사용되는가?

## Description
```swift
@MainActor @preconcurrency
class ModelEntity
```
- Entity의 서브클래스로 3D mesh(모양), metrial(색상 및 질감), 물리적 속성 등을 가질 수 있음.
- HasModel, HasPhysics 프로토콜을 따르고 있어, **렌더링뿐 아니라 물리 시뮬레이션도 가능**.

## 주요 기능
+ 시각적 표현, 물리/충돌 처리, 애니메이션을 가능하게 함

## 코드 예시
```swift
let box = ModelEntity(mesh: .generateBox(size: 0.2),
                      materials: [SimpleMaterial(color: .red, isMetallic: false)])

if let model = try? await ModelEntity(named: "GlassCube") {
    content.add(model)
}
```


## References
- [Apple의 공식 문서](https://developer.apple.com/documentation/realitykit/anchorentity)