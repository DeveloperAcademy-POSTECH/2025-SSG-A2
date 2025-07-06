//
//  vision_tutorialApp.swift
//  vision_tutorial
//
//  Created by Apple on 6/29/25.
//

import SwiftUI

@main
struct vision_tutorialApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // .windowStyle(.volumetric)
        .windowResizability(.contentSize)
        // .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)

        // Label Window
        WindowGroup(for: Label.self) { $label in
            LabelView(label: $label)
                .disabled(true)
        } defaultValue: {
            Label(text: "", cornerRadius: 20)
        }
        .windowResizability(.contentSize)
        .windowStyle(.plain)

        // SeaCreature Window
        WindowGroup(id: "creatureWindow", for: String.self) { $modelName in
            SeaCreatureDetailView(modelName: modelName ?? "ToyBiplane")
                .padding3D(.all, 250)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.5, height: 0.5, depth: 0.5, in: .meters)
    }
}

#Preview("Main Window") {
    ContentView()
}

#Preview("Label Window") {
    @Previewable @State var label = Label(text: "Sample Text", cornerRadius: 30)
    LabelView(label: $label)
}
