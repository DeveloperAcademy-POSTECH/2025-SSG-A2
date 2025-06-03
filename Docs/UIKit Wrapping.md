## Description
### Definition
**UIKit Wrapping이란?**
- **SwiftUI에서 UIKit의 UIView나 UIViewController를 재사용할 수 있도록** 해주는 기술.
- SwiftUI가 아직 모든 UIKit 기능을 지원하지 않기 때문에, 기존 UIKit 컴포넌트를 SwiftUI에서 활용하기 위해 사용된다.
- 이를 통해 레거시 UIKit 자원을 활용하거나 SwiftUI에서 구현이 어려운 기능을 재사용할 수 있다.
**UIViewRepresentable이란?**
- UIView 기반 컴포넌트를 SwiftUI에서 사용하도록 래핑할 때 사용하는 프로토콜이다.
- 필수 메서드인 makeUIView와 updateUIView를 구현해 UIKit 뷰 생성 및 업데이트 로직을 정의한다.
**UIViewControllerRepresentable이란?**
- UIViewController 기반 컴포넌트를 SwiftUI에서 사용하도록 래핑할 때 사용하는 프로토콜이다.
- 필수 메서드인 makeUIViewController, updateUIViewController를 통해 뷰컨트롤러를 생성하고 업데이트한다.
- 필요하면 Coordinator를 만들어 delegate, target-action 같은 UIKit 인터랙션도 처리할 수 있다.

## 주요 기능
 **기존 UIKit 재사용**
- SwiftUI에서 아직 직접 지원하지 않는 고급 기능들을 UIKit 컴포넌트를 통해 사용할 수 있다.
- 예: Core Animation, PencilKit 등
**복잡한 인터랙션 처리 가능**
- makeCoordinator()를 통해 delegate 패턴이나 이벤트 콜백을 처리할 수 있어, SwiftUI의 @Binding이나 콜백 클로저로 연동 가능하다.
 **SwiftUI 생태계와 통합**
- 래핑된 컴포넌트도 SwiftUI 뷰 트리에 포함되어 .frame, .padding 등의 SwiftUI 수식어 사용이 가능하다.

#### 코드 예시

**UIViewRepresentable 예시**
```swift
struct JoidUIKitWrapper: UIViewRepresentable {
    var text: String

    func makeUIView(context: Context) -> UILabel {
        UILabel()
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
    }
}
```
**UIViewControllerRepresentable 예시**
```swift
import SwiftUI
import UIKit

class JoidViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

struct JoidYellowView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> JoidViewController {
    JoidViewController()
	}
	func updateUIViewController(_ uiViewController: JoidViewController, context: Context) {
	}
}
```
## **Keywords**
- [[UIViewRepresentable]]
- [[UIViewControllerRepresentable]]

## **References**
- [UIViewRepresentable 설명 블로그 (Hacking with Swift)](https://kka7.tistory.com/314i)
- ChatGPT