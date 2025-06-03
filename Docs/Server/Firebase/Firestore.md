>[!question]
>GQ1. Firestore SDK가 무엇인지?
>GQ2. Firestore 가격 정책이 무엇인지?

## Description
- FireStore SDK
	- FireStore SDK(Software Development Kit)란 Cloud FireStore에 접근할 수 있도록 도와주는 라이브러리 모음이다. 이를 통해서 다양한 언어에서 쉽게 FireStore에 접근에 정보를 CRUD 할수 있게 해준다.(HTTP API 없이도 접근을 할 수 있게 해준다.)
	- query를 통해서 데이터를 받아올 수 있다.
	- 실시간 업데이트 역시 진행된다. 이는 onSnapshot이라는 기능을 통해서 데이터가 변경될때 자동으로 콜백이 실행되는 것이다.(Websocket 구현 없이 실시간 채팅 기능이 가능한 이유)
		- 이를 사용하기 위해서는 .addSnapshotListener() 와 같은 함수를 사용하게 된다.
		- 이는 자동으로 Websocket을 유지하는 것과 동일하기에 너무 많은 리스너가 실행되면 메모리/베터리상 문제가 발생 할 수 있다.

- Firestore 가격은 각 리전에 따라 다르게 측정된다. 문서의 CRUD, 복원 등에 다른 가격이 측정된다. 

![[datastore_price.png]]


## References
- [Firestore 공식문서](https://firebase.google.com/docs/firestore/pricing?hl=ko)
