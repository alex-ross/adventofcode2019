import Foundation

struct Day2 {
    let input: String
    let expectedProduct = 19690720

    func part1(noun: Int? = nil, verb: Int? = nil) -> [Int] {
        var integers = InputDecoder(input: input).decode()
        if let noun = noun {
            integers[1] = noun
        }
        if let verb = verb {
            integers[2] = verb
        }

        for index in (0..<integers.count) {
            let integer = integers[index]
            var shouldBreak = false

            if index % 4 == 0 {
                let opCode = OpCode(rawValue: integer)!
                switch opCode {
                case .add, .multiply:
                    let a = integers[integers[index + 1]]
                    let b = integers[integers[index + 2]]
                    let position = integers[index + 3]
                    integers[position] = opCode.calc(a, b)
                case .finished:
                    shouldBreak = true
                }
            }

            if shouldBreak {
                break
            }
        }

        return integers
    }

    func part2() throws -> String {
        for noun in 0...99 {
            for verb in 0...99 {
                let result = part1(noun: noun, verb: verb).first

                if result == expectedProduct {
                    return "\(noun.description.padding(toLength: 2, withPad: "0", startingAt: 0))\(verb.description.padding(toLength: 2, withPad: "0", startingAt: 0))"
                }
            }
        }

        throw Day2Error.noVerbOrNounMatched
    }
}

enum Part {
    case one
}

struct InputDecoder {
    let input: String

    func decode() -> [Int] {
        input.split(separator: ",").compactMap { Int($0) }
    }
}

/// Encountering an unknown opcode means something went wrong.
enum OpCode: Int {
    /// 99 means that the program is finished and should immediately halt.
    case finished = 99

    /// Opcode 1 adds together numbers read from two positions and stores the result in a third position.
    /// The three integers immediately after the opcode tell you these three positions - the first two indicate
    /// the positions from which you should read the input values, and the third indicates the position at
    /// which the output should be stored.
    ///
    /// For example, if your Intcode computer encounters 1,10,20,30, it should read the values at positions
    /// 10 and 20, add those values, and then overwrite the value at position 30 with their sum.
    case add = 1

    /// Opcode 2 works exactly like opcode 1, except it multiplies the two inputs instead of adding them.
    /// Again, the three integers after the opcode indicate where the inputs and outputs are, not their values.
    case multiply = 2

    var calc: (Int, Int) -> Int {
        switch self {
        case .add:
            return (+)
        case .multiply:
            return (*)
        case .finished:
            fatalError("Finished doesn't have an operator")
        }
    }
}

enum Day2Error: Error {
    case noVerbOrNounMatched
}
