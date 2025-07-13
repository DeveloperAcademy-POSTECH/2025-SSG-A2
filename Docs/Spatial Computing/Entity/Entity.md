>[!question]
>GQ1. Entity는 무엇인가?
>GQ2. Entity의 종류는 무엇이 있는가?

##  Description 
```swift
@MainActor @preconcurrency
class Entity
```
- Entity는 외관 및 행동 특성을 제공하는 구성 용소를 첨부하는 RealityKit의 가장 기본적인 객체 단위이다.
- 실제 세계에 AR 앱에서 배치하려는 개체를 구현하도록 Entity를 작성하고 구성한다.
<div align="center">
	<img src="entityStructure.png" width="70%">
</div>

##  Types
- Entity: 위치, 회전, 스타일을 가지는 기본적인 Entity
- [[Anchor Entity]]: [[Scene]] 안에 특정 기준접에 콘텐츠를 고정할 때 사용되는 Entity
- [[Model Entity]]: 3D mesh(모양), metrial(색상 및 질감), 물리적 속성 등을 가질 수 있는 Entity

<div align="center">
	<img src="entityTypes.png" width="70%">
</div>
<table>
  <thead>
    <tr>
      <th><strong>목적</strong></th>
      <th><strong>Entity 타입</strong></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>단순 3D 형상 출력</td>
      <td><code>ModelEntity</code></td>
    </tr>
    <tr>
      <td>캐릭터 애니메이션</td>
      <td><code>CharacterEntity</code></td>
    </tr>
    <tr>
      <td>오디오 재생</td>
      <td><code>AudioEntity</code></td>
    </tr>
    <tr>
      <td>조명 설정</td>
      <td><code>DirectionalLight</code>, <code>PointLight</code>, <code>SpotLight</code></td>
    </tr>
    <tr>
      <td>충돌 감지</td>
      <td><code>TriggerVolumeEntity</code></td>
    </tr>
    <tr>
      <td>입자 효과 (연기, 불꽃 등)</td>
      <td><code>ParticleEmitterEntity</code></td>
    </tr>
    <tr>
      <td>공간 기준점 / AR plane 고정</td>
      <td><code>AnchorEntity</code></td>
    </tr>
    <tr>
      <td>엔티티 그룹 또는 위치 조정용</td>
      <td><code>Entity</code> (기본형)</td>
    </tr>
  </tbody>
</table>


## 코드 예시
###### 부모-자식 계층 생성 시
```swift
let parent = Entity()
let child = ModelEntity(mesh: .generateSphere(radius: 0.1))
parent.addChild(child)
```
## Keywords
+ [[Anchor Entity]]
+ [[Model Entity]]

## References
- [Apple의 공식 문서](https://developer.apple.com/documentation/realitykit/entity)
- GPT