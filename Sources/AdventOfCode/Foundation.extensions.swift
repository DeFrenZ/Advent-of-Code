import Foundation

// MARK: - Scanner

extension Scanner {
    public var remainingString: String {
        String(string[currentIndex...])
    }

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
