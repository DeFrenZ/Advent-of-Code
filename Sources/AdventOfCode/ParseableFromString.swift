import Foundation

public protocol ParseableFromString {
    static func parse(on scanner: Scanner) throws -> Self
}

extension ParseableFromString {
    public init?(_ description: String) {
        guard let parsed = try? Self.parse(from: description) else { return nil }
        self = parsed
    }

    public static func parse(from string: String) throws -> Self {
        let scanner = Scanner(string: string)
        scanner.charactersToBeSkipped = nil
        return try Self.parse(on: scanner)
    }
}

extension Sequence where Element: CustomStringConvertible, Element: ParseableFromString {
    var inputDescription: String {
        map(\.description)
            .joined(separator: "\n")
    }
}

// MARK: - Scanner

extension Scanner {
    func scan <P: ParseableFromString> (_ type: P.Type) throws -> P {
        try P.parse(on: self)
    }

    func scanAll <P: ParseableFromString> (
        _ type: P.Type,
        separators: Set<String> = [],
        stopAt terminators: CharacterSet = .newlines
    ) throws -> [P] {
        var parsed: [P] = []
        while !isAtEnd, peekUnicodeScalar().map(terminators.contains) != true {
            try parsed.append(scan(P.self))
            if let separator = separators.first(where: { remainingString.hasPrefix($0) }) {
                _ = scanString(separator)
            }
        }
        return parsed
    }
}

// MARK: - stdlib Types Conformances

extension Character: ParseableFromString {
    public static func parse(on scanner: Scanner) throws -> Self {
        try scanner.scanCharacter() ?! ParseError.doesNotStartWithACharacter(scanner.remainingString)
    }

    public enum ParseError: Error {
        case doesNotStartWithACharacter(String)
    }
}

extension String: ParseableFromString {
    public static func parse(on scanner: Scanner) throws -> Self {
        try scanner.scanUpToString("\0") ?! ParseError.doesNotStartWithAString(scanner.remainingString)
    }

    public enum ParseError: Error {
        case doesNotStartWithAString(String)
    }
}

extension Int: ParseableFromString {
    public static func parse(on scanner: Scanner) throws -> Self {
        try scanner.scanInt() ?! ParseError.doesNotStartWithAnInt(scanner.remainingString)
    }

    public enum ParseError: Error {
        case doesNotStartWithAnInt(String)
    }
}

extension Array: ParseableFromString where Element: ParseableFromString {
    public static func parse(on scanner: Scanner) throws -> Self {
        try scanner.scanAll(Element.self)
    }
}

// MARK: - RawRepresentable

extension ParseableFromString where Self: RawRepresentable, RawValue == Character {
    public var description: String {
        String(rawValue)
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        typealias ParseError = CharacterRawRepresentableParseError

        let character = try scanner.scanCharacter() ?! ParseError.doesNotStartWithACharacter(scanner.remainingString)
        let parsed = try Self(rawValue: character) ?! ParseError.notAValidRawCharacter(character)
        return parsed
    }
}

public enum CharacterRawRepresentableParseError: Error {
    case doesNotStartWithACharacter(String)
    case notAValidRawCharacter(Character)
}

extension ParseableFromString where Self: RawRepresentable, RawValue == String {
    public var description: String {
        String(rawValue)
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        typealias ParseError = StringRawRepresentableParseError

        let string = try scanner.scanUpToString("\n") ?! ParseError.doesNotStartWithAString(scanner.remainingString)
        let parsed = try Self(rawValue: string) ?! ParseError.notAValidRawString(string)
        return parsed
    }
}

public enum StringRawRepresentableParseError: Error {
    case doesNotStartWithAString(String)
    case notAValidRawString(String)
}

extension ParseableFromString where Self: RawRepresentable, RawValue == Int {
    public var description: String {
        rawValue.description
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        typealias ParseError = IntRawRepresentableParseError

        let int = try scanner.scanInt() ?! ParseError.doesNotStartWithAnInt(scanner.remainingString)
        let parsed = try Self(rawValue: int) ?! ParseError.notAValidRawInt(int)
        return parsed
    }
}

public enum IntRawRepresentableParseError: Error {
    case doesNotStartWithAnInt(String)
    case notAValidRawInt(Int)
}
