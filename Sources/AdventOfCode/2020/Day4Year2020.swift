//
//  File.swift
//  
//
//  Created by Davide De Franceschi on 04/12/2020.
//

import Foundation

public final class Day4Year2020: DaySolverWithInputs {
    public static let day = 4
    public static let year = 2020
    public static let elementsSeparator = "\n\n"

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /*
     --- Day 4: Passport Processing ---

     You arrive at the airport only to realize that you grabbed your North Pole Credentials instead of your passport. While these documents are extremely similar, North Pole Credentials aren't issued by a country and therefore aren't actually valid documentation for travel in most of the world.

     It seems like you're not the only one having problems, though; a very long line has formed for the automatic passport scanners, and the delay could upset your travel itinerary.

     Due to some questionable network security, you realize you might be able to solve both of these problems at the same time.

     The automatic passport scanners are slow because they're having trouble detecting which passports have all required fields. The expected fields are as follows:

     - byr (Birth Year)
     - iyr (Issue Year)
     - eyr (Expiration Year)
     - hgt (Height)
     - hcl (Hair Color)
     - ecl (Eye Color)
     - pid (Passport ID)
     - cid (Country ID)

     Passport data is validated in batch files (your puzzle input). Each passport is represented as a sequence of key:value pairs separated by spaces or newlines. Passports are separated by blank lines.

     Here is an example batch file containing four passports:

     ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
     byr:1937 iyr:2017 cid:147 hgt:183cm

     iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
     hcl:#cfa07d byr:1929

     hcl:#ae17e1 iyr:2013
     eyr:2024
     ecl:brn pid:760753108 byr:1931
     hgt:179cm

     hcl:#cfa07d eyr:2025 pid:166559648
     iyr:2011 ecl:brn hgt:59in

     The first passport is valid - all eight fields are present. The second passport is invalid - it is missing hgt (the Height field).

     The third passport is interesting; the only missing field is cid, so it looks like data from North Pole Credentials, not a passport at all! Surely, nobody would mind if you made the system temporarily ignore missing cid fields. Treat this "passport" as valid.

     The fourth passport is missing two fields, cid and byr. Missing cid is fine, but missing any other field is not, so this passport is invalid.

     According to the above rules, your improved system would report 2 valid passports.

     Count the number of valid passports - those that have all required fields. Treat cid as optional. In your batch file, how many passports are valid?
     */
    public func solvePart1() -> String {
        inputElements
            .count(where: { $0.hasMandatoryPassportFields() })
            .description
    }

    /*
     --- Part Two ---

     The line is moving more quickly now, but you overhear airport security talking about how passports with invalid data are getting through. Better add some data validation, quick!

     You can continue to ignore the cid field, but each other field has strict rules about what values are valid for automatic validation:

     byr (Birth Year) - four digits; at least 1920 and at most 2002.
     iyr (Issue Year) - four digits; at least 2010 and at most 2020.
     eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
     hgt (Height) - a number followed by either cm or in:
     If cm, the number must be at least 150 and at most 193.
     If in, the number must be at least 59 and at most 76.
     hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
     ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
     pid (Passport ID) - a nine-digit number, including leading zeroes.
     cid (Country ID) - ignored, missing or not.
     Your job is to count the passports where all required fields are both present and valid according to the above rules. Here are some example values:

     byr valid:   2002
     byr invalid: 2003

     hgt valid:   60in
     hgt valid:   190cm
     hgt invalid: 190in
     hgt invalid: 190

     hcl valid:   #123abc
     hcl invalid: #123abz
     hcl invalid: 123abc

     ecl valid:   brn
     ecl invalid: wat

     pid valid:   000000001
     pid invalid: 0123456789

     Here are some invalid passports:

     eyr:1972 cid:100
     hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

     iyr:2019
     hcl:#602927 eyr:1967 hgt:170cm
     ecl:grn pid:012533040 byr:1946

     hcl:dab227 iyr:2012
     ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

     hgt:59cm ecl:zzz
     eyr:2038 hcl:74454a iyr:2023
     pid:3556412378 byr:2007
     Here are some valid passports:

     pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
     hcl:#623a2f

     eyr:2029 ecl:blu cid:129 byr:1989
     iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

     hcl:#888785
     hgt:164cm byr:2001 iyr:2015 cid:88
     pid:545766238 ecl:hzl
     eyr:2022

     iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719

     Count the number of valid passports - those that have all required fields and valid values. Continue to treat cid as optional. In your batch file, how many passports are valid?
     */
    public func solvePart2() -> String {
        inputElements
            .compactMap({ try? $0.passport() })
            .count
            .description
    }
}

// MARK: - Input

public extension Day4Year2020 {
    struct InputElement {
        fileprivate var keyValuePairs: [KeyValuePair]

        public typealias Passport = Day4Year2020.Passport
        fileprivate typealias KeyValuePair = Day4Year2020.KeyValuePair
        fileprivate typealias Key = KeyValuePair.Key
    }

    struct Passport {
        var birthYear: Year
        var issueYear: Year
        var expirationYear: Year
        var height: Measurement<UnitLength>
        var hairColor: RGBColor
        var eyeColor: EyeColor
        var passportID: String
        var countryID: String?

        public typealias Year = Int

        public enum EyeColor: String {
            case amber = "amb"
            case blue = "blu"
            case brown = "brn"
            case gray = "gry"
            case green = "grn"
            case hazel = "hzl"
            case other = "oth"
        }
    }

    fileprivate struct KeyValuePair {
        var key: Key
        var value: String

        enum Key: String, CaseIterable {
            case birthYear = "byr"
            case issueYear = "iyr"
            case expirationYear = "eyr"
            case height = "hgt"
            case hairColor = "hcl"
            case eyeColor = "ecl"
            case passportID = "pid"
            case countryID = "cid"
        }
    }
}

extension Day4Year2020.InputElement: ParseableFromString {
    public var description: String {
        keyValuePairs
            .map(\.description)
            .joined(separator: "\n")
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let pairs = try scanner.scanAll(KeyValuePair.self)

        return Self(keyValuePairs: pairs)
    }
}

extension Day4Year2020.KeyValuePair: ParseableFromString {
    var description: String {
        "\(key.rawValue):\(value)"
    }

    static func parse(on scanner: Scanner) throws -> Self {
        let keyString = try scanner.scanUpToString(":") ?! ParseError.onKey(scanner.remainingString)
        let key = try Key(rawValue: keyString) ?! ParseError.notAValidKey(keyString)
        _ = try scanner.scanString(":") ?! ParseError.onColon(scanner.remainingString)
        let value = try scanner.scanUpToCharacters(from: Self.keyValuePairSeparators) ?! ParseError.onValue(scanner.remainingString)
        _ = scanner.scanCharacters(from: Self.keyValuePairSeparators)

        return Self(key: key, value: value)
    }

    private static let keyValuePairSeparators: CharacterSet = .init(charactersIn: " \n")

    enum ParseError: Error {
        case onKey(String)
        case notAValidKey(String)
        case onColon(String)
        case onValue(String)
    }
}

extension Day4Year2020.Passport.EyeColor: ParseableFromString {}

// MARK: - Logic

private extension Day4Year2020.KeyValuePair.Key {
    static let mandatoryKeys: Set<Self> = Set(allCases).subtracting([.countryID])
}

extension Day4Year2020.InputElement {
    func hasMandatoryPassportFields() -> Bool {
        let keys = Set(keyValuePairs.map(\.key))
        return Key.mandatoryKeys.isSubset(of: keys)
    }

    func passport() throws -> Passport {
        let dictionary = Dictionary(grouping: keyValuePairs, by: \.key)
            .mapValues(\.first!.value)

        return try Passport(
            birthYear: Self.parseBirthYear(from: dictionary[.birthYear] ?! ValidationError.missingKey(\Passport.birthYear)),
            issueYear: Self.parseIssueYear(from: dictionary[.issueYear] ?! ValidationError.missingKey(\Passport.issueYear)),
            expirationYear: Self.parseExpirationYear(from: dictionary[.expirationYear] ?! ValidationError.missingKey(\Passport.expirationYear)),
            height: Self.parseLength(from: dictionary[.height] ?! ValidationError.missingKey(\Passport.height)),
            hairColor: Self.parseColor(from: dictionary[.hairColor] ?! ValidationError.missingKey(\Passport.hairColor)),
            eyeColor: Passport.EyeColor.parse(from: dictionary[.eyeColor] ?! ValidationError.missingKey(\Passport.eyeColor)),
            passportID: Self.parsePassportID(from: dictionary[.passportID] ?! ValidationError.missingKey(\Passport.passportID)),
            countryID: dictionary[.countryID])
    }

    public static func parseBirthYear(from string: String) throws -> Passport.Year {
        try parseYear(from: string, validRange: 1920 ... 2002)
    }

    public static func parseIssueYear(from string: String) throws -> Passport.Year {
        try parseYear(from: string, validRange: 2010 ... 2020)
    }

    public static func parseExpirationYear(from string: String) throws -> Passport.Year {
        try parseYear(from: string, validRange: 2020 ... 2030)
    }

    private static func parseYear(from string: String, validRange: ClosedRange<Int>) throws -> Passport.Year {
        let year = try Passport.Year(string, radix: 10) ?! ValidationError.year(.notANumber(string))
        let digitCount = string.count
        guard digitCount == 4 else { throw ValidationError.year(.wrongDigitCount(count: digitCount)) }
        guard validRange.contains(year) else { throw ValidationError.year(.notInRange(value: year, validRange: validRange)) }
        return year
    }

    public static func parseLength(from string: String) throws -> Measurement<UnitLength> {
        let scanner = Scanner(string: string)
        let length = try scanner.scanInt() ?! ValidationError.length(.doesNotStartWithANumber(string))
        let rawUnit = try scanner.scanUpToString("\n") ?! ValidationError.length(.notAValidUnit(""))

        let unit: UnitLength
        let validRange: ClosedRange<Int>
        switch rawUnit {
        case "cm":
            unit = UnitLength.centimeters
            validRange = 150 ... 193
        case "in":
            unit = UnitLength.inches
            validRange = 59 ... 76
        default:
            throw ValidationError.length(.notAValidUnit(rawUnit))
        }
        guard validRange.contains(length) else { throw ValidationError.length(.notInRange(value: length, validRange: validRange))}

        return Measurement(value: .init(length), unit: unit)
    }

    public static func parseColor(from string: String) throws -> RGBColor {
        let scanner = Scanner(string: string)
        _ = try scanner.scanString("#") ?! ValidationError.rgbColor(.doesNotStartWithAHash(string))
        let red = try scanner.scanUInt16(representation: .hexadecimal) ?! ValidationError.rgbColor(.notAValidNumber(scanner.remainingString))
        let green = try scanner.scanUInt16(representation: .hexadecimal) ?! ValidationError.rgbColor(.notAValidNumber(scanner.remainingString))
        let blue = try scanner.scanUInt16(representation: .hexadecimal) ?! ValidationError.rgbColor(.notAValidNumber(scanner.remainingString))
        guard scanner.isAtEnd else { throw ValidationError.rgbColor(.hasLeftover(scanner.remainingString)) }

        return RGBColor(red: red, green: green, blue: blue)
    }

    public static func parsePassportID(from string: String) throws -> String {
        guard string.prefix(10).count == 9 else { throw ValidationError.passportID(.notAValidLength(string)) }
        guard string.allSatisfy(\.isNumber) else { throw ValidationError.passportID(.notAllDigits(string)) }
        return string
    }

    public enum ValidationError: Error {
        case missingKey(PartialKeyPath<Passport>)
        case year(YearError)
        case length(LengthError)
        case rgbColor(RGBColorError)
        case passportID(PassportIDError)

        public enum YearError: Error {
            case notANumber(String)
            case wrongDigitCount(count: Int)
            case notInRange(value: Int, validRange: ClosedRange<Int>)
        }

        public enum LengthError: Error {
            case doesNotStartWithANumber(String)
            case notAValidUnit(String)
            case notInRange(value: Int, validRange: ClosedRange<Int>)
        }

        public enum RGBColorError: Error {
            case doesNotStartWithAHash(String)
            case notAValidNumber(String)
            case hasLeftover(String)
        }

        public enum PassportIDError: Error {
            case notAValidLength(String)
            case notAllDigits(String)
        }
    }
}
