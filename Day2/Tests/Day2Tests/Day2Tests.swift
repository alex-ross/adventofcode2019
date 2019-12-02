import XCTest
@testable import Day2

final class Day2Tests: XCTestCase {
    func testExample_1_part1() {
        let input = "1,0,0,0,99"

        let day = Day2(input: input)

        XCTAssertEqual(day.part1(), [2,0,0,0,99])
    }

    func testExample_2_part1() {
        let input = "2,3,0,3,99"

        let day = Day2(input: input)

        XCTAssertEqual(day.part1(), [2,3,0,6,99])
    }

    func testExample_3_part1() {
        let input = "2,4,4,5,99,0"

        let day = Day2(input: input)

        XCTAssertEqual(day.part1(), [2,4,4,5,99,9801])
    }

    func testExample_4_part1() {
        let input = "1,1,1,4,99,5,6,0,99"

        let day = Day2(input: input)

        XCTAssertEqual(day.part1(), [30,1,1,4,2,5,6,0,99])
    }

    func testWithInput() {
        let day = Day2(input: input)

        XCTAssertEqual(day.part1(noun: 12, verb: 2).first, 5482655)
    }

    func testPart2() throws {
        let day = Day2(input: input)

        XCTAssertEqual(try day.part2(), "4967")

    }


//    static var allTests = [
//        ("testExample", testExample),
//    ]
}
