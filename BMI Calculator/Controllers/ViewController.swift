//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        print(String(format: "%.2F", sender.value))
        //display user friendly metric and imperial units at the same time
        let lengthInMeters = Measurement(value: Double(sender.value), unit: UnitLength.meters)
        let lengthInMetersString = String(format: "%.2F", sender.value) + "m"
        let lengthInFeetString = convertMetersToFeetAndInches(lengthInMeters.value)
        print("Length in meters: \(lengthInMetersString)")
        print("Length in feet & inches: \(lengthInFeetString)")
        heightLabel.text = "\(lengthInMetersString)" + " (\(lengthInFeetString)" + ")"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        print(String(format: "%.0F", sender.value))
        let weightInKilograms = Measurement(value: Double(sender.value), unit: UnitMass.kilograms)
        let weightInPounds = convertKilogramsToPounds(kilograms: weightInKilograms.value)
        let weightInPoundsString = String(format: "%.0F", weightInPounds)
        print(String(format: "%.0F", sender.value) + "Kg (" + "\(weightInPoundsString)" + " lb)")
        //display user friendly metric and imperial units at the same time
        weightLabel.text = String(format: "%.0F", sender.value) + "Kg (" + "\(weightInPoundsString)" + " lb)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func convertMetersToFeetAndInches(_ meters: Double) -> String {
        let lengthInMeters = Measurement(value: meters, unit: UnitLength.meters)
        let lengthInFeet = lengthInMeters.converted(to: UnitLength.feet)
        
        let wholeFeet = Int(lengthInFeet.value)
        let remainingInches = (lengthInFeet.value - Double(wholeFeet)) * 12
        let roundedInches = Int(round(remainingInches))
        
        return "\(wholeFeet)'\(roundedInches)\""
    }

    func convertKilogramsToPounds(kilograms: Double, decimalPlaces: Int = 0) -> Double {
        let weightInKilograms = Measurement(value: kilograms, unit: UnitMass.kilograms)
        let weightInPounds = weightInKilograms.converted(to: .pounds)
        
        if decimalPlaces == 0 {
            return round(weightInPounds.value)
        } else {
            let multiplier = pow(10.0, Double(decimalPlaces))
            return round(weightInPounds.value * multiplier) / multiplier
        }
    }
}

