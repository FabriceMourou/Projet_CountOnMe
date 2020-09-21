import Foundation

class MathOperatorConverter {
    func convertSymbolToMathOperator(symbol: String) -> MathOperator? {
        switch symbol {
        case "+": return .plus
        case "-": return .minus
        case "×": return .multiply
        case "÷": return .divide
        default: return nil
        }
    }
}
