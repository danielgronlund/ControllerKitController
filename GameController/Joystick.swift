//
//  Joystick.swift
//  GameController
//
//  Created by Daniel Grönlund on 2015-11-04.
//  Copyright © 2015 Daniel Grönlund. All rights reserved.
//

import SpriteKit
import CoreGraphics

class Joystick: SKNode {
    
    let maxHeadDistance: Float = 80.0
    let stiffness: Float = 10.0
    let numberOfStemSegments = 20
    
    private let head = SKSpriteNode(imageNamed: "joystick_head")

    
    override init() {
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func moveToParent(parent: SKNode) {
        
    }
    
    func setupJoystick() {
        
        self.userInteractionEnabled = true
        
        let base1 = SKSpriteNode(imageNamed: "joystick_base1")
        let base2 = SKSpriteNode(imageNamed: "joystick_base2")
        let base3 = SKSpriteNode(imageNamed: "joystick_base3")
        let base4 = SKSpriteNode(imageNamed: "joystick_base4")
       
        self.addChild(base1)
        self.addChild(base2)
        self.addChild(base3)
        self.addChild(base4)
        
        base1.zPosition = 0;
        base2.zPosition = 1;
        base3.zPosition = 3;
        base4.zPosition = 4;
        
        var index = 0
        
        for var i = 0; i < numberOfStemSegments; i++ {
            let stem:SKSpriteNode = SKSpriteNode(imageNamed: "joystick_stem")
            stem.zPosition = CGFloat(5 + i)
            self.addChild(stem);
            index = 5 + i
        }
        
        self.addChild(head)
        head.zPosition = CGFloat(index + 2)
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.removeAllActions()
        
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        //      let touchedNode = self.nodeAtPoint(positionInScene)
        
        var distance: Float = self.distanceBetweenPoints(positionInScene, second: CGPoint.zero)
        
        if distance > maxHeadDistance {
            distance = maxHeadDistance
        }
        
        let angle: Float = self.angleBetweenPoints(CGPoint.zero, second: positionInScene)
        
        let vx: Double = cos(Double( angle ) * M_PI / 180) * (Double( distance ));
        let vy: Double = sin(Double( angle ) * M_PI / 180) * (Double( distance ));
        
        var i:CGFloat = 1
        let layerCount:CGFloat = CGFloat(self.children.count)
        
        for var layer: SKNode in self.children {
            
            layer.position = CGPointMake(CGFloat(vx) * (i / layerCount),CGFloat(vy) * (i / layerCount))
            
            i = i + 1
        }
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch:UITouch = touches.first! as UITouch
        let positionInScene = touch.locationInNode(self)
        //      let touchedNode = self.nodeAtPoint(positionInScene)
        
        var distance: Float = self.distanceBetweenPoints(positionInScene, second: CGPoint.zero)
        
        if distance > maxHeadDistance {
            distance = maxHeadDistance
        }
        
        let angle: Float = self.angleBetweenPoints(CGPoint.zero, second: positionInScene)
        
        let vx: Double = cos(Double( angle ) * M_PI / 180) * (Double( distance ));
        let vy: Double = sin(Double( angle ) * M_PI / 180) * (Double( distance ));
        
        var i:CGFloat = 1
        let layerCount:CGFloat = CGFloat(self.children.count)
        
        for var layer: SKNode in self.children {
            
            layer.position = CGPointMake(CGFloat(vx) * (i / layerCount),CGFloat(vy) * (i / layerCount))
            
            i = i + 1
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.removeAllActions()
        
        let duration: Float = 1.0 - (stiffness / 10.0)
        let resetAction = SKAction.moveTo(CGPoint.zero, duration: Double(0.2))
        resetAction.timingMode = SKActionTimingMode.EaseOut
        
//        resetAction.timingFunction =  {
//            (t:Float) -> Float in
//            return sin(-13.0 * Float(M_PI)/2.0 * (t + 1.0)) * pow(2.0, -10.0 * t) + 1.0
//        }
        
        for var layer: SKNode in self.children {
            layer.runAction(resetAction)
        }
    }
    
    // Math
    
    func distanceBetweenPoints(first: CGPoint, second: CGPoint)->Float {
        let sx = Float(second.x)
        let sy = Float(second.y)
        let fx = Float(first.x)
        let fy = Float(first.y)
        return hypotf(sx - fx, sy - fy);
    }
    
    func angleBetweenPoints(first: CGPoint, second: CGPoint)->Float {
        let originPoint:CGPoint = CGPointMake(second.x - first.x, second.y - first.y)
        let bearingRadians: CGFloat = atan2(originPoint.y, originPoint.x)
        var bearingDegrees = Double(bearingRadians) * (180.0 / M_PI)
        
        bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees));
        
        return Float(bearingDegrees)
    }

}
