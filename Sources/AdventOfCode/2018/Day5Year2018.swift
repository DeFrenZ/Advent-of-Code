import Foundation

public final class Day5Year2018: DaySolverWithInputs {
    public static let day = 5
    public static let year = 2018

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /*
     --- Day 5: Alchemical Reduction ---

     You've managed to sneak in to the prototype suit manufacturing lab. The Elves are making decent progress, but are still struggling with the suit's size reduction capabilities.

     While the very latest in 1518 alchemical technology might have solved their problem eventually, you can do better. You scan the chemical composition of the suit's material and discover that it is formed by extremely long polymers (one of which is available as your puzzle input).

     The polymer is formed by smaller units which, when triggered, react with each other such that two adjacent units of the same type and opposite polarity are destroyed. Units' types are represented by letters; units' polarity is represented by capitalization. For instance, r and R are units with the same type but opposite polarity, whereas r and s are entirely different types and do not react.

     For example:

     In aA, a and A react, leaving nothing behind.
     In abBA, bB destroys itself, leaving aA. As above, this then destroys itself, leaving nothing.
     In abAB, no two adjacent units are of the same type, and so nothing happens.
     In aabAAB, even though aa and AA are of the same type, their polarities match, and so nothing happens.
     Now, consider a larger example, dabAcCaCBAcCcaDA:

     dabAcCaCBAcCcaDA  The first 'cC' is removed.
     dabAaCBAcCcaDA    This creates 'Aa', which is removed.
     dabCBAcCcaDA      Either 'cC' or 'Cc' are removed (the result is the same).
     dabCBAcaDA        No further actions can be taken.
     After all possible reactions, the resulting polymer contains 10 units.

     How many units remain after fully reacting the polymer you scanned? (Note: in this puzzle and others, the input is large; if you copy/paste your input, make sure you get the whole thing.)
     */
    public func solvePart1() -> String {
        polymer
            .reacting()
            .count
            .description
    }

    /*
     --- Part Two ---

     Time to improve the polymer.

     One of the unit types is causing problems; it's preventing the polymer from collapsing as much as it should. Your goal is to figure out which unit type is causing the most problems, remove all instances of it (regardless of polarity), fully react the remaining polymer, and measure its length.

     For example, again using the polymer dabAcCaCBAcCcaDA from above:

     Removing all A/a units produces dbcCCBcCcD. Fully reacting this polymer produces dbCBcD, which has length 6.
     Removing all B/b units produces daAcCaCAcCcaDA. Fully reacting this polymer produces daCAcaDA, which has length 8.
     Removing all C/c units produces dabAaBAaDA. Fully reacting this polymer produces daDA, which has length 4.
     Removing all D/d units produces abAcCaCBAcCcaA. Fully reacting this polymer produces abCBAc, which has length 6.
     In this example, removing all C/c units was best, producing the answer 4.

     What is the length of the shortest polymer you can produce by removing all units of exactly one type and fully reacting the result?
     */
    public func solvePart2() -> String {
        improvedPolymers()
            .min(on: \.value.count)!
            .value
            .count
            .description
    }
}

// MARK: - Input

public extension Day5Year2018 {
    struct Unit {
        var typeCode: UInt8
        var polarity: Bool
    }

    typealias Polymer = [Unit]
    typealias InputElement = Polymer
}

extension Day5Year2018.Unit: ParseableFromString {
    public var description: String {
        let utf8CodePoint = typeCode + (polarity ? 0 : 32)
        let character = Character(Unicode.Scalar(utf8CodePoint))
        return String(character)
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let character = try scanner.scanCharacter() ?! ParseError.nothingToScan
        let codePoint = try character.utf8.onlyValue ?! ParseError.notACodePoint(character)
        switch codePoint {
        case Self.validTypeCodes:
            return .init(typeCode: codePoint, polarity: true)
        case Self.uppercasedTypeCodes:
            return .init(typeCode: codePoint - 32, polarity: false)
        default:
            throw ParseError.notAValidCodePoint(codePoint)
        }
    }

    static let validTypeCodes: ClosedRange<UInt8> = 65 ... 90
    static let uppercasedTypeCodes: ClosedRange<UInt8> = 97 ... 122

    public enum ParseError: Error {
        case nothingToScan
        case notACodePoint(Character)
        case notAValidCodePoint(UInt8)
    }
}

// MARK: - Logic

extension Day5Year2018 {
    var polymer: Polymer {
        inputElements.onlyValue!
    }

    func improvedPolymers() -> [UInt8: Polymer] {
        let basePolymer = polymer
        let fixedPolymersPerTypeCode = Dictionary(indexingUniqueValues: Unit.validTypeCodes)
            .mapValues({ typeCode in basePolymer.filter({ $0.typeCode != typeCode }) })
        return fixedPolymersPerTypeCode
            .mapValues({ $0.reacting() })
    }
}

extension Day5Year2018.Unit {
    func reacts(with other: Self) -> Bool {
        self.typeCode == other.typeCode
            && self.polarity != other.polarity
    }
}

extension Day5Year2018.Polymer {
    func reacting() -> Self {
        var workingUnits = self
        var currentIndex = workingUnits.startIndex
        var nextIndex = workingUnits.index(after: currentIndex)
        while currentIndex != workingUnits.endIndex, nextIndex != workingUnits.endIndex {
            defer { nextIndex = workingUnits.index(after: currentIndex) }
            if workingUnits[currentIndex].reacts(with: workingUnits[nextIndex]) {
                workingUnits[currentIndex ... nextIndex] = []
                if currentIndex != workingUnits.startIndex {
                    currentIndex = workingUnits.index(before: currentIndex)
                }
                continue
            }
            currentIndex = nextIndex
        }
        return workingUnits
    }
}
