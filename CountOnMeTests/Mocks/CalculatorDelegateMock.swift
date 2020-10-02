@testable import CountOnMe

class CalculatorDelegateMock: CalculatorDelegate {
    var operation = ""

    func didUpdateOperationString(operation: String) {
        self.operation = operation
    }
}
