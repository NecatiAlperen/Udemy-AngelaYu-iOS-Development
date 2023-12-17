//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    var calculatorBrain = CalculatorBrain()
    
    
     @IBOutlet weak var heigthLabel: UILabel!
    
     @IBOutlet weak var weigthLabel: UILabel!
    
    @IBOutlet weak var heigthSlider: UISlider!
    
    @IBOutlet weak var weigthSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    @IBAction func heigthSliderChanged(_ sender: UISlider) {
        
        
        let userHeigth = String(format: "%.2f", sender.value)
        print(userHeigth)
        heigthLabel.text = "\(userHeigth)m"
        }
    
    
    @IBAction func weigthSliderChanged(_ sender: UISlider) {
        
        let userWeigth = String(format: "%.0f", sender.value)
        print(userWeigth)
        weigthLabel.text = "\(userWeigth)kg"
        }
    
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
         let userHeigth = heigthSlider.value
         let userWeigth = weigthSlider.value
        
        
        calculatorBrain.calculateBMI(heigth: userHeigth,weigth:userWeigth)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "goToResult"{
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.bmiValue = calculatorBrain.getBMIValue()
            destinationVC.advice = calculatorBrain.getAdvice()
            destinationVC.color = calculatorBrain.getColor()
        }
    }
    
}

