>[!question]
>- [x] CaseIterable은 뭐지?
>- [x] CaseIterable은 어떻게 쓰는거지?
# Description
CaseIterable은 Swift에서 enum의 모든 case를 배열로 가져올 수 있게 해주는 프로토콜이다.

아래와 같이 사용한다.
```swift
enum Direction: CaseIterable {
	case north, south, east, west
}

for dir in Direction.allCases {
	print(dir)
}
```

### 왜 쓰는가?
- Picker, ForEach에서 enum을 반복할 때 사용한다.
- 모든 케이스를 한 번에 다루고 싶을 때 유용하다.
# Keywords
- [[enum]]
# References
- 
