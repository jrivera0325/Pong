//
//  GameScene.swift
//  Pong
//
//  Created by Julio Rivera on 4/15/19.
//  Copyright © 2019 John Hersey High School. All rights reserved.
//

import SpriteKit
import GameplayKit

let paddleCategory: UInt32 = 1
let topCategory: UInt32 = 2
let ballCategory: UInt32 = 4  // 0x1 << 5

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var topPaddle = SKSpriteNode()
    var ball = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = border
        
       let topLeft = CGPoint(x: frame.origin.x, y: -frame.origin.y)
       let topRight = CGPoint(x: -frame.origin.x, y: -frame.origin.y)
        
        let top = SKNode()
        top.name = "top"
        top.physicsBody = SKPhysicsBody(edgeFrom: topLeft, to: topRight)
        self.addChild(top)
        
        topPaddle = self.childNode(withName: "topPaddle") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        topPaddle.physicsBody?.contactTestBitMask = paddleCategory
        ball.physicsBody?.contactTestBitMask = ballCategory
        top.physicsBody?.contactTestBitMask = topCategory
        
        ball.physicsBody?.contactTestBitMask = topCategory|paddleCategory
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
//        print(contact.bodyA.node?.name)
//        print(contact.bodyB.node?.name)
        if contact.bodyA.contactTestBitMask == topCategory{
            changePaddle(node: topPaddle)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        topPaddle.run(SKAction.moveTo(x: location.x, duration: 0.2))
    }
    
    func changePaddle(node: SKSpriteNode) {
        if node.color == .red {
            node.removeAllActions()
            node.removeFromParent()
        }
        node.color = .red
    }
    
}
