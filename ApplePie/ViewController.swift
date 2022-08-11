//
//  ViewController.swift
//  ApplePie
//
//  Created by rjjq on 2022/8/9.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["bug", "apple", "car", "vacation", "summer"]
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    var currentGame: Game!

    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newRound()
    }

    func newRound() {
        if listOfWords.isEmpty {
            enableLetterButtons(false)
            updateUI()
        } else {
            let newWord = listOfWords.removeFirst()
            
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessLetters: [])
            enableLetterButtons(true)
            updateUI()
        }
        
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for btn in letterButtons {
            btn.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
}

