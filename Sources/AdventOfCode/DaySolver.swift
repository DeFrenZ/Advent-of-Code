import Foundation

public protocol DaySolver {
    init(lines: [Substring]) throws
    static var day: Int { get }
    static var year: Int { get }
    func solvePart1() -> String
    func solvePart2() -> String
}

protocol DaySolverWithInput: DaySolver {
    associatedtype InputLine: ParseableFromString
    init(inputLines: [InputLine]) throws
}

extension DaySolverWithInput {
    public init(lines: [Substring]) throws {
        let inputLines = try lines.map({ try InputLine.parse(from: String($0)) })
        try self.init(inputLines: inputLines)
    }
}

// MARK: - ParseableFromString

protocol ParseableFromString: LosslessStringConvertible {
    static func parse(on scanner: Scanner) throws -> Self
}

struct ParseError: Error {}

extension ParseableFromString {
    public init?(_ description: String) {
        guard let parsed = try? Self.parse(from: description) else { return nil }
        self = parsed
    }

    static func parse(from string: String) throws -> Self {
        let scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = nil
        return try Self.parse(on: scanner)
    }
}

extension Int: ParseableFromString {
    static func parse(on scanner: Scanner) throws -> Int {
        var parsed: Int = 0
        guard scanner.scanInt(&parsed) else { throw ParseError() }
        return parsed
    }
}
