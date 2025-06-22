//
//  SandeulPreview.swift
//  Code-2025-SSG-A2
//
//  Created by 산들 on 6/23/25.
//

import SwiftUI
import SwiftData

// MARK: - 메인 뷰 정의
struct ContainerPreview: View {
    // SwiftData의 모델Context에서 자동으로 Learner들을 가져오기
    @Query private var learners: [Learner1]

    var body: some View {
        List(learners, id: \.name) { learner in
            VStack(alignment: .leading) {
                Text("이름: \(learner.name)")
                Text("메모: \(learner.memo)")
            }
        }
    }
}

// MARK: - 프리뷰용 컨테이너 생성 헬퍼 함수
/// SwiftUI 프리뷰에서 SwiftData를 테스트하기 위한 임시 컨테이너를 생성합니다.
/// 실제 디스크에 저장되지 않고 메모리에서만 동작하므로 안전하게 프리뷰할 수 있어요.
@MainActor func learnerPreviewContainer(with learners: [Learner1]) -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Learner1.self, configurations: config)
    let context = container.mainContext

    // 배열로 받아 일괄 insert
    learners.forEach { context.insert($0) }

    return container
}

// MARK: - SwiftUI 프리뷰
#Preview {
    ContainerPreview()
        .modelContainer(
            learnerPreviewContainer(with: [
                Learner1(name: "산들", memo: "ㅎㅇ"),
                Learner1(name: "해솔", memo: "반가워요"),
                Learner1(name: "유진", memo: "SwiftData 연습 중"),
                Learner1(name: "김치맨", memo: "🥬")
            ])
        )
}
