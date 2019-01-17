//
//  ViewController.swift
//  GrapestoGrapes
//
//  Created by 64911 on 10/5/18.
//  Copyright © 2018 64911. All rights reserved.
//

import UIKit
import SpriteKit

class card {
    
    private var xPosition: Int
    private var yPosition: Int
    private var text = ""
    private var col = ""
    private var sprite: SKSpriteNode
    private var imageWidth: Int
    private var imageHeight: Int
    init (image: String, x: Int, y: Int){
        self.sprite = SKSpriteNode(imageNamed: image)
        self.xPosition = x
        self.yPosition = y
        self.sprite.position = CGPoint(x: xPosition, y: yPosition)
        self.imageWidth = Int(sprite.size.width)
        self.imageHeight = Int(sprite.size.height)
        self.sprite.colorBlendFactor = 0.7
        self.sprite.color = .black
        print(sprite.size)
    }
    
    //Color is assigned based on whether it is an adjective or noun
    func assignColor (color : String){
        self.col = color
    }
    
    //Checker if needed to determine what color a card is
    func getColor ()-> String {
        return self.col
    }
    /////////////////////////////////////
    func assignText (newText : String){
        self.text = newText
    }
    
    /////////////////////////////////////
    func getText ()-> String {
        return self.text
    }
    /////////////////////////////////////
    func getSprite ()-> SKSpriteNode {
        return self.sprite
    }
    ////////////////////////////////////
    func setPoint (xpos: Int ,ypos: Int, time: Int){
        self.sprite.run(SKAction.moveTo(x: CGFloat(xpos) , duration: TimeInterval(time)))
        self.sprite.run(SKAction.moveTo(y: CGFloat(ypos), duration: TimeInterval(time)))
    }
    ///////////////////////////////////
    func getImageWidth ()-> Int {
        return self.imageWidth
    }
    ///////////////////////////////////
    func getImageHeight ()-> Int {
        return self.imageHeight
    }
    ///////////////////////////////////
}

class player {
    
    private var cardsInHand: Int
    private var score: Int
    private var username: String
    private var status: Int
    private var cardHand = [card]()
    ///////////////////////////
    
    init(username1: String) {
        self.cardsInHand = 0
        self.score = 0
        self.username = username1
        self.status = 0
    }
    ///////////////////////////
    func setUsername (user : String) {
        self.username = user
    }
    ///////////////////////////
    func getUsername ()-> String {
        return self.username
    }
    ///////////////////////////
    func addScore () {
        self.score = score + 1
    }
    ///////////////////////////
    func setScore (newScore: Int) {
        self.score = newScore
    }
    //////////////////////////
    func getScore ()-> Int {
        return self.score
    }
    //////////////////////////
    func getCardsInHand ()-> Int {
        return self.cardsInHand
    }
    //////////////////////////
    func getStatus ()-> Int {
        return self.status
    }
    /////////////////////////
    func dealNewHand(availableCards: [card]) {
        //Deals player an entirely new hand
    }
    /////////////////////////
    func draw (availableCards: [card]){
        var rand: Int
        rand = Int(arc4random_uniform(UInt32(availableCards.count)))
        cardHand.append(availableCards[rand])
    }
    ////////////////////////
    func makeJudge() {
        //Assigns current player the role of judge
    }
    ////////////////////////
    
}

class ViewController: UIViewController {
  
    ////////////////////////////////////////
    @IBAction func startbutton(_ sender: Any) {
        performSegue(withIdentifier: "Start", sender: self)
    }
   /////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view = SKView()
    }
    ////////////////////////
    var skView: SKView {
        return view as! SKView
    }
    //////////////"MAIN FUNCTION"//////////////////////
    override func viewWillAppear(_ animated: Bool) {
        ////////////////////VARIABLES//////////////////
        // Screen width.
        var screenWidth: CGFloat {
            return UIScreen.main.bounds.width
        }
        print(screenWidth)
        // Screen height.
        var screenHeight: CGFloat {
            return UIScreen.main.bounds.height
        }
        print(screenHeight)
        let scene = SKScene(size: CGSize(width: screenWidth, height: screenHeight))
        let Rohan = card(image: "o", x: Int((screenWidth/2)), y: Int((screenHeight/2)))
        print(Rohan.getImageWidth())
        print(Rohan.getImageHeight())
        var destinationx = Int((screenWidth/2))
        var destinationy = Int((screenHeight/2))
        let winner = SKLabelNode(fontNamed: "Chalkduster")
        var win = false
        //////////////////////////////////////////////////
          //////////INITIALIZING THE SCENE//////////////////
        scene.scaleMode = .resizeFill
        scene.position = view.center
        skView.presentScene(scene)
        scene.backgroundColor = .white
        scene.addChild(Rohan.getSprite())
        destinationy = 200
        destinationx = 900
        Rohan.setPoint(xpos: destinationx, ypos: destinationy, time: 3)
        //////////////////////////////////////////////////
        ///////////THREAD TO CHECK "WIN" (TEMP) ///////////////////
        DispatchQueue.global(qos: .userInteractive).async {
            while (!win) {
            if (Rohan.getSprite().position == CGPoint(x: destinationx, y: destinationy) ){
                winner.text = "You Win!"
                winner.fontSize = 65
                winner.fontColor = SKColor.black
                winner.position = CGPoint(x: screenWidth/2, y: screenHeight/2)
                scene.addChild(winner)
                win = true
            }
        }
    }
        ///////////BOUNDARIES THREAD//////////////////////
        DispatchQueue.global(qos: .userInteractive).async {
            if (destinationx + (Rohan.getImageWidth()/2) > Int(screenWidth)){
                while(destinationx + (Rohan.getImageWidth()/2) > Int(screenWidth)){
                    destinationx = destinationx - 1
                }
                Rohan.setPoint(xpos: destinationx, ypos: destinationy, time: 3)
                print(destinationx)
            }
            if (destinationy > Int(screenHeight)){
                while(destinationy > Int(screenHeight)){
                    destinationy = destinationy - 1
                }
                Rohan.setPoint(xpos: destinationx, ypos: destinationy, time: 3)
            }
            
            
        }
       //////////////MAIN CONT//////////////////////////////
        func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            for touch: AnyObject in touches {
                let location = touch.location(in: view)
                destinationx = Int(location.x)
                destinationy = Int(location.y)
               
                print("Check")
            }
        }
    }
}

