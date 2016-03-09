//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var incorrectGuessesLabel: UILabel!
    @IBOutlet var hangmanImageView: UIImageView!
    @IBOutlet var phraseLabel: UILabel!
    @IBOutlet var correctButton: UIButton!
    @IBOutlet var incorrectButton: UIButton!
    @IBOutlet var textField: UITextField!
    var currentCharIndex = 0
    var numOfIncorrectGuesses = 0
    var phrase = String()
    var blankSpaces = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        
    
        for var i = 0; i < phrase.characters.count; ++i {
            let char = phrase[phrase.startIndex.advancedBy(i)]
            if char != " " {
                blankSpaces += "_ "
            } else {
                blankSpaces += "  "
            }
        }
        print(phrase)
        print(blankSpaces)
        phraseLabel.text = blankSpaces
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func enterCorrectLetter() {
        if (currentCharIndex < phrase.characters.count) {
            if (phrase[phrase.startIndex.advancedBy(currentCharIndex)] == " ") {
                currentCharIndex += 1
            }
            var blankSpacesArray = Array(blankSpaces.characters)
            blankSpacesArray[currentCharIndex*2] = phrase[phrase.startIndex.advancedBy(currentCharIndex)]
            blankSpaces = String(blankSpacesArray)
            phraseLabel.text = blankSpaces
            currentCharIndex += 1
        }

    }
    
    @IBAction func enterIncorrectLetter() {
        if (textField.text!.isEmpty == false) {
            incorrectGuessesLabel.text = incorrectGuessesLabel.text! + textField.text!.uppercaseString + " "
        }
        let imageName = "hangman" + String(numOfIncorrectGuesses+2) + ".gif"
        if (numOfIncorrectGuesses < 6) {
            hangmanImageView.image = UIImage(named: imageName)!
        }
        numOfIncorrectGuesses += 1
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
