

>[!question]
>- [x] computed property는 뭐지?
>- [x] 왜 사용하지?
>- [x] getter와 setter는 뭐지?
# Description
computed property(연산 속성)은 실제 값을 저장하지 않고, 계산을 통해 값을 반환하거나 설정하는 속성이다.
[[get & set]]을 활용하여 값을 읽고 설정할 때 커스텀을 할 수 있다.

### 사용 이유
- 계산된 값을 배번 자동으로 줄 때
- 값 저장 없이 읽고 쓰느느 로직을 넣고 싶을 때

### 코드 예시
아래 코드에서 area는 값을 저장하지 않는다.
매번 width * height를 계산해서 반환한다.
```swift
struct Rectangle {
	var width: Double
	var height: Double

	var area: Double {
		return width * height
	}
}
```

# Keywords
- [[get & set]]
# References
- 
