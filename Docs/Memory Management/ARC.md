>[!question]
>- [x] ARC는 뭐지?
# Description
ARC는 Automatic Reference Counting의 준말이다.
ARC는 참조 타입(class, actor)가 더이상 필요하지 않을 때 자동으로 메모리를 해제하는 시스템이다.
# 작동 원리
1. 참조 타입 인스턴스가 생성되면 참조 횟수가 +1이 된다.
2. 다른 곳에서 해당 인스턴스를 참조하면 +1이 된다.
3. 참조가 사라지면 -1이 된다.
4. 참조 횟수가 0이 되면 메모리가 해제 된다. (deinit 호출)

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is initialized")
    }
    deinit {
        print("\(name) is deinitialized")
    }
}

var a: Person? = Person(name: "Miru") // +1
var b = a                              // +1 → 총 2
a = nil                                // -1 → 1 남음
b = nil                                // -1 → 0 → 메모리 해제
```
### 장점
장점으로는 참조 횟수 기반으로 하여 빠르고 예측이 가능하다.
### 단점
ARC의 문제는 [[Memory Leak]]을 야기하는 [[Retain Cycle]](순환 참조)가 있다. 
해결 방법으로는 [[weak]]와 [[unowned]]가 있다. 둘 다 참조를 약하게 하여 순환되는 문제를 해결한 것이다. 이러한 것들은 참조 방식을 지정해주는 것이다.

# Keywords
- [[Memory Leak]]
- [[Retain Cycle]]
- [[strong]]
- [[weak]]
- [[unonwed]]
# References
- 
