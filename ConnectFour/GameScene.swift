//
//  GameScene.swift
//  Mastermind
//
//  Created by Riley John Gibbs on 4/23/20.
//  Copyright © 2020 Riley John Gibbs. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var board: Board!
    var gameLogo: SKLabelNode!
    var bestScore: SKLabelNode!
    var playButton: SKShapeNode!

    override func didMove(to view: SKView) {
        initializeMenu()
        board = Board()
        createBoard()
    }
    
    
    private func initializeMenu() {
        //Create game title
        gameLogo = SKLabelNode(fontNamed: "ArialRoundedMTBold")
        gameLogo.zPosition = 1
        gameLogo.position = CGPoint(x: 0, y: (frame.size.height / 2) - 200)
        gameLogo.fontSize = 60
        gameLogo.text = "Connect Four"
        gameLogo.fontColor = SKColor.purple
        self.addChild(gameLogo)
        playButton = SKShapeNode()
        playButton.name = "play_button"
        playButton.zPosition = 1
        playButton.position = CGPoint(x: 0, y: (frame.size.height / -2) + 200)
        playButton.fillColor = SKColor.cyan
        let topCorner = CGPoint(x: -50, y: 50)
        let bottomCorner = CGPoint(x: -50, y: -50)
        let middle = CGPoint(x: 50, y: 0)
        let path = CGMutablePath()
        path.addLine(to: topCorner)
        path.addLines(between: [topCorner, bottomCorner, middle])
        playButton.path = path
        self.addChild(playButton)
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let touchedNode = self.nodes(at: location)
            for node in touchedNode {
                if node.name == "play_button" {
                    startGame()
                }
            }
        }
    }

    private func startGame() {
        createBoard()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    private func createBoard() {
        let width: CGFloat = frame.size.width * 7 / 9
        let cellWidth: CGFloat = width / CGFloat(board.NUM_COLUMNS)
        let height = cellWidth * CGFloat(board.NUM_ROWS)
        var x = width / -2 + cellWidth / 2
        var y = height / -2 + cellWidth / 2
        for col in board.columns {
            for cell in col.cells {
                let node = SKShapeNode(rectOf: CGSize(width: cellWidth, height: cellWidth))
                node.zPosition = 2
                node.position = CGPoint(x: x, y: y)
                node.strokeColor = SKColor.black
                cell.node = node
                cell.fill()
                addChild(node)
                y += cellWidth
            }
            let dropper = SKShapeNode()
            dropper.zPosition = 2
            dropper.position = CGPoint(x: x, y: y + cellWidth)
            dropper.fillColor = SKColor.cyan
            let path = CGMutablePath()
            path.addLines(between: [
                CGPoint(x: -cellWidth / 2 + 10, y: cellWidth / 2 - 10),
                CGPoint(x: cellWidth / 2 - 10, y: cellWidth / 2 - 10),
                CGPoint(x: 0, y: -cellWidth / 2 + 10)
            ])
            dropper.path = path
            addChild(dropper)
            col.dropper = dropper
            x += cellWidth
            y = height / -2 + cellWidth / 2
        }
    }
}
