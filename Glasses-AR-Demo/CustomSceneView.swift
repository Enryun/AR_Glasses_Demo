//
//  CustomSceneView.swift
//  USDzExperience
//
//  Created by user on 11/2/22.
//

import SwiftUI
import SceneKit

struct CustomSceneView: UIViewRepresentable {
    
    @State var scene: SCNScene?
    @State var allowCamControl: Bool
    var isAddRotation: Bool = false
    var prepareRotation: Float = 0
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.allowsCameraControl = allowCamControl
        sceneView.autoenablesDefaultLighting = true
        sceneView.antialiasingMode = .multisampling2X
        sceneView.scene = scene
        sceneView.backgroundColor = .clear
        if isAddRotation {
            addRotation()
        }
        needRotation(yFloat: prepareRotation)
        return sceneView
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        
    }
    
    func addRotation() {
        if let planetNode = scene?.rootNode.childNodes.first {
            planetNode.removeAllActions()
            if Bool.random() {
                let action = SCNAction.rotate(by: 360 * CGFloat(-Double.pi / 180), around: .init(0, 1, 0), duration: 8)
                let repeatAction = SCNAction.repeatForever(action)
                planetNode.runAction(repeatAction)
            } else {
                let action = SCNAction.rotate(by: 360 * CGFloat(Double.pi / 180), around: .init(0, 1, 0), duration: 8)
                let repeatAction = SCNAction.repeatForever(action)
                planetNode.runAction(repeatAction)
            }
        }
    }
    
    func needRotation(yFloat: Float) {
        if let planetNode = scene?.rootNode.childNodes.first {
            planetNode.eulerAngles = SCNVector3Make(0, yFloat, 0);
        }
    }
    
}

