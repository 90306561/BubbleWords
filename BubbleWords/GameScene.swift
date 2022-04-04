//
//  GameScene.swift
//  jake-evan-erik
//
//  Created by 90306561 on 3/16/22.

import SpriteKit
import GameplayKit


let allWords: [[String]] = [wordsA, wordsB, wordsC, wordsD, wordsE, wordsF, wordsG, wordsH, wordsI, wordsJ, wordsK, wordsL, wordsM, wordsN, wordsO, wordsP, wordsQ, wordsR, wordsS, wordsT, wordsU, vwxyzWords]

var cancelMode = false

var word : SKLabelNode!
var score : SKLabelNode!
var scoreInt = 0
var val = 0

let letters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
      
// weigthed letter adjustment
let weighted: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 9, 10, 11, 11, 11, 11, 12, 12, 13, 13, 13, 13, 13, 13, 13, 14, 14, 14, 14, 14, 14, 14, 14, 15, 15, 16, 17, 17, 17, 17, 17, 18, 18, 18, 18, 18, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 20, 20, 21, 22, 22, 23, 24, 24, 25]

let scrabble: [Int] = [1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10]


var A = SKSpriteNode(imageNamed: letters[0])
var B = SKSpriteNode(imageNamed: letters[1])
var C = SKSpriteNode(imageNamed: letters[2])
var D = SKSpriteNode(imageNamed: letters[3])
var E = SKSpriteNode(imageNamed: letters[4])
var F = SKSpriteNode(imageNamed: letters[5])
var G = SKSpriteNode(imageNamed: letters[6])
var H = SKSpriteNode(imageNamed: letters[7])
var I = SKSpriteNode(imageNamed: letters[8])
var J = SKSpriteNode(imageNamed: letters[9])
var K = SKSpriteNode(imageNamed: letters[10])
var L = SKSpriteNode(imageNamed: letters[11])
var M = SKSpriteNode(imageNamed: letters[12])
var N = SKSpriteNode(imageNamed: letters[13])
var O = SKSpriteNode(imageNamed: letters[14])
var P = SKSpriteNode(imageNamed: letters[15])
var Q = SKSpriteNode(imageNamed: letters[16])
var R = SKSpriteNode(imageNamed: letters[17])
var S = SKSpriteNode(imageNamed: letters[18])
var T = SKSpriteNode(imageNamed: letters[19])
var U = SKSpriteNode(imageNamed: letters[20])
var V = SKSpriteNode(imageNamed: letters[21])
var W = SKSpriteNode(imageNamed: letters[22])
var X = SKSpriteNode(imageNamed: letters[23])
var Y = SKSpriteNode(imageNamed: letters[24])
var Z = SKSpriteNode(imageNamed: letters[25])

var check = SKSpriteNode(imageNamed: "check")
var cancel = SKSpriteNode(imageNamed: "X")

var Shooter = SKSpriteNode(imageNamed: "Shooter")
var BS = SKSpriteNode(imageNamed: "BS")
var Ball = SKSpriteNode(imageNamed: "Ball")


var nodes: [SKSpriteNode] = [A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z]
var XWords: [SKSpriteNode] = []

let aCount = wordsA.count
let bCount = wordsB.count
let cCount = wordsC.count
let dCount = wordsD.count
let eCount = wordsE.count
let fCount = wordsF.count
let gCount = wordsG.count
let hCount = wordsH.count
let iCount = wordsI.count
let jCount = wordsJ.count
let kCount = wordsK.count
let lCount = wordsL.count
let mCount = wordsM.count
let nCount = wordsN.count
let oCount = wordsO.count
let pCount = wordsP.count
let qCount = wordsQ.count
let rCount = wordsR.count
let sCount = wordsS.count
let tCount = wordsT.count
let uCount = wordsU.count
let vwxyzCount = vwxyzWords.count
let count: [Int] = [aCount, bCount, cCount, dCount, eCount, fCount, gCount, hCount, iCount, jCount, kCount, lCount, mCount, nCount, oCount, pCount, qCount, rCount, sCount, tCount, uCount, vwxyzCount, vwxyzCount, vwxyzCount, vwxyzCount, vwxyzCount]

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    

    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        initialize()
        
        
    }
    
    func findList(length: Int) -> [String]{
        var index = 0
        var isFound = false
        while(!isFound){
           let tempWords = allWords[index]
            if(length == tempWords.count){
                isFound = true
                return allWords[index]
            }
            index += 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
        let touchLocation = touch.location(in: self)
        let touchedWhere = nodes(at: touchLocation)
            if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == Shooter {
                                let x2 = touchLocation.x
                                let y2 = touchLocation.y
                                let x1 = 0.0
                                //let y1 = -267.0
                                let y1 = sqrt((x2*x2)+pow((y2+321), 2)) + -321
                                let theta = atan((y2-y1) / (x2-CGFloat(x1)))
                                Shooter.zRotation = theta
                            }
                            if sprite == check {
                                if word.text != "" {
                                    let firstLetter = word.text!.prefix(1)
                                    var position = -1
                                    var quickboolean = false
                                    while (!quickboolean) {
                                        position += 1
                                        if firstLetter == letters[position] {
                                            quickboolean = true
                                        }
                                    }
                                    var tempArray: [String]
                                    tempArray = findList(length: count[position])
                                    for xyz in 0...(tempArray.count - 1) {
                                        if tempArray[xyz].localizedUppercase == word.text! {
                                            scoreInt += scrabVal()
                                            score.text = "Score: " + String(scoreInt)
                                            word.text = ""
                                            XWords.removeAll()
                                            return
                                        }
                                    }
                                }
                            }
                            if sprite == cancel {
                                if cancelMode {
                                    cancelMode = false
                                }
                                else if word.text != "" {
                                    scoreInt -= scrabVal()
                                    score.text = "Score: " + String(scoreInt)
                                    for wifdjn in 0...(XWords.count - 1){
                                        addChild(XWords[wifdjn])
                                    }
                                    word.text = ""
                                }
                                else{cancelMode = true}
                            }
                        }
                    }
                }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedWhere = nodes(at: touchLocation)
            
            if !touchedWhere.isEmpty {
                for node in touchedWhere {
                    if let sprite = node as? SKSpriteNode {
                        if sprite == Shooter {
                            let x2 = touchLocation.x
                            let y2 = touchLocation.y
                            let x1 = 0.0
                            let y1 = sqrt((x2*x2)+pow((y2+321), 2)) + -321
                            let theta = atan((y2-y1) / (x2-CGFloat(x1)))
                            Shooter.zRotation = theta
                            Shooter.removeFromParent()
                            addChild(Shooter)
                        }
                    }
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchLocation = touch.location(in: self)
            let touchedWhere = nodes(at: touchLocation)
            
            if !touchedWhere.isEmpty {
                for node in touchedWhere {
                    if let sprite = node as? SKSpriteNode {
                        if sprite == Shooter {
                            let dx = (touchLocation.x * 2)
                            let dy = -(touchLocation.y)
                            Shooter.removeFromParent()
                            BS.zRotation = Shooter.zRotation
                            Ball.position = CGPoint(x: touchLocation.x, y: touchLocation.y)
                            Ball.physicsBody?.mass = 0.0997
                            addChild(Ball)
                            addChild(BS)
                            Ball.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
                        }
                    }
                }
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Ball" {
            collision(between: contact.bodyA.node!, object: contact.bodyB.node!)
        }
        else if contact.bodyB.node?.name == "Ball" {
            collision(between: contact.bodyB.node!, object: contact.bodyA.node!)
        }
    }
    
    func scrabVal() -> Int {
        var tempWord = word.text!
        var scrabScore = 0
        while tempWord.count > 0 {
            for scrabblevalues in 0...25 {
                if tempWord.prefix(1) == letters[scrabblevalues ] {
                    scrabScore += scrabble[scrabblevalues]
                    tempWord = String(tempWord.suffix(tempWord.count - 1))
                }
                
            }
        }
        return scrabScore
    }
    
    func collision(between Ball: SKNode, object: SKNode) {
        if object != Shooter && object != BS {
            Ball.removeFromParent()
            BS.removeFromParent()
            Shooter.removeFromParent()
            addChild(Shooter)
            Shooter.zRotation = 0
            for number in 0...(BubbleWords.nodes.count - 1) {
                    if object == BubbleWords.nodes[number]{
                        if cancelMode {
                            object.removeFromParent()
                        }
                        else {
                            var cancelWord : SKSpriteNode!
                            cancelWord = object as? SKSpriteNode
                            var used: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
                            object.removeFromParent()
                            var quickLetter = ""
                            if number > 25 {
                                quickLetter = String(object.name!.prefix(1))
                            }
                            else {quickLetter = letters[number]}
                            for numers in 0...25 {
                                if  quickLetter == letters[numers]{
                                    if used[numers] == 0 {
                                        XWords.append(cancelWord)
                                        used[numers] += 1
                                    }
                                    else {
                                        var usedNum = used[number]
                                        var usedName = letters[number]
                                        while usedNum > 0 {
                                            usedName += letters[number]
                                            usedNum -= 1
                                        }
                                        cancelWord.name = usedName
                                        XWords.append(cancelWord)
                                    }
                                    word.text = word.text! + quickLetter
                                    return
                                }
                            }
                        }
                }
            }
        }
        
        
        
    }
    
    
    
    func initialize(){
        check.position = CGPoint(x: 137.5, y: -337.847)
        check.zPosition = 1
        addChild(check)
        cancel.position = CGPoint(x: -137.5, y: -337.847)
        cancel.zPosition = 1
        addChild(cancel)
        
        Shooter.size = CGSize(width: 78, height: 108)
        Shooter.position = CGPoint(x: 0, y: -321)
        addChild(Shooter)
        BS.size = CGSize(width: 78, height: 108)
        BS.position = CGPoint(x: 0, y: -321)
        Ball.size = CGSize(width: 35, height: 35)
        Ball.physicsBody = SKPhysicsBody(circleOfRadius: 17.5)
        Ball.physicsBody?.contactTestBitMask = Ball.physicsBody?.collisionBitMask ?? 0
        Ball.physicsBody?.affectedByGravity = false
        Ball.zPosition = 0
        Ball.name = "Ball"
        let size = width/8
        let gap = 2 * size / 5
        var localWidth = width / 2 - size / 2
        //look into if can detect notch
        var localHeight = height / 2 - size / 2 - 50
        
        print(String(localWidth - 5))
        print(String(localHeight + 10))
        print(width)
        print(height)
        word = SKLabelNode(text: "")
        word.fontName = "Microsoft Sans Serif"
        word.fontSize = 18.0
        word.position = CGPoint(x: localWidth - 10, y: localHeight + 30)
        addChild(word)
        score = SKLabelNode(text: "Score: 0")
        score.fontName = "Microsoft Sans Serif"
        score.fontSize = 18.0
        score.position = CGPoint(x: -1 * (localWidth - 10), y: localHeight + 30)
        addChild(score)
        
        var n = 0
        
        var used: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        while n < 30 {
            
            let randomInt = Int.random(in: 0...100)
            let random = weighted[randomInt]
            
            if used[random] == 0 {
                BubbleWords.nodes[random] = SKSpriteNode(imageNamed: letters[random])
                BubbleWords.nodes[random].size = CGSize(width: size, height: size)
                BubbleWords.nodes[random].position = CGPoint(x: localWidth, y: localHeight)
                
                BubbleWords.nodes[random].physicsBody = SKPhysicsBody(rectangleOf: BubbleWords.nodes[random].size)
                BubbleWords.nodes[random].physicsBody?.contactTestBitMask = BubbleWords.nodes[random].physicsBody?.collisionBitMask ?? 0
                BubbleWords.nodes[random].physicsBody?.affectedByGravity = false
                BubbleWords.nodes[random].zPosition = 0
                BubbleWords.nodes[random].physicsBody?.isDynamic = false
                addChild(BubbleWords.nodes[random])
                used[random] += 1
            }
            else {
                var usedNum = used[random]
                var usedName = letters[random]
                while usedNum > 0 {
                    usedName += letters[random]
                    usedNum -= 1
                }
                let numberOf = BubbleWords.nodes.count
                var testL = SKSpriteNode(imageNamed:letters[random])
                testL = SKSpriteNode(imageNamed: letters[random])
                testL.size = CGSize(width: size, height: size)
                testL.position = CGPoint(x: localWidth, y: localHeight)
                testL.physicsBody = SKPhysicsBody(rectangleOf: testL.size)
                testL.physicsBody?.contactTestBitMask = testL.physicsBody?.collisionBitMask ?? 0
                testL.physicsBody?.affectedByGravity = false
                testL.physicsBody?.isDynamic = false
                testL.zPosition = 0
                BubbleWords.nodes.append(testL)
                BubbleWords.nodes[numberOf].name = usedName
                addChild(BubbleWords.nodes[numberOf])
                BubbleWords.nodes[numberOf].name = usedName
                
            }
            
            
            n+=1
            
            localWidth = localWidth - gap - size
            
            if n % 6 == 0 {
                localWidth = width / 2 - size / 2
                localHeight -= (gap + size)
            }
        }

         
    }
}

