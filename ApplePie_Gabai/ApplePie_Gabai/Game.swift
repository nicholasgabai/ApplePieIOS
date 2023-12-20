//
//  Game.swift
//  ApplePie_Gabai
//
//  Created by Nicholas Gabai on 10/4/22.
//

import Foundation

//Created a Structure called Game that initializes the Game and updates letters guessed
struct Game{
    var word: String
    var incorrectMovesRemaining: Int
    var guessedLetters: [Character]
    
    mutating func playerGuessed(letter: Character){
        guessedLetters.append(letter)
        if !word.contains(letter){
            incorrectMovesRemaining -= 1
        }
    }
    //Variable that formats the String being passed by ViewController Func
    var formattedWord: String{
        var guessedWord = ""
        for letter in word {
            if guessedLetters.contains(letter){
                guessedWord += "\(letter)"
            }
            else{
                guessedWord += "_"
            }
        }
        return guessedWord
    }
}
