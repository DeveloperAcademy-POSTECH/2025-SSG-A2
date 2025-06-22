import SwiftUI

struct NavNavView: View {
    var body: some View {
        NavigationStack{
            List{
                Text("Tether")
                NavigationLink("TetherNavigationCompareView", destination: TetherNavigationCompareView())
                Text("Gyeong")
                NavigationLink("GyeongTabviewExampleView", destination: GyeongTabviewExampleView())
                NavigationLink("GyeongTabSectionView", destination: GyeongTabSectionView())
                NavigationLink("GyeongTabviewSelectionView", destination: GyeongTabviewSelectionView())
            }
            .navigationTitle("Navigation")
        }
    }
}
