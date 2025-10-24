import Foundation
import ArgumentParser

@main
struct Advent: ParsableCommand {
	static var configuration: CommandConfiguration {
		.init(abstract: "Solve the puzzle of the given day of the Advent of Code")
	}

    @Option(name: .shortAndLong, help: "The year of the Advent of Code to solve")
    var year: Int = 2020

	@Option(name: .shortAndLong, help: "The day of the Advent of Code to solve")
	var day: Int

    @Argument(help: "The input to parse")
    var input: [String]
	
    mutating func run() throws {
        let solverType = try daySolverType(year: year, day: day)
        let fullInput = input.joined(separator: "\n")
        let solver = try solverType.init(input: fullInput)
        print("Part 1: \(solver.solvePart1())")
        print("Part 2: \(solver.solvePart2())")
	}
}
