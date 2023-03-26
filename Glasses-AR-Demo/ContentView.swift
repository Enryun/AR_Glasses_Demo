//
//  ContentView.swift
//  Glasses-AR-Demo
//
//  Created by Pete Murray on 12/10/2022.
//

import SwiftUI
import RealityKit
import ARKit
import SceneKit

struct ContentView : View {

	@State private var isPresented: Bool = false
    @State private var glassCase = 1

    var body: some View {
        ZStack {
            ARViewVC(glassCase: $glassCase)
                .edgesIgnoringSafeArea(.all)
        }
        .alert("Face Tracking Unavailable", isPresented: $isPresented) {
            Button {
                isPresented = false
            } label: {
                Text("Okay")
            }
        } message: {
            Text("Face tracking requires an iPhone X or later.")
        }
        .onAppear {
            if !ARFaceTrackingConfiguration.isSupported {
                isPresented = true
            }
        }
        .overlay(alignment: .bottom) {
            HStack {
                Button {
                    glassCase = 0
                    let userInfo: [String : Int] = [
                        "glassCase" : glassCase
                    ]
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "GlassChange"), object: nil, userInfo: userInfo)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(glassCase == 0 ? .white : .gray.opacity(0.3))
                            .frame(width: 120, height: 120)
                        
                        CustomSceneView(scene: .init(named: "Sunglass.usdz"), allowCamControl: false, prepareRotation: Float.pi/2)
                            .frame(width: 120, height: 120)
                            .offset(x: -10)
                    }
                }

                Button {
                    glassCase = 1
                    let userInfo: [String : Int] = [
                        "glassCase" : glassCase
                    ]
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "GlassChange"), object: nil, userInfo: userInfo)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(glassCase == 1 ? .white : .gray.opacity(0.3))
                            .frame(width: 120, height: 120)
                        
                        CustomSceneView(scene: .init(named: "Sunglasses.usdz"), allowCamControl: false, prepareRotation: -Float.pi/2)
                            .frame(width: 100, height: 100)
                    }
                }

                Button {
                    glassCase = 2
                    let userInfo: [String : Int] = [
                        "glassCase" : glassCase
                    ]
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "GlassChange"), object: nil, userInfo: userInfo)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(glassCase == 2 ? .white : .gray.opacity(0.3))
                            .frame(width: 120, height: 120)
                        
                        CustomSceneView(scene: .init(named: "Plastic_Sunglasses.usdz"), allowCamControl: false, prepareRotation: .zero)
                            .frame(width: 100, height: 100)
                    }
                }
            }
        }
	}
}

struct ARViewContainer: UIViewRepresentable {
    
    @Binding var glassCase: Int
    
	func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        // Load the "Face" scene from the "Glasses" Reality File
        if glassCase == 0 {
            if let faceScene = try? Glasses.loadFace() {
                arView.scene.anchors.append(faceScene)
            }
        } else if glassCase == 1 {
            if let faceScene = try? SunglassesReality.loadFace() {
                arView.scene.anchors.append(faceScene)
            }
        }

		let arConfig = ARFaceTrackingConfiguration()
		arView.session.run(arConfig)

        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}


struct ARViewVC: UIViewControllerRepresentable {
    
    @Binding var glassCase: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = ARViewController(glassCase: $glassCase)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

