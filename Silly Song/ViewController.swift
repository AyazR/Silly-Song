//
//  ViewController.swift
//  Silly Song
//
//  Created by Ayaz Reshamwala on 4/24/17.
//  Copyright © 2017 Ayaz Reshamwala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameField.delegate = self
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        let nameIO = self.nameField.text
        let song = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameIO!)
        lyricsView.text = song
    }
    
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

// Name Shorten Function If Consonant Present
func shorten (name : String, vowelValue: Bool) -> String{
    var temp = name
    if vowelValue != true {
        temp.remove(at: temp.startIndex)
    }
    return temp
}

func shortNameForName (fullname:String) -> String{
    
    var lowerCasedName = fullname.lowercased()
    
    var vowelBool : Bool = false
    
    let vowelSet = "aeiou"
    
    // Loop For Vowel Presences Check
    for char in vowelSet.characters {
        if let idx = lowerCasedName.characters.index(of: char) {
            let pos = lowerCasedName.characters.distance(from: lowerCasedName.startIndex, to: idx)
            if pos == 0 {
                vowelBool = true
                break
            }
        }
    }
    
    // Calling Shorten Function to Set Shortname Value
    let shortName = shorten(name: lowerCasedName, vowelValue: vowelBool)
    
    return shortName
}

func lyricsForName(lyricsTemplate: String, fullName: String) ->String {
    
    let shortName = shortNameForName(fullname: fullName)
    
    let lyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullName).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
