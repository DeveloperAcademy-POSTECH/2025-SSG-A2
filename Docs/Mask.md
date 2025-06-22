## Description
### Definition
**mask란?**
- **뷰에 특정 형태의 마스킹(가림 효과)을 적용하는 SwiftUI modifier**.
- mask(_:)는 뷰의 **보여지는 영역을 다른 뷰의 형태로 제한**해주는 역할을 한다.
- UIKit의 CALayer.mask와 유사한 개념으로, 특정 모양(예: Circle, Text, Custom Shape 등)에 맞춰 **투명 처리된 외형**을 만들 수 있다.
**동작 원리**
- mask로 전달된 뷰는 **알파 채널(투명도)** 기준으로 마스킹된다.
- 전달된 뷰의 투명한 부분은 부모 뷰를 숨기고, 불투명한 부분만 보이게 만든다.

## **주요 기능**
**커스텀 형태의 클리핑**
- 예: Text("JOID")를 마스크로 쓰면, 텍스트 모양만 보이게 함.
**애니메이션 적용 가능**
- 마스크도 SwiftUI 뷰이므로, **애니메이션을 적용**해 마스크 형태를 동적으로 변경할 수 있음.
**다양한 뷰와 조합 가능**
- Image, Gradient, Shape, Text, VStack 등 다양한 SwiftUI 뷰를 마스크로 사용할 수 있음.

#### 코드 예시

**기본적 mask 적용**
```swift
.mask(
	GeometryReader { geo in
		Rectangle()
			.frame(width: geo.size.width * fillProgress, height: geo.size.height)
			.alignmentGuide(.leading) { _ in 0 }
	}
)
```
**TextMask 효과**
```swift
LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)
    .frame(width: 300, height: 100)
    .mask(
        Text("JOID")
            .font(.system(size: 64, weight: .bold))
    )
```
## **Keywords**

- [[mask modifier]]
- [[SwiftUI masking]]
- [[CALayer.mask (UIKit)]]

---

## **References**

- [Apple Documentation - View.mask(alignment:_:)](https://developer.apple.com/documentation/swiftui/view/mask(alignment:_:))
- [Apple Documentation - View.mask(_:)](https://developer.apple.com/documentation/swiftui/view/mask(_:))