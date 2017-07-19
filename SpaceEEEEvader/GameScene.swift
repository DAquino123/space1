//
//  GameScene.swift
//  SpaceEEEEvader
//
//  Created by iD Student on 7/19/17.
//  Copyright © 2017 ID TECH. All rights reserved.
//


import SpriteKit

import GameplayKit



class GameScene: SKScene {
    
    
    let hero = SKSpriteNode(imageNamed: "Spaceship")
    
    private var label : SKLabelNode?
    
    private var spinnyNode : SKShapeNode?
    
    
    
    override func didMove(to view: SKView) {
        
        let myLabel = SKLabelNode(fontNamed: "Chalkduster")
        
        myLabel.text = "Hello World"
        
        myLabel.fontSize = 65
        
        myLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(myLabel)
        
        // Get label node from scene and store it for use later
        
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        
        if let label = self.label {
            
            label.alpha = 0.0
            
            label.run(SKAction.fadeIn(withDuration: 2.0))
            
        }
        backgroundColor = SKColor.black
        
        
        let xCoord = size.width * 0.5
        let yCoord = size.height * 0.5
        
        hero.size.height = 50
        hero.size.width = 50
        
        hero.position = CGPoint(x: xCoord, y: yCoord)
        
        addChild(hero)
        
        
        // Create shape node to use during mouse interaction
        
        
        
    }
    
    
    
    
    
    func touchDown(atPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            
            n.position = pos
            
            n.strokeColor = SKColor.green
            
            self.addChild(n)
            
        }
        
    }
    
    
    
    func touchMoved(toPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            
            n.position = pos
            
            n.strokeColor = SKColor.blue
            
            self.addChild(n)
            
        }
        
    }
    
    
    
    func touchUp(atPoint pos : CGPoint) {
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            
            n.position = pos
            
            n.strokeColor = SKColor.red
            
            self.addChild(n)
            
        }
        
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
       
        
    }
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
        
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
    }
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // Called before each frame is rendered
        
    }
    
    
    
}

