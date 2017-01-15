//
//  ViewController.swift
//  Bresket
//
//  Created by Jesus Noland on 1/4/17.
//  Copyright © 2017 JesusNoland. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreTextLabel: UILabel!
    @IBOutlet weak var resource1Label: UILabel!
    @IBOutlet weak var resource2Label: UILabel!
    @IBOutlet weak var resource3Label: UILabel!
    @IBOutlet weak var deathLabel: UILabel!
    
    @IBOutlet weak var seedButton: UIButton!
    @IBOutlet weak var craftButton: UIButton!
    
    // End of Outlets
    
    var resourceBarrel1: [String] = ["Grain", "Rock", "Berry", "Pinecone", "Weed", "Moss", "Grain"]
    var resourceBarrel2: [String] = ["Grain", "Rock", "Berry", "Pinecone", "Weed", "Moss", "Poop"]
    var resourceBarrel3: [String] = ["Grain", "Rock", "Berry", "Grain", "Weed", "Moss", "Grain"]
    
    var resourceBarrel1Index: Int = 0
    var resourceBarrel2Index: Int = 0
    var resourceBarrel3Index: Int = 0
    
    var craftedRecipe: String = "Nothing was crafted"
    
    var rounds: Int = 0
    
    var updateTimer: Timer?
    
    var currentScore: Int = 10
    
    // Inventory
    var playerInventory = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideCraftButton()
        hideResourceLabels()
        startNewGame()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func beginSeeding() {
        
        switch UIApplication.shared.applicationState {
        case .active:
            if updateTimer == nil {
                updateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(backgroundStartNewGame), userInfo: nil, repeats: true)
            }
        case .background:
            break
        case .inactive:
            break
        }
        
        
        // Hide the seed Button
        hideSeedButton()
        displayCraftButton()
        calculateResourceBarrelsIndexes()
        showResourceLabels()
    }
    
    @IBAction func beginCrafting() {
        craftRecipe()
        
        // Lose condition
        if currentScore <= 0 {
            hideAll()
            blankScreenWhite()
            displayDeathLabel()
        } else {
            startNewRound()
        }
    }
    
    func backgroundStartNewGame() {
        switch UIApplication.shared.applicationState {
        case .active:
            break
        case .background:
            startNewGame()
            updateTimer?.invalidate()
            updateTimer = nil
        case .inactive:
            break
        }
    }
    
    func startNewGame() {
        hideDeathLabel()
        hideCraftButton()
        hideResourceLabels()
        resetCurrentScore()
        displaySeedButton()
        displayScore()
        updateLabels()
        resetRounds()
    }
    
    func craftRecipe() {
        let lresource1: String = resourceBarrel1[resourceBarrel1Index]
        let lresource2: String = resourceBarrel2[resourceBarrel2Index]
        let lresource3: String = resourceBarrel3[resourceBarrel3Index]
        
        if lresource1 == "Grain" && lresource2 == "Grain" {
            craftedRecipe = "You made bread"
            currentScore += 2
        } else if lresource1 == "Grain" && lresource3 == "Grain" {
            craftedRecipe = "You made bread"
            currentScore += 2
        } else if lresource3 == "Grain" && lresource2 == "Grain" {
            craftedRecipe = "You made bread"
            currentScore += 2
        }
        
        if lresource1 == "Poop" || lresource2 == "Poop" || lresource3 == "Poop" {
            craftedRecipe = "Poop for dinner"
            currentScore -= 5
        }
        
        if lresource1 == "Rock" || lresource2 == "Rock" || lresource3 == "Rock" {
            craftedRecipe = "Stones soup"
            currentScore -= 3
        }
        
        if lresource1 == "Pinecone" || lresource2 == "Pinecone" || lresource3 == "Pinecone" {
            craftedRecipe = "Pine needles"
            currentScore -= 1
        }
        
        if lresource1 == "Weed" || lresource2 == "Weed" || lresource3 == "Weed" {
            craftedRecipe = "Disrupt my flow"
            currentScore += 1
        }
        
        if lresource1 == "Moss" || lresource2 == "Moss" || lresource3 == "Moss" {
            craftedRecipe = "Disrupt my flow"
            currentScore += 1
        }
    }
    
    func resetCurrentScore() {
        currentScore = 10
    }
    
    func displaySeedButton() {
        seedButton.isHidden = false
    }
    
    func displayCraftButton() {
        craftButton.isHidden = false
    }
    
    func hideSeedButton() {
        seedButton.isHidden = true
    }
    
    func hideCraftButton() {
        craftButton.isHidden = true
    }
    
    func startNewRound() {
        hideCraftButton()
        hideResourceLabels()
        displaySeedButton()
        updateLabels()
        
        rounds += 1
    }
    
    func updateLabels() {
        scoreLabel.text = String(currentScore)
    }
    
    func hideResourceLabels() {
        resource1Label.isHidden = true
        resource2Label.isHidden = true
        resource3Label.isHidden = true
    }
    
    func showResourceLabels() {
        // Set the text property of the labels
        resource1Label.text = resourceBarrel1[resourceBarrel1Index]
        resource2Label.text = resourceBarrel2[resourceBarrel2Index]
        resource3Label.text = resourceBarrel3[resourceBarrel3Index]
        
        resource1Label.isHidden = false
        resource2Label.isHidden = false
        resource3Label.isHidden = false
    }
    
    func calculateResourceBarrelsIndexes() {
        resourceBarrel1Index = Int(arc4random_uniform(7))
        resourceBarrel2Index = Int(arc4random_uniform(7))
        resourceBarrel3Index = Int(arc4random_uniform(7))
    }
    
    func blankScreenWhite() {
        view.backgroundColor = UIColor.white
    }
    
    func hideScore() {
        scoreLabel.isHidden = true
        scoreTextLabel.isHidden = true
    }
    
    func displayScore() {
        scoreLabel.isHidden = false
        scoreTextLabel.isHidden = false
    }
    
    func hideAll() {
        hideCraftButton()
        hideSeedButton()
        hideResourceLabels()
        hideScore()
    }
    
    func resetRounds() {
        rounds = 0
    }
    
    func displayDeathLabel() {
        if rounds == 1 {
            deathLabel.text = "\(rounds) day"
        } else if rounds <= 0 {
            deathLabel.text = "no life to live"
        } else {
            deathLabel.text = "\(rounds) days"
        }
        deathLabel.isHidden = false
    }
    
    func hideDeathLabel() {
        deathLabel.text = ""
        deathLabel.isHidden = true
    }
}
