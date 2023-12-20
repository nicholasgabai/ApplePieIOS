//
//  ViewController.swift
//  ApplePie_Gabai
//
//  Created by Nicholas Gabai on 9/29/22.
//

import UIKit

class ViewController: UIViewController {

//Lines 30-35, 38-40 44-58 Creating Game
//Lines 49, 50, 56-61 Update Game
//Lines 30, 31, 57,  Updating Game State
    
    //Create array of words
    var listOfWords = ["buccaneer","swift","glorious","incandescent","bug","program"]
    //Incorrect moves counter as Constant
    let incorrectMovesAllowed = 7
    //Wins and Loss counter
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet{
            newRound()
        }
    }
    
    //Created a new instance of Game
    var currentGame: Game!
    
//Lines 14-26: Interface Builder
    //Tree Image Outlet Variable
    @IBOutlet var treeImageView: UIImageView!
    
    //Correct word and Score Outlet Variable
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    //Buttons Collection Outlet Variable
    @IBOutlet var letterButtons: [UIButton]!
    
    //Buttons Pressed Collection Action Variable
    @IBAction func letterButtonPressed(_ sender: UIButton) {
       sender.isEnabled = false //sets letter to false when pressed
        //creates a string of char when pressed
        //let letterString = sender.title(for: .normal)!
        let letterString = sender.configuration!.title!
        //converts the string of Upper to char of Lower
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        }
        else{
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    
    func enableLetterButtons(_ enable: Bool){
        for button in letterButtons{
            button.isEnabled = enable
        }
    }
    //function creating a new round
    func newRound(){
        if !listOfWords.isEmpty{
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }
        else{
            enableLetterButtons(false)
        }
    }
    
    //function updating User Interface
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord{
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        //updates scoreLabel
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        //updates Tree Image by using the decrementation of incorrectMovesRemaining
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
}

