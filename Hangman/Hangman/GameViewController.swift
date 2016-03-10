//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var startoverButton: UIButton!
    @IBOutlet var incorrectGuessesLabel: UILabel!
    @IBOutlet var hangmanImageView: UIImageView!
    @IBOutlet var phraseLabel: UILabel!
    @IBOutlet var guessField: UITextField!
    @IBOutlet var guessButton: UIButton!
    var phrase = String()
    var blankSpaces = String()
    var numOfIncorrectGuesses = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.guessField.delegate = self
        // Do any additional setup after loading the view.
        setUpGame()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField,
        shouldChangeCharactersInRange range: NSRange,
        replacementString string: String) -> Bool {
        return textField.text?.characters.count < 1;
        
    }
    
    @IBAction func guessButtonPressed() {
        let inputChar = guessField.text?.characters.first
        var blankSpacesArray = Array(blankSpaces.characters)
        print(String(inputChar).uppercaseString)
        if (guessField.text!.isEmpty == false) {
            if (phrase.lowercaseString.characters.contains(inputChar!)) {
                for var i = 0; i < phrase.characters.count; ++i {
                    let char = phrase.lowercaseString[phrase.startIndex.advancedBy(i)]
                    if (char == inputChar) {
                        blankSpacesArray[i] = char
                    }
                }
                blankSpaces = String(blankSpacesArray)
                if (blankSpaces.characters.contains("-") == false) {
                    let alert = UIAlertController(title: "Congratulations!", message: "You Win", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    guessButton.enabled = false
                    
                }
            } else {
                incorrectGuessesLabel.text = incorrectGuessesLabel.text! + guessField.text!.uppercaseString + " "
                let imageName = "hangman" + String(numOfIncorrectGuesses+2) + ".gif"
                if (numOfIncorrectGuesses < 5) {
                    hangmanImageView.image = UIImage(named: imageName)!
                } else {
                    hangmanImageView.image = UIImage(named: imageName)!
                    let alert = UIAlertController(title: "You Lose", message: "The phrase is: " + phrase + ". Try Again!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    guessButton.enabled = false

                }
                blankSpaces = String(blankSpacesArray)
                numOfIncorrectGuesses += 1
            }
        
            phraseLabel.text = blankSpaces
            guessField.text = ""
        }
        
    }
    
    @IBAction func startOver() {
        setUpGame()
    }
    
    func setUpGame() {
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        blankSpaces = ""
        incorrectGuessesLabel.text = "Incorrect guesses: "
        for var i = 0; i < phrase.characters.count; ++i {
            let char = phrase[phrase.startIndex.advancedBy(i)]
            if char != " " {
                blankSpaces += "-"
            } else {
                blankSpaces += " "
            }
        }
        print(phrase)
        phraseLabel.text = blankSpaces
        guessButton.enabled = true
        numOfIncorrectGuesses = 0
        let imageName = "hangman1.gif"
        hangmanImageView.image = UIImage(named: imageName)!
    }
    

}
