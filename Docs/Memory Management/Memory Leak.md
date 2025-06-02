>[!question]
>- [x] Memory Leak은 뭐지?
# Description
Memory Leak(메모리 누수)는 더이상 필요없는 메모리가 해제되지 않고 남아있는 현상이다.
이건 앱 성능을 떨어뜨리고 심한 경우에는 앱이 크래시되거나 메모리가 부족해진다.
# 발생하는 경우
Swift에서 Memory Leak이 발생하는 경우는 크게 두가지가 있다.
1. [[Retain Cycle]](순환 참조)
2. 클로저가 self를 강하게 캡쳐할 때

# Keywords
- [[Retain Cycle]]
# References
- 
