//
//  GameScene.swift
//  ConwayGameofLife
//
//  Created by JeffChiu on 6/23/16.
//  Copyright (c) 2016 JeffChiu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    /* Game objects */
    var gridNode: Grid!

    
    /* UI Objects */
    var stepButton: MSButtonNode!
    var populationLabel: SKLabelNode!
    var generationLabel: SKLabelNode!
    var playButton: MSButtonNode!
    var pauseButton: MSButtonNode!
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* Connect scene objects */
        gridNode = childNodeWithName("gridNode") as! Grid
        
        /* Connect UI scene objects */
        stepButton = childNodeWithName("stepButton") as! MSButtonNode
        populationLabel = childNodeWithName("populationLabel") as! SKLabelNode
        generationLabel = childNodeWithName("generationLabel") as! SKLabelNode
        playButton = childNodeWithName("playButton") as! MSButtonNode
        pauseButton = childNodeWithName("pauseButton") as! MSButtonNode
        
        /* Setup testing button selected handler */
        stepButton.selectedHandler = {
            self.stepSimulation()
        }
        
        /* Setup play button selected handler */
        playButton.selectedHandler = {
            self.paused = false
        }
        
        /* Setup pause button selected handler */
        pauseButton.selectedHandler = {
            self.paused = true
        }
        
        /* Create an SKAction based timer, 0.5 second delay */
        let delay = SKAction.waitForDuration(0.5)
        
        /* Call the stepSimulation() method to advance the simulation */
        let callMethod = SKAction.performSelector(#selector(GameScene.stepSimulation), onTarget: self)
        
        /* Create the delay,step cycle */
        let stepSequence = SKAction.sequence([delay,callMethod])
        
        /* Create an infinite simulation loop */
        let simulation = SKAction.repeatActionForever(stepSequence)
        
        /* Run simulation action */
        self.runAction(simulation)
        
        /* Default simulation to pause state */
        self.paused = true
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func stepSimulation() {
        /* Step Simulation */
        
        /* Run next step in simulation */
        gridNode.evolve()
        
        /* Update UI label objects */
        populationLabel.text = String(gridNode.population)
        generationLabel.text = String(gridNode.generation)
    }
}
