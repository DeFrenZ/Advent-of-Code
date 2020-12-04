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
}
