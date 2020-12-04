import Foundation

// MARK: - Scanner

extension Scanner {
    public var remainingString: String {
        String(string[currentIndex...])
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

    func scanAll <P: ParseableFromString> (_ type: P.Type) throws -> [P] {
        var parsed: [P] = []
        while !isAtEnd {
            try parsed.append(scan(P.self))
        }
        return parsed
    }
}
