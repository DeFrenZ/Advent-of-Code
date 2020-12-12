import Foundation
import StandardLibraryPreview

public final class Day11Year2020: DaySolverWithInputs {
    public static let day = 11
    public static let year = 2020

    private let inputElements: [InputElement]

    public init(inputElements: [InputElement]) {
        self.inputElements = inputElements
    }

    /**
     --- Day 11: Seating System ---

     Your plane lands with plenty of time to spare. The final leg of your journey is a ferry that goes directly to the tropical island where you can finally start your vacation. As you reach the waiting area to board the ferry, you realize you're so early, nobody else has even arrived yet!

     By modeling the process people use to choose (or abandon) their seat in the waiting area, you're pretty sure you can predict the best place to sit. You make a quick map of the seat layout (your puzzle input).

     The seat layout fits neatly on a grid. Each position is either floor (`.`), an empty seat (`L`), or an occupied seat (`#`). For example, the initial seat layout might look like this:

     ```
     L.LL.LL.LL
     LLLLLLL.LL
     L.L.L..L..
     LLLL.LL.LL
     L.LL.LL.LL
     L.LLLLL.LL
     ..L.L.....
     LLLLLLLLLL
     L.LLLLLL.L
     L.LLLLL.LL
     ```

     Now, you just need to model the people who will be arriving shortly. Fortunately, people are entirely predictable and always follow a simple set of rules. All decisions are based on the **number of occupied seats** adjacent to a given seat (one of the eight positions immediately up, down, left, right, or diagonal from the seat). The following rules are applied to every seat simultaneously:

     - If a seat is **empty** (`L`) and there are **no** occupied seats adjacent to it, the seat becomes **occupied**.
     - If a seat is **occupied** (`#`) and **four or more** seats adjacent to it are also occupied, the seat becomes **empty**.
     - Otherwise, the seat's state does not change.

     Floor (`.`) never changes; seats don't move, and nobody sits on the floor.

     After one round of these rules, every seat in the example layout becomes occupied:

     ```
     #.##.##.##
     #######.##
     #.#.#..#..
     ####.##.##
     #.##.##.##
     #.#####.##
     ..#.#.....
     ##########
     #.######.#
     #.#####.##
     ```

     After a second round, the seats with four or more occupied adjacent seats become empty again:

     ```
     #.LL.L#.##
     #LLLLLL.L#
     L.L.L..L..
     #LLL.LL.L#
     #.LL.LL.LL
     #.LLLL#.##
     ..L.L.....
     #LLLLLLLL#
     #.LLLLLL.L
     #.#LLLL.##
     ```

     This process continues for three more rounds:

     ```
     #.##.L#.##
     #L###LL.L#
     L.#.#..#..
     #L##.##.L#
     #.##.LL.LL
     #.###L#.##
     ..#.#.....
     #L######L#
     #.LL###L.L
     #.#L###.##
     ```

     ```
     #.#L.L#.##
     #LLL#LL.L#
     L.L.L..#..
     #LLL.##.L#
     #.LL.LL.LL
     #.LL#L#.##
     ..L.L.....
     #L#LLLL#L#
     #.LLLLLL.L
     #.#L#L#.##
     ```

     ```
     #.#L.L#.##
     #LLL#LL.L#
     L.#.L..#..
     #L##.##.L#
     #.#L.LL.LL
     #.#L#L#.##
     ..L.L.....
     #L#L##L#L#
     #.LLLLLL.L
     #.#L#L#.##
     ```

     At this point, something interesting happens: the chaos stabilizes and further applications of these rules cause no seats to change state! Once people stop moving around, you count **`37`** occupied seats.

     Simulate your seating area by applying the seating rules repeatedly until no seats change state. **How many seats end up occupied?**
     */
    public func solvePart1() -> String {
        stableSeatLayout(rule: .adjacent)
            .count(occurrencesOf: .occupiedSeat)
            .description
    }

    /**
     --- Part Two ---

     As soon as people start to arrive, you realize your mistake. People don't just care about adjacent seats - they care about **the first seat they can see** in each of those eight directions!

     Now, instead of considering just the eight immediately adjacent seats, consider the **first seat** in each of those eight directions. For example, the empty seat below would see **eight** occupied seats:

     ```
     .......#.
     ...#.....
     .#.......
     .........
     ..#L....#
     ....#....
     .........
     #........
     ...#.....
     ```

     The leftmost empty seat below would only see **one** empty seat, but cannot see any of the occupied ones:

     ```
     .............
     .L.L.#.#.#.#.
     .............
     ```

     The empty seat below would see no occupied seats:

     ```
     .##.##.
     #.#.#.#
     ##...##
     ...L...
     ##...##
     #.#.#.#
     .##.##.
     ```

     Also, people seem to be more tolerant than you expected: it now takes **five or more** visible occupied seats for an occupied seat to become empty (rather than **four or more** from the previous rules). The other rules still apply: empty seats that see no occupied seats become occupied, seats matching no rule don't change, and floor never changes.

     Given the same starting layout as above, these new rules cause the seating area to shift around as follows:

     ```
     L.LL.LL.LL
     LLLLLLL.LL
     L.L.L..L..
     LLLL.LL.LL
     L.LL.LL.LL
     L.LLLLL.LL
     ..L.L.....
     LLLLLLLLLL
     L.LLLLLL.L
     L.LLLLL.LL
     ```

     ```
     #.##.##.##
     #######.##
     #.#.#..#..
     ####.##.##
     #.##.##.##
     #.#####.##
     ..#.#.....
     ##########
     #.######.#
     #.#####.##
     ```

     ```
     #.LL.LL.L#
     #LLLLLL.LL
     L.L.L..L..
     LLLL.LL.LL
     L.LL.LL.LL
     L.LLLLL.LL
     ..L.L.....
     LLLLLLLLL#
     #.LLLLLL.L
     #.LLLLL.L#
     ```

     ```
     #.L#.##.L#
     #L#####.LL
     L.#.#..#..
     ##L#.##.##
     #.##.#L.##
     #.#####.#L
     ..#.#.....
     LLL####LL#
     #.L#####.L
     #.L####.L#
     ```

     ```
     #.L#.L#.L#
     #LLLLLL.LL
     L.L.L..#..
     ##LL.LL.L#
     L.LL.LL.L#
     #.LLLLL.LL
     ..L.L.....
     LLLLLLLLL#
     #.LLLLL#.L
     #.L#LL#.L#
     ```

     ```
     #.L#.L#.L#
     #LLLLLL.LL
     L.L.L..#..
     ##L#.#L.L#
     L.L#.#L.L#
     #.L####.LL
     ..#.#.....
     LLL###LLL#
     #.LLLLL#.L
     #.L#LL#.L#
     ```

     ```
     #.L#.L#.L#
     #LLLLLL.LL
     L.L.L..#..
     ##L#.#L.L#
     L.L#.LL.L#
     #.LLLL#.LL
     ..#.L.....
     LLL###LLL#
     #.LLLLL#.L
     #.L#LL#.L#
     ```

     Again, at this point, people stop shifting around and the seating area reaches equilibrium. Once this occurs, you count **`26`** occupied seats.

     Given the new visibility method and the rule change for occupied seats becoming empty, once equilibrium is reached, **how many seats end up occupied?**
     */
    public func solvePart2() -> String {
        stableSeatLayout(rule: .sight)
            .count(occurrencesOf: .occupiedSeat)
            .description
    }
}

// MARK: - Input

public extension Day11Year2020 {
    enum SeatState: Character {
        case floor = "."
        case emptySeat = "L"
        case occupiedSeat = "#"
    }

    typealias InputElement = [SeatState]
    typealias SeatLayout = Matrix2<SeatState>
}

extension Day11Year2020.SeatState: ParseableFromString {}

// MARK: - Logic

extension Day11Year2020 {
    var initialSeatLayout: SeatLayout {
        try! .init(inputElements)
    }

    func stableSeatLayout(rule: NeighbourRule) -> SeatLayout {
        let initialLayout = initialSeatLayout
        let neighbours = memoized({ initialLayout.neighbourIndices(to: $0, rule: rule) })
        let seatLayoutUpdates = sequence(state: initialLayout, next: { (state: inout SeatLayout) -> SeatLayout? in
            defer { state.updateLayout(rule: rule, neighbourIndices: neighbours) }
            return state
        })
        return seatLayoutUpdates.withPrevious()
            .first(where: { $0.current == $0.previous })!
            .current
    }

    enum NeighbourRule {
        case adjacent
        case sight

        var minimumSeatsToFreeSeat: Int {
            switch self {
            case .adjacent: return 4
            case .sight: return 5
            }
        }
    }
}

extension Matrix2 where Element == Day11Year2020.SeatState {
    func neighbourIndices(to center: Index, rule: Day11Year2020.NeighbourRule) -> [Index] {
        let directions: [(x: Int, y: Int)] = [(-1, -1), (0, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (0, 1), (1, 1)]
        return directions
            .compactMap({ neighbourIndex(from: center, inDirection: $0, rule: rule) })
    }

    func indices(from center: Index, inDirection direction: (x: Int, y: Int)) -> AnySequence<Index> {
        let rows = validRowIndices
        let columns = validColumnIndices
        return sequence(state: position(for: center), next: { position in
            position.column += direction.x
            position.row += direction.y
            guard columns.contains(position.column), rows.contains(position.row) else { return nil }
            return index(position)
        }).eraseToAnySequence()
    }

    func neighbourIndex(
        from center: Index,
        inDirection direction: (x: Int, y: Int),
        rule: Day11Year2020.NeighbourRule)
    -> Index? {
        let indices = self.indices(from: center, inDirection: direction)
        switch rule {
        case .adjacent: return indices.first(where: { _ in true })
        case .sight: return indices.first(where: { self[$0] != .floor })
        }
    }

    func newSeatState <S: Sequence> (
        from state: Element,
        forNeighbours neighbours: S,
        rule: Day11Year2020.NeighbourRule
    ) -> Element where S.Element == Element {
        switch state {
        case .floor:
            return .floor
        case .emptySeat:
            return neighbours.contains(.occupiedSeat)
                ? .emptySeat
                : .occupiedSeat
        case .occupiedSeat:
            let sum = neighbours
                .count(where: { $0 == .occupiedSeat })
            return sum >= rule.minimumSeatsToFreeSeat
                ? .emptySeat
                : .occupiedSeat
        }
    }

    mutating func updateLayout(
        rule: Day11Year2020.NeighbourRule,
        neighbourIndices: (Index) -> [Index])
    {
        var newLayout = self
        for index in indices {
            let neighboursIndices = neighbourIndices(index)
            let neighbours = neighboursIndices.map({ self[$0] })
            newLayout[index] = newSeatState(from: self[index], forNeighbours: neighbours, rule: rule)
        }
        self = newLayout
    }
}
