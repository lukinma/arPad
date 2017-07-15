//
//  AppDelegate.swift
//  arPad
//
//  Copyright © 2017 xnzr. All rights reserved.
//

import Foundation
import SceneKit

class NRay: SCNNode {
    override init() {
        super.init()
        
        let obj = SCNCylinder(radius: 0.001, height: 10)
        obj.firstMaterial?.diffuse.contents = UIColor.red
        self.geometry = obj
        //rq = SCNQua
        //self.localRotate(by: <#T##SCNQuaternion#>)
        //self.geometry.pivot = SCNMatrix4MakeRotation(CGFloat(M_PI_2), 1, 0, 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

