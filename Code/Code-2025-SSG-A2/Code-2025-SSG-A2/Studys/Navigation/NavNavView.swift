import SwiftUI

struct NavNavView: View {
    var body: some View {
        NavigationStack{
            List{
                Text("Tether")
                NavigationLink("TetherNavigationCompareView", destination: TetherNavigationCompareView())
                Text("Gyeong")
                NavigationLink("GyeongTabviewExampleView", destination: GyeongTabviewExampleView())
            }
            .navigationTitle("Navigation")
        }
    }
}
