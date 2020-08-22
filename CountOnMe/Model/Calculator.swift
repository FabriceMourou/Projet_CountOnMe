//
//  Calculator.swift
//  CountOnMe
//
//  Created by Fabrice Mourou on 21/08/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

protocol CalculatorDelegate: class {
    func didUpdateOperationString(textToCompute: String)
}


class Calculator {
    
    var delegate: CalculatorDelegate?
    
    var textToCompute: String = ""{
        didSet {
            delegate?.didUpdateOperationString(textToCompute: textToCompute)
        }
    }
    
    func addDigit (_ digit: Int){
        textToCompute.append(digit.description)
    }
    func addMathOperator (_ mathOperator: MathOperator) throws {
        textToCompute.append(mathOperator.symbol)
    }
    
    func resetOperation () {
        
    }
    func resolveOperation() throws {
        
    }
}
