import Testing
import class Foundation.Bundle
import AdventOfCode

extension DaySolver {
	static func testSolutions(
		input: String = puzzleInput(),
		part1Solution: String? = nil,
		part2Solution: String? = nil,
		sourceLocation: SourceLocation = #_sourceLocation)
	throws {
		let solver = try Self.init(input: input)

		if let part1Solution = part1Solution {
			let part1ComputedSolution = solver.solvePart1()
			#expect(
				part1ComputedSolution == part1Solution,
				"Solution of \(Self.self),1 is incorrect",
				sourceLocation: sourceLocation)
		}

		if let part2Solution = part2Solution {
			let part2ComputedSolution = solver.solvePart2()
			#expect(
				part2ComputedSolution == part2Solution,
				"Solution of \(Self.self),2 is incorrect",
				sourceLocation: sourceLocation)
		}
	}

	static func computeSolutions() throws {
		let solver = try Self.init(input: puzzleInput())
		_ = solver.solvePart1()
		_ = solver.solvePart2()
	}

	private static func puzzleInput() -> String {
		let inputURL = Bundle.module.url(forResource: "\(year)-\(day)", withExtension: "txt")!
		let input = try! String(contentsOf: inputURL, encoding: .utf8)
		return input
	}
}
