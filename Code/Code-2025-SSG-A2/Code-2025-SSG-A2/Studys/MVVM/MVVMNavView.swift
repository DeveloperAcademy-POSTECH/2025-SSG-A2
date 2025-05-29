import SwiftUI

struct MVVMNavView: View {
    var body: some View {
        NavigationStack{
            List{
                Text("Miru")
                NavigationLink("MiruMVVMTodoView", destination: MiruMVVMTodoView())
                NavigationLink("MiruMVVMCountView", destination: MiruMVVMParentView())
                Text("")
                Text("Joid")
                NavigationLink("JoidCounterView", destination: JoidCounterView())
            }
            .navigationTitle("MVVM")
        }
    }
}