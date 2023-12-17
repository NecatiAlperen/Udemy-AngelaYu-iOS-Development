//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Necati Alperen IŞIK on 1.09.2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//


import UIKit


struct CalculatorBrain {
    var bmi: BMI?
    
     func getBMIValue()->String{
        
       
         let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? "its nil")
            return bmiTo1DecimalPlace
    
        }
    func getAdvice()->String{
        return bmi?.advice ?? "no advice"
    }
    
    func getColor()->UIColor{
        return bmi?.color  ??  UIColor.white
    }
    mutating func calculateBMI(heigth: Float, weigth:Float){
        
        let bmiValue = weigth / (heigth * heigth)
        
        if bmiValue < 18.5{
            bmi = BMI(value: bmiValue, advice: "eat more pies", color: UIColor.blue)
        }else if bmiValue > 18.5 && bmiValue < 24.9{
            bmi = BMI(value: bmiValue, advice: "fit as a fiddle", color: UIColor.green)
        }else{
            bmi = BMI(value: bmiValue, advice: "eat less pies", color: UIColor.red)
        }
        
    }
}
