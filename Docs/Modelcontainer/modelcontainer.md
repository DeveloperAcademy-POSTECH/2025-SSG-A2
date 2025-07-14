>[!question]
>
>GQ1. modelcontainer는 무엇일까?
>
>GQ2. 어떤 원리로 작동할까?


## Description

## 주요 기능

`ModelContainer`는 SwiftData의 **데이터 영속성 계층을 총괄하는 핵심 엔진**입니다. 단순히 데이터를 담는 통이 아니라, 앱의 데이터 구조(스키마)와 저장 방식(구성)을 모두 관리하는 정책 결정자이자 실행자 역할을 합니다.

#### `ModelContainer`의 두 가지 핵심 역할

1. **스키마 관리:** 앱이 어떤 종류의 데이터를 저장할지에 대한 구조적 청사진(`Schema`)을 관리합니다. 이 스키마는 개발자가 `@Model` 매크로를 사용하여 정의합니다.
    
2. **저장소 구성 관리:** 데이터가 실제로 어디에(예: 디스크, iCloud), 어떤 방식(예: 읽기/쓰기)으로 저장될지 결정하고 관리합니다.

#### SwiftData의 세 가지 핵심 요소와 관계

SwiftData는 `Schema`, `ModelContainer`, `ModelContext` 세 요소의 유기적인 협력으로 작동합니다.

- **`Schema` (청사진):** `@Model`로 정의하는 데이터의 구조입니다.
    
- **`ModelContainer` (건축가):** `Schema`라는 청사진을 받아 실제 데이터베이스(주로 SQLite)를 구축하고 모든 I/O 작업을 총괄합니다. iCloud 동기화 같은 복잡한 과정도 자동으로 처리합니다.
    
- **`ModelContext` (작업 공간):** 데이터를 생성, 수정, 삭제하는 임시 작업 공간입니다. 여기서 일어난 변경사항은 메모리에 기록되었다가, `save()` 명령을 통해 `ModelContainer`에 전달되어 영구 저장소에 최종 반영됩니다.
    


---

#### 핵심 작동 원리: 중재자 역할

`ModelContainer`의 가장 중요한 역할은 **앱의 코드(모델 객체)와 실제 저장소(SQLite) 사이를 중재**하는 것입니다. 개발자가 `@Query`로 데이터를 요청하거나 `save()`를 호출하면, `ModelContext`는 이 요청을 `ModelContainer`에 전달할 뿐입니다. 실제로 SQL 쿼리를 실행하고 디스크에 접근하는 복잡한 작업은 `ModelContainer`가 모두 알아서 처리합니다.

이러한 추상화 덕분에 개발자는 복잡한 데이터베이스 관리나 파일 I/O에 대해 신경 쓸 필요 없이, Swift 코드로 객체를 다루는 데만 집중할 수 있습니다.

## 코드예시

### `ModelContainer` 설정 방법: 선언적 vs. 프로그래밍

`ModelContainer`를 설정하는 방법은 크게 두 가지입니다.

1. **선언적 방식 (딸깍):** SwiftUI에서는 **`.modelContainer`** 수식어를 사용합니다. 앱의 최상위 뷰에 적용하면 지정된 모델의 컨테이너를 생성하고, `mainContext`를 뷰 전체에서 사용할 수 있도록 `Environment`에 자동으로 넣어줍니다. `@Query`가 작동하는 이유가 바로 이것 때문입니다.

 ```Swift
  // 단일 모델
  .modelContainer(for: ToDoItem.self)
  
  // 여러 모델
  .modelContainer(for: [Trip.self, Activity.self])
   ```

> **💡 관계 추론 (Relationship Inference):** 모델 간에 관계가 설정되어 있다면, 최상위 모델 하나만 등록해도 SwiftData가 연결된 모든 모델을 알아서 스키마에 포함시켜 줍니다.

2. **프로그래밍 방식 (해야만 한다;;):** 더 복잡한 설정(예: 여러 저장소 구성)이 필요할 때 사용합니다. `try ModelContainer(...)`를 직접 호출하여 컨테이너 인스턴스를 생성한 후, 이 인스턴스를 `.modelContainer()` 수식어에 전달합니다.

  ```Swift
   // 1. ModelContainer 인스턴스를 직접 생성
   let container = try ModelContainer(for: schema, configurations: config)
   
   // 2. 생성된 인스턴스를 수식어에 전달
   .modelContainer(container)
   ```

---
### 스키마 변경과 데이터 마이그레이션

앱이 업데이트되면서 데이터 모델이 변경될 때(스키마가 변경될 때) 기존 데이터를 보존하는 과정입니다. `ModelContainer`가 이 과정을 관리합니다.

- **자동 마이그레이션:** 속성을 추가(Optional 또는 기본값 있는 경우)하거나 삭제하는 등 간단한 스키마 변경은 SwiftData가 앱 실행 시 자동으로 처리해 줍니다.
    
- **사용자 정의 마이그레이션:** 속성 이름 변경, 타입 변환 등 복잡한 변경 시에는 개발자가 직접 마이그레이션 계획을 제공해야 합니다.
    
    1. **`VersionedSchema`로 버전 정의:** 각 앱 릴리즈별로 데이터 모델의 버전을 명시적으로 정의합니다. **프로젝트 초기부터 이 작업을 하는 것이 매우 중요합니다.**
        
    2. **`SchemaMigrationPlan`으로 계획 수립:** 버전 간에 어떻게 데이터를 옮길지 구체적인 계획(`MigrationStage`)을 작성합니다.
        
    3. **`ModelContainer`에 계획 전달:** 컨테이너를 초기화할 때 이 마이그레이션 계획을 함께 전달합니다.
        

> **⚠️ 중요:** 데이터 마이그레이션은 "나중에 생각하자"는 접근이 매우 위험합니다. 프로젝트 시작부터 `VersionedSchema`를 도입하여 변경 사항을 체계적으로 관리하는 습관이 장기적으로 안정적인 앱을 만드는 핵심입니다.


```swift
import SwiftData

// MARK: - 버전 1 스키마
enum UserSchemaV1: VersionedSchema {
    // 앱의 첫 번째 버전 식별자
    static var versionIdentifier: Schema.Version = .init(1, 0, 0)

    // 이 버전에서 사용하는 모델 목록
    static var models: [any PersistentModel.Type] {
        [UserV1.self]
    }

    // 버전 1의 User 모델
    @Model
    final class UserV1 {
        var name: String
        let joinDate: Date

        init(name: String, joinDate: Date = .now) {
            self.name = name
            self.joinDate = joinDate
        }
    }
}

// MARK: - 버전 2 스키마
enum UserSchemaV2: VersionedSchema {
    // 앱의 두 번째 버전 식별자
    static var versionIdentifier: Schema.Version = .init(2, 0, 0)

    // 이 버전에서 사용하는 모델 목록
    static var models: [any PersistentModel.Type] {
        [UserV2.self]
    }

    // 버전 2의 User 모델
    @Model
    final class UserV2 {
        var fullName: String // 'name' -> 'fullName'으로 이름 변경
        var email: String?   // 새로운 Optional 속성 추가
        let joinDate: Date

        init(fullName: String, email: String?, joinDate: Date) {
            self.fullName = fullName
            self.email = email
            self.joinDate = joinDate
        }
    }
}
```
---

### 2. 마이그레이션 계획 수립 (`SchemaMigrationPlan`)

어떤 버전에서 다른 버전으로 어떻게 데이터를 이전할지 계획을 세웁니다.

- **`lightweight:`** 이름 변경, Optional 속성 추가/제거 등 간단한 변경은 SwiftData가 자동으로 처리하도록 위임합니다.
    
- **`custom:`** 데이터 타입 변환 등 복잡한 로직이 필요할 때 직접 코드를 작성합니다.
    
```Swift
import SwiftData

// MARK: - 마이그레이션 계획
enum MigrationPlan: SchemaMigrationPlan {
    // 관리할 모든 스키마 버전을 등록합니다.
    static var schemas: [any VersionedSchema.Type] {
        [UserSchemaV1.self, UserSchemaV2.self]
    }
    
    // 마이그레이션 단계를 정의합니다.
    static var stages: [MigrationStage] {
        [migrateV1toV2]
    }
    
    // V1 -> V2 마이그레이션 단계 정의
    static let migrateV1toV2 = MigrationStage.lightweight(
        fromVersion: UserSchemaV1.self,
        toVersion: UserSchemaV2.self
    )
    
    // 만약 'name'을 'firstName'과 'lastName'으로 분리하는 등
    // 복잡한 로직이 필요하다면 custom 마이그레이션을 사용합니다.
    /*
    static let migrateV1toV2_custom = MigrationStage.custom(
        fromVersion: UserSchemaV1.self,
        toVersion: UserSchemaV2.self,
        willMigrate: { context in
            // 마이그레이션 시작 전
        },
        didMigrate: { context in
            // 마이그레이션 완료 후
            let usersV1 = try context.fetch(FetchDescriptor<UserSchemaV1.UserV1>())
            // 여기서 usersV1 데이터를 가공하여 V2 모델에 맞게 변환/저장하는 코드를 작성
            try context.save()
        }
    )
    */
}
```

> 💡 **Tip:** 속성 이름 변경(`name` -> `fullName`)은 SwiftData가 자동으로 감지하고 처리해주므로 `lightweight` 마이그레이션으로 충분합니다.

---

### 3. `ModelContainer`에 계획 전달

앱이 시작될 때 `ModelContainer`를 초기화하면서 위에서 만든 마이그레이션 계획을 전달합니다.

```Swift
import SwiftUI
import SwiftData

@main
struct YourApp: App {
    let container: ModelContainer

    init() {
        do {
            // 현재 앱이 사용할 모델(V2)과 마이그레이션 계획(MigrationPlan)을 함께 전달
            container = try ModelContainer(
                for: UserSchemaV2.models,
                migrationPlan: MigrationPlan.self
            )
        } catch {
            fatalError("ModelContainer 생성에 실패했습니다: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container) // 뷰 계층에 컨테이너 주입
    }
}
```

이제 앱을 실행하면 SwiftData는 저장된 데이터의 버전과 현재 앱의 모델 버전을 비교합니다. 버전이 다를 경우, `MigrationPlan`에 정의된 계획에 따라 자동으로 데이터를 새로운 스키마에 맞게 이전해 줍니다.

​Keywords
- [[modelcontainer]]
