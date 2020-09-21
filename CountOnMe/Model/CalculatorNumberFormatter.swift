import Foundation


class CalculatorNumberFormatter {
    func formatResult(_ result: String) throws -> String {
        guard let resultAsDouble = Double(result) else {
            throw CalculatorError.cannotFormatInvalidStringNumber
        }
        
        let finalResult = resultAsDouble as NSNumber
        
        let numberFormatter = NumberFormatter()
        
        if resultAsDouble > 100000 {
            numberFormatter.numberStyle = .scientific
            numberFormatter.positiveFormat = "0.###E+0"
            numberFormatter.exponentSymbol = "e"
        } else {
            numberFormatter.numberStyle = .decimal
        }
        
        numberFormatter.maximumFractionDigits = 5
        numberFormatter.roundingMode = .up
        
        guard let formattedResult = numberFormatter.string(from: finalResult) else {
            throw CalculatorError.failedToFormatFinalResult
        }
        
        return formattedResult
    }
}
