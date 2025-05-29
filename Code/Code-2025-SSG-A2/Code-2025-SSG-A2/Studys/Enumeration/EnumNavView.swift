import SwiftUI

struct EnumNavView: View {
    var body: some View {
        NavigationStack{
            List{
                Text("Sandeul")
                NavigationLink("SandeulEnumerationView", destination: SandeulEnumerationView())
            }
            .navigationTitle("Enumeration")
        }
    }
}