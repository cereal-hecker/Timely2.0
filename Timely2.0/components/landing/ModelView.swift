//
//  SplineCard.swift
//  Timely2.0
//
//  Created by Riya Batla on 29/01/24.
//


import SwiftUI
import SceneKit

struct ModelView: View {
    @State private var sceneRootNode: SCNNode?
    @State private var scene: SCNScene?
    @State private var modelColor: Color = .clear
    var currentHp: Double
    @State var value = 900
    @State var isLongPressed: Bool = false
    var body: some View {
        VStack {
            SceneView(
                scene: scene,
                options: [.autoenablesDefaultLighting, .allowsCameraControl]
            )
//            .simultaneousGesture(LongPressGesture(minimumDuration: 0.5)
//                                            .onEnded { _ in
//                        self.isLongPressed = true
//                                        
//                    })
//            .sheet(isPresented: $isLongPressed) {
//                ChoosePetSheet()
//                    .background(.black)
//                
//            }
        }
        .onAppear {
            if sceneRootNode == nil { // Load scene only if not already loaded
                if let rootNode = loadModel(named: "petmodel.scn") {
                    sceneRootNode = rootNode
                    scene = SCNScene()

                    // Set the solid color as the background
                    scene?.background.contents = UIColor.black
                    

                    // MARK: Background glow image
                    
                    if let image = UIImage(named: "landglow") {
                        UIGraphicsBeginImageContextWithOptions(image.size , false, image.scale)
                        let context = UIGraphicsGetCurrentContext()!

                        UIColor.black.setFill()
                        context.fill(CGRect(origin: .zero, size: image.size))

                        image.draw(at: .zero, blendMode: .normal, alpha: 1.0)

                        let compositeImage = UIGraphicsGetImageFromCurrentImageContext()!
                        UIGraphicsEndImageContext()

                        scene?.background.contents = compositeImage
                    }

                    scene?.rootNode.addChildNode(rootNode)
                    adjustModel()
                }
            }
            
            // Update material color only on initial appearance
            updateMaterialColor()
        }
        .onChange(of: currentHp){
            updateMaterialColor()
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
            material.diffuse.contents = gradientColor(value: Double(currentHp))
          }
        }
      }

      for childNode in node.childNodes {
        updateMaterialColorRecursive(node: childNode)
      }
    }
    
    func gradientColor(value: Double) -> UIColor {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        if value/10 <= 25 {
            red = 1
            green = CGFloat(value/10 / 25)
            
        } else if value/10 <= 65 {
            red = 1 - CGFloat((value/10 - 25) / 40)
            green = 1
        } else {
            green = 1 - CGFloat((value/10 - 65) / 35)
            blue = CGFloat((value/10 - 65) / 35)
            red = 1
            alpha = 1
        }
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    private func adjustModel() {
        guard let rootNode = sceneRootNode else { return }

        rootNode.eulerAngles.x = -.pi / 2 // Rotate around x-axis
        rootNode.eulerAngles.z = .pi / 12
        rootNode.eulerAngles.y = .pi / 12
        rootNode.position = SCNVector3(x: 0, y: 0, z: 0)
    }
}

#Preview{
    ModelView(currentHp: 0)
}
