import XCTest
@testable import Day1

final class Day1Tests: XCTestCase {
    func testExample_massIs12() {
        let module = Module(mass: 12)

        XCTAssertEqual(2, module.fuelRequirement(part: .one))
    }

    func testExample_massIs14() {
        let module = Module(mass: 14)

        XCTAssertEqual(2, module.fuelRequirement(part: .one))
    }

    func testExample_massIs1969() {
        let module = Module(mass: 1969)

        XCTAssertEqual(654, module.fuelRequirement(part: .one))
    }

    func testExample_massIs100756() {
        let module = Module(mass: 100756)

        XCTAssertEqual(33583, module.fuelRequirement(part: .one))
    }

    func testWithInput() {
        let fuelRequirement = StructuredInput(input: input)
            .masses
            .map { Module(mass: $0).fuelRequirement(part: .one) }
            .reduce(0, +)

        XCTAssertEqual(3412207, fuelRequirement)
    }

    func testExample_massIs14_part2() {
        let module = Module(mass: 14)

        XCTAssertEqual(2, module.fuelRequirement(part: .two))
    }

    func testExample_massIs1969_part2() {
        let module = Module(mass: 1969)

        XCTAssertEqual(966, module.fuelRequirement(part: .two))
    }

    func testExample_massIs100756_part2() {
        let module = Module(mass: 100756)

        XCTAssertEqual(50346, module.fuelRequirement(part: .two))
    }

    func testWithInput_part2() {
        let fuelRequirement = StructuredInput(input: input)
            .masses
            .map { Module(mass: $0).fuelRequirement(part: .two) }
            .reduce(0, +)

        XCTAssertEqual(5115436, fuelRequirement)
    }

//    static var allTests = [
//        ("testExample", testExample),
//    ]
}
