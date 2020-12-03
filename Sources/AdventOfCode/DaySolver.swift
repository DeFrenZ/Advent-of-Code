import Foundation

public protocol DaySolver {
    init(input: String) throws
    static var day: Int { get }
    static var year: Int { get }
    func solvePart1() -> String
    func solvePart2() -> String
}

protocol DaySolverWithInputs: DaySolver {
    associatedtype InputElement: ParseableFromString
    static var elementsSeparator: Character { get }
    init(inputElements: [InputElement]) throws
}

extension DaySolverWithInputs {
    public init(input: String) throws {
        let inputLines = try input
            .split(separator: Self.elementsSeparator)
            .map({ try InputElement.parse(from: String($0)) })
        try self.init(inputElements: inputLines)
    }

    public static var elementsSeparator: Character { "\n" }
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

extension Sequence where Element: ParseableFromString {
    var inputDescription: String {
        map(\.description)
            .joined(separator: "\n")
    }
}

extension Int: ParseableFromString {
    static func parse(on scanner: Scanner) throws -> Int {
        var parsed: Int = 0
        guard scanner.scanInt(&parsed) else { throw ParseError.doesNotStartWithAnInt(scanner.remainingString) }
        return parsed
    }

    enum ParseError: Error {
        case doesNotStartWithAnInt(String)
    }
}

extension ParseableFromString where Self: RawRepresentable, RawValue == Character {
    static func parse(on scanner: Scanner) throws -> Self {
        typealias ParseError = CharacterRawRepresentableParseError

        guard let character = scanner.scanCharacter() else { throw ParseError.doesNotStartWithACharacter(scanner.remainingString) }
        guard let parsed = Self(rawValue: character) else { throw ParseError.notAValidRawCharacter(character) }
        return parsed
    }
}

enum CharacterRawRepresentableParseError: Error {
    case doesNotStartWithACharacter(String)
    case notAValidRawCharacter(Character)
}

extension ParseableFromString where Self: RawRepresentable, RawValue == String {
    static func parse(on scanner: Scanner) throws -> Self {
        typealias ParseError = StringRawRepresentableParseError

        guard let string = scanner.scanUpToString("\n") else { throw ParseError.doesNotStartWithAString(scanner.remainingString) }
        guard let parsed = Self(rawValue: string) else { throw ParseError.notAValidRawString(string) }
        return parsed
    }
}

enum StringRawRepresentableParseError: Error {
    case doesNotStartWithAString(String)
    case notAValidRawString(String)
}
