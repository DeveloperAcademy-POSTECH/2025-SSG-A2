>[!question]
>- [x] unowned는 무엇이지?
>- [x] unowned는 언제 사용하지?
>- [x] unowned와 weak의 차이는 무엇이지?
# Description
unowned는 weak처럼 순환 참조를 방지하는 방법이다.
### [[weak]]와 unowned의 차이
하지만 unowned는 절대 nil이 되지 않는다고 확신할 때 사용된다.
[[weak]]는 nil이 되었을 때도 상정하고 사용한다.
# 사용 방법

아래와 같이 사용할 수 있다.
Dog의 인스턴스는 선언되지 않았으므로, 따로 Dog이 Person에 접근할 일은 없다.
그러므로 Person이 사라지면 Dog도 사라진다고 볼 수 있다.
만약 여기서 Dog이 Person보다 오래 살아남고 Person에 접근하게 되면 앱 크래시가 난다.
```swift
class Person {
    var dog: Dog!

    init() {
        dog = Dog(owner: self)
    }

    deinit {
        print("👋 Person 해제됨")
    }
}

class Dog {
    unowned let owner: Person

    init(owner: Person) {
        self.owner = owner
    }

    deinit {
        print("🐶 Dog 해제됨")
    }
}

var person: Person? = Person()
person = nil
```

# Keywords
- [[weak]]
- [[deinit]]
# References
- 
