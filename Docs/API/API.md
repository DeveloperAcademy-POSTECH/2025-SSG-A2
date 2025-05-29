>[!question]
>>GQ1. API란?
>>GQ2. Swift에서의 API는 다른 점이 있는가?
>>GQ3. API는 어떻게 활용하고, 유용하거나 자주 쓰이는 것이 있나?

## API란?
- API(Application Programming Interface)는 결국 인터페이스다. UI가 사용자와 기기간의 인터페이스인 것처럼 서버와 어플리케이션 사이의 인터페이스이다. 인터페이스의 핵심은 내부 사정을 모르는 데에 있음. 그냥 API에 요청하면 띡 나오는 거임.
![[API 설명 이미지.png]]

## Swift API Design Guidelines
##### 1. 사용 지점 명확성(Clarity at Point of Use)
``` swift
// 좋은 예: 컨텍스트 명확
x.removeBoxes(havingLength: 12)
employees.remove(at: x)

// 나쁜 예: 맥락 불분명
x.remove(12)
employees.remove(x)
```

##### 2. 명확성 > 간결성(Clarity Over Brevity)
```swift
// 권장: 의미 전달 명확
extension List {
    mutating func prepend(_ newHead: Element)
}

// 비권장: 과도한 축약
extension List {
    mutating func ⬆️(_ e: Element)
}
```

##### 3. 문서화 주석 의무화
```swift
/// `self` 시작 부분에 `newHead` 삽입
/// - Parameter newHead: 추가할 요소
/// - Complexity: O(1)
mutating func prepend(_ newHead: Element)

}
```

이 문서에서는 API를 코드안에서의 인터페이스, 코드간의 인터페이스 정도로 좁은 범위로 보는 듯함.
## URLSession
IOS에서 서버와 통신하기 위해 애플에서 제공하는 API.
보통 URLSession을 추상화한 Alamofire, Moya를 많이 사용하는데, 둘 다 URLSession을 기반으로 동작하는 것이라 URLSession을 알기는 해야한다.

configuration이라는 객체를 기본으로 가지고 있음.
행동과 규칙을 정의하는 객체임.
.default, .ephemeral, .background 3가지 종류임.

1  기본 세션 : **URLSession(configuration: .default)**
- 디스크에 기록함 (캐시, 쿠키, 자격 증명)
- delegate 지정 가능 (순차적으로 데이터 처리)

2  임시 세션 : **URLSession(configuration: .ephemeral)**
- 디스크에 데이터를 쓰지 않음(캐시, 쿠키, 인증 등)
- 메모리에 올려서 세션을 연결하고, 세션 만료 시 데이터 사라짐 -> 비공개 세션이라고 생각하면 됨

3 백그라운드 세션 : **URLSession(configuration: .background)**
- 백그라운드에서 업로드, 다운로드가 가능함
- 별도의 프로세스가 모든 데이터 전송을 처리 (앱이 중지되거나 종료되어도 계속함)

- **URLSession**: 실제 네트워크 통신을 담당하는 객체

- **URLSessionTask**: 각각의 네트워크 작업을 의미
    
    - **DataTask**: 데이터(예: JSON) 주고받기
    - **DownloadTask**: 파일 다운로드
    - **UploadTask**: 파일 업로드

```swift
// 1. URL 생성
guard let url = URL(string: "https://api.example.com/data") else { return }

// 2. URLSession 생성 (기본 설정)
let session = URLSession(configuration: .default)

// 3. DataTask 생성 및 실행
let task = session.dataTask(with: url) { data, response, error in
    if let error = error {
        print("오류 발생: \(error)")
        return
    }
    guard let data = data else {
        print("데이터 없음")
        return
    }
    // JSON 파싱 예시
    do {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        print("받은 데이터: \(json)")
    } catch {
        print("JSON 파싱 오류: \(error)")
    }
}
// 4. Task 시작
task.resume()
```

## Keywords
- [[API]]

## References
- perplexity
- swift 공식문서
- https://tngusmiso.tistory.com/50
- https://d0ngurrrrrrr.tistory.com/159