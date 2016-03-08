//
//  ViewController.swift
//  SpaceRetroCalculator
//
//  Created by Tanveer Bashir on 11/22/15.
//  Copyright © 2015 Tanveer Bashir. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operations: String{
        case Devide = "/"
        case Myltiply = "*"
        case Subtract = "-"
        case Addition = "+"
        case Empty = "Empty"
    }
    
    
    @IBOutlet weak var displayLabel: UILabel!
    var audioPlayer:AVAudioPlayer!
    
    var runningNummber = ""
    var rightValue = ""
    var leftValue = ""
    var result:String = ""
    var operations:Operations = Operations.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()

        operations = Operations.Empty
        let path = NSBundle.mainBundle().URLForResource("btn", withExtension: "wav")
        do{
            try audioPlayer = AVAudioPlayer(contentsOfURL: path!)
        } catch let error as NSError{
            print("\(error.localizedDescription)")
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    @IBAction func digitPressed(sender: UIButton) {
       playSound()
        runningNummber += "\(sender.tag)"
        displayLabel.text = runningNummber
    }
    
    @IBAction func subtractButtonPressed(sender: UIButton) {
        playSound()
        operations = Operations.Subtract
        print("\(operations)")
        processesOperation(Operations.Subtract)
    }
    
    @IBAction func additionButtonPressed(sender: UIButton) {
        playSound()
        operations = Operations.Addition
        print("\(operations)")
        processesOperation(Operations.Addition)
    }
    
    @IBAction func devideButtonPressed(sender: UIButton) {
        operations = Operations.Devide
        print("\(operations)")
        processesOperation(Operations.Devide)
    }
    
    @IBAction func multiplyButtonPressed(sender: UIButton) {
        playSound()
        operations = Operations.Myltiply
        print("\(operations)")
        processesOperation(Operations.Myltiply)
    }
    
    @IBAction func equalButtonPressed(sender: UIButton) {
        playSound()
        processesOperation(operations)
    }
    
    func playSound(){
        if audioPlayer.playing{
            audioPlayer.stop()
        }
        audioPlayer.play()
    }
    
    func processesOperation(op: Operations) {
        if operations != Operations.Empty {
            if runningNummber != ""{
                rightValue = runningNummber
                runningNummber = ""
                if operations == Operations.Addition {
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
            }
        } else {
            rightValue = runningNummber
            runningNummber = ""
            operations = op
        }
        displayLabel.text = result
        
    }
}

