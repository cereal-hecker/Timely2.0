//
//  3dModelView.swift
//  Timely2.0
//
//  Created by user2 on 05/03/24.
//

import SwiftUI
import SceneKit

struct ModelView: View {
    @State private var sceneRootNode: SCNNode?
    @State private var scene: SCNScene?
    @State private var modelColor: Double = 0.0

    var body: some View {
        VStack {
            SceneView(scene: scene, options: [.autoenablesDefaultLighting,.allowsCameraControl])
//                .frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height / 2)

            Slider(value: $modelColor, in: 0...1, label: {
                Text("Color")
            })
            .onChange(of: modelColor) { _ in
                updateMaterialColor()
            }
        }
        .onAppear {
            if let rootNode = loadModel(named: "PetMod.scn") {
                sceneRootNode = rootNode
                scene = SCNScene()
                scene?.rootNode.addChildNode(rootNode)
            }
        }
    }

    private func loadModel(named name: String) -> SCNNode? {
        guard let scene = SCNScene(named: name) else { return nil }
        return scene.rootNode.clone()
    }

    private func updateMaterialColor() {
        guard let rootNode = sceneRootNode else { return }
        updateMaterialColorRecursive(node: rootNode)
    }

    private func updateMaterialColorRecursive(node: SCNNode) {
        if let geometry = node.geometry {
            geometry.materials.forEach { material in
                // Check if the material has the identity "Material_004"
                if material.name == "body" {
                    material.diffuse.contents = UIColor(
                        red: CGFloat(1 - modelColor),
                        green: CGFloat(modelColor),
                        blue: 0,
                        alpha: 1.0
                    )
                }
            }
        }

        for childNode in node.childNodes {
            updateMaterialColorRecursive(node: childNode)
        }
    }
}

#Preview {
    ModelView()
}
