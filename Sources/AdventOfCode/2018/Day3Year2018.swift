import Foundation
import Algorithms

public final class Day3Year2018: DaySolverWithInputs {
    public static let day = 3
    public static let year = 2018

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     # --- Day 3: No Matter How You Slice It ---

     The Elves managed to locate the chimney-squeeze prototype fabric for Santa's suit (thanks to someone who helpfully wrote its box IDs on the wall of the warehouse in the middle of the night). Unfortunately, anomalies are still affecting them - nobody can even agree on how to cut the fabric.

     The whole piece of fabric they're working on is a very large square - at least `1000` inches on each side.

     Each Elf has made a **claim** about which area of fabric would be ideal for Santa's suit. All claims have an ID and consist of a single rectangle with edges parallel to the edges of the fabric. Each claim's rectangle is defined as follows:

     The number of inches between the left edge of the fabric and the left edge of the rectangle.
     The number of inches between the top edge of the fabric and the top edge of the rectangle.
     The width of the rectangle in inches.
     The height of the rectangle in inches.

     A claim like `#123 @ 3,2: 5x4` means that claim ID `123` specifies a rectangle `3` inches from the left edge, `2` inches from the top edge, `5` inches wide, and `4` inches tall. Visually, it claims the square inches of fabric represented by `#` (and ignores the square inches of fabric represented by `.`) in the diagram below:

     ```
     ...........
     ...........
     ...#####...
     ...#####...
     ...#####...
     ...#####...
     ...........
     ...........
     ...........
     ```

     The problem is that many of the claims **overlap**, causing two or more claims to cover part of the same areas. For example, consider the following claims:

     ```
     #1 @ 1,3: 4x4
     #2 @ 3,1: 4x4
     #3 @ 5,5: 2x2
     ```

     Visually, these claim the following areas:

     ```
     ........
     ...2222.
     ...2222.
     .11XX22.
     .11XX22.
     .111133.
     .111133.
     ........
     ```

     The four square inches marked with `X` are claimed by **both `1` and `2`**. (Claim `3`, while adjacent to the others, does not overlap either of them.)

     If the Elves all proceed with their own plans, none of them will have enough fabric. **How many square inches of fabric are within two or more claims?**
     */
    public func solvePart1() -> String {
        let intersectionPoints = intersections
            .flatMap(\.intersection.points)
            .uniqued()
        return intersectionPoints.count
            .description
    }

    /**
     # --- Part Two ---

     Amidst the chaos, you notice that exactly one claim doesn't overlap by even a single square inch of fabric with any other claim. If you can somehow draw attention to it, maybe the Elves will be able to make Santa's suit after all!

     For example, in the claims above, only claim `3` is intact after all claims are made.

     **What is the ID of the only claim that doesn't overlap?**
     */
    public func solvePart2() -> String {
        let allIDs = Set(inputElements.map(\.id))
        let allIntersectingIDs = Set(intersections.flatMap({ [$0.id1, $0.id2] }))
        let nonIntersectingIDs = allIDs.subtracting(allIntersectingIDs)
        return nonIntersectingIDs.first!
            .description
    }
}

// MARK: - Input

public extension Day3Year2018 {
    struct Claim: Hashable {
        var id: Int
        var rect: Rect

        struct Rect: Hashable {
            var x: Range<Int>
            var y: Range<Int>
        }
    }

    typealias InputElement = Claim
}

extension Day3Year2018.Claim: ParseableFromString {
    public var description: String {
        "#\(id) @ \(rect.x.lowerBound),\(rect.y.lowerBound): \(rect.x.count)x\(rect.y.count)"
    }

    public static func parse(on scanner: Scanner) throws -> Self {
        _ = try scanner.scanString("#") ?! ParseError.onHash
        let id = try scanner.scanInt() ?! ParseError.onID
        _ = try scanner.scanString(" @ ") ?! ParseError.onAt
        let x = try scanner.scanInt() ?! ParseError.onX
        _ = try scanner.scanString(",") ?! ParseError.onOriginSeparator
        let y = try scanner.scanInt() ?! ParseError.onY
        _ = try scanner.scanString(": ") ?! ParseError.onColonSpace
        let width = try scanner.scanInt() ?! ParseError.onWidth
        _ = try scanner.scanString("x") ?! ParseError.onSizeSeparator
        let height = try scanner.scanInt() ?! ParseError.onHeight
        let rect = Rect(x: x ..< (x + width), y: y ..< (y + height))

        return Self(id: id, rect: rect)
    }

    enum ParseError: Error {
        case onHash
        case onID
        case onAt
        case onX
        case onOriginSeparator
        case onY
        case onColonSpace
        case onWidth
        case onSizeSeparator
        case onHeight
    }
}

// MARK: - Logic

extension Day3Year2018.Claim.Rect {
    static func intersection(_ a: Self, _ b: Self) -> Self {
        let x = a.x.clamped(to: b.x)
        let y = a.y.clamped(to: b.y)
        return .init(x: x, y: y)
    }

    var isEmpty: Bool {
        return x.isEmpty || y.isEmpty
    }

    var points: [Point] {
        product(x, y)
            .map({ Point(x: $0, y: $1) })
    }

    struct Point: Hashable {
        var x: Int
        var y: Int
    }
}

extension Day3Year2018 {
    var intersections: [(id1: Int, id2: Int, intersection: Claim.Rect)] {
        Set(inputElements)
            .pairs()
            .map({ (id1: $0.id, id2: $1.id, intersection: Claim.Rect.intersection($0.rect, $1.rect)) })
            .filter(\.intersection.isEmpty.not)
    }
}
