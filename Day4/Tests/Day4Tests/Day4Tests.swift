import XCTest
@testable import Day4

final class Day4Tests: XCTestCase {
    func testDoubleValidator() {
        XCTAssertTrue(DoubleValidator("111111").isValid)
        XCTAssertTrue(DoubleValidator("223450").isValid)

        XCTAssertFalse(DoubleValidator("123789").isValid)
    }

    func testLeftToRightNeverDecreaseValidator() {
        XCTAssertTrue(LeftToRightNeverDecreaseValidator("111111").isValid)
        XCTAssertTrue(LeftToRightNeverDecreaseValidator("123789").isValid)

        XCTAssertFalse(LeftToRightNeverDecreaseValidator("223450").isValid)
    }

    func testNotLargerGroupOfMatchingDigitsValidator() {
        XCTAssertTrue(NotLargerGroupOfMatchingDigitsValidator("111122").isValid)
        XCTAssertTrue(NotLargerGroupOfMatchingDigitsValidator("223450").isValid)
        XCTAssertTrue(NotLargerGroupOfMatchingDigitsValidator("112233").isValid)

        XCTAssertFalse(NotLargerGroupOfMatchingDigitsValidator("111111").isValid)
        XCTAssertFalse(NotLargerGroupOfMatchingDigitsValidator("222345").isValid)
        XCTAssertFalse(NotLargerGroupOfMatchingDigitsValidator("123444").isValid)
    }

    func testInpudDecoder() {
        let decoder = InputDecoder(input: "146810-612564")

        XCTAssertEqual(decoder.decode(), 146810...612564)
    }

    func testDay4WithInput_part1() {
        let day = Day4(input: "146810-612564")

        XCTAssertEqual(1748, day.part1())
    }

    func testDay4WithInput_part2() {
        let day = Day4(input: "146810-612564")

        XCTAssertEqual(1180, day.part2())
    }

    static var allTests = [
        ("testDoubleValidator", testDoubleValidator),
        ("testLeftToRightNeverDecreaseValidator", testLeftToRightNeverDecreaseValidator),
        ("testNotLargerGroupOfMatchingDigitsValidator", testNotLargerGroupOfMatchingDigitsValidator),
        ("testInpudDecoder", testInpudDecoder),
        ("testDay4WithInput_part1", testDay4WithInput_part1),
        ("testDay4WithInput_part2", testDay4WithInput_part2),
    ]
}
