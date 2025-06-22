>[!question]
>
>GQ1. Preview를 편하게 사용하는 방법이 없을까?  
>
>GQ2. Preview가 안되는건 왜 그런걸까?


## Description
- Preview는 안드로이드 스튜디오와 비교해서 불편함이 많음. @Environment, Modalcontext등을 모두 수동으로 지정해야하고, 속도도 느리기 때문
- 실시간으로 반영되지 않음. 느림.
- 디버깅 불가능(breakpoint가 작동하지 않는 경우 많음)
- 그럼에도 그나마 Preview를 편하게 사용하는 방법 2가지
- modelContainer를 Preview에 넣는 것과 Preview를 위한 뷰를 하나 만드는 것

## 주요 기능
- modelcontainer를 직접 Preview에 넣어 관리
- Preview를 위한 struct를 만들어 그것을 Preview에 넣어 관리

## 코드 예시
- 예시 코드 참조

## Keywords
- [[Preview]]
- [modelcontainer]
