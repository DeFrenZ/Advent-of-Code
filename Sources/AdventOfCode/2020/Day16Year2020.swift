import Foundation

public final class Day16Year2020: DaySolverWithSingleInput {
    public static let day = 16
    public static let year = 2020

    private let input: Input

    public init(input: Input) {
        self.input = input
    }

    /**
     # --- Day 16: Ticket Translation ---

     As you're walking to yet another connecting flight, you realize that one of the legs of your re-routed trip coming up is on a high-speed train. However, the train ticket you were given is in a language you don't understand. You should probably figure out what it says before you get to the train station after the next flight.

     Unfortunately, you can't actually **read** the words on the ticket. You can, however, read the numbers, and so you figure out **the fields these tickets must have** and **the valid ranges** for values in those fields.

     You collect the **rules for ticket fields**, the **numbers on your ticket**, and the **numbers on other nearby tickets** for the same train service (via the airport security cameras) together into a single document you can reference (your puzzle input).

     The **rules for ticket fields** specify a list of fields that exist **somewhere** on the ticket and the **valid ranges of values** for each field. For example, a rule like `class: 1-3 or 5-7` means that one of the fields in every ticket is named `class` and can be any value in the ranges `1-3` or `5-7` (inclusive, such that `3` and `5` are both valid in this field, but `4` is not).

     Each ticket is represented by a single line of comma-separated values. The values are the numbers on the ticket in the order they appear; every ticket has the same format. For example, consider this ticket:

     ```
     .--------------------------------------------------------.
     | ????: 101    ?????: 102   ??????????: 103     ???: 104 |
     |                                                        |
     | ??: 301  ??: 302             ???????: 303      ??????? |
     | ??: 401  ??: 402           ???? ????: 403    ????????? |
     '--------------------------------------------------------'
     ```

     Here, `?` represents text in a language you don't understand. This ticket might be represented as `101,102,103,104,301,302,303,401,402,403`; of course, the actual train tickets you're looking at are **much** more complicated. In any case, you've extracted just the numbers in such a way that the first number is always the same specific field, the second number is always a different specific field, and so on - you just don't know what each position actually means!

     Start by determining which tickets are **completely invalid**; these are tickets that contain values which **aren't valid for any field**. Ignore **your ticket** for now.

     For example, suppose you have the following notes:

     ```
     class: 1-3 or 5-7
     row: 6-11 or 33-44
     seat: 13-40 or 45-50

     your ticket:
     7,1,14

     nearby tickets:
     7,3,47
     40,**4**,50
     **55**,2,20
     38,6,**12**
     ```

     It doesn't matter which position corresponds to which field; you can identify invalid **nearby tickets** by considering only whether tickets contain **values that are not valid for any field**. In this example, the values on the first **nearby ticket** are all valid for at least one field. This is not true of the other three **nearby tickets**: the values `4`, `55`, and `12` are are not valid for any field. Adding together all of the invalid values produces your **ticket scanning error rate**: `4 + 55 + 12` = **`71`**.

     Consider the validity of the **nearby tickets** you scanned. **What is your ticket scanning error rate?**
     */
    public func solvePart1() -> String {
        let allRules = allRulesRangeSet
        return input
            .nearbyTickets
            .flatMap({ $0.fieldsValuesNotMatchingAnyRule(allRules) })
            .sum()
            .description
    }

    /**
     # --- Part Two ---

     Now that you've identified which tickets contain invalid values, **discard those tickets entirely**. Use the remaining valid tickets to determine which field is which.

     Using the valid ranges for each field, determine what order the fields appear on the tickets. The order is consistent between all tickets: if `seat` is the third field, it is the third field on every ticket, including **your ticket**.

     For example, suppose you have the following notes:

     ```
     class: 0-1 or 4-19
     row: 0-5 or 8-19
     seat: 0-13 or 16-19

     your ticket:
     11,12,13

     nearby tickets:
     3,9,18
     15,1,5
     5,14,9
     ```

     Based on the **nearby tickets** in the above example, the first position must be `row`, the second position must be `class`, and the third position must be `seat`; you can conclude that in **your ticket**, `class` is `12`, `row` is `11`, and `seat` is `13`.

     Once you work out which field is which, look for the six fields on **your ticket** that start with the word `departure`. **What do you get if you multiply those six values together?**
     */
    public func solvePart2() -> String {
        let fields = deducedFields()
        return zip(fields, input.yourTicket.fieldsValues)
            .filter({ name, value in name.hasPrefix("departure") })
            .map(\.1)
            .product()
            .description
    }
}

// MARK: - Input

public extension Day16Year2020 {
    struct Input {
        var rules: [FieldRule]
        var yourTicket: Ticket
        var nearbyTickets: [Ticket]

        typealias FieldRule = Day16Year2020.FieldRule
        typealias Ticket = Day16Year2020.Ticket
    }

    struct FieldRule: Hashable {
        var ruleName: String
        var ranges: [ClosedRange<Int>]
    }

    struct Ticket {
        var fieldsValues: [Int]
    }
}

extension Day16Year2020.Input: ParseableFromString {
    public var description: String {
        let rulesDescription = rules.map(\.description)
            .joined(separator: "\n")
        let nearbyTicketsDescription = nearbyTickets.map(\.description)
            .joined(separator: "\n")
        return """
            \(rulesDescription)

            your ticket:
            \(yourTicket.description)

            nearby tickets:
            \(nearbyTicketsDescription)
            """
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let rules = try scanner.scanAll(FieldRule.self, separators: ["\n"], stopAt: ["\n\n"])
        _ = try scanner.scanString("\n\nyour ticket:\n") ?! ParseError.notAValidYourTicketHeader(scanner.remainingString)
        let yourTicket = try scanner.scan(Ticket.self)
        _ = try scanner.scanString("\n\nnearby tickets:\n") ?! ParseError.notAValidNearbyTicketsHeader(scanner.remainingString)
        let nearbyTickets = try scanner.scanAll(Ticket.self, separators: ["\n"], stopAt: [])

        return .init(rules: rules, yourTicket: yourTicket, nearbyTickets: nearbyTickets)
    }

    enum ParseError: Error {
        case notAValidYourTicketHeader(String)
        case notAValidNearbyTicketsHeader(String)
    }
}

extension Day16Year2020.FieldRule: ParseableFromString {
    public var description: String {
        let rangesDescription = ranges
            .map({ "\($0.lowerBound)-\($0.upperBound)" })
            .joined(separator: " or ")
        return "\(ruleName): \(rangesDescription)"
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let ruleName = try scanner.scanUpToString(":") ?! ParseError.notAValidRuleName(scanner.remainingString)
        _ = try scanner.scanString(": ") ?! ParseError.notAValidSeparator(scanner.remainingString)
        let ranges = try scanner.scanAll(
            parseRange(on:),
            separators: [" or "],
            stopAt: ["\n"])

        return .init(ruleName: ruleName, ranges: ranges)
    }

    private static func parseRange(on scanner: Scanner) throws -> ClosedRange<Int> {
        let lowerBound = try scanner.scanInt() ?! ParseError.notAValidLowerBound(scanner.remainingString)
        _ = try scanner.scanString("-") ?! ParseError.notAValidRangeSeparator(scanner.remainingString)
        let upperBound = try scanner.scanInt() ?! ParseError.notAValidUpperBound(scanner.remainingString)
        guard lowerBound <= upperBound else { throw ParseError.notAValidRange(lower: lowerBound, upper: upperBound) }

        return lowerBound ... upperBound
    }

    enum ParseError: Error {
        case notAValidRuleName(String)
        case notAValidSeparator(String)
        case notAValidLowerBound(String)
        case notAValidRangeSeparator(String)
        case notAValidUpperBound(String)
        case notAValidRange(lower: Int, upper: Int)
    }
}

extension Day16Year2020.Ticket: ParseableFromString {
    public var description: String {
        fieldsValues.map(\.description)
            .joined(separator: ",")
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let fieldsValues = try scanner.scanAll(Int.self, separators: [","], stopAt: ["\n"])
        return .init(fieldsValues: fieldsValues)
    }
}

// MARK: - Logic

extension Day16Year2020 {
    var allRulesRangeSet: RangeSet<Int> {
        input.rules
            .reduce(into: .init(), { $0.formUnion($1.rangeSet) })
    }

    public func deducedFields() -> [String] {
        let allRules = allRulesRangeSet
        let validNearbyTickets = input.nearbyTickets
            .filter({ $0.fieldsValuesNotMatchingAnyRule(allRules).isEmpty })
        let nearbyTicketsFieldsRangeSets = Self.fieldsRangeSets(for: validNearbyTickets)
        let possibleRulesPerField = nearbyTicketsFieldsRangeSets
            .map({ Self.possibleRules(forFieldEntries: $0, allRules: input.rules) })
        let pickedRules = Self.pickRules(fromPossibleRules: possibleRulesPerField)!
        return pickedRules.map(\.ruleName)
    }

    public static func fieldsRangeSets(for tickets: [Ticket]) -> [RangeSet<Int>] {
        let fieldValuesGrid = tickets
            .map(\.fieldsValues)
        let fieldValuesMatrix = try! Matrix2(fieldValuesGrid)
        return fieldValuesMatrix.columns
            .map({ column in
                column.reduce(into: RangeSet(), { $0.formUnion(.init($1 ..< $1 + 1)) })
            })
    }

    static func possibleRules(forFieldEntries fieldEntries: RangeSet<Int>, allRules: [FieldRule]) -> Set<FieldRule> {
        allRules
            .filter({ $0.rangeSet.isSuperset(of: fieldEntries) })
            |> Set.init
    }

    static func pickRules(fromPossibleRules possibleRules: [Set<FieldRule>]) -> [FieldRule]? {
        var stillPossibleRules = possibleRules
        var pickedRules: [FieldRule?] = Array(repeating: nil, count: possibleRules.count)

        while pickedRules.contains(nil) {
            guard let nextPickIndex = stillPossibleRules.firstIndex(where: { $0.count == 1 }) else { return nil }
            let nextPick = stillPossibleRules[nextPickIndex].onlyValue!
            pickedRules[nextPickIndex] = nextPick
            for index in stillPossibleRules.indices {
                stillPossibleRules[index].remove(nextPick)
            }
        }

        return pickedRules.compacted()
    }
}

extension Day16Year2020.FieldRule {
    var rangeSet: RangeSet<Int> {
        let openRanges = ranges.map({ $0.lowerBound ..< $0.upperBound + 1 })
        return .init(openRanges)
    }
}

extension Day16Year2020.Ticket {
    func fieldsValuesNotMatchingAnyRule(_ allRules: RangeSet<Int>) -> [Int] {
        fieldsValues.filter({ allRules.contains($0).not })
    }
}
