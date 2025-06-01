>[!question]
>GQ1. FireBase는 무엇인가?
>GQ2. FireBase를 어떻게 활용하면 좋은가?

## Description
- Firebase는 Google에서 제공하는 백엔드 서비스 플랫폼(Backend-as-a-Service,BaaS)이다. 이를 통해 복잡한 서버 구축 없이도 빠르게 앱을 개발하고 배포할 수 있다. 특히 모바일 앱, 웹 앱, 게임 개발 등에 적합하다.

## 주요 기능 및 서비스
+ Firebase Authentication
	- 이메일/비밀번호, 전화번호, Google, Facebook, GitHub 등 다양한 방법으로 **사용자 인증**을 처리.
	- 간단한 설정으로 OAuth 로그인 구현 가능.
	- 토큰 기반 인증으로 **보안**도 기본 제공.

- **Cloud Firestore**
	- Firebase에서 제공하는 **NoSQL 클라우드 데이터베이스**.
	- 실시간 동기화 지원 → 여러 사용자의 데이터가 즉시 반영됨.
	- 유연한 데이터 구조와 강력한 쿼리 지원.
	- 모바일, 웹, 서버 환경에서 모두 사용 가능.

- **Realtime Database**
	- Cloud Firestore 이전에 제공된 실시간 데이터베이스.
	- 트리 구조의 데이터 저장 방식.
	- 실시간 데이터 변경 감지가 필요할 때 사용.
	- Firestore보다 구조가 단순하지만, 복잡한 쿼리는 어려움.

- **Cloud Functions**
	- Firebase의 서버리스 백엔드 기능.
	- 특정 이벤트(예: 사용자 생성, Firestore 데이터 변경 등)에 반응하는 **JavaScript 함수**를 작성.
	- 서버 없이도 **백엔드 로직을 실행**할 수 있음.

-  **Firebase Hosting**
	- 정적 웹 사이트 및 SPA(React, Vue 등) 배포 가능.
	- 글로벌 CDN 제공 → 빠른 로딩 속도.
	- 커스텀 도메인, HTTPS, GitHub CI/CD 연동 등 지원.

-  **Cloud Storage**
	- 이미지, 동영상, 파일 등 **대용량 파일 저장**.
	- Firebase Authentication과 연동하여 접근 권한 제어 가능.


## Keywords
+ [Server]
+ [[Firestore]]

## References
- [파이어베이스 문서](https://firebase.google.com/docs/projects/learn-more?hl=ko)
- GPT