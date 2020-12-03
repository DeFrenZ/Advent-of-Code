import Foundation
import ArgumentParser

@main
struct Advent: ParsableCommand {
    static let configuration: CommandConfiguration = .init(abstract: "Solve the puzzle of the given day of the Advent of Code")

    @Option(name: .shortAndLong, help: "The year of the Advent of Code to solve")
    var year: Int = 2020

	@Option(name: .shortAndLong, help: "The day of the Advent of Code to solve")
	var day: Int

    @Argument(help: "The input to parse")
    var input: [String]
	
    mutating func run() throws {
        let solverType = try Self.solverType(year: year, day: day)
        let fullInput = input.joined(separator: "\n")
        let solver = try solverType.init(input: fullInput)
        print("Part 1: \(solver.solvePart1())")
        print("Part 2: \(solver.solvePart2())")
	}

    private static func solverType(year: Int, day: Int) throws -> DaySolver.Type {
        switch (year, day) {
        case (2020, 1): return Day1Year2020.self
        case (2020, 2): return Day2Year2020.self
        case (2020, 3): return Day3Year2020.self
        default: throw Error.unsolvedDay(year: year, day: day)
        }
    }

    enum Error: Swift.Error {
        case unsolvedDay(year: Int, day: Int)
    }
}
