>[!question]
>GQ1. LLVM은 무엇일까?
>GQ2. LLDB는 무엇일까?
>GQ3. Xcode에서 어떻게 디버깅할 수 있을까?

## Description

### LLVM(Low Level Virtual Machine)

다양한 프로그래밍 언어의 소스 코드를 중간 표현(IR, Intermediate Representation)으로 변환하고, 이 IR을 각 하드웨어 아키텍처에 맞는 기계어(바이너리 코드)로 최적화 및 생성하는 역할을 한다.

### LLVM의 구조

![LLVM Structure](https://camo.githubusercontent.com/a5f174499b3b151a17e61dfaffa75f2b71e71ec4858baf6c4c8726cd41007b0b/68747470733a2f2f626c6f672e6b616b616f63646e2e6e65742f646e2f5a62556d4b2f6274714f366638596c5a6f2f6b574d757a664b494a65584b4c6e774e4f6f6b346b312f696d672e6a7067)

1. 프론트엔드(Frontend)
	- Swift 코드를 AST(Abstract Syntax Tree)로 변환한다.
	- 이를 SIL(Swift Intermediate Language)로 한 번 더 변환한다.
	- SIL 변환 단계에서 1차 최적화가 이루어진다.
2. LLVM Optimizer(LLVM IR 생성)
	- SIL을 LLVM IR로 변환한다.
	- LLVM IR 변환 단계에서 2차 최적화가 이루어진다.
3. 백엔드(Backend)
	- 최적화된 LLVM IR을 타겟 하드웨어(x86, ARM 등)에 맞는 기계어(오브젝트 코드, .o 파일)로 변환한다.

### LLDB(Low Level Debugger)

LLVM 프로젝트의 디버거 컴포넌트로 C, C++, Objective-C, Swift 등을 지원하며, Xcode의 기본 디버거로 내장되어 있다.

## 주요 기능

### LLDB 명령어 기초 문법

```
(lldb) command [subcommand] -option "this is argument"
```

- `command`와 `subcommand`는 LLDB 내 Object의 이름으로 `command`에 따라 사용할 수 있는 `subcommand`가 다르다.

### Breakpoint

- 특정 함수에 걸기

```
(lldb) breakpoint set --name viewDidLoad
(lldb) b -n viewDidLoad
```

- 특정 조건에만 걸기

```
(lldb) breakpoint set --name "viewWillAppear" --condition animated
(lldb) b s -n "viewWillAppear" -c animated
```

### Watchpoint

- 변수의 값이 바뀔 때마다 중단되도록 설정

```
(lldb) watchpoint set variable global_var
(lldb) wa s v global_var
```

### Expression

- Object Description 출력

```
(lldb) expr --object-description -- 변수명
(lldb) expr -o -- 변수명
(lldb) po 변수명
```

- 변수값 수정

```
(lldb) expr 변수명 = 새값
(lldb) p 변수명 = 새값
```

## 코드 예시

```Swift
import SwiftUI

struct LemonLLVMView: View {
  @State private var viewModel: LemonLLVMViewModel = .init()

  var body: some View {
    VStack {
      VStack {
        Text("\(viewModel.count)")

        Button("Increase") {
          viewModel.increase()
        }
        
        Button("Decrease") {
          viewModel.decrease()
        }
      }
      .padding()
      .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))

      VStack {
        ForEach(viewModel.names, id: \.self) { name in
          Text(name)
        }
      }
      .padding()
      .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
  }
}

@Observable
final class LemonLLVMViewModel {
  var count: Int
  var increasing: Int
  
  init() {
    self.count = 0
    // Watchpoint 설정
    // wa s v _count
    self.increasing = 1
  }

  func increase() {
    // names 수정
    // po names
    // p names[1] = "Mango"
    count += increasing
  }
  
  func decrease() {
    count -= increasing
  }

  var names: [String] = ["Lemon", "Orange", "Apple"]
}

#Preview {
  LemonLLVMView()
}
```

## Keywords

- [[Swift]]

## References

- [TIL/Swift/LLVM.md](https://github.com/sujinnaljin/TIL/blob/master/Swift/LLVM.md)
- [SIL(Swift Intermediate Language)을 통한 Swift debugging](https://techblog.woowahan.com/2563/)
- [LLDB를 사용한 Xcode 디버깅](https://velog.io/@rnfxl92/Xcode-LLDB)
- [Xcode에서 디버깅 하는 법에 대해 아라보자 - LLDB](https://velog.io/@ssionii/Xcode-디버깅-하는-법에-대해-아라보자-LLDB-정복)