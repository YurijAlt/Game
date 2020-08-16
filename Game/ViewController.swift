//
//  ViewController.swift
//  Game
//
//  Created by SummeR on 05.08.2020.
//  Copyright © 2020 SummeR. All rights reserved.
//

import UIKit
import AudioToolbox
class ViewController: UIViewController {
    
    @IBAction func stepperChanged(_ sender: UIStepper) {
        updateUI()
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameField: UIView!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var shapeX: NSLayoutConstraint!
    @IBOutlet weak var shapeY: NSLayoutConstraint!
    @IBOutlet weak var gameObject: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var finalResult: UILabel!
    @IBOutlet weak var sasha: UIImageView!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var sliderOutlet: UISlider!
    
    
    @IBAction func slider(_ sender: Any) {
    }
    
    private func sliderHidden() {
        sliderOutlet.isHidden = true
    }
    
    private func changeColor() {

       
        
        gameField.layer.borderWidth = 4
               gameField.layer.borderColor = UIColor.red.cgColor
    }
    
    
    
    @IBAction func objectTapped(_ sender: Any) {repositionImageTimer()
        guard isGameActive else { return }
       
        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
    impactMed.impactOccurred()
        changeColor()
        
        repositionImageTimer()
        score += 1
        //AudioServicesPlaySystemSound (1000)
    }
    
    private var isGameActive = false
    private var gameTimeLeft: TimeInterval = 0
    private var gameTimer: Timer?
    private var timer: Timer?
    private let displayDuration: TimeInterval = 2
    private var score = 0

    
    
    
    
    
    private func startGame() {
        speed.text = "Скорость: \(Float(sliderOutlet.value))"
        gameField.backgroundColor = UIColor.systemGray4
        score = 0
        finalResult.isHidden = !isGameActive
        sasha.isHidden = !isGameActive
        repositionImageTimer()
        gameTimer?.invalidate()
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTimeTick), userInfo: nil, repeats: true)
        gameTimeLeft = stepper.value
        isGameActive = true
        updateUI()
        sliderHidden()
    }
    
    private func stopGame() {
        gameField.backgroundColor = UIColor.white
        isGameActive = false
        updateUI()
        gameTimer?.invalidate()
        timer?.invalidate()
        scoreLabel.text = "Последний счет: \(score)"
        finalResult.isHidden = false
        sasha.isHidden = false
        finalResult.text = String(score)
        sliderOutlet.isHidden = false
    }
    
    
    private func repositionImageTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(sliderOutlet.value), target: self,selector: #selector (moveToImage), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    
    private func updateUI() {
        gameObject.isHidden = !isGameActive
        stepper.isEnabled = !isGameActive
        if isGameActive {
            timeLabel.text = "Осталось \(Int(gameTimeLeft)) сек"
            actionButton.setTitle("Остановить", for: .normal)
        } else { timeLabel.text = "Время: \(Int(stepper.value)) сек"
            actionButton.setTitle("Начать", for: .normal)
        }
    }
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        
        if isGameActive {
            stopGame()
        } else {
            startGame()
        }
    }
    
    //code 1
    
    
    @objc private func gameTimeTick() {
        gameTimeLeft -= 1
        if gameTimeLeft <= 0 {
            stopGame()
        } else {
            updateUI()
        }
    }
    
    @objc private func moveToImage() {
        let maxX = gameField.bounds.maxX - gameObject.frame.width
        let maxY = gameField.bounds.maxY - gameObject.frame.height
        shapeX.constant = CGFloat(arc4random_uniform(UInt32(maxX)))
        shapeY.constant = CGFloat(arc4random_uniform(UInt32(maxY)))
    }
    
    
    
    
    override func viewDidLoad() {
        speed.text = "Скорость: \(Float(sliderOutlet.value))"
        sasha.isHidden = !isGameActive
        finalResult.isHidden = !isGameActive
        super.viewDidLoad()
        gameField.layer.borderWidth = 1
        gameField.layer.borderColor = UIColor.purple.cgColor
        gameField.layer.cornerRadius = 25
        updateUI()
        
        
    }
    
    
}

