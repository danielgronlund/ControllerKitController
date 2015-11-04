//
//  GameScene.swift
//  GameController
//
//  Created by Daniel Grönlund on 2015-11-03.
//  Copyright (c) 2015 Daniel Grönlund. All rights reserved.
//

import SpriteKit
import Act
import ControllerKit
import UIKit

class GameScene: SKScene {
    
    var controllerServer: Server!
    
    let joystick = Joystick.init()
    let buttonA = Button(imageNamed: "button_up")
    let buttonB = Button(imageNamed: "button_up")
    
    func setupServer() {
        controllerServer = Server(name: "Controller11" , controllerTypes: [.MFi])
    }
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        self.addChild(joystick)
        joystick.position = CGPoint(x: (self.frame.size.width / 2) * 0.5, y:self.frame.size.height / 2)
        joystick.yScale = 1.5
        joystick.xScale = 1.5
        
        self.addChild(buttonA)
        buttonA.yScale = 1.5;
        buttonA.xScale = 1.5;
        
        buttonA.setImageForState("button_down", state: ButtonState.Down)
        buttonA.setImageForState("button_up", state: ButtonState.Up)
        
        self.addChild(buttonB)
      
        buttonB.setImageForState("button_down", state: ButtonState.Down)
        buttonB.setImageForState("button_up", state: ButtonState.Up)
        
        buttonB.yScale = 1.5
        buttonB.xScale = 1.5
        let buttonCenterX = (self.frame.size.width / 2) + ( (self.frame.size.width / 2) * 0.5 )
        buttonA.position = CGPoint(x: buttonCenterX - 140, y:self.frame.size.height / 2)
        buttonB.position = CGPoint(x: buttonCenterX + 100, y:self.frame.size.height / 2)
        
        joystick.setupJoystick()
        self.scene?.backgroundColor = SKColor.lightGrayColor()
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//       // self.head.position = touches.first!.locationInNode(self.parent!)
//        
//        let touch:UITouch = touches.first! as UITouch
//        let positionInScene = touch.locationInNode(self)
//        let touchedNode = self.nodeAtPoint(positionInScene)
//        
//        if touchedNode.isKindOfClass(Joystick) {
//            joystick.touchesBegan(touches, withEvent: event)
//        }
//    }
    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.head.position = touches.first!.locationInNode(self.parent!)
//    }
}
