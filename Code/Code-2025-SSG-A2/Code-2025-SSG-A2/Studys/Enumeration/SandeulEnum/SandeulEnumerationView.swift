import SwiftUI

struct SandeulEnumerationView: View {
    enum Day: String, CaseIterable {
        case monday = "힘내봐야지", tuesday = "할만한가?", wednesday = "으악", thursday = "하루만 더...", friday = "드디어 쉰다!", saturday = "내일도 쉰다!", sunday = "벌써 주말이 끝났네..."
    }
    // Raw Value로 요일 기분 표현
    @State var today = Day.monday
    
    var body: some View {
        
        switch today {
        case .monday:
            Text("월요일")
            Text(today.rawValue)
        case .tuesday:
            Text("화요일")
            Text(today.rawValue)
        case .wednesday:
            Text("수요일")
            Text(today.rawValue)
        case .thursday:
            Text("목요일")
            Text(today.rawValue)
        case .friday:
            Text("금요일")
            Text(today.rawValue)
        case .saturday:
            Text("토요일")
            Text(today.rawValue)
        case .sunday:
            Text("일요일")
            Text(today.rawValue)
        }
        Button {
            //누르면 다음 요일로
            if let currentIndex = Day.allCases.firstIndex(of: today) {
                let nextIndex = Day.allCases.index(after: currentIndex)
                today = nextIndex == Day.allCases.endIndex ? Day.allCases.first! : Day.allCases[nextIndex]
            }
            // enum에서 CaseIterable을 채택하였으므로 Day.allCases = [monday, tuesday, wednesday, thursday, friday, saturday, sunday]라는 프로퍼티가 생긴다. .firstIndex(of: today)는 현재 선택된 요일(today)가 배열의 몇 번째 인덱스인지 찾아준다.
            // index(after: currentIndex)는 현재 인덱스의 다음 인덱스를 구한다.
            // 삼항연산자를 활용해 인덱스의 끝이이면 처음으로 돌아가고, 그게 아니면 다음 인덱스로 변경.
        } label: {
            Text("next day")
        }
    }
}

#Preview {
    SandeulEnumerationView()
}
