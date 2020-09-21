//
//  CalculatorError.swift
//  CountOnMe
//
//  Created by Fabrice Mourou on 21/08/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.
//

import UIKit

enum CalculatorError: Error {
    case cannotAddOperatorAfterAnotherOperator
    case cannotDivideByZero
    case expressionIsIncorrect
    case expressionHasNotEnoughElement
    case cannotAddOperatorIfOperationEmpty
    case cannotFormatInvalidStringNumber
    case failedToFormatFinalResult
    case cannotGetLeftAndRightNumberForOperationUnit
    case cannotConvertSymbolIntoMathOperator
//    case cannotGetFinalResult

    var errorMessage: String {
        switch self {
        case .cannotAddOperatorAfterAnotherOperator: return " Un operateur est déja mis 🔢 !"
        case .cannotDivideByZero: return " Vous ne pouvez pas diviser par zéro ❌  ! "
        case .expressionIsIncorrect: return "Entrez une expression correcte ⛔️ !"
        case .expressionHasNotEnoughElement: return "L'opération n'a pas assez d'éléments 🛠 !"
        case .cannotAddOperatorIfOperationEmpty: return "Vous ne pouvez pas commencer par un opérateur 🔢 !"
        case .cannotFormatInvalidStringNumber: return "cannotFormatInvalidStringNumber"
        case .failedToFormatFinalResult: return "Le resultat final ne peut pas être afficher ❌ !"
        case .cannotGetLeftAndRightNumberForOperationUnit: return "Impossible d'obtenir les chiffres 🛠 !"
        case .cannotConvertSymbolIntoMathOperator: return "Impossible de convertir le symbole en opérateur mathématique ❌ !"
//        case .cannotGetFinalResult: return "cannotGetFinalResult"
        }
    }
}
