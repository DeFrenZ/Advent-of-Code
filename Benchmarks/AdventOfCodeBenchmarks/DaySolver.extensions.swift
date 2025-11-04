import AdventOfCode
import AdventOfCodeInputs

extension DaySolver {
	static func computeSolutions() throws {
		let puzzleInput = try Inputs.puzzleInput(year: year, day: day)
		let solver = try Self.init(input: puzzleInput)
		_ = solver.solvePart1()
		_ = solver.solvePart2()
	}
}
