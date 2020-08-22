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
    case unknownOperator
    
    var errorMessage: String{
        switch self {
        case .cannotAddOperatorAfterAnotherOperator: return " Un operateur est déja mis !"
        case .cannotDivideByZero: return " Vous ne pouvez pas diviser par zéro ❌ ! "
        case .unknownOperator: return "Entrez une expression correcte !"
            
        }
    }
}
