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
    
    var updateTimer: Timer?
    
    var currentScore: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNewRound()
        updateLabels()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addScore() {
        currentScore += 1
        
        updateLabels()
        
        switch UIApplication.shared.applicationState {
        case .active:
            if updateTimer == nil {
                updateTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(calculateZeroScore), userInfo: nil, repeats: true)
            }
        case .background:
            break
        case .inactive:
            break
        }

    }
    
    func calculateZeroScore() {
        switch UIApplication.shared.applicationState {
        case .active:
            break
        case .background:
            startNewRound()
            updateLabels()
            updateTimer?.invalidate()
            updateTimer = nil
        case .inactive:
            break
        }
    }
    
    func startNewRound() {
        currentScore = 0
    }
    
    func updateLabels() {
        scoreLabel.text = String(currentScore)
    }
}
