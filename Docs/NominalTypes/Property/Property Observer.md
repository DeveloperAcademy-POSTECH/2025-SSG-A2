

>[!question]
>- [x] Property Observer는 뭐지?
>- [x] 왜 사용하지?
# Description
Property Observer는 Stored Property의 값이 변경될 때 실행되는 코드이다.
- willSet: 값이 바뀌기 직전에 실행되며 새 값은 newValue로 접근할 수 있다.
- didSet: 값이 바뀐 직후 실행되며 이전 값은 oldValue로 접근할 수 있다.
### 코드 예시
```swift
var score Int = 0 {
	willSet {
		print("점수가 \(newValue)로 바뀔 예정!")
	}
	didSet {
		print("점수가 \(oldValue)에서 \(scroe)로 바뀜!")
	}
}

score = 10
// 출력:
// 점수가 10로 바뀔 예정!
// 점수가 0에서 10로 바뀜!
```

### 사용 예시
- UI 자동 업데이트 -> 값이 바뀔때 UI에 있는 값을 바꿔줄 때
```swift
var score = 0 {
	didSet {
		scoreLable.text = "\(score)"
	}
}
```
- 값 변경에 따라 메시지 출력
```swift
var level = 1 {
	didSet {
		if level > oldValue {
			print("Level UP!")
		}
	}
}
```
- 서버나 DB에 실시간 저장
```swift
var memo = "" {
	didSet {
		saveToDatabase(memo)
	}
}
```
# Keywords
- 
# References
- 
