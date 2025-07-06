import SwiftUI
import RealityKit
import RealityKitContent

struct Tut3View: View {
    @Environment(\.openWindow) private var openWindow
    @State private var selectedCreature: SeaCreature?
    
    private var seaCreatures = [
        SeaCreature(name: "Clam", modelName: "ClamView"),
        SeaCreature(name: "Fish", modelName: "FishView"),
        SeaCreature(name: "Slug", modelName: "SlugView"),
        SeaCreature(name: "Starfish", modelName: "StarfishView")
    ]


    var body: some View {
        NavigationSplitView {
            List(seaCreatures) { creature in
                Button(action: {
                    selectedCreature = creature
                }, label: {
                    Text(creature.name)
                })
            }
            .navigationTitle("Sea Creatures")
        } detail: {
            if let selectedCreature {
                Model3D(named: selectedCreature.modelName, bundle: realityKitContentBundle)
                    .navigationTitle(selectedCreature.name)
                    .toolbar {
                        Button(action: {
                            openWindow(id: "creatureWindow", value: selectedCreature.modelName)
                        }, label: {
                            Text("View \(selectedCreature.name)")
                        })
                    }
            } else {
                Text("Select a sea creature")
            }
        }
        .frame(minWidth: 1200, minHeight: 700)
    }
}

#Preview(windowStyle: .volumetric) {
    Tut3View()
}
