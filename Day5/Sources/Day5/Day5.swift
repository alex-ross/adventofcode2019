import Foundation

struct Day5 {
    let input: String

    func part1() -> DiagnosticResult {
        let memory = InputDecoder(input: input).decode()

        return IntcodeComputer(memory: memory).runDiagnosticProgram(systemId: 1)
    }

    func part2() -> DiagnosticResult {
        let memory = InputDecoder(input: input).decode()

        return IntcodeComputer(memory: memory).runDiagnosticProgram(systemId: 5)
    }
}

struct DiagnosticResult {
    let memory: [Int]
    let outputs: [Int]
}

struct IntcodeComputer {
    let memory: [Int]

    func runDiagnosticProgram(systemId: Int) -> DiagnosticResult {
        var memory = self.memory
        var index = 0
        var instruction = Instruction(parse: memory[index])
        var outputs = [Int]()

        while instruction.opCode != .finished {
            switch instruction.opCode {
            case .add:
                let a = instruction.parameterFirst.value(at: index + 1, in: memory)
                let b = instruction.parameterSecond.value(at: index + 2, in: memory)
                memory[memory[index + 3]] = a + b
                index += instruction.opCode.numberOfJumpsForward
            case .multiply:
                let a = instruction.parameterFirst.value(at: index + 1, in: memory)
                let b = instruction.parameterSecond.value(at: index + 2, in: memory)
                memory[memory[index + 3]] = a * b
                index += instruction.opCode.numberOfJumpsForward
            case .input:
                memory[memory[index + 1]] = systemId
                index += instruction.opCode.numberOfJumpsForward
            case .output:
                let a = instruction.parameterFirst.value(at: index + 1, in: memory)
                outputs.append(a)
                index += instruction.opCode.numberOfJumpsForward
            case .jumpIfTrue:
                let a = instruction.parameterFirst.value(at: index + 1, in: memory)
                let b = instruction.parameterSecond.value(at: index + 2, in: memory)
                if a != 0 {
                    index = b
                } else {
                    index += instruction.opCode.numberOfJumpsForward
                }
            case .jumpIfFalse:
                let a = instruction.parameterFirst.value(at: index + 1, in: memory)
                let b = instruction.parameterSecond.value(at: index + 2, in: memory)
                if a == 0 {
                    index = b
                } else {
                    index += instruction.opCode.numberOfJumpsForward
                }
            case .lessThan:
                let a = instruction.parameterFirst.value(at: index + 1, in: memory)
                let b = instruction.parameterSecond.value(at: index + 2, in: memory)
                if a < b {
                    memory[memory[index + 3]] = 1
                } else {
                    memory[memory[index + 3]] = 0
                }
                index += instruction.opCode.numberOfJumpsForward
            case .equals:
                let a = instruction.parameterFirst.value(at: index + 1, in: memory)
                let b = instruction.parameterSecond.value(at: index + 2, in: memory)
                if a == b {
                    memory[memory[index + 3]] = 1
                } else {
                    memory[memory[index + 3]] = 0
                }
                index += instruction.opCode.numberOfJumpsForward
            case .finished:
                fatalError("Something whent wrong, you should never get here!")
            }
            instruction = Instruction(parse: memory[index])
        }

        return DiagnosticResult(memory: memory, outputs: outputs)
    }
}

struct InputDecoder {
    let input: String

    func decode() -> [Int] {
        input.split(separator: ",").compactMap { Int($0) }
    }
}

/// Encountering an unknown opcode means something went wrong.
enum OpCode: Int {
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

    /// Opcode 3 takes a single integer as input and saves it to the position given by its only parameter. For
    /// example, the instruction 3,50 would take an input value and store it at address 50.
    case input = 3

    /// Opcode 4 outputs the value of its only parameter. For example, the instruction 4,50 would output the
    /// value at address 50.
    case output = 4

    /// Opcode 5 is jump-if-true: if the first parameter is non-zero, it sets the instruction pointer to the value
    /// from the second parameter. Otherwise, it does nothing.
    case jumpIfTrue = 5

    /// Opcode 6 is jump-if-false: if the first parameter is zero, it sets the instruction pointer to the value
    /// from the second parameter. Otherwise, it does nothing.
    case jumpIfFalse = 6

    /// Opcode 7 is less than: if the first parameter is less than the second parameter, it stores 1 in the
    /// position given by the third parameter. Otherwise, it stores 0.
    case lessThan = 7

    /// Opcode 8 is equals: if the first parameter is equal to the second parameter, it stores 1 in the position
    /// given by the third parameter. Otherwise, it stores 0.
    case equals = 8

    /// 99 means that the program is finished and should immediately halt.
    case finished = 99

    var numberOfJumpsForward: Int {
        switch self {
        case .add, .multiply, .lessThan, .equals:
            return 4
        case .input, .output:
            return 2
        case .jumpIfTrue, .jumpIfFalse:
            return 3
        default:
            return 1
        }
    }
}

enum ParameterMode: Int {
    /// If the parameter is 50, its value is the value stored at address 50 in memory.
    case position = 0

    /// If the parameter is 50, its value is simply 50.
    case immediate = 1

    func value(at index: Int, in memory: [Int]) -> Int {
        switch self {
        case .position:
            return memory[memory[index]]
        case .immediate:
            return memory[index]
        }
    }
}

struct Instruction: Equatable {
    let opCode: OpCode
    let parameterFirst: ParameterMode
    let parameterSecond: ParameterMode
    let parameterThird: ParameterMode

    init(parse integer: Int) {
        opCode = OpCode(rawValue: integer % 100)!
        parameterFirst = ParameterMode(rawValue: (integer / 100) % 10)!
        parameterSecond = ParameterMode(rawValue: (integer / 1000) % 10)!
        parameterThird = ParameterMode(rawValue: (integer / 10000) % 10)!
    }

    init(opCode: OpCode, parameterFirst: ParameterMode, parameterSecond: ParameterMode, parameterThird: ParameterMode) {
        self.opCode = opCode
        self.parameterFirst = parameterFirst
        self.parameterSecond = parameterSecond
        self.parameterThird = parameterThird
    }
}
