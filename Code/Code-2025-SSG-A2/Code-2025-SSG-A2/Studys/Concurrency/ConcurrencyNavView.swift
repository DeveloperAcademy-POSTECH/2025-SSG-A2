import SwiftUI

struct ConcurrencyNavView: View {
    var body: some View {
        NavigationStack{
            List{
                Text("Lemon")
                NavigationLink("LemonActorView", destination: LemonActorView())
                NavigationLink("LemonTaskView", destination: LemonTaskView())
                NavigationLink("LemonAsyncAwaitView", destination: LemonAsyncAwaitView())
            }
            .navigationTitle("Concurrency")
        }
    }
}