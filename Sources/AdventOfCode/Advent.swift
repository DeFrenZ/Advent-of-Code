import Foundation
import ArgumentParser

@main
struct Advent: ParsableCommand {
    static let configuration: CommandConfiguration = .init(abstract: "Solve the puzzle of the given day of the Advent of Code")

	@Option(name: .shortAndLong, help: "The day of the Advent of Code to solve")
	var day: Int
	
    mutating func run() throws {
		
	}
}

public protocol DaySolver {
    static var day: Int { get }
    static var year: Int { get }
    init(lines: [Substring])
    func solvePart1() -> String
    func solvePart2() -> String
}
