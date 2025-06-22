//
//  SandeulPreview.swift
//  Code-2025-SSG-A2
//
//  Created by 산들 on 6/23/25.
//

import SwiftUI
import SwiftData

// MARK: - 뷰 정의
struct ViewForPreview: View {
    let learners: [Learner2]

    var body: some View {
        List(learners, id: \.name) { learner2 in
            VStack(alignment: .leading) {
                Text("이름: \(learner2.name)")
                Text("메모: \(learner2.memo)")
            }
        }
    }
}

// MARK: - 프리뷰 전용 뷰 (바깥으로 분리!)
struct ViewForPreview_PreviewWrapper: View {
    var body: some View {
        ViewForPreview(learners: [
            Learner2(name: "산들", memo: "ㅎㅇ"),
            Learner2(name: "해솔", memo: "반가워요"),
            Learner2(name: "유진", memo: "SwiftData 연습 중"),
            Learner2(name: "김치맨", memo: "🥬")
        ])
    }
}

#Preview {
    ViewForPreview_PreviewWrapper()
}


