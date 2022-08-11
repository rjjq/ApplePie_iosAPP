//
//  Game.swift
//  ApplePie
//
//  Created by rjjq on 2022/8/9.
//

import Foundation

struct Game {
    var word: String
    var incorrectMovesRemaining: Int
    var guessLetters: [Character]
    
    mutating func playerGuessed(letter: Character) {
        guessLetters.append(letter)
        if !word.contains(letter) {
            incorrectMovesRemaining -= 1
        }
    }
    
    var formattedWord: String {
        var guessWord = ""
        for letter in word {
            if guessLetters.contains(letter) {
                guessWord += "\(letter)"
            } else {
                guessWord += "_"
            }
        }
        return guessWord
    }
}
