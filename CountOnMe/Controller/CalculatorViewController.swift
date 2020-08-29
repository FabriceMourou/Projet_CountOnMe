//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

/*
 1. Créer un protocol portant le nom du modèle+delegate (Model = Calculator => CalculatorDelegate)
 2. Indiquer que le protocol peut s'appliquer seulement sur des classes => Une classe peut se conformer au protcole mais pas une struct/enum => : class
 3. Indiquer dans le protocol les fonctions quim représente les évéenements sur lesquelle la classe qui s'y conforme peut réagir => utilisatiojn du mot clef did has + participe passé etc.
 4. L'objet qui souhaite répondre ou réagir à ses events doit s'y confo conformant il faut respecter le contrat
 5. Le modèle (calculator) doit maintenant possédé une référence (une propriété) qui est du type delegate optionnel + ajout du mot weak pour éviter les retain cycle (gestion mémoire)
 6. appeler les fonctions du delegate au bon endroit dans le modèle
 7. l'objet qui souhaite être notifié dois assigné sa référence au delefate du modèle => se fait en l'occurence dans le view did load (calculator.delegate = self)
 */

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
            title: "Zéro!",
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

