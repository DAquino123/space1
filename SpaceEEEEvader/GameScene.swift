//
//  GameScene.swift
//  SpaceEEEEvader
//
//  Created by iD Student on 7/19/17.
//  Copyright © 2017 ID TECH. All rights reserved.
//


import SpriteKit

import GameplayKit

struct BodyType {
    
    static let None: UInt32 = 0
    static let Meteor: UInt32 = 1
    static let Bullet: UInt32 = 2
    static let Hero: UInt32 = 4
}

class GameScene: SKScene,
SKPhysicsContactDelegate{
    
    var level = 1
    
    var levelLabel = SKLabelNode(fontNamed: "Arial")
    
    var levelLimit = 5
    
    var levelIncrease = 5
    
    var enemies = [Enemy]()
    var enemyHealth = 3
    
    let hero = SKSpriteNode(imageNamed: "space")
    let heroSpeed: CGFloat = 100.0
   
    
    var meteorScore = 0
    
    var scoreLabel = SKLabelNode(fontNamed: "Arial")
    
    
    
    
    
    
    private var label : SKLabelNode?
    
    private var spinnyNode : SKShapeNode?
    
    
    
    override func didMove(to view: SKView) {
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedUp))
        
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeUp)

        let myLabel = SKLabelNode(fontNamed: "Chalkduster")
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedDown))
        
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedRight))
        
        swipeRight.direction = .right
        
        view.addGestureRecognizer(swipeRight)
        
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipedLeft))
        
        swipeLeft.direction = .left
        
        view.addGestureRecognizer(swipeLeft)

        
      
        
        scoreLabel.fontColor = UIColor.white
        
        scoreLabel.fontSize = 40
        
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height-50)
        
        addChild(scoreLabel)
        
        scoreLabel.text = "0"
        
        meteorScore = meteorScore + 1
        
        scoreLabel.text = "\(meteorScore)"
        
        
        myLabel.text = ""
        
        myLabel.fontSize = 65
        
        myLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(myLabel)
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
        levelLabel.fontColor = UIColor.yellow
        
        levelLabel.fontSize = 20
        
        levelLabel.position = CGPoint(x: self.size.width * 0.8, y: self.size.height * 0.9)
        
        addChild(levelLabel)
        
        levelLabel.text = "Level: 1"
        
addEnemies()
        if let label = self.label {
            
            label.alpha = 0.0
            
            label.run(SKAction.fadeIn(withDuration: 2.0))
            
        }
        backgroundColor = SKColor.black
        
        
        let xCoord = size.width * 0.5
        let yCoord = size.height * 0.5
        
        hero.size.height = 70
        hero.size.width = 70
        
        hero.position = CGPoint(x: xCoord, y: yCoord)
        hero.physicsBody = SKPhysicsBody(rectangleOf: hero.size)
  hero.physicsBody?.isDynamic = true
 hero.physicsBody?.categoryBitMask = BodyType.Hero
   hero.physicsBody?.contactTestBitMask = BodyType.Meteor
    hero.physicsBody?.collisionBitMask = 0

        addChild(hero)
        
        
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
  physicsWorld.contactDelegate = self
        
    }
    
    func addEnemies (){
        
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(addMeteor), SKAction.wait(forDuration: 1.0)])), withKey:"addEnemies")
        
    }
    
    func stopEnemies () {
        for enemy in enemies {
            enemy.removeFromParent()
        
        
        }
    removeAction (forKey: "add Enemies")
    
    }
    
    
    
    func increaseLevel(){
        
        levelLimit = levelLimit + levelIncrease
        
        level += 1
        
        levelLabel.text = "Level: \(level)"
    }
 
        
    func checkLevelIncrease() {
        
        if meteorScore > levelLimit {
            
            let runEnemies = SKAction.sequence([SKAction.run(stopEnemies), SKAction.wait(forDuration: 10.0), SKAction.run(increaseLevel), SKAction.run(addEnemies)])
            
            run(runEnemies)
        }
        for enemy in enemies {
            
            enemy.removeFromParent()
        }
        
        enemies = [Enemy]()
    }
        

    func swipedUp(sender:UISwipeGestureRecognizer){
        var actionMove: SKAction
        
        actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y + heroSpeed), duration: 0.5)
        hero.run(actionMove)
    
    
        if (hero.position.y + heroSpeed >= size.height){
            
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y + heroSpeed), duration: 0.5)
        }
        else {
            
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y + heroSpeed), duration: 0.5)
        }
    
    
    
    }

    
        
        func swipedDown(sender:UISwipeGestureRecognizer){
            var actionMove: SKAction
            
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y - heroSpeed), duration: 0.5)
           hero.run(actionMove)
            if (hero.position.y - heroSpeed <= 0){
                
                let pnt = CGPoint(x: hero.position.x, y:hero.size.height/2)
                actionMove = SKAction.move(to: pnt,duration: 0.5)
            
            }
            else{
                    actionMove = SKAction.move(to: CGPoint(x: hero.position.x, y: hero.position.y - heroSpeed), duration: 0.5)
            }
            hero.run(actionMove)
    }
    
    
    
        
        func swipedRight(sender:UISwipeGestureRecognizer){
            var actionMove: SKAction
            
            
            
            
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x + heroSpeed, y: hero.position.y), duration: 0.5)
            hero.run(actionMove)
        
            if (hero.position.x + heroSpeed >= size.width) {
                actionMove = SKAction.move(to: CGPoint(x: size.width - hero.size.width/2, y: hero.position.y), duration: 0.5)
            }
            else {
                actionMove = SKAction.move(to: CGPoint(x: hero.position.x + heroSpeed, y: hero.position.y), duration: 0.5)
                }
    hero.run(actionMove)
    }
    
        
    
    func swipedLeft(sender:UISwipeGestureRecognizer){
        var actionMove: SKAction
        
        
        
        
        actionMove = SKAction.move(to: CGPoint(x: hero.position.x - heroSpeed, y: hero.position.y), duration: 0.5)
        hero.run(actionMove)
   
        if (hero.position.x - heroSpeed <= 0) {
            actionMove = SKAction.move (to: CGPoint( x: hero.size.width/2, y: hero.position.y), duration:0.5)
        }
        else {
            actionMove = SKAction.move(to: CGPoint(x: hero.position.x - heroSpeed, y: hero.position.y), duration: 0.5)
        }
    
    hero.run(actionMove)
    
    
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
        let bullet = SKSpriteNode (imageNamed: "bullets thiing")
        bullet.size = CGSize(width: 30, height: 30)
        bullet.position = CGPoint (x: hero.position.x, y: hero.position.y)
    bullet.physicsBody = SKPhysicsBody(circleOfRadius: bullet.size.width/2)
       bullet.physicsBody?.isDynamic = true
        bullet.physicsBody?.categoryBitMask = BodyType.Bullet
        bullet.physicsBody?.contactTestBitMask = BodyType.Meteor
    bullet.physicsBody?.collisionBitMask = 0
        bullet.physicsBody?.usesPreciseCollisionDetection = true
        
        
        
        addChild(bullet)
   
        guard let touch = touches.first else { return}
        
        let touchLocation = touch.location(in: self)
        
        let vector = CGVector(dx: -(hero.position.x - touchLocation.x), dy: -(hero.position.y - touchLocation.y))
        
        
    
        let projectileAction = SKAction.sequence([
            SKAction.repeat(
    
            SKAction.move(by: vector, duration: 0.5), count: 10),
            SKAction.wait(forDuration: 0.5),
            SKAction.removeFromParent()
            ])
        bullet.run(projectileAction)
    
    }

    
        
    
    
    
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
        
    }
    
    
    
    
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
   
    
    
    func random() -> CGFloat {
        
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
        
    }
    
    func addMeteor() {
        var meteor: Enemy
        
        meteor = Enemy(imageNamed: "unnamed")
        
        
        meteor.size.height = 65
       
        meteor.size.width = 90
        
 
    let randomY = random() * ((size.height - meteor.size.height/2)-meteor.size.height/2) + meteor.size.height/2
    
        meteor.position = CGPoint(x: size.width + meteor.size.width/2, y: randomY)
        meteor.physicsBody = SKPhysicsBody(rectangleOf: meteor.size)
        meteor.physicsBody?.isDynamic = true
      meteor.physicsBody?.categoryBitMask = BodyType.Meteor
    meteor.physicsBody?.contactTestBitMask = BodyType.Bullet
        meteor.physicsBody?.collisionBitMask = 0
     var moveMeteor: SKAction
        
        moveMeteor = SKAction.move(to: CGPoint(x: -meteor.size.width/2, y:randomY), duration: (2.0))
        
        meteor.run(SKAction.sequence([moveMeteor, SKAction.removeFromParent()]))
        addChild(meteor)
        
        enemies.append(meteor)
        
    
    }
    func didBegin(_ contact: SKPhysicsContact){
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB
        let contactA = bodyA.categoryBitMask
        let contactB = bodyB.categoryBitMask
    
        

        switch contactA {
            
        case BodyType.Meteor:
            
            
            
            switch contactB {
                
                
                
            case BodyType.Meteor:
                
                break
                
                
                
            case BodyType.Bullet:
                if let bodyBNode = contact.bodyB.node as? SKSpriteNode, let bodyANode = contact.bodyA.node as? Enemy {
                    
                    bulletHitMeteor(bullet: bodyBNode, meteor: bodyANode)
 
                }
                
            
                if let bodyBNode = contact.bodyB.node as? SKSpriteNode, let bodyANode = contact.bodyA.node as? Enemy {
                    
                    heroHitMeteor(player: bodyBNode, meteor: bodyANode)
                    
                }
                
                
                
            default:
                
                break
                
            }
            
            
            
        case BodyType.Bullet:
            
            
            
            switch contactB {
                
                
                
            case BodyType.Meteor:
                
                if let bodyANode = contact.bodyA.node as? SKSpriteNode, let bodyBNode = contact.bodyB.node as? Enemy {
                    
                    bulletHitMeteor(bullet: bodyANode, meteor: bodyBNode)
             
                }
                
                
                
            case BodyType.Bullet:
                
                break
                
                
                
            case BodyType.Hero:
                
                break
                
                
                
            default:
                
                break
                
            }
            
            
            
        case BodyType.Hero:
            
            
            
            switch contactB {
                
                
                
            case BodyType.Meteor:
                
                if let bodyANode = contact.bodyA.node as? SKSpriteNode, let bodyBNode = contact.bodyB.node as? Enemy {
                    
                    heroHitMeteor(player: bodyANode, meteor: bodyBNode)
                    
                }           
                
                
                
            case BodyType.Bullet:
                
                break     
                
                
                
            case BodyType.Hero:
                
                break       
                
                
                
            default:
                
                break
                
            }
            
            
            
        default:
            
            break
            
        }
    
    
    
    }
    
    
    func bulletHitMeteor(bullet:SKSpriteNode, meteor: Enemy) {
        bullet.removeFromParent ()
        meteor.removeFromParent ()
        explodeMeteor(meteor : meteor)
        if let meteorIndex = enemies.index(of: meteor) {
            
            enemies.remove(at: meteorIndex)
        }
        
        }
    func heroHitMeteor(player:SKSpriteNode, meteor: Enemy){
        
        removeAllChildren()
        
        // Label Code
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        
        gameOverLabel.text = "Game Over"
        
        gameOverLabel.fontColor = UIColor.white
        
        gameOverLabel.fontSize = 40
        
        gameOverLabel.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        
        addChild(gameOverLabel)
    }
    
    func explodeMeteor(meteor: Enemy) {
        let explosions: [SKSpriteNode] = [SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode(), SKSpriteNode()]
    
        
        for explosion in explosions {
         explosion.color = UIColor.orange
            explosion.size = CGSize(width: 5, height: 3)
            explosion.position = CGPoint(x: meteor.position.x, y: meteor.position.y)
            let randomExplosionX = (random() * (1000 + size.width)) - size.width
            
            let randomExplosionY = (random() * (1000 + size.height)) - size.width
    addChild(explosion)
      
        
        
        
            let moveExplosion: SKAction
            
            moveExplosion = SKAction.move(to: CGPoint(x: randomExplosionX, y: randomExplosionY), duration: 10.0)
            explosion.run(SKAction.sequence([moveExplosion, SKAction.removeFromParent()]))

        
        
        }
    
    
    
    
    
    
    
    
    
    }
   
    
    
    
    
    
    
    
    
    
    


}
