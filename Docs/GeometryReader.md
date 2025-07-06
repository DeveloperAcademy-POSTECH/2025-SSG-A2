>[!question]
>GQ1. GeometryReader란 무엇일까
>GQ2. GeometryReader는 어떻게 사용하고 어디에 사용될까?

## GeometryReader
- GeometryReader는 SwiftUI에서 제공하는 뷰 중 하나로, 부모 뷰가 자식 뷰에 대한 크기와 위치를 결정하는 방법을 제어할 수 있다.
- 자식 뷰의 위치, 크기 및 방향을 결정하는데 사용된다. 
```swift
GeometryReader { geometry in 
	// Geometry 객체를 사용하여 자식 뷰의 위치, 크기 및 방향을 결정합니다.
}
```
- Geometry 객체는 부모 뷰의 크기, 위치, 안전 영역 및 레이아웃 가이드와 같은 정보를 포함한다.
- 예시) 뷰의 가운데에 원 배치하기
```swift
GeometryReader { geometry in 
	Circle() 
		.frame(width: geometry.size.width / 2, height: geometry.size.width / 2) 
		.position(x: geometry.size.width / 2, y: geometry.size.height / 2) }
```
## GeometryProxy
- GeometryReader 클로저 내뷰에서 생성
- GeometryReader보다 더 자세한 레이아웃 제공
```swift
GeometryReader { geometry in
	Rectangle()
		.foregroundColor(.red)
		.frame(width: geometry.size.width / 2,
			   height: geometry.size.width / 2)
		.position(x: geometry.size.width / 2, y: geometry.size.height / 2)
		
	Circle()
		.foregroundColor(.blue)
		.frame(width: geometry.size.width / 4, height: geometry.size.width / 4)
		.position(x: geometry.safeAreaInsets.leading + geometry.size.width / 8,
				  y: geometry.safeAreaInsets.top  + geometry.size.width / 8)
}
```
- GeometryProxy에서 제공되는 안전 영역 정보를 사용해 Circle 뷰를 안전 영역 좌측 상단에 배치
- 부모 뷰의 크기, 레이아웃 가이드 및 좌표 공간 변환 정보도 제공한다.

## Alignment
- Geometry 객체와 함께 사용해 뷰의 위치를 정렬하는데 사용된다.
```swift
GeometryReader { geometry in 
	VStack(alignment: .leading) { 
		Text("Hello, World!") 
			.frame(width: geometry.size.width, height: geometry.size.height / 2) 
		Spacer() 
		
		Text("This is SwiftUI Geometry") 
			.frame(width: geometry.size.width, height: geometry.size.height / 2) 
	} 
}
```

## References
- [블로그](https://bulmang-ios.tistory.com/53)
- [공식 문서](https://developer.apple.com/documentation/swiftui/geometryreader)