>[!question]
>
>GQ1. modelcontainer는 무엇일까?
>
>GQ2. 어떤 원리로 작동할까?


## Description

## 주요 기능
### 제1장: `ModelContainer`의 본질: 개념과 작동 원리

`ModelContainer`를 이해하는 것은 SwiftData 프레임워크 전체를 관통하는 핵심 철학을 이해하는 것과 같습니다. 이 장에서는 `ModelContainer`의 정확한 정의를 살펴보고, SwiftData 스택 내에서 다른 핵심 구성 요소들과 어떻게 유기적으로 상호작용하며 작동하는지 그 원리를 심층적으로 분석합니다.

#### 1.1. `ModelContainer`란 무엇인가?: 앱의 스키마와 저장소 구성 관리자

Apple의 공식 문서에 따르면, `ModelContainer`는 "앱의 스키마(schema)와 모델 저장소 구성(model storage configuration)을 관리하는 객체"로 정의됩니다. 이 정의는 `ModelContainer`의 두 가지 핵심 역할을 명확히 보여줍니다. 

첫째, 어떤 종류의 데이터를 어떻게 저장할지에 대한 구조적 청사진인 '스키마'를 관리합니다. 
둘째, 그 데이터가 실제로 어디에(예: 디스크, 메모리, iCloud), 어떤 방식으로(예: 읽기/쓰기, 읽기 전용) 저장될지를 결정하는 '저장소 구성'을 관리합니다.

#### 1.2. SwiftData 스택의 삼위일체: `Schema`, `ModelContainer`, `ModelContext`의 유기적 관계

SwiftData의 강력함은 `Schema`, `ModelContainer`, `ModelContext`라는 세 가지 핵심 요소의 유기적인 협력에서 비롯됩니다. 이들의 관계를 이해하는 것은 SwiftData의 작동 방식을 이해하는 데 필수적입니다.

- **`Schema` (청사진):** 스키마는 데이터의 구조를 정의하는 청사진입니다. SwiftData에서는 `@Model` 매크로를 Swift 클래스에 적용하는 것만으로 스키마가 정의됩니다. 이 클래스의 프로퍼티는 데이터베이스 테이블의 컬럼이 되고, 다른 `@Model` 클래스와의 관계는 데이터베이스의 관계(relationship)로 변환됩니다. 즉, 개발자는 Swift 코드를 작성하는 것만으로 데이터베이스의 구조를 설계하게 됩니다.   
    
- **`ModelContainer` (건축가 및 관리자):** `ModelContainer`는 `Schema`라는 청사진을 받아 실제 데이터베이스를 구축하고 관리하는 총책임자입니다. 컨테이너는 스키마를 분석하여 기본적으로 SQLite 데이터베이스 파일을 생성하고, 디스크에 데이터를 읽고 쓰는 모든 I/O 작업을 총괄합니다. 더 나아가 iCloud 동기화 설정이 감지되면 데이터 동기화 과정까지 자동으로 처리하는 중재자 역할을 수행합니다.   
    
- **`ModelContext` (작업 공간):** `ModelContext`는 데이터 작업을 위한 임시 작업 공간, 즉 '스크래치 패드(scratch pad)' 또는 '작업대(workbench)'와 같습니다. 개발자는   
    
    `ModelContext`를 통해 데이터 객체(모델 인스턴스)를 가져오고(fetch), 생성(insert), 수정(update), 삭제(delete)합니다. `ModelContext`는 이러한 모든 변경 사항을 메모리 상에서 추적하고 있다가, `save()` 메서드가 호출되면 이 변경 사항들을 `ModelContainer`에 전달하여 영구 저장소에 최종적으로 반영하도록 요청합니다.   
    

이 세 요소의 상호작용은 매우 체계적입니다. 개발자가 `@Model`로 `Schema`를 정의하면, `ModelContainer`가 이 청사진을 바탕으로 데이터 저장소라는 '건물'을 짓습니다. 그리고 개발자는 `ModelContext`라는 '작업 공간' 안에서 데이터를 조작하고, 작업이 끝나면 `ModelContainer`에게 알려 '건물'에 영구적으로 기록하는 것입니다.

#### 1.3. 작동 원리: 모델 객체와 물리적 저장소(SQLite) 간의 중재

`ModelContainer`의 가장 중요한 작동 원리는 앱의 모델 객체와 물리적 저장소(기본적으로 SQLite 데이터베이스) 사이에서 '중재자(mediator)' 역할을 수행하는 것입니다. 이 중재 과정은 데이터의 일관성과 무결성을 보장하고, 앱의 리소스를 효율적으로 사용하기 위해 매우 중요합니다.   

예를 들어, SwiftUI 뷰에서 `@Query` 프로퍼티 래퍼를 사용하여 데이터를 요청하거나, 코드 내에서 `modelContext.save()`를 호출할 때, 실제로 디스크에 접근하여 SQL 쿼리를 실행하는 주체는 `ModelContainer`입니다. `ModelContext`는 단지 변경 사항을 추적하고 요청을 전달할 뿐입니다. `ModelContainer`는 전달받은 요청과 자신이 관리하는 `Schema` 정보를 바탕으로, 최적화된 읽기/쓰기 작업을 수행합니다. 이 과정은 효율적이고 조정된 방식으로(efficient and coordinated manner) 이루어져, 여러 스레드에서 동시에 데이터에 접근하더라도 충돌이 발생하지 않도록 보호하는 역할을 합니다.   

이러한 추상화 덕분에 개발자는 복잡한 SQLite 쿼리나 저수준의 파일 I/O에 대해 전혀 신경 쓸 필요가 없습니다.그저 Swift 객체를 다루듯이 모델을 조작하면,  `ModelContainer`가 나머지 모든 복잡한 과정을 알아서 처리해주는 것입니다. 이것이 바로 SwiftData가 제공하는 강력한 추상화의 핵심이며, 그 중심에는 `ModelContainer`가 있습니다.

결론적으로 `ModelContainer`는 단순한 데이터 저장소가 아니라, 데이터 영속성 계층의 '정책 결정자'이자 '실행자'입니다. 개발자가 `@Model`로 스키마를 선언하고 `ModelConfiguration`으로 정책(예: 저장 위치, 동기화 여부)을 설정하면, `ModelContainer`는 그 정책에 따라 영속성 환경 전체를 구축하고 운영하는 핵심 엔진 역할을 담당합니다. 이 개념을 명확히 이해하는 것이 SwiftData를 효과적으로 활용하기 위한 가장 중요한 첫걸음입니다.

## 코드 예시

`ModelContainer`를 애플리케이션에 통합하는 방법은 크게 두 가지로 나뉩니다.
1. SwiftUI와 긴밀하게 통합된 선언적 방식
2. 더 많은 제어권을 제공하는 프로그래밍 방식입니다. 
#### 2.1. SwiftUI를 위한 선언적 설정: `.modelContainer` 수식어 활용법

SwiftUI 애플리케이션에서 `ModelContainer`를 설정하는 가장 일반적이고 간결한 방법은 `.modelContainer` 뷰 수식어(modifier)를 사용하는 것입니다. 이 수식어를 앱의 최상위 뷰 계층, 주로   

`App` 프로토콜을 준수하는 구조체의 `WindowGroup`에 적용하면, 해당 뷰와 그 아래의 모든 자식 뷰들이 동일한 `ModelContainer` 인스턴스에 접근할 수 있게 됩니다.   

이 수식어의 핵심 역할은 두 가지입니다. 첫째, 지정된 모델 타입을 위한 `ModelContainer`를 생성하거나 기존 컨테이너를 설정합니다. 둘째, 생성된 컨테이너의 `mainContext`를 SwiftUI의 `Environment`에 주입합니다. 이렇게 주입된 `ModelContext`는 `@Query` 프로퍼티 래퍼가 데이터를 가져오기 위한 필수적인 소스로 사용됩니다. 즉, `@Query`가 마법처럼 동작할 수 있는 배경에는 `.modelContainer` 수식어의 역할이 있습니다.   

**기본 예제 (단일 모델):** 가장 간단한 형태는 단일 모델 타입을 지정하는 것입니다.

```swift
import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
       .modelContainer(for: ToDoItem.self) // ToDoItem 모델을 위한 컨테이너 설정
    }
}
```

**여러 모델 타입 등록 예제:** 앱에서 여러 모델을 사용하는 경우, 배열 형태로 모든 모델 타입을 전달할 수 있습니다.

```swift
import SwiftUI
import SwiftData

@main
struct TripsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
       .modelContainer(for:) // 여러 모델 타입 등록
    }
}
```

#### 2.2. 프로그래밍 방식의 유연한 초기화: `ModelContainer` 인스턴스 직접 생성

SwiftUI 환경 외부에서 `ModelContainer`를 사용해야 하거나, 여러 개의 저장소를 구성하는 등 더 복잡한 설정이 필요할 때는 `ModelContainer` 인스턴스를 직접 생성해야 합니다.   

`try ModelContainer(for:configurations:)` 초기화 구문을 사용하면, 스키마와 구성을 명시적으로 제어하며 컨테이너를 만들 수 있습니다.   

이렇게 프로그래밍 방식으로 생성된 컨테이너 인스턴스는 `.modelContainer()` 수식어에 직접 전달하여 SwiftUI 뷰 계층에 주입할 수 있습니다. 이 방식은 주로 앱의 시작점(`App` 구조체)에서 즉시 실행 클로저(immediately-executing closure)를 사용하여 `ModelContainer`를 초기화하고 저장 프로퍼티로 관리하는 패턴으로 구현됩니다.   

**예제 코드:**

```swift
import SwiftUI
import SwiftData

@main
struct TripsApp: App {
    // 즉시 실행 클로저를 사용하여 sharedModelContainer 프로퍼티를 초기화
    var sharedModelContainer: ModelContainer = {
        // 영속화할 모델들로 스키마를 정의
        let schema = Schema()
        // 스키마와 저장소 옵션을 포함하는 구성 객체 생성
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            // 정의된 스키마와 구성을 사용하여 ModelContainer 인스턴스를 생성
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // 컨테이너 생성 실패 시 앱을 종료하고 에러를 출력
            fatalError("Could not create ModelContainer: \(error)")
        }
    }() // 클로저를 즉시 실행

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // 직접 생성한 컨테이너를 뷰 계층에 주입
       .modelContainer(sharedModelContainer)
    }
}
```

#### 2.3. 모델 스키마 등록: 영속화할 타입 명시 및 관계 추론 메커니즘

`ModelContainer`를 설정할 때 영속화할 모델 타입을 명시하는 것은 매우 중요합니다. 컨테이너는 이 정보를 바탕으로 데이터베이스의 테이블과 관계를 포함하는 전체 스키마를 구축하기 때문입니다.   

여기서 SwiftData의 매우 강력하고 편리한 기능 중 하나인 **관계 추론(Relationship Inference)** 이 등장합니다. 만약 모델 클래스 간에 `@Relationship` 매크로를 통해 관계가 명확하게 정의되어 있다면, 모든 모델 타입을 일일이 나열할 필요가 없습니다. 관계의 시작점이 되는 루트(root) 모델만 컨테이너에 등록하면, SwiftData가 해당 모델의 관계를 재귀적으로 따라가며 연결된 모든 모델 타입을 자동으로 스키마에 포함시켜 줍니다.   

예를 들어, `Folder` 모델이 여러 개의 `Snippet` 모델을 포함하는 일대다(one-to-many) 관계를 가지고 있다면, 다음과 같이 `Folder`만 등록해도 충분합니다.

``` swift
.modelContainer(for: Folder.self)
```

SwiftData는 `Folder`의 `snippets` 프로퍼티가 `Snippet` 모델과의 관계임을 인지하고, `Snippet` 모델도 스키마에 자동으로 추가합니다. 이 기능은 모델 구조가 복잡해질수록 설정 코드를 간결하게 유지하는 데 큰 도움이 됩니다.

이처럼 SwiftData는 개발자에게 '선언적 편의성'과 '명령적 유연성' 사이의 현명한 균형점을 제공합니다. `.modelContainer(for:)` 수식어는 대부분의 일반적인 사용 사례를 위한 간결하고 직관적인 API를 제공하는 반면, `ModelContainer` 인스턴스를 직접 생성하는 방식은 위젯 연동, 다중 저장소, iCloud 고급 설정 등 복잡한 요구사항을 해결하기 위한 강력한 제어권을 부여합니다. 따라서 개발자는 프로젝트의 현재와 미래의 복잡성을 고려하여 적절한 초기화 전략을 선택해야 합니다. 이는 단순히 코드를 작성하는 것을 넘어, 프레임워크의 설계 의도를 파악하고 효과적으로 활용하는 전문가적 접근 방식의 시작입니다.

---

#### 제4장: `ModelContext`와의 상호작용 및 데이터 생명주기 관리

`ModelContainer`가 데이터 영속성의 '설계 및 관리'를 담당한다면, `ModelContext`는 '실제 작업'이 이루어지는 공간입니다. 이 장에서는 `ModelContainer`가 제공하는 `ModelContext`에 어떻게 접근하고, 이를 통해 데이터의 생성, 읽기, 수정, 삭제(CRUD) 작업을 수행하는지, 그리고 트랜잭션과 실행 취소 같은 고급 기능을 어떻게 관리하는지 살펴봅니다.

##### 4.1. `mainContext`와 SwiftUI `Environment`를 통한 접근

모든 `ModelContainer` 인스턴스는 `mainContext`라는 기본 `ModelContext`를 가지고 있습니다. 이 컨텍스트는 이름에서 알 수 있듯이 앱의 메인 액터(Main Actor)에 바인딩되어 있어, UI와 관련된 작업에 안전하게 사용할 수 있도록 보장됩니다.   

SwiftUI 환경에서는 `.modelContainer` 수식어를 통해 이 `mainContext`가 뷰 계층의 `Environment`에 자동으로 주입됩니다. 따라서 개발자는 `@Environment(\.modelContext)` 프로퍼티 래퍼를 사용하여 어떤 뷰에서든 이 `mainContext`에 쉽게 접근할 수 있습니다. 이 접근 방식은 SwiftUI와 SwiftData의 긴밀한 통합을 보여주는 대표적인 예입니다.   

```swift
import SwiftUI
import SwiftData

struct FriendList: View {
    // Environment를 통해 mainContext에 접근
    @Environment(\.modelContext) private var context
    @Query private var friends: [Friend]

    //... 뷰 본문...
}
```

물론, 백그라운드에서 대량의 데이터를 처리하는 등 메인 스레드를 차단해서는 안 되는 작업을 위해서는 `ModelContext(container)` 초기화 구문을 사용하여 `ModelContainer`로부터 새로운 백그라운드 컨텍스트를 생성할 수도 있습니다.   

##### 4.2. 데이터 생명주기: CRUD(생성, 읽기, 수정, 삭제) 작업의 실제

`ModelContext`를 통해 수행되는 데이터의 기본적인 생명주기 작업은 다음과 같습니다.

- **Create (생성):** 새로운 모델 객체를 생성한 후, `modelContext.insert(newObject)`를 호출하여 컨텍스트의 추적 대상으로 등록합니다. 이 시점에서는 아직 디스크에 저장되지 않은 상태입니다.   
    
    ```swift
    let newFriend = Friend(name: "Elena")
    context.insert(newFriend) // 컨텍스트에 새 친구 객체 삽입
    ```
    
- **Read (읽기):** SwiftUI 뷰 내에서는 `@Query` 프로퍼티 래퍼를 사용하는 것이 가장 일반적입니다. `@Query`는 선언적으로 데이터를 가져와 뷰에 표시하고, 데이터 변경 시 뷰를 자동으로 업데이트합니다. 뷰 외부나 더 복잡한 조회가 필요한 경우,   
    
    `FetchDescriptor`를 정의하여 `modelContext.fetch(...)`를 명시적으로 호출해 데이터를 가져올 수 있습니다.   
    
- **Update (수정):** SwiftData의 가장 직관적인 부분 중 하나입니다. `@Model`로 선언된 객체의 프로퍼티 값을 직접 변경하기만 하면 됩니다. `ModelContext`가 이러한 변경을 자동으로 감지하고 추적하므로, 별도의 `update`메서드를 호출할 필요가 없습니다.   
    
    ``` swift
    // friend 객체는 @Query 등을 통해 가져온 모델 인스턴스
    friend.name = "Rody" // 프로퍼티를 직접 수정하면 변경 사항이 추적됨
    ```
    
- **Delete (삭제):** 삭제할 객체를 `modelContext.delete(objectToDelete)` 메서드에 전달합니다. 이 역시 `insert`와 마찬가지로 컨텍스트 내에서 삭제 대상으로 표시될 뿐, 즉시 디스크에서 제거되지는 않습니다.   
    
``` swift
    // SwiftUI 리스트의 onDelete 수정자 내에서
	.onDelete { indexSet in for index in indexSet { let friendToDelete = friends[index] context.delete(friendToDelete) } }
    
```

##### 4.3. 트랜잭션 관리: 자동 저장(Autosave), 수동 저장, 그리고 롤백(Rollback)

`ModelContext`에 등록된 변경 사항(생성, 수정, 삭제)은 '트랜잭션'이라는 단위로 관리되며,最终적으로 영구 저장소에 반영되어야 합니다.

- **자동 저장 (Autosave):** `mainContext`의 기본 동작은 자동 저장입니다. 앱이 백그라운드로 전환되거나, 포그라운드로 돌아오거나, 또는 앱 사용 중 주기적인 시스템 이벤트가 발생할 때 `ModelContext`의 변경 사항이 자동으로 디스크에 저장됩니다. 이 기능은 개발자가 저장 시점에 대해 크게 신경 쓰지 않아도 되게 하여 개발 편의성을 높여줍니다.   
    
- **자동 저장의 함정과 수동 저장 (Manual Save):** 자동 저장은 편리하지만, 저장 시점이 명확하게 보장되지 않는다는 단점이 있습니다. 이로 인해 앱이 예기치 않게 종료되거나 중요한 작업 직후에 저장이 이루어지지 않으면 데이터가 유실될 위험이 있습니다. 실제로 일부 개발자 커뮤니티에서는 이 기능이 "신뢰할 수 없다"고 평가하기도 합니다. 따라서, 사용자의 중요한 데이터가 변경되는 작업 흐름의 마지막에는   
    
    `try modelContext.save()`를 명시적으로 호출하여 변경 사항을 즉시 영구 저장소에 커밋하는 것이 훨씬 안전하고 예측 가능한 방법입니다.   
    
- **롤백 (Rollback):** `modelContext.rollback()` 메서드를 사용하면 마지막 저장 시점 이후에 `ModelContext` 내에서 발생한 모든 변경 사항(inserts, updates, deletes)을 폐기하고 컨텍스트를 깨끗한 상태로 되돌릴 수 있습니다. 이는 사용자가 편집을 취소하는 기능 등을 구현할 때 유용합니다.   
    

##### 4.4. 실행 취소(Undo) 및 다시 실행(Redo) 기능 통합

SwiftData는 `UndoManager`와의 통합을 매우 쉽게 만들어 줍니다. `.modelContainer` 수식어에 `isUndoEnabled: true`파라미터를 전달하기만 하면 실행 취소 기능이 활성화됩니다.   

```swift
.modelContainer(for: Snippet.self, isUndoEnabled: true)
```

이 기능이 활성화되면, `ModelContext`에서 발생하는 모든 데이터 변경 작업이 자동으로 `UndoManager`에 등록됩니다. 개발자는 SwiftUI의 `Environment`를 통해 `UndoManager` 인스턴스에 접근하여 `undo()` 및 `redo()` 메서드를 버튼 액션 등에 연결할 수 있습니다. 또한, iOS의 기본 시스템 제스처인 '기기 흔들어서 실행 취소'도 추가 코드 없이 자동으로 동작하게 됩니다.   

결론적으로, `ModelContext`는 단순한 CRUD 인터페이스를 넘어, '상태 관리'와 '트랜잭션'의 개념을 포함하는 정교한 작업 단위(Unit of Work)입니다. 특히 'Autosave' 기능의 편리함과 그 이면에 있는 신뢰성 사이의 트레이드오프를 이해하는 것은 실무에서 매우 중요합니다. 프레임워크가 제공하는 '마법' 같은 기능에 맹목적으로 의존하기보다는, 그 동작 원리를 정확히 이해하고 트랜잭션의 단위를 명확히 인지하여 중요한 시점에는 `context.save()`를 명시적으로 호출하는 방어적인 프로그래밍 습관이 견고한 애플리케이션을 만드는 핵심 요소입니다.

---

#### 제5장: 스키마 진화와 데이터 마이그레이션

애플리케이션은 끊임없이 변화하고 발전합니다. 새로운 기능이 추가되면서 데이터 모델에 새로운 속성이 필요해지거나 기존 속성의 이름이나 타입이 변경되는 일은 흔합니다. 이처럼 앱의 생명주기 동안 발생하는 스키마의 변화에 대응하여 기존 사용자 데이터를 안전하게 보존하는 과정을 '데이터 마이그레이션'이라고 합니다. `ModelContainer`는 이 복잡한 과정을 관리하는 핵심적인 역할을 수행합니다.

##### 5.1. 자동 마이그레이션: SwiftData가 처리하는 간단한 스키마 변경

가장 기본적인 시나리오에서 SwiftData는 놀라울 정도로 지능적인 자동 마이그레이션 기능을 제공합니다. `ModelContainer`는 앱이 실행될 때 현재 코드에 정의된 `@Model` 클래스(스키마)와 디스크에 저장된 데이터베이스의 스키마를 비교합니다. 만약 차이가 발견되면, 데이터 손실 없이 마이그레이션을 시도합니다.   

SwiftData가 자동으로 처리할 수 있는 간단한 변경 사항들은 다음과 같습니다 :   

- 새로운 속성 추가 (단, 해당 속성이 Optional이거나 기본값이 제공되어야 함)
    
- 기존 속성 제거
    
- 속성을 Optional로 변경
    
- 속성을 Non-optional에서 Optional로 변경
    

이러한 경우, 개발자는 별도의 코드 작성 없이 앱을 업데이트하기만 하면 `ModelContainer`가 알아서 마이그레이션을 처리해 줍니다.

##### 5.2. `SchemaMigrationPlan`을 이용한 사용자 정의 마이그레이션

하지만 스키마 변경이 복잡해지면 자동 마이그레이션만으로는 부족합니다. 예를 들어, 필수(Non-optional) 속성을 기본값 없이 추가하거나, 속성의 이름을 바꾸거나, 데이터 타입을 변환하는 등의 작업은 SwiftData가 자동으로 처리할 수 없습니다. 이러한 경우, 개발자는 `SchemaMigrationPlan`이라는 명시적인 마이그레이션 계획을 `ModelContainer`에 제공해야 합니다.   

사용자 정의 마이그레이션은 크게 두 단계로 구성됩니다.

##### 5.2.1. `VersionedSchema`를 통한 스키마 버전 관리

가장 먼저 해야 할 일은 앱의 각 릴리즈별 스키마를 명확하게 버전으로 정의하는 것입니다. 이를 위해 `VersionedSchema` 프로토콜을 사용합니다. 일반적으로 각 버전을 나타내는 열거형(enum)을 만들고, 이 프로토콜을 채택하도록 합니다.   

`VersionedSchema`는 두 가지 필수 정보를 요구합니다:

1. `versionIdentifier`: `Schema.Version` 타입을 사용하여 `(major, minor, patch)` 형식으로 버전을 고유하게 식별합니다.
    
2. `models`: 해당 스키마 버전에 포함된 모든 모델 타입의 배열을 정의합니다.
**예제 코드:**

```swift
// V1 스키마 정의
enum AppSchemaV1: VersionedSchema {
    static var versionIdentifier = Schema.Version(1, 0, 0)
    static var models: { [UserV1.self] }
}

// V2 스키마 정의 (예: User 모델이 UserV2로 변경됨)
enum AppSchemaV2: VersionedSchema {
    static var versionIdentifier = Schema.Version(2, 0, 0)
    static var models: { [UserV2.self] }
}
```

##### 5.2.2. `SchemaMigrationPlan` 정의

스키마 버전들이 준비되면, `SchemaMigrationPlan` 프로토콜을 채택하는 타입을 만들어 마이그레이션의 전체적인 계획을 수립합니다.   

이 계획은 다음 두 가지를 정의합니다:

1. `schemas`: 앱이 지원하는 모든 `VersionedSchema`를 버전 순서대로 배열에 나열합니다. 이는 SwiftData에게 가능한 마이그레이션 경로를 알려줍니다.   
    
2. `stages`: 각 버전 간의 전환을 처리하는 `MigrationStage`의 배열을 정의합니다. 마이그레이션 단계는 두 종류가 있습니다.
    
    - **Lightweight Migration:** 속성 이름 변경(`@Attribute(originalName:)` 사용 시)과 같이 SwiftData가 추론할 수 있는 간단한 변경에 사용됩니다.   
        
    - **Custom Migration:** 복잡한 데이터 변환이 필요할 때 사용됩니다. `.custom` 단계는 `willMigrate`와 `didMigrate`라는 두 개의 클로저를 제공하여, 개발자가 마이그레이션 과정에 직접 개입할 수 있게 해줍니다.   
        
        - `willMigrate`: 마이그레이션이 시작되기 전에 호출됩니다. 주로 이전 버전의 데이터를 임시 변수에 백업하는 등의 준비 작업을 수행합니다.
            
        - `didMigrate`: 마이그레이션이 완료된 후에 호출됩니다. 주로 새로 생성된 객체에 백업해 두었던 데이터를 채워 넣거나, 데이터 형식을 변환하는 등의 후처리 작업을 수행합니다.
            

마지막으로, 이렇게 정의된 마이그레이션 계획을 `ModelContainer`를 초기화할 때 `migrationPlan` 파라미터로 전달합니다.

```swift
let container = try ModelContainer(for: AppSchemaV2.self, migrationPlan: AppMigrationPlan.self)
```

##### 5.3. 마이그레이션 실패 시나리오 및 복구 전략

데이터 마이그레이션은 앱의 생명주기에서 가장 섬세하고 위험한 작업 중 하나이며, 실패할 가능성도 존재합니다.

- **일반적인 실패 원인:** 가장 흔한 오류는 "Cannot use staged migration with an unknown coordinator model version"입니다. 이 오류는 주로 버전 관리를 처음부터 하지 않고, 나중에 마이그레이션 필요성이 생겼을 때 뒤늦게   
    
    `VersionedSchema`를 도입하려 할 때 발생합니다. SwiftData는 이전에 버전이 없던 상태를 인식하지 못하기 때문에 마이그레이션을 시작할 기준점을 찾지 못하는 것입니다. 이 외에도 마이그레이션 로직 자체의 버그나 데이터베이스 파일 손상 등도 원인이 될 수 있습니다.   
    
- **Xcode Preview에서의 마이그레이션 오류:** SwiftUI 프리뷰는 자체적인 데이터 저장소를 사용하는데, 개발 중 스키마를 변경하면 이 저장소와 충돌하여 프리뷰가 크래시될 수 있습니다. 이 경우, 터미널에서 `xcrun simctl --set previews delete all` 명령어를 실행하여 모든 프리뷰 데이터를 초기화하면 문제를 해결할 수 있습니다.   
    
- **실용적인 복구 전략:** 프로덕션 환경에서 마이그레이션 실패는 사용자에게 치명적인 경험을 줄 수 있습니다. 만약 데이터의 일부 유실을 감수하더라도 앱의 안정성을 최우선으로 해야 하는 상황이라면, 마이그레이션 실패 시 데이터베이스 파일을 강제로 삭제하고 깨끗한 상태에서 새로 시작하는 방어적인 복구 전략을 고려할 수 있습니다. 이는 특히 개발 초기 단계나 데이터의 중요도가 비교적 낮은 앱에서 유용한 대안이 될 수 있습니다.   
    

결론적으로, 데이터 마이그레이션에 대한 "나중에 생각하자"는 접근 방식은 매우 위험합니다. 프로젝트를 시작하는 시점부터 `VersionedSchema`를 도입하여 스키마의 모든 변경 사항을 체계적으로 관리하는 것이 장기적으로 훨씬 안전하고 예측 가능한 개발을 보장합니다. 이는 단순한 기술적 팁을 넘어, 안정적인 서비스를 제공하기 위한 프로젝트 관리 및 릴리즈 전략의 핵심적인 부분입니다.

## Keywords
- [[modelcontainer]]
