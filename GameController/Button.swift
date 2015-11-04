//
//  Button.swift
//  GameController
//
//  Created by Daniel Grönlund on 2015-11-04.
//  Copyright © 2015 Daniel Grönlund. All rights reserved.
//

import SpriteKit

public enum ButtonState: String {
    case Up = "up"
    case Down = "down"
}

class Button: SKSpriteNode {
    
    var currentState: ButtonState = ButtonState.Up
   
    var buttonImages:[ButtonState:String] = [:]

    func setImageForState(imageNamed:  String, state: ButtonState) {
        buttonImages[state] = imageNamed
        self.userInteractionEnabled = true
    }
    
    func setCurrentState(state: ButtonState) {
        currentState = state
        self.texture = SKTexture(imageNamed: buttonImages[state]!)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.setCurrentState(ButtonState.Down)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.setCurrentState(ButtonState.Down)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.setCurrentState(ButtonState.Up)
    }
    
}
