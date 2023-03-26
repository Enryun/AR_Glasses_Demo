//
//  ARViewController.swift
//  Glasses-AR-Demo
//
//  Created by James Thang on 20/03/2023.
//

import UIKit
import SwiftUI
import ARKit
import RealityKit

class ARViewController: UIViewController {
    
    private var glassCase: Binding<Int>
    private let arView: ARView = {
        let arView = ARView(frame: .zero)
        arView.translatesAutoresizingMaskIntoConstraints = false
        return arView
    }()
    
    init(glassCase: Binding<Int>) {
        self.glassCase = glassCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if glassCase.wrappedValue == 0 {
            if let faceScene = try? Glasses.loadFace() {
                arView.scene.anchors.append(faceScene)
            }
        } else if glassCase.wrappedValue == 1 {
            if let faceScene = try? SunglassesReality.loadFace() {
                arView.scene.anchors.append(faceScene)
            }
        } else {
            if let faceScene = try? PlasticReality.loadFace() {
                arView.scene.anchors.append(faceScene)
            }
        }

        let arConfig = ARFaceTrackingConfiguration()
        arView.session.run(arConfig)

        view.addSubview(arView)
        NSLayoutConstraint.activate([
            arView.topAnchor.constraint(equalTo: view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            arView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NotificationCenter.default.addObserver(self, selector: #selector(didTapChangeGlass(_:)), name: Notification.Name("GlassChange"), object: nil)
    }
    
    @objc private func didTapChangeGlass(_ notification: NSNotification) {
        if let userInfo = notification.userInfo, let glassIndex = userInfo["glassCase"] as? Int {
            if glassIndex == 0 {
                if let faceScene = try? Glasses.loadFace() {
                    arView.scene.anchors.removeAll()
                    arView.scene.anchors.append(faceScene)
                }
            } else if glassIndex == 1 {
                if let faceScene = try? SunglassesReality.loadFace() {
                    arView.scene.anchors.removeAll()
                    arView.scene.anchors.append(faceScene)
                }
            } else {
                if let faceScene = try? PlasticReality.loadFace() {
                    arView.scene.anchors.removeAll()
                    arView.scene.anchors.append(faceScene)
                }
            }
        }
    }
}
