//
//  ViewController.swift
//  arPad
//
//  Copyright © 2017 xnzr. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    // MARK: - ARKit / ARSCNView
    let session = ARSession()
    var sessionConfig: ARSessionConfiguration = ARWorldTrackingSessionConfiguration()
    /*
     var use3DOFTracking = false {
     didSet {
     if use3DOFTracking {
     sessionConfig = ARSessionConfiguration()
     }
     //sessionConfig.isLightEstimationEnabled = UserDefaults.standard.bool//(for: .ambientLightEstimation)
     session.run(sessionConfig)
     }
     }
     var use3DOFTrackingFallback = false
     */
    var screenCenter: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingSessionConfiguration.isSupported ? ARWorldTrackingSessionConfiguration() : ARSessionConfiguration();
        
        sceneView.session = self.session
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        placeRay()
    }
    
    func placeRay() {
        
        guard let ct = self.session.currentFrame?.camera.transform, let camRot = self.session.currentFrame?.camera.eulerAngles else {
            //        guard let ct = session.currentFrame?.camera.transform, let camRot = session.currentFrame?.camera.eulerAngles else {
            return
        }
        
        //let cameraTransform = session.currentFrame?.camera.transform
        let cameraPos = positionFromTransform(ct)
        
        let ray = NRay()
        ray.position = cameraPos
        ray.eulerAngles.x = camRot.x
        ray.eulerAngles.y = camRot.y
        ray.eulerAngles.z = camRot.z
        
        //ray.localRotate(by: SCNMatrix4MakeRotation(Float.pi, 0, 1, 0))
        ray.pivot = SCNMatrix4MakeRotation(Float.pi/2, 1, 0, 0)
        
        sceneView.scene.rootNode.addChildNode(ray)
    }
    
    
    func positionFromTransform(_ transform: matrix_float4x4) -> SCNVector3 {
        return SCNVector3Make(transform.columns.3.x, transform.columns.3.y, transform.columns.3.z)
    }
    
}

