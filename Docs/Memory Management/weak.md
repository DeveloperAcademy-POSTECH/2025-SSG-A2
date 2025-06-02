>[!question]
>- [x] weak는 뭐지?
>- [x] weak는 언제 사용하면 되지?
# Description
weak는 weak reference(약한 참조)를 만드는 키워드이다.
ARC에서 Retain Cycle(순환 참조)를 막기 위해 사용된다.
# 사용 방법
weak를 사용할 때는 무조건 [[Optional]]을 사용해준다.
그렇게 하면 객체가 강하게 참조되지 않으며 참조하고 있는 객체가 사라져도 메모리에서 해제되고 nil로 바뀐다.
```swift
class Person {
    var dog: Dog?
}

class Dog {
    weak var owner: Person? // 약한 참조
}

var john: Person? = Person()
var puppy: Dog? = Dog()

john?.dog = puppy // ?: john이 nil이 아닐 때에만 puppy를 할당하겠다는 말
puppy?.owner = john

john = nil  // Person 해제됨
puppy = nil // Dog도 해제됨
```

이렇듯 weak는 순환 참조를 피하고 싶을 때 사용하면 된다.
# Keywords
- [[Optional]]
# References
- 
