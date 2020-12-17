public protocol DaySolver {
    init(input: String) throws
    static var day: Int { get }
    static var year: Int { get }
    func solvePart1() -> String
    func solvePart2() -> String
}

func daySolverType(year: Int, day: Int) throws -> DaySolver.Type {
    switch (year, day) {
    case (2018,  1): return Day1Year2018.self
    case (2018,  2): return Day2Year2018.self
    case (2018,  3): return Day3Year2018.self
    case (2018,  4): return Day4Year2018.self
    case (2018,  5): return Day5Year2018.self
    case (2019,  1): return Day1Year2019.self
    case (2019,  2): return Day2Year2019.self
    case (2020,  1): return Day1Year2020.self
    case (2020,  2): return Day2Year2020.self
    case (2020,  3): return Day3Year2020.self
    case (2020,  4): return Day4Year2020.self
    case (2020,  5): return Day5Year2020.self
    case (2020,  6): return Day6Year2020.self
    case (2020,  7): return Day7Year2020.self
    case (2020,  8): return Day8Year2020.self
    case (2020,  9): return Day9Year2020.self
    case (2020, 10): return Day10Year2020.self
    case (2020, 11): return Day11Year2020.self
    case (2020, 12): return Day12Year2020.self
    case (2020, 13): return Day13Year2020.self
    case (2020, 14): return Day14Year2020.self
    case (2020, 15): return Day15Year2020.self
    case (2020, 16): return Day16Year2020.self
    default: throw DaySolverError.unsolvedDay(year: year, day: day)
    }
}

enum DaySolverError: Swift.Error {
    case unsolvedDay(year: Int, day: Int)
}

import Foundation

// MARK: - DaySolverWithSingleInput

public protocol DaySolverWithSingleInput: DaySolver {
    associatedtype Input: ParseableFromString
    init(input: Input)
}

extension DaySolverWithSingleInput {
    public init(input: String) throws {
        let input = try Input.parse(from: input)
        self.init(input: input)
    }
}

// MARK: - DaySolverWithInputs

public protocol DaySolverWithInputs: DaySolver {
    associatedtype InputElement: ParseableFromString
    static var elementsSeparator: String { get }
    init(inputElements: [InputElement])
}

extension DaySolverWithInputs {
    public init(input: String) throws {
        let inputElements = try Self.parseInputElements(input: input)
        self.init(inputElements: inputElements)
    }
}

extension DaySolverWithInputs {
    public static var elementsSeparator: String { "\n" }
}

extension DaySolverWithInputs {
    public static func parseInputElements(input: String) throws -> [InputElement] {
        let entries = input
            .components(separatedBy: Self.elementsSeparator)
            .filter(\.isEmpty.not)
        let inputElements = try entries
            .map({ try InputElement.parse(from: String($0)) })
        return inputElements
    }
}

// MARK: - DaySolverWithHeaderAndInputs

public protocol DaySolverWithHeaderAndInputs: DaySolver {
    associatedtype HeaderElement: ParseableFromString
    associatedtype InputElement: ParseableFromString
    static var headerSeparator: String { get }
    static var elementsSeparator: String { get }
    init(headerElement: HeaderElement, inputElements: [InputElement])
}

extension DaySolverWithHeaderAndInputs {
    public init(input: String) throws {
        let (headerElement, remainingInput) = try Self.parseHeaderElement(input: input)
        let inputElements = try Self.parseInputElements(input: remainingInput)
        self.init(headerElement: headerElement, inputElements: inputElements)
    }
}

extension DaySolverWithHeaderAndInputs {
    public static var headerSeparator: String { "\n" }
    public static var elementsSeparator: String { "\n" }
}

extension DaySolverWithHeaderAndInputs {
    public static func parseHeaderElement(input: String) throws -> (HeaderElement, remaining: String) {
        guard let headerTerminator = input.range(of: Self.headerSeparator) else { throw HeaderParseError.noSeparator(input) }
        let header = try HeaderElement.parse(from: String(input[input.startIndex ..< headerTerminator.lowerBound]))
        let remaining = String(input[headerTerminator.upperBound...])
        return (header, remaining)
    }

    public static func parseInputElements(input: String) throws -> [InputElement] {
        let entries = input
            .components(separatedBy: Self.elementsSeparator)
            .filter(\.isEmpty.not)
        let inputElements = try entries
            .map({ try InputElement.parse(from: String($0)) })
        return inputElements
    }

    typealias HeaderParseError = _HeaderParseError
}

enum _HeaderParseError: Error {
    case noSeparator(String)
}
