import XCTest
import AdventOfCode

final class DaySolutionsTests: XCTestCase {
    func testDay1() throws {
        let sampleInput = """
            1721
            979
            366
            299
            675
            1456
            """
        try testDaySolver(Day1Year2020.self, input: sampleInput, part1Solution: "514579", part2Solution: "241861950")
        try testDaySolver(Day1Year2020.self, part1Solution: "1010884", part2Solution: "253928438")
    }

    func testDay2() throws {
        let sampleInput = """
            1-3 a: abcde
            1-3 b: cdefg
            2-9 c: ccccccccc
            """
        try testDaySolver(Day2Year2020.self, input: sampleInput, part1Solution: "2", part2Solution: "1")
        try testDaySolver(Day2Year2020.self, part1Solution: "393", part2Solution: "690")
    }

    func testDay3() throws {
        let sampleInput = """
            ..##.......
            #...#...#..
            .#....#..#.
            ..#.#...#.#
            .#...##..#.
            ..#.##.....
            .#.#.#....#
            .#........#
            #.##...#...
            #...##....#
            .#..#...#.#
            """
        try testDaySolver(Day3Year2020.self, input: sampleInput, part1Solution: "7", part2Solution: "336")
        try testDaySolver(Day3Year2020.self, part1Solution: "268", part2Solution: "3093068400")
    }
}

extension DaySolutionsTests {
    private func testDaySolver <Solver: DaySolver> (
        _ solverType: Solver.Type,
        input: String = input(year: Solver.year, day: Solver.day),
        part1Solution: String? = nil,
        part2Solution: String? = nil,
        file: StaticString = #file,
        line: UInt = #line)
    throws {
        let solver = try Solver(input: input)

        if let part1Solution = part1Solution {
            let part1ComputedSolution = solver.solvePart1()
            XCTAssertEqual(part1ComputedSolution, part1Solution, "Solution of \(Solver.self),1 is incorrect", file: file, line: line)
        }

        if let part2Solution = part2Solution {
            let part2ComputedSolution = solver.solvePart2()
            XCTAssertEqual(part2ComputedSolution, part2Solution, "Solution of \(Solver.self),2 is incorrect", file: file, line: line)
        }
    }

    private static func input(year: Int, day: Int) -> String {
        let inputURL = Bundle.module.url(forResource: "\(year)-\(day)", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL, encoding: .utf8)
        return input
    }
}
