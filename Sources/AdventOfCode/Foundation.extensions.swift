import Foundation

// MARK: - Scanner

extension Scanner {
    public var remainingString: String {
        String(string[currentIndex...])
    }

    func peekUnicodeScalar() -> UnicodeScalar? {
        remainingString.unicodeScalars.first
    }

    public func scanUInt16(representation: NumberRepresentation) -> UInt16? {
        let parseEndIndex = string.index(currentIndex, offsetBy: 2)
        guard parseEndIndex <= string.endIndex else { return nil }
        let parsedString = string[currentIndex ..< parseEndIndex]
        guard let number = UInt16(parsedString, radix: 16) else { return nil }
        self.currentIndex = parseEndIndex
        return number
    }
}

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
