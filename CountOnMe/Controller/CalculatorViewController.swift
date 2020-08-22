//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    
    // MARK: - PRIVATE
    
    // MARK: Properties - Private
    
    private let calculator = Calculator()
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var operationTextView: UITextView!
    
    
    // MARK: IBActions
    
    @IBAction private func tappedNumberButton(_ sender: UIButton) {
       addDigit(sender.tag)
    }
    
    @IBAction private func tappedOnMathOperator(_ sender: UIButton) {
        let mathOperator = MathOperator.allCases[sender.tag]
        addMathOperator(mathOperator)
    }
    
    @IBAction private func tappedEqualButton(_ sender: UIButton) {
        resolveOperation()
    }
    
    
    @IBAction private func didTapOnResetButton(_ sender: UIButton) {
        textToCompute.removeAll()
    }
    
    private func presentSimpleAlert(message: String) {
        let alertVC = UIAlertController(
            title: "Zéro!",
            message: message,
            preferredStyle: .alert
        )
        
        let confirmAction =  UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertVC.addAction(confirmAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
    
    private var textToCompute = "" {
        didSet {
            operationTextView.text = textToCompute
        }
    }
    
    
    private var elements: [String] {
        return textToCompute.split(separator: " ").map { "\($0)" }
    }
    

   
    
    // Error check computed variables
    private var expressionIsCorrect: Bool {
        return !isLastElementMathOperator
    }
    
    private var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    private var canAddOperator: Bool {
        return !isLastElementMathOperator
    }
    
    private var isLastElementMathOperator: Bool {
        MathOperator.allCases.contains {
            $0.symbol == elements.last
        }
    }
    
    private var expressionHaveResult: Bool {
        return textToCompute.firstIndex(of: "=") != nil
    }
    

    
    private func addDigit(_ digit: Int) {
        if expressionHaveResult {
            textToCompute.removeAll()
        }
        
        textToCompute.append(digit.description)
    }
    
    
    
    
    private func addMathOperator(_ mathOperator: MathOperator) {
        guard canAddOperator else {
            presentSimpleAlert(message: "Un operateur est déja mis !")
            return
        }
        
        textToCompute.append(" \(mathOperator.symbol) ")
    }
    
   
    
    
    private func resolveOperation() {
        guard expressionIsCorrect else {
            presentSimpleAlert(message: "Entrez une expression correcte !")
            return
        }
        
        guard expressionHaveEnoughElement else {
            presentSimpleAlert(message: "Démarrez un nouveau calcul !")
            return
        }
        
        // Create local copy of operations
        var operationsToReduce = elements
        
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!
            
            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "×": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }
            
            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        
        textToCompute.append(" = \(operationsToReduce.first!)")
    }
    
    
}

extension CalculatorViewController: CalculatorDelegate {
    func didUpdateOperationString(textToCompute: String) {
        
    }
    
    
}

