import Foundation

// MARK: - Calendar

extension Calendar {
    public static let api: Self = updated(Calendar(identifier: .gregorian)) {
        $0.timeZone = .utc
        $0.locale = .posix
    }
}

// MARK: - Comparable

extension Comparable {
    func compared(to other: Self) -> ComparisonResult {
        if self == other {
            return .orderedSame
        } else if self < other {
            return .orderedAscending
        } else {
            return .orderedDescending
        }
    }
}

// MARK: - DateFormatter

extension DateFormatter {
    public static func apiDateFormatter(format: String) -> DateFormatter {
        updated(DateFormatter()) {
            let calendar = Calendar.api
            $0.calendar = calendar
            $0.timeZone = calendar.timeZone
            $0.locale = calendar.locale
            $0.dateFormat = format
        }
    }
}

// MARK: - Locale

extension Locale {
    public static let posix = Self(identifier: "en_US_POSIX")
}

// MARK: - NSRegularExpression

extension NSRegularExpression {
    func matches(_ string: String) -> Bool {
        firstMatch(in: string, options: .anchored, range: string.fullNSRange) != nil
    }
}

// MARK: - Scanner

extension Scanner {
    public var remainingString: String {
        String(string[currentIndex...])
    }

    func peekUnicodeScalar() -> UnicodeScalar? {
        remainingString.unicodeScalars.first
    }

    public func scanUInt8(representation: NumberRepresentation) -> UInt8? {
        guard let character = scanCharacter() else { return nil }
        guard let number = UInt8(String(character), radix: representation.radix) else { return nil }
        return number
    }

    public func scanUInt16(representation: NumberRepresentation) -> UInt16? {
        let parseEndIndex = string.index(currentIndex, offsetBy: 2)
        guard parseEndIndex <= string.endIndex else { return nil }
        let parsedString = string[currentIndex ..< parseEndIndex]
        guard let number = UInt16(parsedString, radix: representation.radix) else { return nil }
        self.currentIndex = parseEndIndex
        return number
    }
}

extension Scanner.NumberRepresentation {
    var radix: Int {
        switch self {
        case .decimal: return 10
        case .hexadecimal: return 16
        @unknown default: return 0
        }
    }
}

// MARK: - String

extension String {
    var fullNSRange: NSRange {
        .init(location: 0, length: (self as NSString).length)
    }
}

// MARK: - TimeZone

extension TimeZone {
    public static let utc = Self(secondsFromGMT: 0)!
}
