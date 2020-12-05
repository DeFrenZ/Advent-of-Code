public protocol DaySolver {
    init(input: String) throws
    static var day: Int { get }
    static var year: Int { get }
    func solvePart1() -> String
    func solvePart2() -> String
}

func daySolverType(year: Int, day: Int) throws -> DaySolver.Type {
    switch (year, day) {
    case (2018, 1): return Day1Year2018.self
    case (2019, 1): return Day1Year2019.self
    case (2019, 2): return Day2Year2019.self
    case (2020, 1): return Day1Year2020.self
    case (2020, 2): return Day2Year2020.self
    case (2020, 3): return Day3Year2020.self
    case (2020, 4): return Day4Year2020.self
    default: throw DaySolverError.unsolvedDay(year: year, day: day)
    }
}

enum DaySolverError: Swift.Error {
    case unsolvedDay(year: Int, day: Int)
}

// MARK: - DaySolverWithInputs

protocol DaySolverWithInputs: DaySolver {
    associatedtype InputElement: ParseableFromString
    static var elementsSeparator: String { get }
    init(inputElements: [InputElement]) throws
}

extension DaySolverWithInputs {
    public init(input: String) throws {
        let entries = input
            .components(separatedBy: Self.elementsSeparator)
            .filter(\.isEmpty.not)
        let inputElements = try entries
            .map({ try InputElement.parse(from: String($0)) })
        try self.init(inputElements: inputElements)
    }

    public static var elementsSeparator: String { "\n" }
}
