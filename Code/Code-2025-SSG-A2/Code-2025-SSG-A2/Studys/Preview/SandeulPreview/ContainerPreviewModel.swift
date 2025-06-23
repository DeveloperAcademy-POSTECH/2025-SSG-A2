//
//  PreviewModel.swift
//  Code-2025-SSG-A2
//
//  Created by 산들 on 6/23/25.
//

import SwiftUI
import SwiftData

// MARK: - 모델 정의
@Model
class Learner1 {
    var name: String
    var memo: String

    init(
        name: String = "",
        memo: String = ""
    ) {
        self.name = name
        self.memo = memo
    }
}

// MARK: - 프리뷰용 더미 데이터 (정적 속성)
extension Learner1 {
    static var preview: Learner1 {
        Learner1(name: "산들", memo: "ㅎㅇ")
    }
}
