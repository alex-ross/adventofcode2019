import XCTest
@testable import Day3

final class Day3Tests: XCTestCase {

    func testManhattanDistance() {
        let a = Point(x: 1, y: 9)
        let b = Point(x: 4, y: 6)

        XCTAssertEqual(a.manhattanDistance(to: b), 6)
    }

    func testDecoder() {
        let input = """
        R75,D30
        U62,L66
        """

        let decoder = InputDecoder(input: input)

        XCTAssertEqual(decoder.decode(), [
            [
                Step(direction: .right, distance: 75),
                Step(direction: .down, distance: 30)
            ],
            [
                Step(direction: .up, distance: 62),
                Step(direction: .left, distance: 66)
            ]
        ])
    }

    func testExample_part1_1() {
        let day = Day3(input: """
        R75,D30,R83,U83,L12,D49,R71,U7,L72
        U62,R66,U55,R34,D71,R55,D58,R83
        """)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(day.part1(), 159)
    }

    func testExample_part1_2() {
        let day = Day3(input: """
        R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
        U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
        """)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(day.part1(), 135)
    }

    func testWithInput_part1() {
        XCTAssertEqual(Day3(input: input).part1(), 303)
    }

    func testExample_part2_1() {
        let day = Day3(input: """
        R75,D30,R83,U83,L12,D49,R71,U7,L72
        U62,R66,U55,R34,D71,R55,D58,R83
        """)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(day.part2(), 610)
    }

    func testExample_part2_2() {
        let day = Day3(input: """
        R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
        U98,R91,D20,R16,D67,R40,U7,R15,U6,R7
        """)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(day.part2(), 410)
    }

    func testExample_part2_3() {
        let day = Day3(input: """
        R8,U5,L5,D3
        U7,R6,D4,L4
        """)

        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(day.part2(), 30)
    }

    func testWithInput_part2() {
        XCTAssertEqual(Day3(input: input).part2(), 11222)
    }

    static var allTests = [
        ("testExample_part1_1", testExample_part1_1),
        ("testExample_part1_2", testExample_part1_2),
    ]
}
