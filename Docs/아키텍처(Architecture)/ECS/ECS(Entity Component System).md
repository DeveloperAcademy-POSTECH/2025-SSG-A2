>[!question]
>GQ1. ECS는 무엇인가
>GQ2. ECS를 언제 사용하는가?

## Description
- ECS는 3D 콘텐츠를 만들고 관리하기 위한 프레임워크이다.
- Entity Component System으로 
	- Entity는 3D 세계의 기본 객체 단위이다.(계층 구조를 가질 수 있고, 비어있는 컨테이너로 시작하여 컴포넌트를 추가하여 기능 확장이 가능)
	- Component는 Entity에 부착되어 특정 기능이나 데이터를 제공하는 재사용 가능한 독립적인 기능 단위이다.
	- System은 Component를 가진 Entity를 처리하는 로직이다. 메 프레임마다 실행되면 상태를 업데이트 한다. 특정 컴포넌트를 가진 엔티티만 선택적으로 처리하게 한다.
- 아키텍처 구조: App, Views, Extensions, Systems, Resources
	- App(앱 계층: 기본 구성 및 설정)
		- 앱의 진입점, SwiftUI Scene 정의, 앱 아이콘 및 이미지 리소스, 앱구성 정보
	- Views(프레젠테이션 계층: UI/UX 구현)
		- 메인 UI 및 Immersive Space 진입점. 뷰 정의
	- Extension(확장 계층: 기능 확장 및 재사용)
		- 3D 모델 로딩, 효과 등등 추가
	- System(시스템 계층: ECS 패턴의 핵심)
		- 컴포넌트 및 로직 작성
		- Compoonent, System, Entity 로직 구현
	- Resources(리소스 계층: 외부 리소스 관리)
		- 3D 모델 파일 등 리소스 정의

```
App Layer
    ↓
Views Layer ←→ Extensions Layer
    ↓
Systems Layer
    ↓
Resources Layer
```


## 코드 예시
```swift
let rootEntity = Entity()
rootEntity.position.y += avgHeight  // 위치 조정
rootEntity.addChild(childEntity)    // 자식 엔티티 추가
```

## Keywords
+ [Entity]
+ [Component]
+ [System]

## References
- [Unity ECS](https://docs.unity3d.com/Packages/com.unity.entities@0.1/manual/ecs_core.html)
- GPT