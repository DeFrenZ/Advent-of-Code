import Foundation

public final class Day2Year2020: DaySolverWithInputs {
    public static let day = 2
    public static let year = 2020

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /*
     --- Day 2: Password Philosophy ---

     Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.

     The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.

     Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.

     To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.

     For example, suppose you have the following list:

     1-3 a: abcde
     1-3 b: cdefg
     2-9 c: ccccccccc

     Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.

     In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.

     How many passwords are valid according to their policies?
     */
    public func solvePart1() -> String {
        inputElements
            .count(where: \.isPasswordValidOnOldRules)
            .description
    }

    /*
     --- Part Two ---

     While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

     The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

     Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

     Given the same example list from above:

     1-3 a: abcde is valid: position 1 contains a and position 3 does not.
     1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
     2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
     How many passwords are valid according to the new interpretation of the policies?
     */
    public func solvePart2() -> String {
        inputElements
            .count(where: \.isPasswordValidOnNewRules)
            .description
    }
}

// MARK: - Input

public extension Day2Year2020 {
    struct InputElement {
        var policy: PasswordPolicy
        var password: String

        typealias PasswordPolicy = Day2Year2020.PasswordPolicy
    }

    struct PasswordPolicy {
        var appearanceTimes: ClosedRange<Int>
        var character: Character
    }
}

extension Day2Year2020.InputElement: ParseableFromString {
    public var description: String {
        "\(policy): \(password)"
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let policy = try PasswordPolicy.parse(on: scanner)
        guard scanner.scanString(": ") != nil else { throw ParseError.onColonSpace }
        guard let password = scanner.scanUpToString("\n") else { throw ParseError.onPassword }

        return Self(policy: policy, password: password)
    }

    public enum ParseError: Error {
        case onColonSpace
        case onPassword
    }
}

extension Day2Year2020.PasswordPolicy: ParseableFromString {
    public var description: String {
        "\(appearanceTimes.lowerBound)-\(appearanceTimes.upperBound) \(character)"
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        guard let lowerBound = scanner.scanInt() else { throw ParseError.onLowerBound }
        guard scanner.scanString("-") != nil else { throw ParseError.onSeparator }
        guard let upperBound = scanner.scanInt() else { throw ParseError.onUpperBound }
        guard upperBound > lowerBound else { throw ParseError.invalidBounds(lower: lowerBound, upper: upperBound) }
        guard scanner.scanString(" ") != nil else { throw ParseError.onSpace }
        guard let character = scanner.scanCharacter() else { throw ParseError.onCharacter }

        return Self(
            appearanceTimes: lowerBound ... upperBound,
            character: character)
    }

    public enum ParseError: Error {
        case onLowerBound
        case onSeparator
        case onUpperBound
        case invalidBounds(lower: Int, upper: Int)
        case onSpace
        case onCharacter
    }
}

// MARK: - Logic

private extension String {
    func matchesPolicyOnOldRules(_ policy: Day2Year2020.PasswordPolicy) -> Bool {
        let characters = Dictionary(countingOccurrencesOf: self)
        let policyCharacterCount = characters[policy.character] ?? 0
        return policy.appearanceTimes.contains(policyCharacterCount)
    }

    func matchesPolicyOnNewRules(_ policy: Day2Year2020.PasswordPolicy) -> Bool {
        let firstMatchedCharacter = self[offset: policy.appearanceTimes.lowerBound - 1]
        let secondMatchedCharacter = self[offset: policy.appearanceTimes.upperBound - 1]
        let matchesCount = [firstMatchedCharacter, secondMatchedCharacter].count(where: { $0 == policy.character })
        return matchesCount == 1
    }
}

private extension Day2Year2020.InputElement {
    var isPasswordValidOnOldRules: Bool {
        password.matchesPolicyOnOldRules(policy)
    }

    var isPasswordValidOnNewRules: Bool {
        password.matchesPolicyOnNewRules(policy)
    }
}
