@testable import CountOnMe

class CalculatorDelegateMock: CalculatorDelegate {
    var textToCompute = ""

    func didUpdateOperationString(textToCompute: String) {
        self.textToCompute = textToCompute
    }
}
