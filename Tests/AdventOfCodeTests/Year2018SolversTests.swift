import XCTest
import AdventOfCode

final class Year2018SolversTests: XCTestCase {
    func testDay1() throws {
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [+1, -2, +3, +1]), 3)
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [+1, +1, +1]), 3)
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [+1, +1, -2]), 0)
        XCTAssertEqual(Day1Year2018.resultFrequency(changes: [-1, -2, -3]), -6)

        try testDaySolver(Day1Year2018.self, part1Solution: "484", part2Solution: "367")
    }
}
