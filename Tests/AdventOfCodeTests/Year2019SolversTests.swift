import XCTest
import AdventOfCode

final class Year2019SolversTests: XCTestCase {
    func testDay1() throws {
        try testDaySolver(Day1Year2019.self, input: "12", part1Solution: "2")
        try testDaySolver(Day1Year2019.self, input: "14", part1Solution: "2")
        try testDaySolver(Day1Year2019.self, input: "1969", part1Solution: "654")
        try testDaySolver(Day1Year2019.self, input: "100756", part1Solution: "33583")

        try testDaySolver(Day1Year2019.self, input: "14", part2Solution: "2")
        try testDaySolver(Day1Year2019.self, input: "1969", part2Solution: "966")
        try testDaySolver(Day1Year2019.self, input: "100756", part2Solution: "50346")

        try testDaySolver(Day1Year2019.self, part1Solution: "3457281", part2Solution: "5183030")
    }

    func testDay2() throws {
        XCTAssertEqual(Day2Year2019.executedProgram([1,9,10,3,2,3,11,0,99,30,40,50]), [3500,9,10,70,2,3,11,0,99,30,40,50])
        XCTAssertEqual(Day2Year2019.executedProgram([1,0,0,0,99]), [2,0,0,0,99])
        XCTAssertEqual(Day2Year2019.executedProgram([2,3,0,3,99]), [2,3,0,6,99])
        XCTAssertEqual(Day2Year2019.executedProgram([2,4,4,5,99,0]), [2,4,4,5,99,9801])
        XCTAssertEqual(Day2Year2019.executedProgram([1,1,1,4,99,5,6,0,99]), [30,1,1,4,2,5,6,0,99])

        try testDaySolver(Day2Year2019.self, part1Solution: "3101878", part2Solution: "8444")
    }
}
