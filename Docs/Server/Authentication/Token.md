>[!question]
>GQ1. 토큰은 무엇인가?
>GQ2. 토큰의 종류는 무엇인 있는가?

## Description
- 토큰은 인증된 사용자를 식별하거나 권한을 부여하기 위해 서버가 발급한 문자열 데이터이다.
- 클라이언트는 토큰을 검증하여 요청한 사용자가 누구인지 권한이 있는지 판단.
- 서버는 토큰을 검증하여 요청한 사용자가 누구인지, 권한이 있는지를 판단.
- **stateless(비상태)** 한 인증 시스템에서 사용
	- 서버가 클라이언트의 상태를 저장하지 않는 구조. 


## 주요 기능(JWT의 경우)
+ 인증에 필요한 정보들을 암호화 시킨 JSON 토큰(Base64Url을 통해 인코딩하여 직렬화). HTTP요청 시 header에 실어 서버가 클라이언트를 식별. 이때 사용자 ID, 만료 시간 등을 저장.
<div style="text-align: center;">
  <img src="jwt.png" width="600" />
</div>
+ 크기가 큼. 만료시간 이전까지 서버가 발급한 토큰을 취소할 수 없음.

## 코드 예시

```cmd
GET /api/user/profile HTTP/1.1
Host: example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```


## Keywords
+ JWT
+ session
+ token

## References
- [블로그](https://inpa.tistory.com/entry/WEB-%F0%9F%93%9A-JWTjson-web-token-%EB%9E%80-%F0%9F%92%AF-%EC%A0%95%EB%A6%AC#token_%EC%9D%B8%EC%A6%9D)
- GPT