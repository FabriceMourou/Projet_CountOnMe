import Foundation

// MARK: - INTERNAL

// MARK: Properties - Internal

enum MathOperator: CaseIterable {
    case plus, minus, multiply, divide

    var symbol: String {
        switch self {
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        }
    }
    
    var isPriorityOperator: Bool {
        switch self {
        case .plus, .minus: return false
        case .multiply, .divide: return true
        }
    }
    
    var associatedOperation: (Double, Double) -> Double {
        switch self {
        case .plus: return { $0 + $1 }
        case .minus: return { $0 - $1 }
        case .multiply: return { $0 * $1 }
        case .divide: return { $0 / $1 }
        }
    }
}
