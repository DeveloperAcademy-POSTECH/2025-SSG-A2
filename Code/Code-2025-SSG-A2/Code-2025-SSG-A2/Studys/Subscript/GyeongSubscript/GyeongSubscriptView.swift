//
//  GyeongSubscriptView.swift
//  Code-2025-SSG-A2
//
//  Created by 조운경 on 6/1/25.
//

import SwiftUI

struct WeekSchedule {
    private var schedule: [String: String] = [
        "월": "헬스장",
        "화": "스터디",
        "수": "휴식",
        "목": "회의",
        "금": "데이트",
        "토": "등산",
        "일": "집콕"
    ]
    
    subscript(day: String) -> String? {
        get {
            return schedule[day]
        }
        set {
            schedule[day] = newValue
        }
    }
}

struct GyeongSubscriptView: View {
    @State private var schedule = WeekSchedule()
    @State private var selectedDay = "월"
    
    var body: some View {
        VStack(spacing: 20) {
            Text("오늘은 \(selectedDay)요일")
                .font(.title)
            
            if let todayTask = schedule[selectedDay] {
                Text("할 일: \(todayTask)")
            } else {
                Text("할 일이 없습니다.")
            }

            Picker("요일 선택", selection: $selectedDay) {
                ForEach(["월", "화", "수", "목", "금", "토", "일"], id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())

            Button("수정하기") {
                schedule[selectedDay] = "Swift 배우기"
            }
        }
        .padding()
    }
}

#Preview {
    GyeongSubscriptView()
}
