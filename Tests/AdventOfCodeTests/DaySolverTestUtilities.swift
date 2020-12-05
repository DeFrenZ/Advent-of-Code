import XCTest
import AdventOfCode

extension XCTestCase {
    func testDaySolver <Solver: DaySolver> (
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

    func executeDaySolver <Solver: DaySolver> (_ solverType: Solver.Type, file: StaticString = #file, line: UInt = #line) {
        let inputFromFile = input(year: Solver.year, day: Solver.day)
        guard let solver = try? Solver(input: inputFromFile) else {
            XCTFail(file: file, line: line)
            return
        }
        _ = solver.solvePart1()
        _ = solver.solvePart2()
    }
}

func input(year: Int, day: Int) -> String {
    let inputURL = Bundle.module.url(forResource: "\(year)-\(day)", withExtension: "txt")!
    let input = try! String(contentsOf: inputURL, encoding: .utf8)
    return input
}
