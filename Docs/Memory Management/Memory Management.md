>[!question]
>- [x] Swift에서 메모리 관리는 어떻게 하지?
# Description
Swift에서 메모리 관리는 다음과 같이 나눠진다.
1. 참조 타입의 메모리 관리: [[ARC]]
2. 값 타입의 메모리 관리: [[COW]]
# 참조 타입의 메모리 관리 - [[ARC]]
참조 타입은 ARC를 활용하여 메모리 관리를 한다.
참조 타입은 Heap에 저장되고, ARC가 자동으로 메모리 관리를 한다.
복사를 한다면 값이 복사되지 않고 같은 인스턴스를 공유한다. 이를 얕은 복사라고 한다.
같은 객체를 여러 변수에서 공유할 수 있다. 즉, 참조 타입이라는 것이다.
하지만, [[Retain Cycle]](순환 참조)를 방지해야 할 필요가 있다.
# 값 타입의 메모리 관리 - [[COW]]
값 타입의 메모리 관리는 [[COW]]와 큰 관련이 있다.
값 타입은 주로 Stack에 저장이 된다. 
복사를 한다면 값이 복사가 된다. 이를 깊은 복사라고 한다.
성능이 좋고, 안정성이 높다.
[[COW]]는 Siwft의 표준 라이브러리 값 타입(Array, String, Dictionary, Set)에 자동으로 적용된다.
나머지는 COW가 아닌 그냥 값 타입에 저장된다고 보면 된다.
# Keywords
- [[ARC]]
- [[Process Memory Layout]]
- [[Memory Leak]]
# References
- 
