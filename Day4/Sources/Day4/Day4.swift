import Foundation

struct Day4 {
    let input: String

    func part1() -> Int {
        numberOfValidPasswords(validators: [
            DoubleValidator.self,
            LeftToRightNeverDecreaseValidator.self
        ])
    }

    func part2() -> Int {
        numberOfValidPasswords(validators: [
            DoubleValidator.self,
            LeftToRightNeverDecreaseValidator.self,
            NotLargerGroupOfMatchingDigitsValidator.self
        ])
    }

    func numberOfValidPasswords(validators: [Validator.Type]) -> Int {
        let range = InputDecoder(input: input).decode()

        return range.reduce(0) { result, integer in
            if validators.allSatisfy({ $0.init(integer.description).isValid }) {
                return result + 1
            }

            return result
        }
    }
}

// MARK: - Validators

protocol Validator {
    init(_ number: String)
    var isValid: Bool { get }
}

struct DoubleValidator: Validator {
    let number: String

    init(_ number: String) {
        self.number = number
    }

    var isValid: Bool {
        number.range(of: #"(.)\1+"#, options: .regularExpression) != nil
    }
}

struct LeftToRightNeverDecreaseValidator: Validator {
    let number: String

    init(_ number: String) {
        self.number = number
    }

    var isValid: Bool {
        let digitsArray = number.compactMap({ Int($0.description) })
        return digitsArray.sorted() == digitsArray
    }
}

struct NotLargerGroupOfMatchingDigitsValidator: Validator {
    let number: String

    init(_ number: String) {
        self.number = number
    }

    var isValid: Bool {
        var valid = false
        for digit in (0...9) {
            if number.replacingOccurrences(of: digit.description, with: "").count == 4 {
                valid = true
            }
        }

        return valid
    }
}

// MARK: - Input decoder

struct InputDecoder {
    let input: String

    func decode() -> ClosedRange<Int> {
        let integers = input.split(separator: "-").map { Int($0)! }

        return integers.first!...integers.last!
    }
}
