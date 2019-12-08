import XCTest
@testable import Day6

final class Day6Tests: XCTestCase {
    let examplePart1Input = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    """

    let examplePart2Input = """
    COM)B
    B)C
    C)D
    D)E
    E)F
    B)G
    G)H
    D)I
    E)J
    J)K
    K)L
    K)YOU
    I)SAN
    """

    func testInputDecoder() {
        let expected = [
            InputDecoder.Result(a: "COM", b: "B"),
            InputDecoder.Result(a: "B",   b: "C"),
            InputDecoder.Result(a: "C",   b: "D"),
            InputDecoder.Result(a: "D",   b: "E"),
            InputDecoder.Result(a: "E",   b: "F"),
            InputDecoder.Result(a: "B",   b: "G"),
            InputDecoder.Result(a: "G",   b: "H"),
            InputDecoder.Result(a: "D",   b: "I"),
            InputDecoder.Result(a: "E",   b: "J"),
            InputDecoder.Result(a: "J",   b: "K"),
            InputDecoder.Result(a: "K",   b: "L"),
        ]

        XCTAssertEqual(expected, InputDecoder(input: examplePart1Input).decode())
    }

    func testDay6_part1_withExampleInput() {
        let day = Day6(input: examplePart1Input)

        XCTAssertEqual(42, day.part1())
    }

    func testDay6_part1_withRealInput() {
        let day = Day6(input: input)

        XCTAssertEqual(162439, day.part1())
    }

    func testDay6_part2_withExampleInput() {
        let day = Day6(input: examplePart2Input)

        XCTAssertEqual(4, day.part2())
    }

    func testDay6_part2_withRealInput() {
        let day = Day6(input: input)

        XCTAssertEqual(367, day.part2())
    }

    static var allTests = [
        ("testInputDecoder", testInputDecoder),
        ("testDay6_part1_withExampleInput", testDay6_part1_withExampleInput),
        ("testDay6_part1_withRealInput", testDay6_part1_withRealInput),
        ("testDay6_part2_withExampleInput", testDay6_part2_withExampleInput),
        ("testDay6_part2_withRealInput", testDay6_part2_withRealInput),
    ]
}
