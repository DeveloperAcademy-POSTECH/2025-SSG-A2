>[!question]
>GQ1. SwiftUI에는 어떤 Navigation들이 존재하는가?
>GQ2. 이들의 생성 목적은 무엇인가?

## Description
- SwiftUI에 존재하는 Navigation는 
	[[NavigationStack]],
	[NavigationSplitView], [NavigationSplitViewVisibility], [NavigationSplitViewColumn],
	[NavigationBarItem], [SidebarRowSize], [TabView], [Tab], [TabRole], [TabSection],
	[HSplitView], [VSplitView],  
	
	[[NavigationView]] (Deprecated), [NavigationViewStyle] (Deprecated)
	등이 있다.

## 웹과 앱의 차이
- 웹에서는 페이지 전환이 URL로 이뤄짐(Router을 사용)
- 앱은 URL이 아닌 View로 통해 이동. 이는 ***"사용성 + 구조적 효율성"*** 때문. 
	- UX를 고려했을 경우 정보나 화면을 한 단계씩 들어가고 빠져나가는 방식으로 기억
	- 이 구조를 구현하기 가장 직관적인 구조가 Stack 구조
	- 기기 화면이 작기 때문에 하나의 화면에 집중하기 위해서 View가 하나의 단위가 됨
	- 웹과 같이 URL 기반 탐색을 흉내낼 수 있지만, 복잡하고 사용성이 좋지 못함.


## Navigation 종류와 목적
| **종류**              | **목적**               | **사용성**                      | **대표 예시**      |
| ------------------- | -------------------- | ---------------------------- | -------------- |
| [[NavigationStack]] | **단계적 탐색 (깊게 들어가기)** | 화면 간 위계 구조 표현                | 홈 → 상세 → 더보기   |
| TabView             | **카테고리 전환 (수평 이동)**  | 동등한 정보 간 빠른 전환               | 홈 / 검색 / 마이페이지 |
| Sheet (모달)          | **일시적 동작/확인**        | 현재 맥락 위에 덮는 화면               | 글쓰기 / 로그인 팝업   |
| FullScreenCover     | **새로운 흐름 진입**        | 완전 다른 흐름 시작                  | 온보딩 / 인증       |
| NavigationSplitView | **대화면 대응**           | iPad, Mac에서 master-detail 구조 | 메일 목록 ↔ 본문     |
| Popover             | **보조 정보 표시**         | 특정 요소에 연결된 팁                 | 캘린더 날짜 세부 설명   |


## 주요 기능
- Navigation은 사용자가 앱의 뷰 계층 구조의 여러 부분 사이를 장면 내에서 이동할 수 있도록 한다.


## References
- GPT
- [Apple 공식 문서](https://developer.apple.com/documentation/swiftui/navigation)