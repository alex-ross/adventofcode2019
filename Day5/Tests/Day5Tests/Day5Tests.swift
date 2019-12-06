import XCTest
@testable import Day5

final class Day5Tests: XCTestCase {
    func testInpudDecoder() {
      let input = "1,23,3,4"

      XCTAssertEqual([1, 23, 3, 4], InputDecoder(input: input).decode())
    }

    func testOpCode() {
        XCTAssertEqual(OpCode.add,
                       OpCode(rawValue: 1))

        XCTAssertEqual(OpCode.multiply,
                       OpCode(rawValue: 2))

        XCTAssertEqual(OpCode.input,
                       OpCode(rawValue: 3))

        XCTAssertEqual(OpCode.output,
                       OpCode(rawValue: 4))

        XCTAssertEqual(OpCode.finished,
                       OpCode(rawValue: 99))
    }

    func testInstruction() {
        XCTAssertEqual(
            Instruction(opCode: .multiply, parameterFirst: .position, parameterSecond: .immediate, parameterThird: .position),
            Instruction(parse: 1002)
        )

        XCTAssertEqual(
            Instruction(opCode: .input, parameterFirst: .position, parameterSecond: .immediate, parameterThird: .immediate),
            Instruction(parse: 11003)
        )

        XCTAssertEqual(
            Instruction(opCode: .finished, parameterFirst: .immediate, parameterSecond: .position, parameterThird: .position),
            Instruction(parse: 199)
        )

        XCTAssertEqual(
            Instruction(opCode: .add, parameterFirst: .position, parameterSecond: .position, parameterThird: .position),
            Instruction(parse: 1)
        )
    }

    func testParameterMode() {
        XCTAssertEqual(ParameterMode.position.value(at: 4, in: [123, 345, 567, 789, 1]), 345)
        XCTAssertEqual(ParameterMode.immediate.value(at: 4, in: [123, 345, 567, 789, 1]), 1)
    }

    func testDay5() {
        XCTAssertEqual(15508323, Day5(input: input).part1().outputs.last)
        XCTAssertEqual(9006327, Day5(input: input).part2().outputs.last)
    }

    func testIntcodeComputer() {
        let input = "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"
        let memory = InputDecoder(input: input).decode()

        let computer = IntcodeComputer(memory: memory)

        XCTAssertEqual(computer.runDiagnosticProgram(systemId: 7).outputs.last,
                       999)
        XCTAssertEqual(computer.runDiagnosticProgram(systemId: 8).outputs.last,
                       1000)
        XCTAssertEqual(computer.runDiagnosticProgram(systemId: 9).outputs.last,
                       1001)
        XCTAssertEqual(computer.runDiagnosticProgram(systemId: 8).memory,
                       [3, 21, 1008, 21, 8, 20, 1005, 20, 22, 107, 8, 21, 20, 1006, 20, 31, 1106, 0, 36, 98, 1000, 8, 1002, 21, 125, 20, 4, 20, 1105, 1, 46, 104, 999, 1105, 1, 46, 1101, 1000, 1, 20, 4, 20, 1105, 1, 46, 98, 99])
    }

    static var allTests = [
        ("testInpudDecoder", testInpudDecoder),
        ("testOpCode", testOpCode),
        ("testInstruction", testInstruction),
        ("testParameterMode", testParameterMode),
        ("testDay5", testDay5),
        ("testIntcodeComputer", testIntcodeComputer)
    ]
}
