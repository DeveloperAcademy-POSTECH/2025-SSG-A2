import SwiftUI

struct NavNavView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink("TetherNavigationCompareView", destination: TetherNavigationCompareView())
            }
            .navigationTitle("Navigation")
        }
    }
}