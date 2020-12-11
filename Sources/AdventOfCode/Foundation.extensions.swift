import Foundation

// MARK: - Calendar

extension Calendar {
    public static let api: Self = updated(Calendar(identifier: .gregorian)) {
        $0.timeZone = .utc
        $0.locale = .posix
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

// MARK: - TimeZone

extension TimeZone {
    public static let utc = Self(secondsFromGMT: 0)!
}
