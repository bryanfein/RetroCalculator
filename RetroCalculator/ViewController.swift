//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Bryan Fein on 3/30/17.
//  Copyright © 2017 Bryan Fein. All rights reserved.
//

import UIKit
import AVFoundation //import audio lib

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Mutiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty // When the 1st time we open up the Cal we know its empty
    var runningNumber : String?
    var leftValStr : String?
    var rightValStr : String?
    var result : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav") // the audio file is located in the bundle
        let soundURL = URL(fileURLWithPath: path!)
        
        
        //Error Handling just incase there nothing in the URL (esp when getting audio over the web)
    
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    
    @IBAction func numberPressed(_ sender: UIButton) {
        playsound()
        
        runningNumber! += "\(sender.tag)" //getting the number tag and assigning it to runningNumber
        outputLbl.text = runningNumber // assigning runningNumber to the text property to output Label
        
    }
    
    
    // Buttons Pressed
    
    @IBAction func onDividePressed(_ sender: UIButton) {
        
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMutiplyPressed(_ sender: UIButton) {
        
        processOperation(operation: .Mutiply)
        
    }
    
    @IBAction func onSubtractPressed(_ sender: UIButton) {
        
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(_ sender: UIButton) {
        
        
        processOperation(operation: .Add)
    }
    
    
    
    
    
    
    
    func playsound () {
        if btnSound.isPlaying {
            //            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        
        if currentOperation != Operation.Empty {
            // A user selected an operator, but then selected another operator without first entering a number
            if runningNumber != nil {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Mutiply {
                    result = "\(Double (leftValStr!)! * Double(rightValStr!)!)"
                }else if currentOperation == Operation.Divide {
                    result = "\(Double (leftValStr!)! / Double(rightValStr!)!)"
  
                }else if currentOperation == Operation.Subtract {
                    result = "\(Double (leftValStr!)! - Double(rightValStr!)!)"

                }else if currentOperation == Operation.Add{
                    result = "\(Double (leftValStr!)! + Double(rightValStr!)!)"

                }
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
            
        }else {
            
            //This is the first time an operator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
        
    }
    
}



