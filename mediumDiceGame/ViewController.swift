//
//  ViewController.swift
//  mediumDiceGame
//
//  Created by Lai Po Ying on 2021/5/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var diceImageViews: [UIImageView]!
    @IBOutlet weak var showLabel: UILabel!
    @IBOutlet weak var diceCup: UIImageView!
    @IBOutlet weak var stepperValue: UIStepper!
    @IBOutlet weak var totalMoneyLabel: UILabel!
    @IBOutlet weak var stakesLabel: UILabel!
    
    var diceTotal = 0
    var totalMoney = 1000
    var stakes = 0
    
    func open() {
        if diceCup.isHidden == false {
            for diceImage in diceImageViews {
                let randomnumber = Int.random(in: 1...6)
                diceImage.image = UIImage.init(systemName: "die.face.\(randomnumber).fill")
                diceTotal += randomnumber
            }
            diceCup.isHidden = true
            showLabel.text = "總點數為：\(diceTotal)"
        }
    }
    func win() {
        let alert = UIAlertController(title: "Congratulations!", message: "You earn the money!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next round", style: .default, handler: {
            action in
            self.totalMoney += Int(self.stakes)
            self.totalMoneyLabel.text = "\(self.totalMoney)"
            self.stepperValue.value = 1
            self.stakes = Int(self.stepperValue.value * 100)
            self.stakesLabel.text = "\(self.stakes)"
            self.diceCup.isHidden = false
            self.showLabel.text = "猜大猜小，猜對贏錢，猜錯賠錢"
            self.diceTotal = 0
            self.stepperValue.maximumValue = Double(self.totalMoney/100)
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func lose() {
        let alert = UIAlertController(title: "Oops!", message: "You lose the money!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Next round", style: .default, handler: {
            action in
            self.totalMoney -= Int(self.stakes)
            self.totalMoneyLabel.text = "\(self.totalMoney)"
            self.stepperValue.value = 1
            self.stakes = Int(self.stepperValue.value * 100)
            self.stakesLabel.text = "\(self.stakes)"
            self.diceCup.isHidden = false
            self.showLabel.text = "猜大猜小，猜對贏錢，猜錯賠錢"
            self.diceTotal = 0
            self.stepperValue.maximumValue = Double(self.totalMoney/100)
            if self.totalMoney == 0 {
                let alert = UIAlertController(title: "OMG", message: "You lose all money!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Restart", style: .default, handler: {
                    action in
                    self.totalMoney = 1000
                    self.totalMoneyLabel.text = "\(self.totalMoney)"
                    self.stepperValue.maximumValue = Double(self.totalMoney/100)
                })
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalMoneyLabel.text = "\(totalMoney)"
        showLabel.text = "猜大猜小，猜對贏錢，猜錯賠錢"
        stepperValue.value = 1
        stakes = Int(stepperValue.value * 100)
        stakesLabel.text = "\(stakes)"
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        stepperValue.maximumValue = Double(totalMoney/100)
        stakes = Int(stepperValue.value * 100)
        stakesLabel.text = "\(Int(stepperValue.value * 100))"
    }
    
    @IBAction func bigButtonPressed(_ sender: Any) {
        open()
        if diceTotal < 9 {
            open()
            lose()
        }
        else {
            open()
            win()
        }
    }
    
    @IBAction func smallButtonPressed(_ sender: Any) {
        open()
        if diceTotal <= 9 {
            open()
            win()
        }
        else {
            open()
            lose()
        }
    }
    @IBAction func showHandPressed(_ sender: Any) {
        stepperValue.value = Double(totalMoney/100)
        stakes = Int(stepperValue.value * 100)
        stakesLabel.text = "\(stakes)"
    }
    

}

