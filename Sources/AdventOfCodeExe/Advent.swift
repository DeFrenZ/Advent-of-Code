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

    @Option(name: .customLong("path"), help: "The path at which to get the input from")
    var inputPath: String
	
    mutating func run() throws {
        let solverType = try daySolverType(year: year, day: day)
		let input = try String(contentsOf: URL(fileURLWithPath: inputPath), encoding: .utf8)
        let solver = try solverType.init(input: input)
        print("Part 1: \(solver.solvePart1())")
        print("Part 2: \(solver.solvePart2())")
	}
}
