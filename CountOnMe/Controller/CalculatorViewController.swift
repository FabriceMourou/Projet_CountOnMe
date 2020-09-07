//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    // MARK: - INTERNAL
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.delegate = self
    }
    // MARK: - PRIVATE
    // MARK: Properties - Private
    private let calculator = Calculator()
    
    // MARK: IBOutlets
    
    @IBOutlet private weak var operationTextView: UITextView!
    
    
    // MARK: IBActions
    
    @IBAction private func didTapDigitButton(_ sender: UIButton) {
        calculator.addDigit(sender.tag)
    }
    
    @IBAction private func didTapOnMathOperator(_ sender: UIButton) {
        let mathOperator = MathOperator.allCases[sender.tag]
        do {
            try calculator.addMathOperator(mathOperator)
        } catch {
            handleError(error: error)
        }
    }
    
    @IBAction private func didTapEqualButton() {
        do {
            try calculator.resolveOperation()
        } catch {
            handleError(error: error)
        }
    }
    
    
    @IBAction private func didTapOnResetButton() {
        calculator.resetOperation()
    }
    
    
    private func handleError(error: Error) {
        guard let calculatorError = error as? CalculatorError else { return }
        presentSimpleAlert(message: calculatorError.errorMessage)
    }
    
    private func presentSimpleAlert(message: String) {
        let alertVC = UIAlertController(
            title: "🤷🏻‍♂️",
            message: message,
            preferredStyle: .alert
        )
        
        let confirmAction =  UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertVC.addAction(confirmAction)
        
        present(alertVC, animated: true, completion: nil)
    }

    
    
    
}

extension CalculatorViewController: CalculatorDelegate {
    func didUpdateOperationString(textToCompute: String) {
        operationTextView.text = textToCompute
    }
    
}

