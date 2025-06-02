### Tags
#작성완료

>[!question]
>- [x] Retain Cycle이 뭐지?
>- [x] Retain Cycle은 언제 발생할까?
>- [x] Retain Cycle을 발생하지 않게 만드는 방법은 무엇일까?
# Description
Retain Cycle(순환 참조)는 [[Memory Leak]]의 한 원인이 되는 현상이다. 이는 객체들이 서로 강하게 참조할 때 발생한다. 서로를 놓지 않아서 [[ARC]]가 메모리를 해제하지 못하게 된다.

아래와 같이 서로를 강하게 참조하는 경우가 Retain Cycle로 인해 Memory Leak이 발생한다고 볼 수 있다.
```swift
class Person {
    var pet: Dog?
}

class Dog {
    var owner: Person?
}

var john = Person()
var puppy = Dog()

john.pet = puppy
puppy.owner = john // 서로를 강하게 참조!
```

이를 해결하는 방법으로는 [[weak]]과 [[unowned]]가 있다. 이러한 것들은 참조 방식을 지정해주는 것이다.

# Keywords
- [[weak]]
- [[unowned]]
# References
- 
****