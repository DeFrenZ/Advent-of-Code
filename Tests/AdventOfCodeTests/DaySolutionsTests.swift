import XCTest
import AdventOfCode

final class DaySolutionsTests: XCTestCase {
    func testDay1() throws {
        try testDaySolver(Day1Year2020.self, part1Solution: "1010884", part2Solution: "253928438")
    }

    private func testDaySolver <Solver: DaySolver> (
        _ solverType: Solver.Type,
        part1Solution: String,
        part2Solution: String,
        file: StaticString = #file,
        line: UInt = #line)
    throws {
        let lines = linesOfInput(year: Solver.year, day: Solver.day)
        let solver = try Solver(lines: lines)

        let part1ComputedSolution = solver.solvePart1()
        XCTAssertEqual(part1ComputedSolution, part1Solution, "Solution of \(Solver.self),1 is incorrect", file: file, line: line)

        let part2ComputedSolution = solver.solvePart2()
        XCTAssertEqual(part2ComputedSolution, part2Solution, "Solution of \(Solver.self),2 is incorrect", file: file, line: line)
    }

    private func linesOfInput(year: Int, day: Int) -> [Substring] {
        let inputURL = Bundle.module.url(forResource: "\(year)-\(day)", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL, encoding: .utf8)
        let lines = input.split(separator: "\n")
        return lines
    }
}
