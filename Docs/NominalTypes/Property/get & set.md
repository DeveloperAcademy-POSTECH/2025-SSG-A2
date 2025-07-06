

>[!question]
>- [x] get과 set은 뭐지?
>- [x] 왜 사용하지?
# Description
swift에서 get과 set은 computed property에서 값을 읽고(get) 설정(set) 할 때 사용하는 키워드이다.

### 코드 예시
get은 값을 요청할 때 실행되며, set은 값을 변경할 때 실행된다.
newValue는 자동 제공되는 키워드이다. 새로 들어온 값을 의미한다.
```swift
var value: Int {
	get {
		// 값을 계산해서 반환
		return 10
	}
	set {
		// 새 값으로 처리
		print("새 값: \(newValue)")
	}
}
```

```swift
var celsius: Double = 0.0

var fahrenheit: Double {
	get { celsius * 9 / 5 + 32 }
	set { celsius = (newValue - 32) * 5 / 9 }
}
```
# Keywords
- 
# References
- 
