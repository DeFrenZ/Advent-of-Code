import class Foundation.Scanner

public final class Day3Year2024: DaySolver {
	public static let day: Int = 3
	public static let year: Int = 2024

	private let input: String

	public init(input: String) {
		self.input = input
	}

	/**
	 # --- Day 3: Mull It Over ---

	 "Our computers are having issues, so I have no idea if we have any Chief Historians in stock! You're welcome to check the warehouse, though," says the mildly flustered shopkeeper at the [North Pole Toboggan Rental Shop](https://adventofcode.com/2020/day/2). The Historians head out to take a look.

	 The shopkeeper turns to you. "Any chance you can see why our computers are having issues again?"

	 The computer appears to be trying to run a program, but its memory (your puzzle input) is **corrupted**. All of the instructions have been jumbled up!

	 It seems like the goal of the program is just to **multiply some numbers**. It does that with instructions like `mul(X,Y)`, where `X` and `Y` are each 1-3 digit numbers. For instance, `mul(44,46)` multiplies `44` by `46` to get a result of `2024`. Similarly, `mul(123,4)` would multiply `123` by `4`.

	 However, because the program's memory has been corrupted, there are also many invalid characters that should be **ignored**, even if they look like part of a `mul` instruction. Sequences like `mul(4*`, `mul(6,9!`, `?(12,34)`, or `mul ( 2 , 4 )` do **nothing**.

	 For example, consider the following section of corrupted memory:

	 `xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))`

	 Only the four highlighted sections are real `mul` instructions. Adding up the result of each instruction produces **`161`** `(2*4 + 5*5 + 11*8 + 8*5)`.

	 Scan the corrupted memory for uncorrupted `mul` instructions. **What do you get if you add up all of the results of the multiplications?**
	 */
	public func solvePart1() -> String {
		try! instructions()
			.map(\.value)
			.sum()
			.description
	}

	/**
	 # --- Part Two ---

	 As you scan through the corrupted memory, you notice that some of the conditional statements are also still intact. If you handle some of the uncorrupted conditional statements in the program, you might be able to get an even more accurate result.

	 There are two new instructions you'll need to handle:

	 - The `do()` instruction **enables** future `mul` instructions.
	 - The `don't()` instruction **disables** future `mul` instructions.

	 Only the **most recent** `do()` or `don't()` instruction applies. At the beginning of the program, `mul` instructions are **enabled**.

	 For example:

	 `xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))`

	 This corrupted memory is similar to the example from before, but this time the `mul(5,5)` and `mul(11,8)` instructions are **disabled** because there is a `don't()` instruction before them. The other `mul` instructions function normally, including the one at the end that gets re-**enabled** by a `do()` instruction.

	 This time, the sum of the results is `48` `(2*4 + 8*5)`.

	 Handle the new instructions; **what do you get if you add up all of the results of just the enabled multiplications?**
	 */
	public func solvePart2() -> String {
		try! enabledInstructions()
			.map(\.value)
			.sum()
			.description
	}
}

// MARK: - Input

extension Day3Year2024 {
	public enum Instruction {
		case mul(Int, Int)
		case `do`
		case dont
	}
}

extension Day3Year2024.Instruction {
	init(match: Regex<(Substring, Substring?, Substring?)>.Match) throws(ParseError) {
		switch match.0 {
		case /mul.+/:
			let aString = try match.1 ?! ParseError.missingNumber
			let a = try Int(aString) ?! ParseError.notAValidNumber(aString.toString())
			let bString = try match.2 ?! ParseError.missingNumber
			let b = try Int(bString) ?! ParseError.notAValidNumber(bString.toString())
			self = .mul(a, b)
		case "do()":
			self = .do
		case "don\'t()":
			self = .dont
		default:
			throw ParseError.notAValidMatch(match.0.toString())
		}
	}

	nonisolated(unsafe)
	static let regex = /mul\((\d{1,3}),(\d{1,3})\)|do\(\)|don\'t\(\)/

	enum ParseError: Error {
		case notAValidMatch(String)
		case missingNumber
		case notAValidNumber(String)
	}
}

// MARK: - Logic

extension Day3Year2024 {
	private func instructions() throws(Instruction.ParseError) -> [Instruction] {
		try input.matches(of: Instruction.regex)
			.map({ match throws(Instruction.ParseError) -> Instruction in try Instruction(match: match) })
	}

	private func enabledInstructions() throws(Instruction.ParseError) -> [Instruction] {
		let instructions = try self.instructions()
		let (enabledInstructions, _) = instructions.reduce(
			(instructions: [Instruction](), isCurrentlyEnabled: true),
			{ (result, newValue) in
				switch (result.isCurrentlyEnabled, newValue) {
				case (true, .mul):
					return (result.0 + [newValue], result.1)
				case (false, .do):
					return (result.0, true)
				case (true, .dont):
					return (result.0, false)
				case (false, .mul), (true, .do), (false, .dont):
					return (result.0, result.1)
				}
			})
		return enabledInstructions
	}
}

extension Day3Year2024.Instruction {
	var value: Int {
		switch self {
		case .mul(let a, let b): a * b
		case .do, .dont: 0
		}
	}
}
