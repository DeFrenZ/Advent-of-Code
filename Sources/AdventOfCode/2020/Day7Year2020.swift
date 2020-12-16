import Foundation
import SwiftGraph

public final class Day7Year2020: DaySolverWithInputs {
    public static let day = 7
    public static let year = 2020

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     # --- Day 7: Handy Haversacks ---

     You land at the regional airport in time for your next flight. In fact, it looks like you'll even have time to grab some food: all flights are currently delayed due to **issues in luggage processing**.

     Due to recent aviation regulations, many rules (your puzzle input) are being enforced about bags and their contents; bags must be color-coded and must contain specific quantities of other color-coded bags. Apparently, nobody responsible for these regulations considered how long they would take to enforce!

     For example, consider the following rules:

     ```
     light red bags contain 1 bright white bag, 2 muted yellow bags.
     dark orange bags contain 3 bright white bags, 4 muted yellow bags.
     bright white bags contain 1 shiny gold bag.
     muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
     shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
     dark olive bags contain 3 faded blue bags, 4 dotted black bags.
     vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
     faded blue bags contain no other bags.
     dotted black bags contain no other bags.
     ```

     These rules specify the required contents for 9 bag types. In this example, every `faded blue` bag is empty, every `vibrant plum` bag contains 11 bags (5 `faded blue` and 6 `dotted black`), and so on.

     You have a **`shiny gold`** bag. If you wanted to carry it in at least one other bag, how many different bag colors would be valid for the outermost bag? (In other words: how many colors can, eventually, contain at least one `shiny gold` bag?)

     In the above rules, the following options would be available to you:

     - A `bright white` bag, which can hold your `shiny gold` bag directly.
     - A `muted yellow` bag, which can hold your `shiny gold` bag directly, plus some other bags.
     - A `dark orange` bag, which can hold `bright white` and `muted yellow` bags, either of which could then hold your `shiny gold` bag.
     - A `light red` bag, which can hold `bright white` and `muted yellow` bags, either of which could then hold your `shiny gold` bag.
     
     So, in this example, the number of bag colors that can eventually contain at least one `shiny gold` bag is **`4`**.

     **How many bag colors can eventually contain at least one `shiny gold` bag?** (The list of rules is quite long; make sure you get all of it.)
     */
    public func solvePart1() -> String {
        bagsContaining(.shinyGold)
            .count
            .description
    }

    /**
     # --- Part Two ---

     It's getting pretty expensive to fly these days - not because of ticket prices, but because of the ridiculous number of bags you need to buy!

     Consider again your `shiny gold` bag and the rules from the above example:

     - `faded blue` bags contain `0` other bags.
     - `dotted black` bags contain `0` other bags.
     - `vibrant plum` bags contain `11` other bags: 5 `faded blue` bags and 6 `dotted black` bags.
     - `dark olive` bags contain `7` other bags: 3 `faded blue` bags and 4 `dotted black` bags.

     So, a single `shiny gold` bag must contain 1 `dark olive` bag (and the 7 bags within it) plus 2 `vibrant plum` bags (and the 11 bags within **each** of those): `1 + 1*7 + 2 + 2*11` = **`32`** bags!

     Of course, the actual rules have a small chance of going several levels deeper than this example; be sure to count all of the bags, even if the nesting becomes topologically impractical!

     Here's another example:

     ```
     shiny gold bags contain 2 dark red bags.
     dark red bags contain 2 dark orange bags.
     dark orange bags contain 2 dark yellow bags.
     dark yellow bags contain 2 dark green bags.
     dark green bags contain 2 dark blue bags.
     dark blue bags contain 2 dark violet bags.
     dark violet bags contain no other bags.
     ```

     In this example, a single `shiny gold` bag must contain **`126`** other bags.

     **How many individual bags are required inside your single `shiny gold` bag?**
     */
    public func solvePart2() -> String {
        bagsContainedCount(in: .shinyGold)
            .description
    }
}

// MARK: - Input

public extension Day7Year2020 {
    struct Rule {
        var bagColor: BagColor
        var containedBags: [BagColor: Int]

        typealias BagColor = Day7Year2020.BagColor
        typealias BagColorCountPair = Day7Year2020.BagColorCountPair
    }

    struct BagColor: Hashable {
        var colorName: String

        static let shinyGold: Self = .init(colorName: "shiny gold")
    }

    struct BagColorCountPair {
        var bagColor: BagColor
        var count: Int

        typealias BagColor = Day7Year2020.BagColor
    }

    typealias InputElement = Rule
}

extension Day7Year2020.Rule: ParseableFromString {
    public var description: String {
        var contentsDescription: String {
            guard containedBags.isEmpty.not else { return "no other bags" }
            return containedBags
                .map({ BagColorCountPair(bagColor: $0, count: $1) })
                .map(\.description)
                .joined(separator: ", ")
        }
        return "\(bagColor) contain \(contentsDescription)"
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let bagColor = try scanner.scan(BagColor.self)
        _ = try scanner.scanString("s contain ") ?! ParseError.noPluralOrContain(scanner.remainingString)
        if scanner.scanString("no other bags.") != nil {
            return Self(bagColor: bagColor, containedBags: [:])
        }

        let contents = try scanner.scanAll(
            BagColorCountPair.self,
            separators: [", "],
            stopAt: ["."])
        _ = try scanner.scanString(".") ?! ParseError.noPeriod(scanner.remainingString)

        let containedBags = Dictionary(grouping: contents, by: \.bagColor)
            .mapValues(\.first!.count)
        return Self(bagColor: bagColor, containedBags: containedBags)
    }

    enum ParseError: Error {
        case noPluralOrContain(String)
        case noPeriod(String)
    }
}

extension Day7Year2020.BagColor: ParseableFromString {
    public var description: String {
        "\(colorName) bag"
    }

    public static func parse(on scanner: Scanner) throws -> Day7Year2020.BagColor {
        let rawColor = try scanner.scanUpToString(" bag") ?! ParseError.noBagColor(scanner.remainingString)
        _ = try scanner.scanString(" bag") ?! ParseError.noBag(scanner.remainingString)

        return Self(colorName: rawColor)
    }

    enum ParseError: Error {
        case noBagColor(String)
        case noBag(String)
    }
}

extension Day7Year2020.BagColorCountPair: ParseableFromString {
    public var description: String {
        "\(count) \(bagColor)\(count > 1 ? "s" : "")"
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        let count = try scanner.scanInt() ?! ParseError.doesNotStartWithANumber(scanner.remainingString)
        _ = try scanner.scanString(" ") ?! ParseError.noSpace(scanner.remainingString)
        let color = try scanner.scan(BagColor.self)
        if count > 1 {
            _ = try scanner.scanString("s") ?! ParseError.noPlural(scanner.remainingString)
        }

        return Self(bagColor: color, count: count)
    }

    enum ParseError: Error {
        case doesNotStartWithANumber(String)
        case noSpace(String)
        case noPlural(String)
    }
}

// MARK: - Logic

private extension Day7Year2020 {
    private var containedBags: WeightedGraph<BagColor, Int> {
        let graph = WeightedGraph<BagColor, Int>(vertices: inputElements.map(\.bagColor))
        for rule in inputElements {
            for (containedBag, count) in rule.containedBags {
                graph.addEdge(
                    from: rule.bagColor,
                    to: containedBag,
                    weight: count,
                    directed: true)
            }
        }
        return graph
    }

    func bagsContaining(_ bagColor: BagColor) -> Set<BagColor> {
        let bags = containedBags
        let bagContainsMemoized = memoized({ continuation in
            { parent, target in
                Self.bagContainsRecursively(
                    parentBagColor: parent,
                    targetBagColor: target,
                    containedBags: bags,
                    contains: continuation)
            }
        })

        return bags.vertices
            .filter({ bagContainsMemoized($0, bagColor) })
            .toSet()
    }

    private static func bagContainsRecursively(
        parentBagColor: BagColor,
        targetBagColor: BagColor,
        containedBags: WeightedGraph<BagColor, Int>,
        contains: (BagColor, BagColor) -> Bool)
    -> Bool {
        guard let neighbors = containedBags.neighborsForVertex(parentBagColor) else { return false }
        if neighbors.contains(targetBagColor) { return true }
        return neighbors.contains(where: { contains($0, targetBagColor) })
    }

    func bagsContainedCount(in bagColor: BagColor) -> Int {
        let bags = containedBags
        let bagsContainedCountMemoized = memoized({ continuation in
            { parent in
                Self.bagsContainedCountRecursively(
                    parentBagColor: parent,
                    containedBags: bags,
                    count: continuation)
            }
        })

        return bagsContainedCountMemoized(bagColor)
    }

    private static func bagsContainedCountRecursively(
        parentBagColor: BagColor,
        containedBags: WeightedGraph<BagColor, Int>,
        count: (BagColor) -> Int)
    -> Int {
        guard let edges = containedBags.edgesForVertex(parentBagColor) else { return 0 }
        return edges
            .map({ edge in edge.weight * (1 + count(containedBags.vertexAtIndex(edge.v))) })
            .sum()
    }
}

extension Day7Year2020.BagColor: Codable {}
