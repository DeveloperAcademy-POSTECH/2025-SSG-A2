>[!question]
 GQ1. for-in이란?
 GQ2. foreach와의 차이점
 
## GQ1. for-in이란?

#### Description
반복문.
원래 C 스타일의 For을 사용했으나 안전성, 성능, 함수형 프로그래밍 지원을 위해 현재의 형태인 for-in으로 전환
```swift
for (int i = 0; i < 5; i++) {// C style
    printf("%d\n", i);
}

for i in 0..<5 {// swift style
    print(i)
}
```

##### break와 continue

`break` 문은 조건이 충족되었을 때 루프를 완전히 종료시키며, `continue` 문은 현재 반복을 건너뛰고 다음 반복으로 진행

``` swift
// break 예시: 3에서 루프 종료
for num in 1...5 {
    if num == 3 {
        break  // 루프 즉시 종료
    }
    print(num)  // 1, 2 출력
}

// continue 예시: 3만 건너뜀
for num in 1...5 {
    if num == 3 {
        continue  // 현재 반복 건너뛰기
    }
    print(num)  // 1, 2, 4, 5 출력
}

// while문에서의 break
var count = 0
while count < 5 {
    count += 1
    if count == 3 { break }  // 3에서 종료
    print(count)  // 1, 2 출력
}

// while문에서의 continue
var index = 0
while index < 5 {
    index += 1
    if index == 3 { continue }  // 3 건너뜀
    print(index)  // 1, 2, 4, 5 출력
}
```

##### where
where 절의 구문은 `for element in collection where condition`의 형태
반복문이나 패턴 안에서 특정 조건(collection)을 만족하는 경우만 실행하고 싶을 때 사용한다.

xcode예시 참고

##### _ in을 사용하면 메모리를 절약?
- 절약 안됨. 사실 되는데 체감 불가능한 수준
- 값을 쓰지 않는다는 명확한 표현을 위해 사용

## GQ2. foreach와의 차이점

#### Description
| 특징          | For-In 루프            | ForEach 메서드                                                                                                                                                 |
| ----------- | -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 제어 흐름 문 지원  | break/continue 가능    | 지원 불가[4](https://velog.io/@un1945/Swift-for-in-forEach-%EC%B0%A8%EC%9D%B4%EC%A0%90)[15](https://agrawalsuneet.github.io/blogs/for-in-vs-for-each-in-swift/) |
| 반복 중단 메커니즘  | 즉시 루프 종료             | 클로저 단위 반환만 가능                                                                                                                                               |
| 성능 프로파일     | 컴파일러 최적화 용이          | 클로저 오버헤드 존재[11](https://stackoverflow.com/questions/45333177/when-to-use-foreach-instead-of-for-in)                                                         |
| 디버깅 가시성     | 호출 스택 직접 추적 가능       | 클로저 내부에서 추적 필요                                                                                                                                              |
| where 절 필터링 | `where condition` 지원 | filter 체인으로 대체                                                                                                                                              |
xcode예시 참고

올리버의 조언 : for문과 관련해서 Iterable 어쩌구 저쩌구
그래서 다음에는 Iterable을 알아보겠습니다
## Keywords
- [[for-in]]
- [Foreach]
- [while]

## References
- [공식문서](https://bbiguduk.gitbook.io/swift/language-reference/statements#for-in-for-in-statement)
- perplexcity, chatgpt
