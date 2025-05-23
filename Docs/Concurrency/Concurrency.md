>[!question]
>GQ1. 비동기 작업이란 무엇인가?
>GQ2. 비동기 작업의 특징은 무엇일까?
>GQ3. Swift에서는 비동기 작업을 어떻게 처리할까?
>GQ4. `async/await`을 어떻게 사용할까?
>GQ5. `Task`를 어떻게 사용할까?
>GQ6. `actor`를 어떻게 사용할까?

## Description

Swift는 구조화된 방식으로 비동기 코드와 병렬 코드를 작성할 수있다.

### 비동기 작업

- 특정 작업이 완료될 때까지 기다리지 않고 다른 작업을 수행할 수 있는 프로그래밍 패러다임
- 프로그램이 특정 작업을 동기적으로 처리하지 않고, 해당 작업이 완료될 때까지 기다리지 않고 다른 작업을 수행할 수 있다.
- 주로 I/O 작업, 네트워크 통신, 데이터베이스 조회와 같이 시간이 소요되는 작업을 효율적으로 처리하기 위해 사용된다.

### 비동기 작업의 특징

#### 장점

1. 실행중인 작업이 완료되지 않아도 다음 작업을 실행한다.
2. 여러 작업을 동시에 처리할 수 있다.
3. 더 적은 리소스로 많은 작업을 관리할 수 있다.
#### 단점

1. 작업의 실행 순서를 보장할 수 없다.
2. 코드가 복잡하여 디버깅하기 어렵다.
3. 오류 처리에 더 주의가 필요하다.

## 주요 기능

### Swift Concurrency

Swift 5.5부터 사용할 수 있다.

- **[[async-await]]**: 비동기 함수를 동기적으로 보이게 하는 문법
- **[[Task]]**: 비동기 작업의 단위
- **[[Actor]]**: 데이터 경합을 방지하는 새로운 타입
- **TaskGroup**: 여러 비동기 작업을 그룹으로 관리

## 코드 예시

```swift
actor BankAccount {
    private var balance: Double = 0
    
    func deposit(amount: Double) {
        balance += amount
    }
    
    func withdraw(amount: Double) -> Bool {
        if balance >= amount {
            balance -= amount
            return true
        }
        return false
    }
    
    func getBalance() -> Double {
        return balance
    }
}

// 사용
let account = BankAccount()
await account.deposit(amount: 100)
let success = await account.withdraw(amount: 50)
let currentBalance = await account.getBalance()
```

## Keywords

- [[async-await]]
- [[Task]]
- [[Actor]]

## References

- [Concurrency | Swift Documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/)
- [Concurrency | Apple Developer Documentation](https://developer.apple.com/documentation/swift/concurrency)