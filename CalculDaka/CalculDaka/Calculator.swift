
import Foundation

class Calculator {
    // MARK: - Constants
    enum Operation {
        case equals
        case constant(value: Double)
        case unary(function: (Double) -> Double)
        case binary(function: (Double, Double) -> Double)
        case c
    }
    
    var map: [String : Operation] = [
        "+" : .binary { $0 + $1 },
        "X" : .binary { $0 * $1 },
        "-" : .binary { $0 - $1 },
        "/" : .binary { $0 / $1 },
        "%" : .unary {$0/100},
        "?" : .unary {sqrt($0)},
        "pi": .constant(value: Double.pi),
        "RANDOM": .constant(value: Double.random(in: 0...100000)),
        "^": .binary(function: {a, b in return pow(a, b)}),
        "!": .unary(function: {a in fact(n: a)}),
        "=" : .equals,
        "C" : .c
    ]
        
    // MARK: - Variables
    var result: Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    // MARK: - Methods
    func setOperand(number: Double) {
        result = number
    }
    
    static func fact(n: Double) -> Double {
        var x:Double = Double(Int(n))
        var ans:Double = 1
        guard x >= 0 && x <= 20 else {
            return n
        }
        while(x > 0){
            ans *= x
            x -= 1
        }
        return ans
    }
    
    func executeOperation(symbol: String) {
        guard let operation = map[symbol] else {
            print("ERROR: no such symbol in map")
            return
        }
        
        switch operation {
        case .c:
            result = 0
            lastBinaryOperation=nil
            reminder = 0
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
        case .binary(let function):
            if lastBinaryOperation != nil {
                executeOperation(symbol: "=")
            }
            
            lastBinaryOperation = function
            reminder = result
            
        case .equals:
            if let lastOperation = lastBinaryOperation {
                result = lastOperation(reminder, result)
                lastBinaryOperation = nil
                reminder = 0
            }
        }
    }
}
