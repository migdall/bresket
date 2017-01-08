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
    @IBOutlet weak var resource1Label: UILabel!
    @IBOutlet weak var resource2Label: UILabel!
    @IBOutlet weak var resource3Label: UILabel!
    
    @IBOutlet weak var seedButton: UIButton!
    
    // End of Outlets
    
    var resourceBarrel1: [String] = ["Grain", "Rock", "Berry", "Pinecone", "Weed", "Moss", "Grain"]
    var resourceBarrel2: [String] = ["Grain", "Rock", "Berry", "Pinecone", "Weed", "Moss", "Poop"]
    var resourceBarrel3: [String] = ["Grain", "Rock", "Berry", "Grain", "Weed", "Moss", "Grain"]
    
    var resourceBarrel1Index: Int = 0
    var resourceBarrel2Index: Int = 0
    var resourceBarrel3Index: Int = 0
    
    
    var updateTimer: Timer?
    
    var currentScore: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        calculateResourceBarrelsIndexes()
        showResourceLabels()
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
        startNewRound()
        updateLabels()
    }
    
    func resetCurrentScore() {
        currentScore = 0
    }
    
    func displaySeedButton() {
        seedButton.isHidden = false
    }
    
    func hideSeedButton() {
        seedButton.isHidden = true
    }
    
    func startNewRound() {
        resetCurrentScore()
        displaySeedButton()
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
}
