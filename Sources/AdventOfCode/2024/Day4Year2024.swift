public final class Day4Year2024: DaySolver {
	public static let day: Int = 4
	public static let year: Int = 2024

	private let input: Input

	public init(input: Input) {
		self.input = input
	}

	/**
	 # --- Day 4: Ceres Search ---

	 "Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the [Ceres monitoring station](https://adventofcode.com/2019/day/10)!

	 As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her **word search** (your puzzle input). She only has to find one word: `XMAS`.

	 This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of `XMAS` - you need to find **all of them**. Here are a few ways `XMAS` might appear, where irrelevant characters have been replaced with `.`:

	 ```
	 ..X...
	 .SAMX.
	 .A..A.
	 XMAS.S
	 .X....
	 ```

	 The actual word search will be full of letters instead. For example:

	 ```
	 MMMSXXMASM
	 MSAMXMSMSA
	 AMXSXMAAMM
	 MSAMASMSMX
	 XMASAMXAMM
	 XXAMMXXAMA
	 SMSMSASXSS
	 SAXAMASAAA
	 MAMMMXMMMM
	 MXMXAXMASX
	 ```

	 In this word search, `XMAS` occurs a total of `18` times; here's the same word search again, but where letters not involved in any `XMAS` have been replaced with `.`:

	 ```
	 ....XXMAS.
	 .SAMXMS...
	 ...S..A...
	 ..A.A.MS.X
	 XMASAMX.MM
	 X.....XA.A
	 S.S.S.S.SS
	 .A.A.A.A.A
	 ..M.M.M.MM
	 .X.X.XMASX
	 ```

	 Take a look at the little Elf's word search. **How many times does `XMAS` appear?**
	 */
	public func solvePart1() -> String {
		matches(of: "XMAS")
			.description
	}

	/**
	 # --- Part Two ---

	 The Elf looks quizzically at you. Did you misunderstand the assignment?

	 Looking for the instructions, you flip over the word search to find that this isn't actually an `XMAS` puzzle; it's an `X-MAS` puzzle in which you're supposed to find two `MAS` in the shape of an `X`. One way to achieve that is like this:

	 ```
	 M.S
	 .A.
	 M.S
	 ```

	 Irrelevant characters have again been replaced with `.` in the above diagram. Within the `X`, each `MAS` can be written forwards or backwards.

	 Here's the same example from before, but this time all of the `X-MAS`es have been kept instead:

	 ```
	 .M.S......
	 ..A..MSMS.
	 .M.S.MAA..
	 ..A.ASMSM.
	 .M.S.M....
	 ..........
	 S.S.S.S.S.
	 .A.A.A.A..
	 M.M.M.M.M.
	 ..........
	 ```

	 In this example, an `X-MAS` appears `9` times.

	 Flip the word search from the instructions back over to the word search side and try again. **How many times does an `X-MAS` appear?**
	 */
	public func solvePart2() -> String {
		let intersectionCharacter = "A".utf8.first!
		return indices(of: intersectionCharacter)
			.filter({ isCrossMASMatch(at: $0) })
			.count
			.description
	}
}

// MARK: - Input

extension Day4Year2024 {
	public typealias Input = Matrix2<UTF8.CodeUnit>

	public convenience init(input: String) throws {
		let grid = input
			.components(separatedBy: "\n")
			.filter(\.isEmpty.not)
			.map({ $0.utf8.map(\.self) })
		let input = try Matrix2(grid)
		self.init(input: input)
	}
}

// MARK: - Logic

extension Day4Year2024 {
	func matches(of word: String) -> Int {
		guard let firstCharacter = word.utf8.first else { return 0 }
		return indices(of: firstCharacter)
			.map({ matches(of: word, at: $0) })
			.sum()
	}

	func indices(of character: UTF8.CodeUnit) -> some Collection<Input.Index> {
		input.indices(where: { $0 == character })
			.ranges
			.flatMap({ $0 })
	}

	func matches(of word: String, at index: Input.Index) -> Int {
		Direction.allCases
			.map({ isMatch(of: word, at: index, in: $0) })
			.count(where: \.self)
	}

	func isMatch(of word: String, at index: Input.Index, in direction: Direction) -> Bool {
		guard couldFitMatch(of: word, at: index, in: direction) else { return false }
		let characters = positions(from: index, in: direction)
			.lazy
			.map({ [input] in input[$0] })
		return zip(word.utf8, characters).allSatisfy(==)
	}

	func couldFitMatch(of word: String, at index: Input.Index, in direction: Direction) -> Bool {
		hasCharacters(count: word.utf8.count, from: index, in: direction)
	}

	func hasCharacters(count: Int, from index: Input.Index, in direction: Direction) -> Bool {
		let positions = positions(from: index, in: direction)
		guard let lastPosition = positions.element(atOffset: count - 1) else { return false }
		return input.isValidPosition(lastPosition)
	}

	func positions(from index: Input.Index, in direction: Direction) -> some Sequence<Input.Position> {
		sequence(
			first: input.position(for: index),
			next: { [input] in input.nextPosition(from: $0, in: direction) })
	}

	func isCrossMASMatch(at index: Input.Index) -> Bool {
		let centerPosition = input.position(for: index)
		let matches = Direction.allCases
			.filter(\.isDiagonal)
			.filter({ offsetDirection in
				let wordStartPosition = input.nextPosition(from: centerPosition, in: offsetDirection)
				return input.isValidPosition(wordStartPosition)
					&& isMatch(
						of: "MAS",
						at: input.index(wordStartPosition),
						in: offsetDirection.opposite)
			})
		let orthogonals = matches.flatMap(\.orthogonals)
		return matches.contains(where: orthogonals.contains)
	}

	enum Direction: CaseIterable {
		case right
		case downRight
		case down
		case downLeft
		case left
		case upLeft
		case up
		case upRight
	}
}

extension Matrix2 {
	fileprivate func nextPosition(from position: Position, in direction: Day4Year2024.Direction) -> Position {
		switch direction {
		case .right:
			return (row: position.row, column: position.column + 1)
		case .downRight:
			return (row: position.row + 1, column: position.column + 1)
		case .down:
			return (row: position.row + 1, column: position.column)
		case .downLeft:
			return (row: position.row + 1, column: position.column - 1)
		case .left:
			return (row: position.row, column: position.column - 1)
		case .upLeft:
			return (row: position.row - 1, column: position.column - 1)
		case .up:
			return (row: position.row - 1, column: position.column)
		case .upRight:
			return (row: position.row - 1, column: position.column + 1)
		}
	}
}

extension Day4Year2024.Direction {
	var isDiagonal: Bool {
		switch self {
		case .right, .down, .left, .up: return false
		case .downRight, .downLeft, .upLeft, .upRight: return true
		}
	}

	var opposite: Self {
		switch self {
		case .right: return .left
		case .downRight: return .upLeft
		case .down: return .up
		case .downLeft: return .upRight
		case .left: return .right
		case .upLeft: return .downRight
		case .up: return .down
		case .upRight: return .downLeft
		}
	}

	var orthogonals: Set<Self> {
		switch self {
		case .right: return [.up, .down]
		case .downRight: return [.upRight, .downLeft]
		case .down: return [.right, .left]
		case .downLeft: return [.downRight, .upLeft]
		case .left: return [.down, .up]
		case .upLeft: return [.downLeft, .upRight]
		case .up: return [.left, .right]
		case .upRight: return [.upLeft, .downRight]
		}
	}
}
