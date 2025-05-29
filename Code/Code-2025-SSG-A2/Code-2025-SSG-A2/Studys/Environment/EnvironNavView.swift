import SwiftUI

struct EnvironNavView: View {
    var body: some View {
        NavigationStack{
            List{
                Text("Lemon")
                NavigationLink("LemonEnvironmentView", destination: LemonEnvironmentView())
            }
            .navigationTitle("Environment")
        }
    }
}