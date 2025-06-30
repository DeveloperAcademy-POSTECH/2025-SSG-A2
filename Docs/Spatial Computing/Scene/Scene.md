>[!question]
> GQ1. Scene이란 무엇인가?
> GQ2. Scene에는 어떤 종류가 있는가?

## Description
- Apple에서 ***"앱이 사용자와 상호작용하는 단위"*** 를 Scene이라 부른다.
- Scene의 종류에는 [[Window]] Scene, [[Volume]] Scene, [[Immersive]] Scene 이라 부른다.
	- window: 2D에서 보는 창
    - Volumes: 3D공간의 일부
    - Space: 3D공간 전체

| **공간 개념**           | **SwiftUI에서 사용하는 방식**                                     | **설명**                                   |
| ------------------- | --------------------------------------------------------- | ---------------------------------------- |
| **Window**          | WindowGroup { ... }                                       | 2D UI를 floating window 형태로 띄움 (전통적 앱 느낌) |
| **Volume**          | VolumeView { ... } 또는 WindowGroup(…) { VolumeView { … } } | 3D 공간 안에 상호작용 가능한 오브젝트(뷰)를 배치            |
| **Immersive Space** | ImmersiveSpace(id: …) + .immersiveSpace(…)                | 완전히 몰입된 공간, 사용자가 ‘들어가는’ 3D 세계            |


<div align="center">
	<img src="Scene.png" width="50%">
</div>


## Keywords
+ [[Window]]
+ [[Volume]]
+ [[Immersive]]

## References
- [Apple의 공식 문서](https://developer.apple.com/visionos/get-started/?utm_source=chatgpt.com)
- ChatGPT