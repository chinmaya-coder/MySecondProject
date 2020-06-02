//
//  ViewController.swift
//  ZoomInAR
//
//  Created by Chinmaya on 26/05/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    var cameraNode: SCNNode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetUp()
    }
    
    private func initialSetUp(){
        
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        sceneView.showsStatistics = true
        
        let text = SCNText(string: "Chinmaya", extrusionDepth: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        text.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(x: 0, y: -0.02, z: -0.5)
        node.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
        node.geometry = text
        //add Camera Node to SceneView
        sceneView.scene.rootNode.addChildNode(node)
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(locationPinched(_:)))
        view.addGestureRecognizer(pinchGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    @objc func locationPinched(_ recognizer: UIPinchGestureRecognizer){
        guard recognizer.view != nil else { return }
        switch recognizer.state {
        case .began, .changed:
            recognizer.view?.transform = (recognizer.view?.transform.scaledBy(x: recognizer.scale, y: recognizer.scale))!
            recognizer.scale = 1.0
            break
        default: break
        }
    }
}

extension ViewController: ARSCNViewDelegate {
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
}

